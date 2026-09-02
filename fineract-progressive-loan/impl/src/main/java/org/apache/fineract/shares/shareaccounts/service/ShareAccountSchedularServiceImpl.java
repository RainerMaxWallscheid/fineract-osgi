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
package org.apache.fineract.shares.shareaccounts.service;

import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.portfolio.savings.moduleapi.LinkedSavingsAccountPort;
import org.apache.fineract.shares.shareaccounts.domain.ShareAccountDividendDetails;
import org.apache.fineract.shares.shareaccounts.domain.ShareAccountDividendRepository;
import org.apache.fineract.shares.shareaccounts.domain.ShareAccountDividendStatusType;
import org.springframework.transaction.annotation.Transactional;

public class ShareAccountSchedularServiceImpl implements ShareAccountSchedularService {

    private final ShareAccountDividendRepository shareAccountDividendRepository;
    private final LinkedSavingsAccountPort linkedSavingsAccountPort;

    @Override
    @Transactional
    public void postDividend(final Long dividendDetailId, final Long savingsId) {
        ShareAccountDividendDetails shareAccountDividendDetails = this.shareAccountDividendRepository.findById(dividendDetailId)
                .orElseThrow();
        final Long transactionId = this.linkedSavingsAccountPort.handleDividendPayout(savingsId, DateUtils.getBusinessLocalDate(),
                shareAccountDividendDetails.getAmount());
        shareAccountDividendDetails.update(ShareAccountDividendStatusType.POSTED.getValue(), transactionId);
        this.shareAccountDividendRepository.saveAndFlush(shareAccountDividendDetails);
    }

    public ShareAccountSchedularServiceImpl(final ShareAccountDividendRepository shareAccountDividendRepository,
            final LinkedSavingsAccountPort linkedSavingsAccountPort) {
        this.shareAccountDividendRepository = shareAccountDividendRepository;
        this.linkedSavingsAccountPort = linkedSavingsAccountPort;
    }
}
