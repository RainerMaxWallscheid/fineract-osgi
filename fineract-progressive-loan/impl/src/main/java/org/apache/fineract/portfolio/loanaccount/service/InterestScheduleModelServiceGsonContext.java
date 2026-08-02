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
package org.apache.fineract.portfolio.loanaccount.service;

import java.lang.reflect.Type;
import java.math.MathContext;
import java.util.ArrayList;
import org.apache.fineract.organisation.monetary.domain.MonetaryCurrency;
import org.apache.fineract.portfolio.loanproduct.calc.data.InterestPeriod;
import org.apache.fineract.portfolio.loanproduct.calc.data.ProgressiveLoanInterestScheduleModel;
import org.apache.fineract.portfolio.loanproduct.calc.data.RepaymentPeriod;
import org.apache.fineract.portfolio.loanproduct.domain.ILoanConfigurationDetails;

public class InterestScheduleModelServiceGsonContext {
    private final MonetaryCurrency currency;
    private final MathContext mc;
    private final ILoanConfigurationDetails loanProductRelatedDetail;
    private RepaymentPeriod prev = null;
    private final Integer installmentAmountInMultipliesOf;

    public RepaymentPeriod createRepaymentPeriodInstance(Type type) {
        if (type == RepaymentPeriod.class) {
            setPrev(RepaymentPeriod.empty(getPrev(), getMc(), getLoanProductRelatedDetail()));
            return getPrev();
        }
        throw new IllegalArgumentException("Unsupported RepaymentPeriod type: " + type);
    }

    public InterestPeriod createInterestPeriodInstance(Type type) {
        if (type == InterestPeriod.class) {
            return InterestPeriod.empty(getPrev(), getMc());
        }
        throw new IllegalArgumentException("Unsupported InterestPeriod type: " + type);
    }

    public ProgressiveLoanInterestScheduleModel createProgressiveLoanInterestScheduleModelInstance(Type type) {
        if (type == ProgressiveLoanInterestScheduleModel.class) {
            setPrev(null);
            return new ProgressiveLoanInterestScheduleModel(new ArrayList<>(), getLoanProductRelatedDetail(), installmentAmountInMultipliesOf, getMc());
        }
        throw new IllegalArgumentException("Unsupported ProgressiveLoanInterestScheduleModel type: " + type);
    }

    @java.lang.SuppressWarnings("all")
        public MonetaryCurrency getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public MathContext getMc() {
        return this.mc;
    }

    @java.lang.SuppressWarnings("all")
        public ILoanConfigurationDetails getLoanProductRelatedDetail() {
        return this.loanProductRelatedDetail;
    }

    @java.lang.SuppressWarnings("all")
        public RepaymentPeriod getPrev() {
        return this.prev;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getInstallmentAmountInMultipliesOf() {
        return this.installmentAmountInMultipliesOf;
    }

    @java.lang.SuppressWarnings("all")
        public void setPrev(final RepaymentPeriod prev) {
        this.prev = prev;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof InterestScheduleModelServiceGsonContext)) return false;
        final InterestScheduleModelServiceGsonContext other = (InterestScheduleModelServiceGsonContext) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$installmentAmountInMultipliesOf = this.getInstallmentAmountInMultipliesOf();
        final java.lang.Object other$installmentAmountInMultipliesOf = other.getInstallmentAmountInMultipliesOf();
        if (this$installmentAmountInMultipliesOf == null ? other$installmentAmountInMultipliesOf != null : !this$installmentAmountInMultipliesOf.equals(other$installmentAmountInMultipliesOf)) return false;
        final java.lang.Object this$currency = this.getCurrency();
        final java.lang.Object other$currency = other.getCurrency();
        if (this$currency == null ? other$currency != null : !this$currency.equals(other$currency)) return false;
        final java.lang.Object this$mc = this.getMc();
        final java.lang.Object other$mc = other.getMc();
        if (this$mc == null ? other$mc != null : !this$mc.equals(other$mc)) return false;
        final java.lang.Object this$loanProductRelatedDetail = this.getLoanProductRelatedDetail();
        final java.lang.Object other$loanProductRelatedDetail = other.getLoanProductRelatedDetail();
        if (this$loanProductRelatedDetail == null ? other$loanProductRelatedDetail != null : !this$loanProductRelatedDetail.equals(other$loanProductRelatedDetail)) return false;
        final java.lang.Object this$prev = this.getPrev();
        final java.lang.Object other$prev = other.getPrev();
        if (this$prev == null ? other$prev != null : !this$prev.equals(other$prev)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof InterestScheduleModelServiceGsonContext;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $installmentAmountInMultipliesOf = this.getInstallmentAmountInMultipliesOf();
        result = result * PRIME + ($installmentAmountInMultipliesOf == null ? 43 : $installmentAmountInMultipliesOf.hashCode());
        final java.lang.Object $currency = this.getCurrency();
        result = result * PRIME + ($currency == null ? 43 : $currency.hashCode());
        final java.lang.Object $mc = this.getMc();
        result = result * PRIME + ($mc == null ? 43 : $mc.hashCode());
        final java.lang.Object $loanProductRelatedDetail = this.getLoanProductRelatedDetail();
        result = result * PRIME + ($loanProductRelatedDetail == null ? 43 : $loanProductRelatedDetail.hashCode());
        final java.lang.Object $prev = this.getPrev();
        result = result * PRIME + ($prev == null ? 43 : $prev.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "InterestScheduleModelServiceGsonContext(currency=" + this.getCurrency() + ", mc=" + this.getMc() + ", loanProductRelatedDetail=" + this.getLoanProductRelatedDetail() + ", prev=" + this.getPrev() + ", installmentAmountInMultipliesOf=" + this.getInstallmentAmountInMultipliesOf() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public InterestScheduleModelServiceGsonContext(final MonetaryCurrency currency, final MathContext mc, final ILoanConfigurationDetails loanProductRelatedDetail, final Integer installmentAmountInMultipliesOf) {
        this.currency = currency;
        this.mc = mc;
        this.loanProductRelatedDetail = loanProductRelatedDetail;
        this.installmentAmountInMultipliesOf = installmentAmountInMultipliesOf;
    }
}
