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

import java.util.ArrayList;
import java.util.List;
import org.apache.fineract.organisation.monetary.domain.MonetaryCurrency;

public class AccrualPeriodsData {
    private final MonetaryCurrency currency;
    private final List<AccrualPeriodData> periods = new ArrayList<>();

    public AccrualPeriodsData addPeriod(AccrualPeriodData period) {
        periods.add(period);
        return this;
    }

    public AccrualPeriodData getPeriodByInstallmentNumber(Integer installmentNumber) {
        return installmentNumber == null ? null : periods.stream().filter(p -> installmentNumber.equals(p.getInstallmentNumber())).findFirst().orElse(null);
    }

    public Integer getFirstInstallmentNumber() {
        return periods.stream().filter(AccrualPeriodData::isFirstPeriod).map(AccrualPeriodData::getInstallmentNumber).findFirst().orElse(null);
    }

    @java.lang.SuppressWarnings("all")
        public MonetaryCurrency getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public List<AccrualPeriodData> getPeriods() {
        return this.periods;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof AccrualPeriodsData)) return false;
        final AccrualPeriodsData other = (AccrualPeriodsData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$currency = this.getCurrency();
        final java.lang.Object other$currency = other.getCurrency();
        if (this$currency == null ? other$currency != null : !this$currency.equals(other$currency)) return false;
        final java.lang.Object this$periods = this.getPeriods();
        final java.lang.Object other$periods = other.getPeriods();
        if (this$periods == null ? other$periods != null : !this$periods.equals(other$periods)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof AccrualPeriodsData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $currency = this.getCurrency();
        result = result * PRIME + ($currency == null ? 43 : $currency.hashCode());
        final java.lang.Object $periods = this.getPeriods();
        result = result * PRIME + ($periods == null ? 43 : $periods.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "AccrualPeriodsData(currency=" + this.getCurrency() + ", periods=" + this.getPeriods() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public AccrualPeriodsData(final MonetaryCurrency currency) {
        this.currency = currency;
    }
}
