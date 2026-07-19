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

import java.util.Collection;
import java.util.List;
import org.apache.fineract.infrastructure.core.data.StringEnumOptionData;
import org.apache.fineract.portfolio.delinquency.data.DelinquencyBucketData;
import org.apache.fineract.portfolio.fund.data.FundData;
import org.apache.fineract.portfolio.workingcapitalloanbreach.data.WorkingCapitalBreachData;
import org.apache.fineract.portfolio.workingcapitalloannearbreach.data.WorkingCapitalNearBreachData;
import org.apache.fineract.portfolio.workingcapitalloanproduct.data.WorkingCapitalLoanProductData;

/**
 * DTO for Working Capital Loan template response: loan details plus dropdown options (productOptions, fundOptions,
 * delinquencyBucketOptions, periodFrequencyTypeOptions).
 */
public class WorkingCapitalLoanTemplateData {
    private WorkingCapitalLoanData loanData;
    private List<WorkingCapitalLoanProductData> productOptions;
    private Collection<FundData> fundOptions;
    private Collection<DelinquencyBucketData> delinquencyBucketOptions;
    private List<StringEnumOptionData> periodFrequencyTypeOptions;
    private List<StringEnumOptionData> delinquencyStartTypeOptions;
    private List<WorkingCapitalBreachData> breachOptions;
    private List<StringEnumOptionData> delinquencyMinimumPaymentTypeOptions;
    private List<WorkingCapitalNearBreachData> nearBreachOptions;


    @java.lang.SuppressWarnings("all")
        public static class WorkingCapitalLoanTemplateDataBuilder {
        @java.lang.SuppressWarnings("all")
                private WorkingCapitalLoanData loanData;
        @java.lang.SuppressWarnings("all")
                private List<WorkingCapitalLoanProductData> productOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<FundData> fundOptions;
        @java.lang.SuppressWarnings("all")
                private Collection<DelinquencyBucketData> delinquencyBucketOptions;
        @java.lang.SuppressWarnings("all")
                private List<StringEnumOptionData> periodFrequencyTypeOptions;
        @java.lang.SuppressWarnings("all")
                private List<StringEnumOptionData> delinquencyStartTypeOptions;
        @java.lang.SuppressWarnings("all")
                private List<WorkingCapitalBreachData> breachOptions;
        @java.lang.SuppressWarnings("all")
                private List<StringEnumOptionData> delinquencyMinimumPaymentTypeOptions;
        @java.lang.SuppressWarnings("all")
                private List<WorkingCapitalNearBreachData> nearBreachOptions;

        @java.lang.SuppressWarnings("all")
                WorkingCapitalLoanTemplateDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTemplateData.WorkingCapitalLoanTemplateDataBuilder loanData(final WorkingCapitalLoanData loanData) {
            this.loanData = loanData;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTemplateData.WorkingCapitalLoanTemplateDataBuilder productOptions(final List<WorkingCapitalLoanProductData> productOptions) {
            this.productOptions = productOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTemplateData.WorkingCapitalLoanTemplateDataBuilder fundOptions(final Collection<FundData> fundOptions) {
            this.fundOptions = fundOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTemplateData.WorkingCapitalLoanTemplateDataBuilder delinquencyBucketOptions(final Collection<DelinquencyBucketData> delinquencyBucketOptions) {
            this.delinquencyBucketOptions = delinquencyBucketOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTemplateData.WorkingCapitalLoanTemplateDataBuilder periodFrequencyTypeOptions(final List<StringEnumOptionData> periodFrequencyTypeOptions) {
            this.periodFrequencyTypeOptions = periodFrequencyTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTemplateData.WorkingCapitalLoanTemplateDataBuilder delinquencyStartTypeOptions(final List<StringEnumOptionData> delinquencyStartTypeOptions) {
            this.delinquencyStartTypeOptions = delinquencyStartTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTemplateData.WorkingCapitalLoanTemplateDataBuilder breachOptions(final List<WorkingCapitalBreachData> breachOptions) {
            this.breachOptions = breachOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTemplateData.WorkingCapitalLoanTemplateDataBuilder delinquencyMinimumPaymentTypeOptions(final List<StringEnumOptionData> delinquencyMinimumPaymentTypeOptions) {
            this.delinquencyMinimumPaymentTypeOptions = delinquencyMinimumPaymentTypeOptions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTemplateData.WorkingCapitalLoanTemplateDataBuilder nearBreachOptions(final List<WorkingCapitalNearBreachData> nearBreachOptions) {
            this.nearBreachOptions = nearBreachOptions;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanTemplateData build() {
            return new WorkingCapitalLoanTemplateData(this.loanData, this.productOptions, this.fundOptions, this.delinquencyBucketOptions, this.periodFrequencyTypeOptions, this.delinquencyStartTypeOptions, this.breachOptions, this.delinquencyMinimumPaymentTypeOptions, this.nearBreachOptions);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "WorkingCapitalLoanTemplateData.WorkingCapitalLoanTemplateDataBuilder(loanData=" + this.loanData + ", productOptions=" + this.productOptions + ", fundOptions=" + this.fundOptions + ", delinquencyBucketOptions=" + this.delinquencyBucketOptions + ", periodFrequencyTypeOptions=" + this.periodFrequencyTypeOptions + ", delinquencyStartTypeOptions=" + this.delinquencyStartTypeOptions + ", breachOptions=" + this.breachOptions + ", delinquencyMinimumPaymentTypeOptions=" + this.delinquencyMinimumPaymentTypeOptions + ", nearBreachOptions=" + this.nearBreachOptions + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static WorkingCapitalLoanTemplateData.WorkingCapitalLoanTemplateDataBuilder builder() {
        return new WorkingCapitalLoanTemplateData.WorkingCapitalLoanTemplateDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanData getLoanData() {
        return this.loanData;
    }

    @java.lang.SuppressWarnings("all")
        public List<WorkingCapitalLoanProductData> getProductOptions() {
        return this.productOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<FundData> getFundOptions() {
        return this.fundOptions;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<DelinquencyBucketData> getDelinquencyBucketOptions() {
        return this.delinquencyBucketOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<StringEnumOptionData> getPeriodFrequencyTypeOptions() {
        return this.periodFrequencyTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<StringEnumOptionData> getDelinquencyStartTypeOptions() {
        return this.delinquencyStartTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<WorkingCapitalBreachData> getBreachOptions() {
        return this.breachOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<StringEnumOptionData> getDelinquencyMinimumPaymentTypeOptions() {
        return this.delinquencyMinimumPaymentTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<WorkingCapitalNearBreachData> getNearBreachOptions() {
        return this.nearBreachOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanData(final WorkingCapitalLoanData loanData) {
        this.loanData = loanData;
    }

    @java.lang.SuppressWarnings("all")
        public void setProductOptions(final List<WorkingCapitalLoanProductData> productOptions) {
        this.productOptions = productOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setFundOptions(final Collection<FundData> fundOptions) {
        this.fundOptions = fundOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyBucketOptions(final Collection<DelinquencyBucketData> delinquencyBucketOptions) {
        this.delinquencyBucketOptions = delinquencyBucketOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setPeriodFrequencyTypeOptions(final List<StringEnumOptionData> periodFrequencyTypeOptions) {
        this.periodFrequencyTypeOptions = periodFrequencyTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyStartTypeOptions(final List<StringEnumOptionData> delinquencyStartTypeOptions) {
        this.delinquencyStartTypeOptions = delinquencyStartTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setBreachOptions(final List<WorkingCapitalBreachData> breachOptions) {
        this.breachOptions = breachOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyMinimumPaymentTypeOptions(final List<StringEnumOptionData> delinquencyMinimumPaymentTypeOptions) {
        this.delinquencyMinimumPaymentTypeOptions = delinquencyMinimumPaymentTypeOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setNearBreachOptions(final List<WorkingCapitalNearBreachData> nearBreachOptions) {
        this.nearBreachOptions = nearBreachOptions;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanTemplateData() {
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanTemplateData(final WorkingCapitalLoanData loanData, final List<WorkingCapitalLoanProductData> productOptions, final Collection<FundData> fundOptions, final Collection<DelinquencyBucketData> delinquencyBucketOptions, final List<StringEnumOptionData> periodFrequencyTypeOptions, final List<StringEnumOptionData> delinquencyStartTypeOptions, final List<WorkingCapitalBreachData> breachOptions, final List<StringEnumOptionData> delinquencyMinimumPaymentTypeOptions, final List<WorkingCapitalNearBreachData> nearBreachOptions) {
        this.loanData = loanData;
        this.productOptions = productOptions;
        this.fundOptions = fundOptions;
        this.delinquencyBucketOptions = delinquencyBucketOptions;
        this.periodFrequencyTypeOptions = periodFrequencyTypeOptions;
        this.delinquencyStartTypeOptions = delinquencyStartTypeOptions;
        this.breachOptions = breachOptions;
        this.delinquencyMinimumPaymentTypeOptions = delinquencyMinimumPaymentTypeOptions;
        this.nearBreachOptions = nearBreachOptions;
    }
}
