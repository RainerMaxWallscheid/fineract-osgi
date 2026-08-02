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
package org.apache.fineract.portfolio.loanaccount.domain.transactionprocessor.impl;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.organisation.monetary.domain.MonetaryCurrency;
import org.apache.fineract.organisation.monetary.domain.Money;
import org.apache.fineract.portfolio.loanaccount.domain.ChangedTransactionDetail;
import org.apache.fineract.portfolio.loanaccount.domain.LoanCharge;
import org.apache.fineract.portfolio.loanaccount.domain.LoanRepaymentScheduleInstallment;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTermVariations;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransaction;
import org.apache.fineract.portfolio.loanaccount.domain.transactionprocessor.MoneyHolder;
import org.apache.fineract.portfolio.loanaccount.domain.transactionprocessor.TransactionCtx;
import org.apache.fineract.portfolio.loanproduct.calc.data.ProgressiveLoanInterestScheduleModel;

public class ProgressiveTransactionCtx extends TransactionCtx {
    private final ProgressiveLoanInterestScheduleModel model;
    private final List<LoanTransaction> alreadyProcessedTransactions = new ArrayList<>();
    private Money sumOfInterestRefundAmount;
    private boolean isChargedOff = false;
    private boolean isWrittenOff = false;
    private boolean isContractTerminated = false;
    private boolean isPrepayAttempt = false;
    private final List<LoanRepaymentScheduleInstallment> skipRepaymentScheduleInstallments = new ArrayList<>();
    private final List<Long> processedLoanChargeIds;

    public ProgressiveTransactionCtx(MonetaryCurrency currency, List<LoanRepaymentScheduleInstallment> installments, Set<LoanCharge> charges, MoneyHolder overpaymentHolder, ChangedTransactionDetail changedTransactionDetail, ProgressiveLoanInterestScheduleModel model, List<LoanTermVariations> activeLoanTermVariations) {
        this(currency, installments, charges, overpaymentHolder, changedTransactionDetail, model, Money.zero(currency), activeLoanTermVariations);
    }

    public ProgressiveTransactionCtx(MonetaryCurrency currency, List<LoanRepaymentScheduleInstallment> installments, Set<LoanCharge> charges, MoneyHolder overpaymentHolder, ChangedTransactionDetail changedTransactionDetail, ProgressiveLoanInterestScheduleModel model, Money sumOfInterestRefundAmount, List<LoanTermVariations> activeLoanTermVariations) {
        this(currency, installments, charges, overpaymentHolder, changedTransactionDetail, model, sumOfInterestRefundAmount, activeLoanTermVariations, charges == null ? new ArrayList<>() : charges.stream().map(AbstractPersistableCustom::getId).toList());
    }

    public ProgressiveTransactionCtx(MonetaryCurrency currency, List<LoanRepaymentScheduleInstallment> installments, Set<LoanCharge> charges, MoneyHolder overpaymentHolder, ChangedTransactionDetail changedTransactionDetail, ProgressiveLoanInterestScheduleModel model, Money sumOfInterestRefundAmount, List<LoanTermVariations> activeLoanTermVariations, List<Long> processedLoanChargeIds) {
        super(currency, installments, charges, overpaymentHolder, changedTransactionDetail, activeLoanTermVariations);
        this.sumOfInterestRefundAmount = sumOfInterestRefundAmount;
        this.model = model;
        this.processedLoanChargeIds = processedLoanChargeIds;
    }

    public Set<LoanCharge> getProcessedLoanCharges() {
        if (getCharges() == null) {
            return new HashSet<>();
        }
        if (getCharges().size() == getProcessedLoanChargeIds().size()) {
            return getCharges();
        }
        return getCharges().stream().filter(this::isLoanChargeProcessed).collect(Collectors.toSet());
    }

    public boolean isLoanChargeProcessed(final LoanCharge loanCharge) {
        return getProcessedLoanChargeIds().contains(loanCharge.getId());
    }

    @java.lang.SuppressWarnings("all")
        public ProgressiveLoanInterestScheduleModel getModel() {
        return this.model;
    }

    @java.lang.SuppressWarnings("all")
        public List<LoanTransaction> getAlreadyProcessedTransactions() {
        return this.alreadyProcessedTransactions;
    }

    @java.lang.SuppressWarnings("all")
        public Money getSumOfInterestRefundAmount() {
        return this.sumOfInterestRefundAmount;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isChargedOff() {
        return this.isChargedOff;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isWrittenOff() {
        return this.isWrittenOff;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isContractTerminated() {
        return this.isContractTerminated;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isPrepayAttempt() {
        return this.isPrepayAttempt;
    }

    @java.lang.SuppressWarnings("all")
        public List<LoanRepaymentScheduleInstallment> getSkipRepaymentScheduleInstallments() {
        return this.skipRepaymentScheduleInstallments;
    }

    @java.lang.SuppressWarnings("all")
        public List<Long> getProcessedLoanChargeIds() {
        return this.processedLoanChargeIds;
    }

    @java.lang.SuppressWarnings("all")
        public void setSumOfInterestRefundAmount(final Money sumOfInterestRefundAmount) {
        this.sumOfInterestRefundAmount = sumOfInterestRefundAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setChargedOff(final boolean isChargedOff) {
        this.isChargedOff = isChargedOff;
    }

    @java.lang.SuppressWarnings("all")
        public void setWrittenOff(final boolean isWrittenOff) {
        this.isWrittenOff = isWrittenOff;
    }

    @java.lang.SuppressWarnings("all")
        public void setContractTerminated(final boolean isContractTerminated) {
        this.isContractTerminated = isContractTerminated;
    }

    @java.lang.SuppressWarnings("all")
        public void setPrepayAttempt(final boolean isPrepayAttempt) {
        this.isPrepayAttempt = isPrepayAttempt;
    }
}
