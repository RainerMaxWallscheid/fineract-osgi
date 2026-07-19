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
package org.apache.fineract.portfolio.workingcapitalloan.data;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import org.apache.fineract.portfolio.loanaccount.data.DelinquencyPausePeriod;

public class WorkingCapitalLoanCollectionData {
    private Long pastDueDays;
    private Long delinquentDays;
    private LocalDate delinquentDate;
    private BigDecimal delinquentAmount;
    public List<DelinquencyPausePeriod> delinquencyPausePeriods;
    public List<WorkingCapitalLoanRangeScheduleDelinquencyData> installmentLevelDelinquency;
    private BigDecimal delinquentPrincipal;

    public static WorkingCapitalLoanCollectionData initializeEmptyData() {
        return new WorkingCapitalLoanCollectionData(0L, 0L, null, BigDecimal.ZERO, new ArrayList<>(), new ArrayList<>(), BigDecimal.ZERO);
    }

    @java.lang.SuppressWarnings("all")
        public Long getPastDueDays() {
        return this.pastDueDays;
    }

    @java.lang.SuppressWarnings("all")
        public Long getDelinquentDays() {
        return this.delinquentDays;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDelinquentDate() {
        return this.delinquentDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDelinquentAmount() {
        return this.delinquentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public List<DelinquencyPausePeriod> getDelinquencyPausePeriods() {
        return this.delinquencyPausePeriods;
    }

    @java.lang.SuppressWarnings("all")
        public List<WorkingCapitalLoanRangeScheduleDelinquencyData> getInstallmentLevelDelinquency() {
        return this.installmentLevelDelinquency;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDelinquentPrincipal() {
        return this.delinquentPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public void setPastDueDays(final Long pastDueDays) {
        this.pastDueDays = pastDueDays;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquentDays(final Long delinquentDays) {
        this.delinquentDays = delinquentDays;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquentDate(final LocalDate delinquentDate) {
        this.delinquentDate = delinquentDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquentAmount(final BigDecimal delinquentAmount) {
        this.delinquentAmount = delinquentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyPausePeriods(final List<DelinquencyPausePeriod> delinquencyPausePeriods) {
        this.delinquencyPausePeriods = delinquencyPausePeriods;
    }

    @java.lang.SuppressWarnings("all")
        public void setInstallmentLevelDelinquency(final List<WorkingCapitalLoanRangeScheduleDelinquencyData> installmentLevelDelinquency) {
        this.installmentLevelDelinquency = installmentLevelDelinquency;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquentPrincipal(final BigDecimal delinquentPrincipal) {
        this.delinquentPrincipal = delinquentPrincipal;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof WorkingCapitalLoanCollectionData)) return false;
        final WorkingCapitalLoanCollectionData other = (WorkingCapitalLoanCollectionData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$pastDueDays = this.getPastDueDays();
        final java.lang.Object other$pastDueDays = other.getPastDueDays();
        if (this$pastDueDays == null ? other$pastDueDays != null : !this$pastDueDays.equals(other$pastDueDays)) return false;
        final java.lang.Object this$delinquentDays = this.getDelinquentDays();
        final java.lang.Object other$delinquentDays = other.getDelinquentDays();
        if (this$delinquentDays == null ? other$delinquentDays != null : !this$delinquentDays.equals(other$delinquentDays)) return false;
        final java.lang.Object this$delinquentDate = this.getDelinquentDate();
        final java.lang.Object other$delinquentDate = other.getDelinquentDate();
        if (this$delinquentDate == null ? other$delinquentDate != null : !this$delinquentDate.equals(other$delinquentDate)) return false;
        final java.lang.Object this$delinquentAmount = this.getDelinquentAmount();
        final java.lang.Object other$delinquentAmount = other.getDelinquentAmount();
        if (this$delinquentAmount == null ? other$delinquentAmount != null : !this$delinquentAmount.equals(other$delinquentAmount)) return false;
        final java.lang.Object this$delinquencyPausePeriods = this.getDelinquencyPausePeriods();
        final java.lang.Object other$delinquencyPausePeriods = other.getDelinquencyPausePeriods();
        if (this$delinquencyPausePeriods == null ? other$delinquencyPausePeriods != null : !this$delinquencyPausePeriods.equals(other$delinquencyPausePeriods)) return false;
        final java.lang.Object this$installmentLevelDelinquency = this.getInstallmentLevelDelinquency();
        final java.lang.Object other$installmentLevelDelinquency = other.getInstallmentLevelDelinquency();
        if (this$installmentLevelDelinquency == null ? other$installmentLevelDelinquency != null : !this$installmentLevelDelinquency.equals(other$installmentLevelDelinquency)) return false;
        final java.lang.Object this$delinquentPrincipal = this.getDelinquentPrincipal();
        final java.lang.Object other$delinquentPrincipal = other.getDelinquentPrincipal();
        if (this$delinquentPrincipal == null ? other$delinquentPrincipal != null : !this$delinquentPrincipal.equals(other$delinquentPrincipal)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof WorkingCapitalLoanCollectionData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $pastDueDays = this.getPastDueDays();
        result = result * PRIME + ($pastDueDays == null ? 43 : $pastDueDays.hashCode());
        final java.lang.Object $delinquentDays = this.getDelinquentDays();
        result = result * PRIME + ($delinquentDays == null ? 43 : $delinquentDays.hashCode());
        final java.lang.Object $delinquentDate = this.getDelinquentDate();
        result = result * PRIME + ($delinquentDate == null ? 43 : $delinquentDate.hashCode());
        final java.lang.Object $delinquentAmount = this.getDelinquentAmount();
        result = result * PRIME + ($delinquentAmount == null ? 43 : $delinquentAmount.hashCode());
        final java.lang.Object $delinquencyPausePeriods = this.getDelinquencyPausePeriods();
        result = result * PRIME + ($delinquencyPausePeriods == null ? 43 : $delinquencyPausePeriods.hashCode());
        final java.lang.Object $installmentLevelDelinquency = this.getInstallmentLevelDelinquency();
        result = result * PRIME + ($installmentLevelDelinquency == null ? 43 : $installmentLevelDelinquency.hashCode());
        final java.lang.Object $delinquentPrincipal = this.getDelinquentPrincipal();
        result = result * PRIME + ($delinquentPrincipal == null ? 43 : $delinquentPrincipal.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "WorkingCapitalLoanCollectionData(pastDueDays=" + this.getPastDueDays() + ", delinquentDays=" + this.getDelinquentDays() + ", delinquentDate=" + this.getDelinquentDate() + ", delinquentAmount=" + this.getDelinquentAmount() + ", delinquencyPausePeriods=" + this.getDelinquencyPausePeriods() + ", installmentLevelDelinquency=" + this.getInstallmentLevelDelinquency() + ", delinquentPrincipal=" + this.getDelinquentPrincipal() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanCollectionData(final Long pastDueDays, final Long delinquentDays, final LocalDate delinquentDate, final BigDecimal delinquentAmount, final List<DelinquencyPausePeriod> delinquencyPausePeriods, final List<WorkingCapitalLoanRangeScheduleDelinquencyData> installmentLevelDelinquency, final BigDecimal delinquentPrincipal) {
        this.pastDueDays = pastDueDays;
        this.delinquentDays = delinquentDays;
        this.delinquentDate = delinquentDate;
        this.delinquentAmount = delinquentAmount;
        this.delinquencyPausePeriods = delinquencyPausePeriods;
        this.installmentLevelDelinquency = installmentLevelDelinquency;
        this.delinquentPrincipal = delinquentPrincipal;
    }
}
