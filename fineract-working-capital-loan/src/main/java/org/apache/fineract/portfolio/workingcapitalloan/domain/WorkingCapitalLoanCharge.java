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
package org.apache.fineract.portfolio.workingcapitalloan.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Convert;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import java.math.BigDecimal;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableWithUTCDateTimeCustom;
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.infrastructure.core.service.MathUtil;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeCalculationType;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeCalculationTypeConverter;
import org.apache.fineract.portfolio.charge.moduleapi.ChargePaymentMode;
import org.apache.fineract.portfolio.charge.moduleapi.ChargePaymentModeConverter;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeTimeType;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeTimeTypeConverter;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionData;
import org.apache.fineract.portfolio.workingcapitalloan.data.WorkingCapitalLoanChargeData;

@Entity
@Table(name = "m_wc_loan_charge", uniqueConstraints = {@UniqueConstraint(columnNames = {"external_id"}, name = "external_id")})
public class WorkingCapitalLoanCharge extends AbstractAuditableWithUTCDateTimeCustom<Long> {
    @ManyToOne(optional = false)
    @JoinColumn(name = "loan_id", referencedColumnName = "id", nullable = false)
    private WorkingCapitalLoan loan;
    /** Catalog charge definition id (no JPA association to charge-impl). */
    @Column(name = "charge_id", nullable = false)
    private Long chargeId;
    @Column(name = "charge_time_type", nullable = false)
    @Convert(converter = ChargeTimeTypeConverter.class)
    private ChargeTimeType chargeTimeType;
    @Column(name = "submitted_on_date")
    private LocalDate submittedOnDate;
    @Column(name = "due_date")
    private LocalDate dueDate;
    @Column(name = "charge_calculation_type")
    @Convert(converter = ChargeCalculationTypeConverter.class)
    private ChargeCalculationType chargeCalculationType;
    @Column(name = "charge_payment_mode")
    @Convert(converter = ChargePaymentModeConverter.class)
    private ChargePaymentMode chargePaymentMode;
    @Column(name = "amount", scale = 6, precision = 19, nullable = false)
    private BigDecimal amount;
    @Column(name = "amount_paid", scale = 6, precision = 19)
    private BigDecimal amountPaid;
    @Column(name = "is_penalty", nullable = false)
    private boolean penaltyCharge = false;
    @Column(name = "is_paid", nullable = false)
    private boolean paid = false;
    @Column(name = "is_active", nullable = false)
    private boolean active = true;
    @Column(name = "external_id")
    private ExternalId externalId;

    public WorkingCapitalLoanChargeData toData(final ChargeDefinitionData catalog) {
        final EnumOptionData chargeTimeTypeData = new EnumOptionData(getChargeTimeType().getValue().longValue(), getChargeTimeType().getCode(),
                String.valueOf(getChargeTimeType().getValue()));
        final EnumOptionData chargeCalculationTypeData = new EnumOptionData(getChargeCalculationType().getValue().longValue(),
                getChargeCalculationType().getCode(), String.valueOf(getChargeCalculationType().getValue()));
        final EnumOptionData chargePaymentModeData = new EnumOptionData(getChargePaymentMode().getValue().longValue(),
                getChargePaymentMode().getCode(), String.valueOf(getChargePaymentMode().getValue()));
        final String name = catalog != null ? catalog.getName() : null;
        final CurrencyData currency = catalog != null ? new CurrencyData(catalog.getCurrencyCode()) : null;
        return WorkingCapitalLoanChargeData.builder().id(getId()).chargeId(getChargeId()).name(name).currency(currency).amount(amount)
                .amountPaid(amountPaid).amountOutstanding(getAmountOutstanding()).chargeTimeType(chargeTimeTypeData)
                .submittedOnDate(submittedOnDate).dueDate(dueDate).chargeCalculationType(chargeCalculationTypeData).penalty(penaltyCharge)
                .chargePaymentMode(chargePaymentModeData).paid(paid).loanId(loan.getId()).externalId(externalId)
                .externalLoanId(loan.getExternalId()).build();
    }

    public BigDecimal getAmountOutstanding() {
        return MathUtil.subtract(getAmount(), getAmountPaid());
    }

    public static WorkingCapitalLoanCharge build(WorkingCapitalLoan loan, ExternalId externalId, ChargeDefinitionData chargeDefinition,
            BigDecimal amount, LocalDate dueDate, LocalDate submittedOnDate) {
        WorkingCapitalLoanCharge res = new WorkingCapitalLoanCharge();
        res.setLoan(loan);
        res.setChargeId(chargeDefinition.getId());
        res.setChargeTimeType(ChargeTimeType.fromInt(chargeDefinition.getChargeTimeType()));
        res.setActive(true);
        res.setExternalId(externalId);
        res.setChargeCalculationType(ChargeCalculationType.fromInt(chargeDefinition.getChargeCalculationType()));
        res.setChargePaymentMode(ChargePaymentMode.fromInt(chargeDefinition.getChargePaymentMode()));
        res.setPenaltyCharge(chargeDefinition.isPenalty());
        res.setDueDate(dueDate);
        res.setSubmittedOnDate(submittedOnDate);
        res.setAmount(amount);
        res.setAmountPaid(BigDecimal.ZERO);
        return res;
    }

    public void setLoan(final WorkingCapitalLoan loan) {
        this.loan = loan;
    }

    public void setChargeId(final Long chargeId) {
        this.chargeId = chargeId;
    }

    public void setChargeTimeType(final ChargeTimeType chargeTimeType) {
        this.chargeTimeType = chargeTimeType;
    }

    public void setSubmittedOnDate(final LocalDate submittedOnDate) {
        this.submittedOnDate = submittedOnDate;
    }

    public void setDueDate(final LocalDate dueDate) {
        this.dueDate = dueDate;
    }

    public void setChargeCalculationType(final ChargeCalculationType chargeCalculationType) {
        this.chargeCalculationType = chargeCalculationType;
    }

    public void setChargePaymentMode(final ChargePaymentMode chargePaymentMode) {
        this.chargePaymentMode = chargePaymentMode;
    }

    public void setAmount(final BigDecimal amount) {
        this.amount = amount;
    }

    public void setAmountPaid(final BigDecimal amountPaid) {
        this.amountPaid = amountPaid;
    }

    public void setPenaltyCharge(final boolean penaltyCharge) {
        this.penaltyCharge = penaltyCharge;
    }

    public void setPaid(final boolean paid) {
        this.paid = paid;
    }

    public void setActive(final boolean active) {
        this.active = active;
    }

    public void setExternalId(final ExternalId externalId) {
        this.externalId = externalId;
    }

    public WorkingCapitalLoan getLoan() {
        return this.loan;
    }

    public Long getChargeId() {
        return this.chargeId;
    }

    public ChargeTimeType getChargeTimeType() {
        return this.chargeTimeType;
    }

    public LocalDate getSubmittedOnDate() {
        return this.submittedOnDate;
    }

    public LocalDate getDueDate() {
        return this.dueDate;
    }

    public ChargeCalculationType getChargeCalculationType() {
        return this.chargeCalculationType;
    }

    public ChargePaymentMode getChargePaymentMode() {
        return this.chargePaymentMode;
    }

    public BigDecimal getAmount() {
        return this.amount;
    }

    public BigDecimal getAmountPaid() {
        return this.amountPaid;
    }

    public boolean isPenaltyCharge() {
        return this.penaltyCharge;
    }

    public boolean isPaid() {
        return this.paid;
    }

    public boolean isActive() {
        return this.active;
    }

    public ExternalId getExternalId() {
        return this.externalId;
    }
}
