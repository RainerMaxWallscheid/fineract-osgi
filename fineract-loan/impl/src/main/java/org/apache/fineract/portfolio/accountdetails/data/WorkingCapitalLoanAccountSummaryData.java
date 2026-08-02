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
package org.apache.fineract.portfolio.accountdetails.data;

import java.math.BigDecimal;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.portfolio.loanaccount.data.LoanApplicationTimelineData;
import org.apache.fineract.portfolio.loanaccount.data.LoanStatusEnumData;

/**
 * Immutable data object for working capital loan accounts.
 */
public class WorkingCapitalLoanAccountSummaryData {
    private final Long id;
    private final String accountNo;
    private final String externalId;
    private final Long productId;
    private final String productName;
    private final String shortProductName;
    private final LoanStatusEnumData status;
    private final CurrencyData currency;
    private final Integer loanCycle;
    private final LoanApplicationTimelineData timeline;
    private final Boolean inArrears;
    private final BigDecimal loanBalance;
    private final BigDecimal amountPaid;

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getAccountNo() {
        return this.accountNo;
    }

    @java.lang.SuppressWarnings("all")
        public String getExternalId() {
        return this.externalId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getProductId() {
        return this.productId;
    }

    @java.lang.SuppressWarnings("all")
        public String getProductName() {
        return this.productName;
    }

    @java.lang.SuppressWarnings("all")
        public String getShortProductName() {
        return this.shortProductName;
    }

    @java.lang.SuppressWarnings("all")
        public LoanStatusEnumData getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyData getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getLoanCycle() {
        return this.loanCycle;
    }

    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData getTimeline() {
        return this.timeline;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getInArrears() {
        return this.inArrears;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getLoanBalance() {
        return this.loanBalance;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmountPaid() {
        return this.amountPaid;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanAccountSummaryData(final Long id, final String accountNo, final String externalId, final Long productId, final String productName, final String shortProductName, final LoanStatusEnumData status, final CurrencyData currency, final Integer loanCycle, final LoanApplicationTimelineData timeline, final Boolean inArrears, final BigDecimal loanBalance, final BigDecimal amountPaid) {
        this.id = id;
        this.accountNo = accountNo;
        this.externalId = externalId;
        this.productId = productId;
        this.productName = productName;
        this.shortProductName = shortProductName;
        this.status = status;
        this.currency = currency;
        this.loanCycle = loanCycle;
        this.timeline = timeline;
        this.inArrears = inArrears;
        this.loanBalance = loanBalance;
        this.amountPaid = amountPaid;
    }
}
