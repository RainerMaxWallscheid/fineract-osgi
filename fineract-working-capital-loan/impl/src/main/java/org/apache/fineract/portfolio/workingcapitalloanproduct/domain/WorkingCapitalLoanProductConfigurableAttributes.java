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
package org.apache.fineract.portfolio.workingcapitalloanproduct.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;

/**
 * Configurable attributes for Working Capital Loan Product. Fields that can be overridden during loan creation.
 */
@Entity
@Table(name = "m_wc_loan_product_configurable_attributes")
public class WorkingCapitalLoanProductConfigurableAttributes extends AbstractPersistableCustom<Long> {
    @OneToOne
    @JoinColumn(name = "wc_loan_product_id", nullable = false)
    private WorkingCapitalLoanProduct wcProduct;
    @Column(name = "delinquency_bucket_classification_overridable")
    private boolean delinquencyBucketClassification;
    @Column(name = "breach_overridable")
    private boolean breach;
    @Column(name = "discount_default_overridable")
    private boolean discountDefaultOverridable;
    @Column(name = "period_payment_frequency_overridable")
    private boolean periodPaymentFrequency;
    @Column(name = "period_payment_frequency_type_overridable")
    private boolean periodPaymentFrequencyType;

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanProduct getWcProduct() {
        return this.wcProduct;
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
        public boolean isDiscountDefaultOverridable() {
        return this.discountDefaultOverridable;
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
        public void setWcProduct(final WorkingCapitalLoanProduct wcProduct) {
        this.wcProduct = wcProduct;
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
        public void setDiscountDefaultOverridable(final boolean discountDefaultOverridable) {
        this.discountDefaultOverridable = discountDefaultOverridable;
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
        public WorkingCapitalLoanProductConfigurableAttributes(final WorkingCapitalLoanProduct wcProduct, final boolean delinquencyBucketClassification, final boolean breach, final boolean discountDefaultOverridable, final boolean periodPaymentFrequency, final boolean periodPaymentFrequencyType) {
        this.wcProduct = wcProduct;
        this.delinquencyBucketClassification = delinquencyBucketClassification;
        this.breach = breach;
        this.discountDefaultOverridable = discountDefaultOverridable;
        this.periodPaymentFrequency = periodPaymentFrequency;
        this.periodPaymentFrequencyType = periodPaymentFrequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanProductConfigurableAttributes() {
    }
}
