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
package org.apache.fineract.portfolio.savings.service;

import org.apache.fineract.portfolio.account.PortfolioAccountType;
import org.apache.fineract.portfolio.account.data.AccountTransferFundsData;
import org.apache.fineract.portfolio.account.domain.AccountTransferType;
import org.apache.fineract.portfolio.account.service.AccountTransferFundsWritePort;
import org.apache.fineract.portfolio.savings.data.InterestTransferData;
import org.springframework.stereotype.Service;

/**
 * Bridges leftover savings-api interest transfer port to leftover core funds
 * write port (provider adapter builds leftover {@code AccountTransferDTO}).
 */
@Service
public class InterestTransferWritePortAdapter implements InterestTransferWritePort {

    private static final String TRANSFER_INTEREST_TO_SAVINGS = "transfer interest to savings";

    private final AccountTransferFundsWritePort accountTransferFundsWritePort;

    public InterestTransferWritePortAdapter(final AccountTransferFundsWritePort accountTransferFundsWritePort) {
        this.accountTransferFundsWritePort = accountTransferFundsWritePort;
    }

    @Override
    public void transferInterest(final InterestTransferData data) {
        final AccountTransferFundsData fundsData = new AccountTransferFundsData(data.getTransactionDate(), data.getTransactionAmount(),
                PortfolioAccountType.SAVINGS, PortfolioAccountType.SAVINGS, data.getFromAccountId(), data.getToAccountId(),
                TRANSFER_INTEREST_TO_SAVINGS, null, null, null, AccountTransferType.INTEREST_TRANSFER.getValue(),
                data.isRegularTransaction(), data.isExceptionForBalanceCheck());
        this.accountTransferFundsWritePort.transferFunds(fundsData);
    }
}
