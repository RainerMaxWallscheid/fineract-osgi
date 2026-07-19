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
package org.apache.fineract.portfolio.loanaccount.domain.transactionprocessor;

import java.util.List;
import java.util.Set;
import org.apache.fineract.organisation.monetary.domain.MonetaryCurrency;
import org.apache.fineract.portfolio.loanaccount.domain.ChangedTransactionDetail;
import org.apache.fineract.portfolio.loanaccount.domain.LoanCharge;
import org.apache.fineract.portfolio.loanaccount.domain.LoanRepaymentScheduleInstallment;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTermVariations;

public class TransactionCtx {
    private final MonetaryCurrency currency;
    private final List<LoanRepaymentScheduleInstallment> installments;
    private final Set<LoanCharge> charges;
    private final MoneyHolder overpaymentHolder;
    private final ChangedTransactionDetail changedTransactionDetail;
    private final List<LoanTermVariations> activeLoanTermVariations;

    @java.lang.SuppressWarnings("all")
        public MonetaryCurrency getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public List<LoanRepaymentScheduleInstallment> getInstallments() {
        return this.installments;
    }

    @java.lang.SuppressWarnings("all")
        public Set<LoanCharge> getCharges() {
        return this.charges;
    }

    @java.lang.SuppressWarnings("all")
        public MoneyHolder getOverpaymentHolder() {
        return this.overpaymentHolder;
    }

    @java.lang.SuppressWarnings("all")
        public ChangedTransactionDetail getChangedTransactionDetail() {
        return this.changedTransactionDetail;
    }

    @java.lang.SuppressWarnings("all")
        public List<LoanTermVariations> getActiveLoanTermVariations() {
        return this.activeLoanTermVariations;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof TransactionCtx)) return false;
        final TransactionCtx other = (TransactionCtx) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$currency = this.getCurrency();
        final java.lang.Object other$currency = other.getCurrency();
        if (this$currency == null ? other$currency != null : !this$currency.equals(other$currency)) return false;
        final java.lang.Object this$installments = this.getInstallments();
        final java.lang.Object other$installments = other.getInstallments();
        if (this$installments == null ? other$installments != null : !this$installments.equals(other$installments)) return false;
        final java.lang.Object this$charges = this.getCharges();
        final java.lang.Object other$charges = other.getCharges();
        if (this$charges == null ? other$charges != null : !this$charges.equals(other$charges)) return false;
        final java.lang.Object this$overpaymentHolder = this.getOverpaymentHolder();
        final java.lang.Object other$overpaymentHolder = other.getOverpaymentHolder();
        if (this$overpaymentHolder == null ? other$overpaymentHolder != null : !this$overpaymentHolder.equals(other$overpaymentHolder)) return false;
        final java.lang.Object this$changedTransactionDetail = this.getChangedTransactionDetail();
        final java.lang.Object other$changedTransactionDetail = other.getChangedTransactionDetail();
        if (this$changedTransactionDetail == null ? other$changedTransactionDetail != null : !this$changedTransactionDetail.equals(other$changedTransactionDetail)) return false;
        final java.lang.Object this$activeLoanTermVariations = this.getActiveLoanTermVariations();
        final java.lang.Object other$activeLoanTermVariations = other.getActiveLoanTermVariations();
        if (this$activeLoanTermVariations == null ? other$activeLoanTermVariations != null : !this$activeLoanTermVariations.equals(other$activeLoanTermVariations)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof TransactionCtx;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $currency = this.getCurrency();
        result = result * PRIME + ($currency == null ? 43 : $currency.hashCode());
        final java.lang.Object $installments = this.getInstallments();
        result = result * PRIME + ($installments == null ? 43 : $installments.hashCode());
        final java.lang.Object $charges = this.getCharges();
        result = result * PRIME + ($charges == null ? 43 : $charges.hashCode());
        final java.lang.Object $overpaymentHolder = this.getOverpaymentHolder();
        result = result * PRIME + ($overpaymentHolder == null ? 43 : $overpaymentHolder.hashCode());
        final java.lang.Object $changedTransactionDetail = this.getChangedTransactionDetail();
        result = result * PRIME + ($changedTransactionDetail == null ? 43 : $changedTransactionDetail.hashCode());
        final java.lang.Object $activeLoanTermVariations = this.getActiveLoanTermVariations();
        result = result * PRIME + ($activeLoanTermVariations == null ? 43 : $activeLoanTermVariations.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "TransactionCtx(currency=" + this.getCurrency() + ", installments=" + this.getInstallments() + ", charges=" + this.getCharges() + ", overpaymentHolder=" + this.getOverpaymentHolder() + ", changedTransactionDetail=" + this.getChangedTransactionDetail() + ", activeLoanTermVariations=" + this.getActiveLoanTermVariations() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public TransactionCtx(final MonetaryCurrency currency, final List<LoanRepaymentScheduleInstallment> installments, final Set<LoanCharge> charges, final MoneyHolder overpaymentHolder, final ChangedTransactionDetail changedTransactionDetail, final List<LoanTermVariations> activeLoanTermVariations) {
        this.currency = currency;
        this.installments = installments;
        this.charges = charges;
        this.overpaymentHolder = overpaymentHolder;
        this.changedTransactionDetail = changedTransactionDetail;
        this.activeLoanTermVariations = activeLoanTermVariations;
    }
}
