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
package org.apache.fineract.portfolio.workingcapitalloanproduct.data;

import java.io.Serializable;

/**
 * Data Transfer Object for Configurable Attributes.
 */
public class WorkingCapitalLoanProductConfigurableAttributesData implements Serializable {
    private boolean delinquencyBucketClassification;
    private boolean breach;
    private boolean discountDefault;
    private boolean periodPaymentFrequency;
    private boolean periodPaymentFrequencyType;


    @java.lang.SuppressWarnings("all")
        public static class WorkingCapitalLoanProductConfigurableAttributesDataBuilder {
        @java.lang.SuppressWarnings("all")
                private boolean delinquencyBucketClassification;
        @java.lang.SuppressWarnings("all")
                private boolean breach;
        @java.lang.SuppressWarnings("all")
                private boolean discountDefault;
        @java.lang.SuppressWarnings("all")
                private boolean periodPaymentFrequency;
        @java.lang.SuppressWarnings("all")
                private boolean periodPaymentFrequencyType;

        @java.lang.SuppressWarnings("all")
                WorkingCapitalLoanProductConfigurableAttributesDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductConfigurableAttributesData.WorkingCapitalLoanProductConfigurableAttributesDataBuilder delinquencyBucketClassification(final boolean delinquencyBucketClassification) {
            this.delinquencyBucketClassification = delinquencyBucketClassification;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductConfigurableAttributesData.WorkingCapitalLoanProductConfigurableAttributesDataBuilder breach(final boolean breach) {
            this.breach = breach;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductConfigurableAttributesData.WorkingCapitalLoanProductConfigurableAttributesDataBuilder discountDefault(final boolean discountDefault) {
            this.discountDefault = discountDefault;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductConfigurableAttributesData.WorkingCapitalLoanProductConfigurableAttributesDataBuilder periodPaymentFrequency(final boolean periodPaymentFrequency) {
            this.periodPaymentFrequency = periodPaymentFrequency;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductConfigurableAttributesData.WorkingCapitalLoanProductConfigurableAttributesDataBuilder periodPaymentFrequencyType(final boolean periodPaymentFrequencyType) {
            this.periodPaymentFrequencyType = periodPaymentFrequencyType;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanProductConfigurableAttributesData build() {
            return new WorkingCapitalLoanProductConfigurableAttributesData(this.delinquencyBucketClassification, this.breach, this.discountDefault, this.periodPaymentFrequency, this.periodPaymentFrequencyType);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "WorkingCapitalLoanProductConfigurableAttributesData.WorkingCapitalLoanProductConfigurableAttributesDataBuilder(delinquencyBucketClassification=" + this.delinquencyBucketClassification + ", breach=" + this.breach + ", discountDefault=" + this.discountDefault + ", periodPaymentFrequency=" + this.periodPaymentFrequency + ", periodPaymentFrequencyType=" + this.periodPaymentFrequencyType + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static WorkingCapitalLoanProductConfigurableAttributesData.WorkingCapitalLoanProductConfigurableAttributesDataBuilder builder() {
        return new WorkingCapitalLoanProductConfigurableAttributesData.WorkingCapitalLoanProductConfigurableAttributesDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public boolean isDelinquencyBucketClassification() {
        return this.delinquencyBucketClassification;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isBreach() {
        return this.breach;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isDiscountDefault() {
        return this.discountDefault;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isPeriodPaymentFrequency() {
        return this.periodPaymentFrequency;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isPeriodPaymentFrequencyType() {
        return this.periodPaymentFrequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyBucketClassification(final boolean delinquencyBucketClassification) {
        this.delinquencyBucketClassification = delinquencyBucketClassification;
    }

    @java.lang.SuppressWarnings("all")
        public void setBreach(final boolean breach) {
        this.breach = breach;
    }

    @java.lang.SuppressWarnings("all")
        public void setDiscountDefault(final boolean discountDefault) {
        this.discountDefault = discountDefault;
    }

    @java.lang.SuppressWarnings("all")
        public void setPeriodPaymentFrequency(final boolean periodPaymentFrequency) {
        this.periodPaymentFrequency = periodPaymentFrequency;
    }

    @java.lang.SuppressWarnings("all")
        public void setPeriodPaymentFrequencyType(final boolean periodPaymentFrequencyType) {
        this.periodPaymentFrequencyType = periodPaymentFrequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanProductConfigurableAttributesData() {
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanProductConfigurableAttributesData(final boolean delinquencyBucketClassification, final boolean breach, final boolean discountDefault, final boolean periodPaymentFrequency, final boolean periodPaymentFrequencyType) {
        this.delinquencyBucketClassification = delinquencyBucketClassification;
        this.breach = breach;
        this.discountDefault = discountDefault;
        this.periodPaymentFrequency = periodPaymentFrequency;
        this.periodPaymentFrequencyType = periodPaymentFrequencyType;
    }
}
