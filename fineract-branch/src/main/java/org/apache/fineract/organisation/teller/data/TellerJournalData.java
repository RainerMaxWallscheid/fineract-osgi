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
package org.apache.fineract.organisation.teller.data;

import java.io.Serializable;
import java.time.LocalDate;

/**
 * {@code TellerJournalData} represents an immutable journal data object.
 *
 * @version 1.0.0
 *
 * @since 2.0.0
 * @see java.io.Serializable
 * @since 2.0.0
 */
public final class TellerJournalData implements Serializable {
    private Long officeId;
    private Long tellerId;
    private LocalDate day;
    private Double openingBalance;
    private Double settledBalance;
    private Double closingBalance;
    private Double sumReceipts;
    private Double sumPayments;

    /**
     * Create a new teller journal data object.
     *
     * @param officeId
     *            - id of related office
     * @param tellerId
     *            - id of related teller
     * @param day
     *            - day of this journals data
     * @param openingBalance
     *            - balance at the time of opening the teller
     * @param settledBalance
     *            - balance at the time od settling the teller
     * @param closingBalance
     *            - balance at the time of closing the teller
     * @param sumReceipts
     *            - sum of all posted receipts
     * @param sumPayments
     *            - sum of all posted payments
     * @return the new created {@code TellerJournalData}
     */
    public static TellerJournalData instance(final Long officeId, final Long tellerId, final LocalDate day, final Double openingBalance, final Double settledBalance, final Double closingBalance, final Double sumReceipts, final Double sumPayments) {
        return new TellerJournalData().setOfficeId(officeId).setTellerId(tellerId).setDay(day).setOpeningBalance(openingBalance).setSettledBalance(settledBalance).setClosingBalance(closingBalance).setSumReceipts(sumReceipts).setSumPayments(sumPayments);
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getTellerId() {
        return this.tellerId;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDay() {
        return this.day;
    }

    @java.lang.SuppressWarnings("all")
        public Double getOpeningBalance() {
        return this.openingBalance;
    }

    @java.lang.SuppressWarnings("all")
        public Double getSettledBalance() {
        return this.settledBalance;
    }

    @java.lang.SuppressWarnings("all")
        public Double getClosingBalance() {
        return this.closingBalance;
    }

    @java.lang.SuppressWarnings("all")
        public Double getSumReceipts() {
        return this.sumReceipts;
    }

    @java.lang.SuppressWarnings("all")
        public Double getSumPayments() {
        return this.sumPayments;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerJournalData setOfficeId(final Long officeId) {
        this.officeId = officeId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerJournalData setTellerId(final Long tellerId) {
        this.tellerId = tellerId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerJournalData setDay(final LocalDate day) {
        this.day = day;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerJournalData setOpeningBalance(final Double openingBalance) {
        this.openingBalance = openingBalance;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerJournalData setSettledBalance(final Double settledBalance) {
        this.settledBalance = settledBalance;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerJournalData setClosingBalance(final Double closingBalance) {
        this.closingBalance = closingBalance;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerJournalData setSumReceipts(final Double sumReceipts) {
        this.sumReceipts = sumReceipts;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public TellerJournalData setSumPayments(final Double sumPayments) {
        this.sumPayments = sumPayments;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof TellerJournalData)) return false;
        final TellerJournalData other = (TellerJournalData) o;
        final java.lang.Object this$officeId = this.getOfficeId();
        final java.lang.Object other$officeId = other.getOfficeId();
        if (this$officeId == null ? other$officeId != null : !this$officeId.equals(other$officeId)) return false;
        final java.lang.Object this$tellerId = this.getTellerId();
        final java.lang.Object other$tellerId = other.getTellerId();
        if (this$tellerId == null ? other$tellerId != null : !this$tellerId.equals(other$tellerId)) return false;
        final java.lang.Object this$openingBalance = this.getOpeningBalance();
        final java.lang.Object other$openingBalance = other.getOpeningBalance();
        if (this$openingBalance == null ? other$openingBalance != null : !this$openingBalance.equals(other$openingBalance)) return false;
        final java.lang.Object this$settledBalance = this.getSettledBalance();
        final java.lang.Object other$settledBalance = other.getSettledBalance();
        if (this$settledBalance == null ? other$settledBalance != null : !this$settledBalance.equals(other$settledBalance)) return false;
        final java.lang.Object this$closingBalance = this.getClosingBalance();
        final java.lang.Object other$closingBalance = other.getClosingBalance();
        if (this$closingBalance == null ? other$closingBalance != null : !this$closingBalance.equals(other$closingBalance)) return false;
        final java.lang.Object this$sumReceipts = this.getSumReceipts();
        final java.lang.Object other$sumReceipts = other.getSumReceipts();
        if (this$sumReceipts == null ? other$sumReceipts != null : !this$sumReceipts.equals(other$sumReceipts)) return false;
        final java.lang.Object this$sumPayments = this.getSumPayments();
        final java.lang.Object other$sumPayments = other.getSumPayments();
        if (this$sumPayments == null ? other$sumPayments != null : !this$sumPayments.equals(other$sumPayments)) return false;
        final java.lang.Object this$day = this.getDay();
        final java.lang.Object other$day = other.getDay();
        if (this$day == null ? other$day != null : !this$day.equals(other$day)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $officeId = this.getOfficeId();
        result = result * PRIME + ($officeId == null ? 43 : $officeId.hashCode());
        final java.lang.Object $tellerId = this.getTellerId();
        result = result * PRIME + ($tellerId == null ? 43 : $tellerId.hashCode());
        final java.lang.Object $openingBalance = this.getOpeningBalance();
        result = result * PRIME + ($openingBalance == null ? 43 : $openingBalance.hashCode());
        final java.lang.Object $settledBalance = this.getSettledBalance();
        result = result * PRIME + ($settledBalance == null ? 43 : $settledBalance.hashCode());
        final java.lang.Object $closingBalance = this.getClosingBalance();
        result = result * PRIME + ($closingBalance == null ? 43 : $closingBalance.hashCode());
        final java.lang.Object $sumReceipts = this.getSumReceipts();
        result = result * PRIME + ($sumReceipts == null ? 43 : $sumReceipts.hashCode());
        final java.lang.Object $sumPayments = this.getSumPayments();
        result = result * PRIME + ($sumPayments == null ? 43 : $sumPayments.hashCode());
        final java.lang.Object $day = this.getDay();
        result = result * PRIME + ($day == null ? 43 : $day.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "TellerJournalData(officeId=" + this.getOfficeId() + ", tellerId=" + this.getTellerId() + ", day=" + this.getDay() + ", openingBalance=" + this.getOpeningBalance() + ", settledBalance=" + this.getSettledBalance() + ", closingBalance=" + this.getClosingBalance() + ", sumReceipts=" + this.getSumReceipts() + ", sumPayments=" + this.getSumPayments() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public TellerJournalData() {
    }

    @java.lang.SuppressWarnings("all")
        public TellerJournalData(final Long officeId, final Long tellerId, final LocalDate day, final Double openingBalance, final Double settledBalance, final Double closingBalance, final Double sumReceipts, final Double sumPayments) {
        this.officeId = officeId;
        this.tellerId = tellerId;
        this.day = day;
        this.openingBalance = openingBalance;
        this.settledBalance = settledBalance;
        this.closingBalance = closingBalance;
        this.sumReceipts = sumReceipts;
        this.sumPayments = sumPayments;
    }
}
