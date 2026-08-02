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

import java.io.Serializable;
import java.math.BigDecimal;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransactionRelationTypeEnum;

public class LoanTransactionRelationData implements Serializable {
    private Long fromLoanTransaction;
    private Long toLoanTransaction;
    private Long toLoanCharge;
    private LoanTransactionRelationTypeEnum relationType;
    private BigDecimal amount;
    private String paymentType;

    @java.lang.SuppressWarnings("all")
        public Long getFromLoanTransaction() {
        return this.fromLoanTransaction;
    }

    @java.lang.SuppressWarnings("all")
        public Long getToLoanTransaction() {
        return this.toLoanTransaction;
    }

    @java.lang.SuppressWarnings("all")
        public Long getToLoanCharge() {
        return this.toLoanCharge;
    }

    @java.lang.SuppressWarnings("all")
        public LoanTransactionRelationTypeEnum getRelationType() {
        return this.relationType;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public String getPaymentType() {
        return this.paymentType;
    }

    @java.lang.SuppressWarnings("all")
        public void setFromLoanTransaction(final Long fromLoanTransaction) {
        this.fromLoanTransaction = fromLoanTransaction;
    }

    @java.lang.SuppressWarnings("all")
        public void setToLoanTransaction(final Long toLoanTransaction) {
        this.toLoanTransaction = toLoanTransaction;
    }

    @java.lang.SuppressWarnings("all")
        public void setToLoanCharge(final Long toLoanCharge) {
        this.toLoanCharge = toLoanCharge;
    }

    @java.lang.SuppressWarnings("all")
        public void setRelationType(final LoanTransactionRelationTypeEnum relationType) {
        this.relationType = relationType;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmount(final BigDecimal amount) {
        this.amount = amount;
    }

    @java.lang.SuppressWarnings("all")
        public void setPaymentType(final String paymentType) {
        this.paymentType = paymentType;
    }

    @java.lang.SuppressWarnings("all")
        public LoanTransactionRelationData(final Long fromLoanTransaction, final Long toLoanTransaction, final Long toLoanCharge, final LoanTransactionRelationTypeEnum relationType, final BigDecimal amount, final String paymentType) {
        this.fromLoanTransaction = fromLoanTransaction;
        this.toLoanTransaction = toLoanTransaction;
        this.toLoanCharge = toLoanCharge;
        this.relationType = relationType;
        this.amount = amount;
        this.paymentType = paymentType;
    }
}
