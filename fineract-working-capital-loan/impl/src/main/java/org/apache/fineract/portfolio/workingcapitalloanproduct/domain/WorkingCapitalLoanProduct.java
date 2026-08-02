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

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Embedded;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.organisation.monetary.domain.MonetaryCurrency;
import org.apache.fineract.portfolio.delinquency.domain.DelinquencyBucket;
import org.apache.fineract.portfolio.fund.domain.Fund;
import org.apache.fineract.portfolio.workingcapitalloanbreach.domain.WorkingCapitalBreach;
import org.apache.fineract.portfolio.workingcapitalloannearbreach.domain.WorkingCapitalNearBreach;

/**
 * Working Capital Loan Product entity. This is a separate entity from the standard LoanProduct to provide flexibility
 * for configuring Working Capital loan products without impacting existing loan products.
 */
@Entity
@Table(name = "m_wc_loan_product", uniqueConstraints = {@UniqueConstraint(columnNames = {"name"}, name = "unq_wc_loan_product_name"), @UniqueConstraint(columnNames = {"external_id"}, name = "unq_wc_loan_product_external_id"), @UniqueConstraint(columnNames = {"short_name"}, name = "unq_wc_loan_product_short_name")})
public class WorkingCapitalLoanProduct extends AbstractPersistableCustom<Long> {
    // Details category
    @Column(name = "name", nullable = false)
    private String name;
    @Column(name = "short_name", nullable = false)
    private String shortName;
    @Column(name = "external_id", length = 100)
    private ExternalId externalId;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "fund_id")
    private Fund fund;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "delinquency_bucket_classification_id")
    private DelinquencyBucket delinquencyBucket;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "breach_id")
    private WorkingCapitalBreach breach;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "near_breach_id")
    private WorkingCapitalNearBreach nearBreach;
    @Column(name = "start_date")
    private LocalDate startDate;
    @Column(name = "close_date")
    private LocalDate closeDate;
    @Column(name = "description")
    private String description;
    // Accounting
    @Enumerated(EnumType.STRING)
    @Column(name = "accounting_type", nullable = false)
    private WorkingCapitalAccountingRuleType accountingRule;
    // Currency (MonetaryCurrency is @Embeddable)
    @Embedded
    private MonetaryCurrency currency;
    // Core product parameters
    @Embedded
    private WorkingCapitalLoanProductRelatedDetail relatedDetail;
    // Min/max constraints
    @Embedded
    private WorkingCapitalLoanProductMinMaxConstraints minMaxConstraints;
    // Payment allocation rules
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "wcProduct", orphanRemoval = true, fetch = FetchType.EAGER)
    private List<WorkingCapitalLoanProductPaymentAllocationRule> paymentAllocationRules = new ArrayList<>();
    // Configurable attributes
    @OneToOne(cascade = CascadeType.ALL, mappedBy = "wcProduct", orphanRemoval = true, fetch = FetchType.EAGER)
    private WorkingCapitalLoanProductConfigurableAttributes configurableAttributes;

    public WorkingCapitalLoanProduct(final String name, final String shortName, final ExternalId externalId, final Fund fund, final DelinquencyBucket delinquencyBucket, final LocalDate startDate, final LocalDate closeDate, final String description, final WorkingCapitalAccountingRuleType accountingRule, final MonetaryCurrency currency, final WorkingCapitalLoanProductRelatedDetail relatedDetail, final WorkingCapitalLoanProductMinMaxConstraints minMaxConstraints, final List<WorkingCapitalLoanProductPaymentAllocationRule> paymentAllocationRules, final WorkingCapitalLoanProductConfigurableAttributes configurableAttributes, final WorkingCapitalBreach breach, final WorkingCapitalNearBreach nearBreach) {
        this.name = name;
        this.shortName = shortName;
        this.externalId = externalId;
        this.fund = fund;
        this.delinquencyBucket = delinquencyBucket;
        this.breach = breach;
        this.nearBreach = nearBreach;
        this.startDate = startDate;
        this.closeDate = closeDate;
        this.description = description;
        this.accountingRule = accountingRule;
        this.currency = currency;
        this.relatedDetail = relatedDetail;
        this.minMaxConstraints = minMaxConstraints;
        this.paymentAllocationRules = paymentAllocationRules;
        if (this.paymentAllocationRules != null) {
            for (WorkingCapitalLoanProductPaymentAllocationRule rule : this.paymentAllocationRules) {
                rule.setWcProduct(this);
            }
        }
        this.configurableAttributes = configurableAttributes;
        if (this.configurableAttributes != null) {
            this.configurableAttributes.setWcProduct(this);
        }
    }

    public void updatePaymentAllocationRules(final List<WorkingCapitalLoanProductPaymentAllocationRule> newRules) {
        if (newRules != null) {
            this.paymentAllocationRules.clear();
            this.paymentAllocationRules.addAll(newRules);
        }
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public String getShortName() {
        return this.shortName;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getExternalId() {
        return this.externalId;
    }

    @java.lang.SuppressWarnings("all")
        public Fund getFund() {
        return this.fund;
    }

    @java.lang.SuppressWarnings("all")
        public DelinquencyBucket getDelinquencyBucket() {
        return this.delinquencyBucket;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalBreach getBreach() {
        return this.breach;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalNearBreach getNearBreach() {
        return this.nearBreach;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getStartDate() {
        return this.startDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getCloseDate() {
        return this.closeDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalAccountingRuleType getAccountingRule() {
        return this.accountingRule;
    }

    @java.lang.SuppressWarnings("all")
        public MonetaryCurrency getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanProductRelatedDetail getRelatedDetail() {
        return this.relatedDetail;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanProductMinMaxConstraints getMinMaxConstraints() {
        return this.minMaxConstraints;
    }

    @java.lang.SuppressWarnings("all")
        public List<WorkingCapitalLoanProductPaymentAllocationRule> getPaymentAllocationRules() {
        return this.paymentAllocationRules;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanProductConfigurableAttributes getConfigurableAttributes() {
        return this.configurableAttributes;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setShortName(final String shortName) {
        this.shortName = shortName;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalId(final ExternalId externalId) {
        this.externalId = externalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setFund(final Fund fund) {
        this.fund = fund;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyBucket(final DelinquencyBucket delinquencyBucket) {
        this.delinquencyBucket = delinquencyBucket;
    }

    @java.lang.SuppressWarnings("all")
        public void setBreach(final WorkingCapitalBreach breach) {
        this.breach = breach;
    }

    @java.lang.SuppressWarnings("all")
        public void setNearBreach(final WorkingCapitalNearBreach nearBreach) {
        this.nearBreach = nearBreach;
    }

    @java.lang.SuppressWarnings("all")
        public void setStartDate(final LocalDate startDate) {
        this.startDate = startDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setCloseDate(final LocalDate closeDate) {
        this.closeDate = closeDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setDescription(final String description) {
        this.description = description;
    }

    @java.lang.SuppressWarnings("all")
        public void setAccountingRule(final WorkingCapitalAccountingRuleType accountingRule) {
        this.accountingRule = accountingRule;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrency(final MonetaryCurrency currency) {
        this.currency = currency;
    }

    @java.lang.SuppressWarnings("all")
        public void setRelatedDetail(final WorkingCapitalLoanProductRelatedDetail relatedDetail) {
        this.relatedDetail = relatedDetail;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinMaxConstraints(final WorkingCapitalLoanProductMinMaxConstraints minMaxConstraints) {
        this.minMaxConstraints = minMaxConstraints;
    }

    @java.lang.SuppressWarnings("all")
        public void setPaymentAllocationRules(final List<WorkingCapitalLoanProductPaymentAllocationRule> paymentAllocationRules) {
        this.paymentAllocationRules = paymentAllocationRules;
    }

    @java.lang.SuppressWarnings("all")
        public void setConfigurableAttributes(final WorkingCapitalLoanProductConfigurableAttributes configurableAttributes) {
        this.configurableAttributes = configurableAttributes;
    }

    @java.lang.SuppressWarnings("all")
        protected WorkingCapitalLoanProduct() {
    }
}
