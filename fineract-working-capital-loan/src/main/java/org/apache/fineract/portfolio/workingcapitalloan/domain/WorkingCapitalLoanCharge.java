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
import org.apache.fineract.portfolio.charge.domain.Charge;
import org.apache.fineract.portfolio.charge.domain.ChargeCalculationType;
import org.apache.fineract.portfolio.charge.domain.ChargeCalculationTypeConverter;
import org.apache.fineract.portfolio.charge.domain.ChargePaymentMode;
import org.apache.fineract.portfolio.charge.domain.ChargePaymentModeConverter;
import org.apache.fineract.portfolio.charge.domain.ChargeTimeType;
import org.apache.fineract.portfolio.charge.domain.ChargeTimeTypeConverter;
import org.apache.fineract.portfolio.workingcapitalloan.data.WorkingCapitalLoanChargeData;

@Entity
@Table(name = "m_wc_loan_charge", uniqueConstraints = {@UniqueConstraint(columnNames = {"external_id"}, name = "external_id")})
public class WorkingCapitalLoanCharge extends AbstractAuditableWithUTCDateTimeCustom<Long> {
    @ManyToOne(optional = false)
    @JoinColumn(name = "loan_id", referencedColumnName = "id", nullable = false)
    private WorkingCapitalLoan loan;
    @ManyToOne(optional = false)
    @JoinColumn(name = "charge_id", referencedColumnName = "id", nullable = false)
    private Charge charge;
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

    public WorkingCapitalLoanChargeData toData() {
        EnumOptionData chargeTimeTypeData = new EnumOptionData(getChargeTimeType().getValue().longValue(), getChargeTimeType().getCode(), String.valueOf(getChargeTimeType().getValue()));
        EnumOptionData chargeCalculationTypeData = new EnumOptionData(getChargeCalculationType().getValue().longValue(), getChargeCalculationType().getCode(), String.valueOf(getChargeCalculationType().getValue()));
        EnumOptionData chargePaymentModeData = new EnumOptionData(getChargePaymentMode().getValue().longValue(), getChargePaymentMode().getCode(), String.valueOf(getChargePaymentMode().getValue()));
        return WorkingCapitalLoanChargeData.builder().id(getId()).chargeId(getCharge().getId()).name(getCharge().getName()).currency(getCharge().toData().getCurrency()).amount(amount).amountPaid(amountPaid).amountOutstanding(getAmountOutstanding()).chargeTimeType(chargeTimeTypeData).submittedOnDate(submittedOnDate).dueDate(dueDate).chargeCalculationType(chargeCalculationTypeData).penalty(penaltyCharge).chargePaymentMode(chargePaymentModeData).paid(paid).loanId(loan.getId()).externalId(externalId).externalLoanId(loan.getExternalId()).build();
    }

    public BigDecimal getAmountOutstanding() {
        return MathUtil.subtract(getAmount(), getAmountPaid());
    }

    public static WorkingCapitalLoanCharge build(WorkingCapitalLoan loan, ExternalId externalId, Charge charge, BigDecimal amount, LocalDate dueDate, LocalDate submittedOnDate) {
        WorkingCapitalLoanCharge res = new WorkingCapitalLoanCharge();
        res.setLoan(loan);
        res.setCharge(charge);
        res.setChargeTimeType(ChargeTimeType.fromInt(charge.getChargeTimeType()));
        res.setActive(true);
        res.setExternalId(externalId);
        res.setChargeCalculationType(ChargeCalculationType.fromInt(charge.getChargeCalculation()));
        res.setChargePaymentMode(ChargePaymentMode.fromInt(charge.getChargePaymentMode()));
        res.setChargeTimeType(ChargeTimeType.fromInt(charge.getChargeTimeType()));
        res.setPenaltyCharge(charge.isPenalty());
        res.setDueDate(dueDate);
        res.setSubmittedOnDate(submittedOnDate);
        res.setAmount(amount);
        res.setAmountPaid(BigDecimal.ZERO);
        return res;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoan(final WorkingCapitalLoan loan) {
        this.loan = loan;
    }

    @java.lang.SuppressWarnings("all")
        public void setCharge(final Charge charge) {
        this.charge = charge;
    }

    @java.lang.SuppressWarnings("all")
        public void setChargeTimeType(final ChargeTimeType chargeTimeType) {
        this.chargeTimeType = chargeTimeType;
    }

    @java.lang.SuppressWarnings("all")
        public void setSubmittedOnDate(final LocalDate submittedOnDate) {
        this.submittedOnDate = submittedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setDueDate(final LocalDate dueDate) {
        this.dueDate = dueDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setChargeCalculationType(final ChargeCalculationType chargeCalculationType) {
        this.chargeCalculationType = chargeCalculationType;
    }

    @java.lang.SuppressWarnings("all")
        public void setChargePaymentMode(final ChargePaymentMode chargePaymentMode) {
        this.chargePaymentMode = chargePaymentMode;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmount(final BigDecimal amount) {
        this.amount = amount;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmountPaid(final BigDecimal amountPaid) {
        this.amountPaid = amountPaid;
    }

    @java.lang.SuppressWarnings("all")
        public void setPenaltyCharge(final boolean penaltyCharge) {
        this.penaltyCharge = penaltyCharge;
    }

    @java.lang.SuppressWarnings("all")
        public void setPaid(final boolean paid) {
        this.paid = paid;
    }

    @java.lang.SuppressWarnings("all")
        public void setActive(final boolean active) {
        this.active = active;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalId(final ExternalId externalId) {
        this.externalId = externalId;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoan getLoan() {
        return this.loan;
    }

    @java.lang.SuppressWarnings("all")
        public Charge getCharge() {
        return this.charge;
    }

    @java.lang.SuppressWarnings("all")
        public ChargeTimeType getChargeTimeType() {
        return this.chargeTimeType;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getSubmittedOnDate() {
        return this.submittedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDueDate() {
        return this.dueDate;
    }

    @java.lang.SuppressWarnings("all")
        public ChargeCalculationType getChargeCalculationType() {
        return this.chargeCalculationType;
    }

    @java.lang.SuppressWarnings("all")
        public ChargePaymentMode getChargePaymentMode() {
        return this.chargePaymentMode;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmountPaid() {
        return this.amountPaid;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isPenaltyCharge() {
        return this.penaltyCharge;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isPaid() {
        return this.paid;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isActive() {
        return this.active;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getExternalId() {
        return this.externalId;
    }
}
