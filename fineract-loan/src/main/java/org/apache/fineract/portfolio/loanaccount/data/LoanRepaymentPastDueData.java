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
package org.apache.fineract.portfolio.loanaccount.data;

import java.math.BigDecimal;

public class LoanRepaymentPastDueData {
    private final BigDecimal totalAmount;
    private final BigDecimal principalAmount;
    private final BigDecimal interestAmount;
    private final BigDecimal feeAmount;
    private final BigDecimal penaltyAmount;

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalAmount() {
        return this.totalAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipalAmount() {
        return this.principalAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestAmount() {
        return this.interestAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeeAmount() {
        return this.feeAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenaltyAmount() {
        return this.penaltyAmount;
    }

    @java.lang.SuppressWarnings("all")
        public LoanRepaymentPastDueData(final BigDecimal totalAmount, final BigDecimal principalAmount, final BigDecimal interestAmount, final BigDecimal feeAmount, final BigDecimal penaltyAmount) {
        this.totalAmount = totalAmount;
        this.principalAmount = principalAmount;
        this.interestAmount = interestAmount;
        this.feeAmount = feeAmount;
        this.penaltyAmount = penaltyAmount;
    }
}
