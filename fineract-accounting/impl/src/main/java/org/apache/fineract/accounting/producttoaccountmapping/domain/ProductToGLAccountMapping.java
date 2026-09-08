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
package org.apache.fineract.accounting.producttoaccountmapping.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import org.apache.fineract.accounting.moduleapi.GLAccountAssociation;
import org.apache.fineract.infrastructure.codes.moduleapi.CodeValueAssociation;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.portfolio.paymenttype.domain.PaymentType;

@Entity
@Table(name = "acc_product_mapping", uniqueConstraints = {@UniqueConstraint(columnNames = {"product_id", "product_type", "financial_account_type", "payment_type"}, name = "financial_action")})
public class ProductToGLAccountMapping extends AbstractPersistableCustom<Long> {
    /**
     * GL account id (no JPA association to leftover GLAccount — ADR-021).
     */
    @Column(name = "gl_account_id")
    private Long glAccountId;
    @Column(name = "product_id", nullable = true)
    private Long productId;
    @ManyToOne
    @JoinColumn(name = "payment_type", nullable = true)
    private PaymentType paymentType;
    /**
     * Catalog charge definition id (no JPA association to charge-impl entity — ADR-021 / charge Step 8).
     */
    @Column(name = "charge_id", nullable = true)
    private Long chargeId;
    @Column(name = "product_type", nullable = true)
    private int productType;
    @Column(name = "financial_account_type", nullable = true)
    private int financialAccountType;
    /**
     * Code-value id (no JPA association to leftover CodeValue — ADR-021).
     */
    @Column(name = "charge_off_reason_id")
    private Long chargeOffReasonId;
    /**
     * Code-value id (no JPA association to leftover CodeValue — ADR-021).
     */
    @Column(name = "write_off_reason_id")
    private Long writeOffReasonId;
    /**
     * Code-value id (no JPA association to leftover CodeValue — ADR-021).
     */
    @Column(name = "capitalized_income_classification_id")
    private Long capitalizedIncomeClassificationId;
    /**
     * Code-value id (no JPA association to leftover CodeValue — ADR-021).
     */
    @Column(name = "buydown_fee_classification_id")
    private Long buydownFeeClassificationId;

    public static ProductToGLAccountMapping createNew(final Object glAccount, final Long productId, final int productType, final int financialAccountType, final Object chargeOffReason, final Object capitalizedIncomeClassification, final Object buydownFeeClassification) {
        return new ProductToGLAccountMapping().setGlAccount(glAccount).setProductId(productId).setProductType(productType).setFinancialAccountType(financialAccountType).setChargeOffReason(chargeOffReason).setCapitalizedIncomeClassification(capitalizedIncomeClassification).setBuydownFeeClassification(buydownFeeClassification);
    }

    @java.lang.SuppressWarnings("all")
        public Long getGlAccountId() {
        return this.glAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getProductId() {
        return this.productId;
    }

    @java.lang.SuppressWarnings("all")
        public PaymentType getPaymentType() {
        return this.paymentType;
    }

    @java.lang.SuppressWarnings("all")
        public Long getChargeId() {
        return this.chargeId;
    }

    @java.lang.SuppressWarnings("all")
        public int getProductType() {
        return this.productType;
    }

    @java.lang.SuppressWarnings("all")
        public int getFinancialAccountType() {
        return this.financialAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public Long getChargeOffReasonId() {
        return this.chargeOffReasonId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getWriteOffReasonId() {
        return this.writeOffReasonId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCapitalizedIncomeClassificationId() {
        return this.capitalizedIncomeClassificationId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getBuydownFeeClassificationId() {
        return this.buydownFeeClassificationId;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProductToGLAccountMapping setGlAccount(final Object glAccount) {
        this.glAccountId = GLAccountAssociation.id(glAccount);
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProductToGLAccountMapping setProductId(final Long productId) {
        this.productId = productId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProductToGLAccountMapping setPaymentType(final PaymentType paymentType) {
        this.paymentType = paymentType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProductToGLAccountMapping setChargeId(final Long chargeId) {
        this.chargeId = chargeId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProductToGLAccountMapping setProductType(final int productType) {
        this.productType = productType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProductToGLAccountMapping setFinancialAccountType(final int financialAccountType) {
        this.financialAccountType = financialAccountType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProductToGLAccountMapping setChargeOffReason(final Object chargeOffReason) {
        this.chargeOffReasonId = CodeValueAssociation.id(chargeOffReason);
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProductToGLAccountMapping setWriteOffReason(final Object writeOffReason) {
        this.writeOffReasonId = CodeValueAssociation.id(writeOffReason);
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProductToGLAccountMapping setCapitalizedIncomeClassification(final Object capitalizedIncomeClassification) {
        this.capitalizedIncomeClassificationId = CodeValueAssociation.id(capitalizedIncomeClassification);
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public ProductToGLAccountMapping setBuydownFeeClassification(final Object buydownFeeClassification) {
        this.buydownFeeClassificationId = CodeValueAssociation.id(buydownFeeClassification);
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public ProductToGLAccountMapping() {
    }
}
