/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package org.apache.fineract.investor.service;

import jakarta.annotation.PostConstruct;
import org.apache.fineract.infrastructure.configuration.service.ConfigurationReadPlatformService;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanAccountSnapshotEventPort;
import org.springframework.stereotype.Service;

@Service
public class ExternalAssetOwnerLoanStatusChangePlatformServiceImpl implements ExternalAssetOwnerLoanStatusChangePlatformService {
    private final ConfigurationReadPlatformService configurationReadPlatformService;
    private final LoanAccountOwnerTransferService loanAccountOwnerTransferService;
    private final LoanAccountSnapshotEventPort loanAccountSnapshotEventPort;
    private static final String ASSET_EXTERNALIZATION_OF_NON_ACTIVE_LOANS = "asset-externalization-of-non-active-loans";

    @PostConstruct
    public void addListeners() {
        loanAccountSnapshotEventPort.onClosedOrOverpaid(loan -> {
            if (configurationReadPlatformService.retrieveGlobalConfiguration(ASSET_EXTERNALIZATION_OF_NON_ACTIVE_LOANS).isEnabled()) {
                loanAccountOwnerTransferService.handleLoanClosedOrOverpaid(loan);
            }
        });
    }

    @java.lang.SuppressWarnings("all")
        public ExternalAssetOwnerLoanStatusChangePlatformServiceImpl(final ConfigurationReadPlatformService configurationReadPlatformService, final LoanAccountOwnerTransferService loanAccountOwnerTransferService, final LoanAccountSnapshotEventPort loanAccountSnapshotEventPort) {
        this.configurationReadPlatformService = configurationReadPlatformService;
        this.loanAccountOwnerTransferService = loanAccountOwnerTransferService;
        this.loanAccountSnapshotEventPort = loanAccountSnapshotEventPort;
    }
}
