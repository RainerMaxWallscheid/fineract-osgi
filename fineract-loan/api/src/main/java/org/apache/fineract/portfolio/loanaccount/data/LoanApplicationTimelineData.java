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

import java.time.LocalDate;

/**
 * Data object represent the important time-line events of a loan application and loan.
 */
public class LoanApplicationTimelineData {
    private LocalDate submittedOnDate;
    private String submittedByUsername;
    private String submittedByFirstname;
    private String submittedByLastname;
    private LocalDate rejectedOnDate;
    private String rejectedByUsername;
    private String rejectedByFirstname;
    private String rejectedByLastname;
    private LocalDate withdrawnOnDate;
    private String withdrawnByUsername;
    private String withdrawnByFirstname;
    private String withdrawnByLastname;
    private LocalDate approvedOnDate;
    private String approvedByUsername;
    private String approvedByFirstname;
    private String approvedByLastname;
    private LocalDate expectedDisbursementDate;
    private LocalDate actualDisbursementDate;
    private String disbursedByUsername;
    private String disbursedByFirstname;
    private String disbursedByLastname;
    private LocalDate closedOnDate;
    private String closedByUsername;
    private String closedByFirstname;
    private String closedByLastname;
    private LocalDate actualMaturityDate;
    private LocalDate expectedMaturityDate;
    private LocalDate writeOffOnDate;
    private String writeOffByUsername;
    private String writeOffByFirstname;
    private String writeOffByLastname;
    private LocalDate chargedOffOnDate;
    private String chargedOffByUsername;
    private String chargedOffByFirstname;
    private String chargedOffByLastname;

    public LocalDate getDisbursementDate() {
        LocalDate disbursementDate = this.expectedDisbursementDate;
        if (this.actualDisbursementDate != null) {
            disbursementDate = this.actualDisbursementDate;
        }
        return disbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getSubmittedOnDate() {
        return this.submittedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getSubmittedByUsername() {
        return this.submittedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getSubmittedByFirstname() {
        return this.submittedByFirstname;
    }

    @java.lang.SuppressWarnings("all")
        public String getSubmittedByLastname() {
        return this.submittedByLastname;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getRejectedOnDate() {
        return this.rejectedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getRejectedByUsername() {
        return this.rejectedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getRejectedByFirstname() {
        return this.rejectedByFirstname;
    }

    @java.lang.SuppressWarnings("all")
        public String getRejectedByLastname() {
        return this.rejectedByLastname;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getWithdrawnOnDate() {
        return this.withdrawnOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getWithdrawnByUsername() {
        return this.withdrawnByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getWithdrawnByFirstname() {
        return this.withdrawnByFirstname;
    }

    @java.lang.SuppressWarnings("all")
        public String getWithdrawnByLastname() {
        return this.withdrawnByLastname;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getApprovedOnDate() {
        return this.approvedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getApprovedByUsername() {
        return this.approvedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getApprovedByFirstname() {
        return this.approvedByFirstname;
    }

    @java.lang.SuppressWarnings("all")
        public String getApprovedByLastname() {
        return this.approvedByLastname;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getExpectedDisbursementDate() {
        return this.expectedDisbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getActualDisbursementDate() {
        return this.actualDisbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getDisbursedByUsername() {
        return this.disbursedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getDisbursedByFirstname() {
        return this.disbursedByFirstname;
    }

    @java.lang.SuppressWarnings("all")
        public String getDisbursedByLastname() {
        return this.disbursedByLastname;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getClosedOnDate() {
        return this.closedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getClosedByUsername() {
        return this.closedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getClosedByFirstname() {
        return this.closedByFirstname;
    }

    @java.lang.SuppressWarnings("all")
        public String getClosedByLastname() {
        return this.closedByLastname;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getActualMaturityDate() {
        return this.actualMaturityDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getExpectedMaturityDate() {
        return this.expectedMaturityDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getWriteOffOnDate() {
        return this.writeOffOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getWriteOffByUsername() {
        return this.writeOffByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getWriteOffByFirstname() {
        return this.writeOffByFirstname;
    }

    @java.lang.SuppressWarnings("all")
        public String getWriteOffByLastname() {
        return this.writeOffByLastname;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getChargedOffOnDate() {
        return this.chargedOffOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getChargedOffByUsername() {
        return this.chargedOffByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getChargedOffByFirstname() {
        return this.chargedOffByFirstname;
    }

    @java.lang.SuppressWarnings("all")
        public String getChargedOffByLastname() {
        return this.chargedOffByLastname;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setSubmittedOnDate(final LocalDate submittedOnDate) {
        this.submittedOnDate = submittedOnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setSubmittedByUsername(final String submittedByUsername) {
        this.submittedByUsername = submittedByUsername;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setSubmittedByFirstname(final String submittedByFirstname) {
        this.submittedByFirstname = submittedByFirstname;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setSubmittedByLastname(final String submittedByLastname) {
        this.submittedByLastname = submittedByLastname;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setRejectedOnDate(final LocalDate rejectedOnDate) {
        this.rejectedOnDate = rejectedOnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setRejectedByUsername(final String rejectedByUsername) {
        this.rejectedByUsername = rejectedByUsername;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setRejectedByFirstname(final String rejectedByFirstname) {
        this.rejectedByFirstname = rejectedByFirstname;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setRejectedByLastname(final String rejectedByLastname) {
        this.rejectedByLastname = rejectedByLastname;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setWithdrawnOnDate(final LocalDate withdrawnOnDate) {
        this.withdrawnOnDate = withdrawnOnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setWithdrawnByUsername(final String withdrawnByUsername) {
        this.withdrawnByUsername = withdrawnByUsername;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setWithdrawnByFirstname(final String withdrawnByFirstname) {
        this.withdrawnByFirstname = withdrawnByFirstname;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setWithdrawnByLastname(final String withdrawnByLastname) {
        this.withdrawnByLastname = withdrawnByLastname;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setApprovedOnDate(final LocalDate approvedOnDate) {
        this.approvedOnDate = approvedOnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setApprovedByUsername(final String approvedByUsername) {
        this.approvedByUsername = approvedByUsername;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setApprovedByFirstname(final String approvedByFirstname) {
        this.approvedByFirstname = approvedByFirstname;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setApprovedByLastname(final String approvedByLastname) {
        this.approvedByLastname = approvedByLastname;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setExpectedDisbursementDate(final LocalDate expectedDisbursementDate) {
        this.expectedDisbursementDate = expectedDisbursementDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setActualDisbursementDate(final LocalDate actualDisbursementDate) {
        this.actualDisbursementDate = actualDisbursementDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setDisbursedByUsername(final String disbursedByUsername) {
        this.disbursedByUsername = disbursedByUsername;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setDisbursedByFirstname(final String disbursedByFirstname) {
        this.disbursedByFirstname = disbursedByFirstname;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setDisbursedByLastname(final String disbursedByLastname) {
        this.disbursedByLastname = disbursedByLastname;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setClosedOnDate(final LocalDate closedOnDate) {
        this.closedOnDate = closedOnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setClosedByUsername(final String closedByUsername) {
        this.closedByUsername = closedByUsername;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setClosedByFirstname(final String closedByFirstname) {
        this.closedByFirstname = closedByFirstname;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setClosedByLastname(final String closedByLastname) {
        this.closedByLastname = closedByLastname;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setActualMaturityDate(final LocalDate actualMaturityDate) {
        this.actualMaturityDate = actualMaturityDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setExpectedMaturityDate(final LocalDate expectedMaturityDate) {
        this.expectedMaturityDate = expectedMaturityDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setWriteOffOnDate(final LocalDate writeOffOnDate) {
        this.writeOffOnDate = writeOffOnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setWriteOffByUsername(final String writeOffByUsername) {
        this.writeOffByUsername = writeOffByUsername;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setWriteOffByFirstname(final String writeOffByFirstname) {
        this.writeOffByFirstname = writeOffByFirstname;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setWriteOffByLastname(final String writeOffByLastname) {
        this.writeOffByLastname = writeOffByLastname;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setChargedOffOnDate(final LocalDate chargedOffOnDate) {
        this.chargedOffOnDate = chargedOffOnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setChargedOffByUsername(final String chargedOffByUsername) {
        this.chargedOffByUsername = chargedOffByUsername;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setChargedOffByFirstname(final String chargedOffByFirstname) {
        this.chargedOffByFirstname = chargedOffByFirstname;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData setChargedOffByLastname(final String chargedOffByLastname) {
        this.chargedOffByLastname = chargedOffByLastname;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanApplicationTimelineData)) return false;
        final LoanApplicationTimelineData other = (LoanApplicationTimelineData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$submittedOnDate = this.getSubmittedOnDate();
        final java.lang.Object other$submittedOnDate = other.getSubmittedOnDate();
        if (this$submittedOnDate == null ? other$submittedOnDate != null : !this$submittedOnDate.equals(other$submittedOnDate)) return false;
        final java.lang.Object this$submittedByUsername = this.getSubmittedByUsername();
        final java.lang.Object other$submittedByUsername = other.getSubmittedByUsername();
        if (this$submittedByUsername == null ? other$submittedByUsername != null : !this$submittedByUsername.equals(other$submittedByUsername)) return false;
        final java.lang.Object this$submittedByFirstname = this.getSubmittedByFirstname();
        final java.lang.Object other$submittedByFirstname = other.getSubmittedByFirstname();
        if (this$submittedByFirstname == null ? other$submittedByFirstname != null : !this$submittedByFirstname.equals(other$submittedByFirstname)) return false;
        final java.lang.Object this$submittedByLastname = this.getSubmittedByLastname();
        final java.lang.Object other$submittedByLastname = other.getSubmittedByLastname();
        if (this$submittedByLastname == null ? other$submittedByLastname != null : !this$submittedByLastname.equals(other$submittedByLastname)) return false;
        final java.lang.Object this$rejectedOnDate = this.getRejectedOnDate();
        final java.lang.Object other$rejectedOnDate = other.getRejectedOnDate();
        if (this$rejectedOnDate == null ? other$rejectedOnDate != null : !this$rejectedOnDate.equals(other$rejectedOnDate)) return false;
        final java.lang.Object this$rejectedByUsername = this.getRejectedByUsername();
        final java.lang.Object other$rejectedByUsername = other.getRejectedByUsername();
        if (this$rejectedByUsername == null ? other$rejectedByUsername != null : !this$rejectedByUsername.equals(other$rejectedByUsername)) return false;
        final java.lang.Object this$rejectedByFirstname = this.getRejectedByFirstname();
        final java.lang.Object other$rejectedByFirstname = other.getRejectedByFirstname();
        if (this$rejectedByFirstname == null ? other$rejectedByFirstname != null : !this$rejectedByFirstname.equals(other$rejectedByFirstname)) return false;
        final java.lang.Object this$rejectedByLastname = this.getRejectedByLastname();
        final java.lang.Object other$rejectedByLastname = other.getRejectedByLastname();
        if (this$rejectedByLastname == null ? other$rejectedByLastname != null : !this$rejectedByLastname.equals(other$rejectedByLastname)) return false;
        final java.lang.Object this$withdrawnOnDate = this.getWithdrawnOnDate();
        final java.lang.Object other$withdrawnOnDate = other.getWithdrawnOnDate();
        if (this$withdrawnOnDate == null ? other$withdrawnOnDate != null : !this$withdrawnOnDate.equals(other$withdrawnOnDate)) return false;
        final java.lang.Object this$withdrawnByUsername = this.getWithdrawnByUsername();
        final java.lang.Object other$withdrawnByUsername = other.getWithdrawnByUsername();
        if (this$withdrawnByUsername == null ? other$withdrawnByUsername != null : !this$withdrawnByUsername.equals(other$withdrawnByUsername)) return false;
        final java.lang.Object this$withdrawnByFirstname = this.getWithdrawnByFirstname();
        final java.lang.Object other$withdrawnByFirstname = other.getWithdrawnByFirstname();
        if (this$withdrawnByFirstname == null ? other$withdrawnByFirstname != null : !this$withdrawnByFirstname.equals(other$withdrawnByFirstname)) return false;
        final java.lang.Object this$withdrawnByLastname = this.getWithdrawnByLastname();
        final java.lang.Object other$withdrawnByLastname = other.getWithdrawnByLastname();
        if (this$withdrawnByLastname == null ? other$withdrawnByLastname != null : !this$withdrawnByLastname.equals(other$withdrawnByLastname)) return false;
        final java.lang.Object this$approvedOnDate = this.getApprovedOnDate();
        final java.lang.Object other$approvedOnDate = other.getApprovedOnDate();
        if (this$approvedOnDate == null ? other$approvedOnDate != null : !this$approvedOnDate.equals(other$approvedOnDate)) return false;
        final java.lang.Object this$approvedByUsername = this.getApprovedByUsername();
        final java.lang.Object other$approvedByUsername = other.getApprovedByUsername();
        if (this$approvedByUsername == null ? other$approvedByUsername != null : !this$approvedByUsername.equals(other$approvedByUsername)) return false;
        final java.lang.Object this$approvedByFirstname = this.getApprovedByFirstname();
        final java.lang.Object other$approvedByFirstname = other.getApprovedByFirstname();
        if (this$approvedByFirstname == null ? other$approvedByFirstname != null : !this$approvedByFirstname.equals(other$approvedByFirstname)) return false;
        final java.lang.Object this$approvedByLastname = this.getApprovedByLastname();
        final java.lang.Object other$approvedByLastname = other.getApprovedByLastname();
        if (this$approvedByLastname == null ? other$approvedByLastname != null : !this$approvedByLastname.equals(other$approvedByLastname)) return false;
        final java.lang.Object this$expectedDisbursementDate = this.getExpectedDisbursementDate();
        final java.lang.Object other$expectedDisbursementDate = other.getExpectedDisbursementDate();
        if (this$expectedDisbursementDate == null ? other$expectedDisbursementDate != null : !this$expectedDisbursementDate.equals(other$expectedDisbursementDate)) return false;
        final java.lang.Object this$actualDisbursementDate = this.getActualDisbursementDate();
        final java.lang.Object other$actualDisbursementDate = other.getActualDisbursementDate();
        if (this$actualDisbursementDate == null ? other$actualDisbursementDate != null : !this$actualDisbursementDate.equals(other$actualDisbursementDate)) return false;
        final java.lang.Object this$disbursedByUsername = this.getDisbursedByUsername();
        final java.lang.Object other$disbursedByUsername = other.getDisbursedByUsername();
        if (this$disbursedByUsername == null ? other$disbursedByUsername != null : !this$disbursedByUsername.equals(other$disbursedByUsername)) return false;
        final java.lang.Object this$disbursedByFirstname = this.getDisbursedByFirstname();
        final java.lang.Object other$disbursedByFirstname = other.getDisbursedByFirstname();
        if (this$disbursedByFirstname == null ? other$disbursedByFirstname != null : !this$disbursedByFirstname.equals(other$disbursedByFirstname)) return false;
        final java.lang.Object this$disbursedByLastname = this.getDisbursedByLastname();
        final java.lang.Object other$disbursedByLastname = other.getDisbursedByLastname();
        if (this$disbursedByLastname == null ? other$disbursedByLastname != null : !this$disbursedByLastname.equals(other$disbursedByLastname)) return false;
        final java.lang.Object this$closedOnDate = this.getClosedOnDate();
        final java.lang.Object other$closedOnDate = other.getClosedOnDate();
        if (this$closedOnDate == null ? other$closedOnDate != null : !this$closedOnDate.equals(other$closedOnDate)) return false;
        final java.lang.Object this$closedByUsername = this.getClosedByUsername();
        final java.lang.Object other$closedByUsername = other.getClosedByUsername();
        if (this$closedByUsername == null ? other$closedByUsername != null : !this$closedByUsername.equals(other$closedByUsername)) return false;
        final java.lang.Object this$closedByFirstname = this.getClosedByFirstname();
        final java.lang.Object other$closedByFirstname = other.getClosedByFirstname();
        if (this$closedByFirstname == null ? other$closedByFirstname != null : !this$closedByFirstname.equals(other$closedByFirstname)) return false;
        final java.lang.Object this$closedByLastname = this.getClosedByLastname();
        final java.lang.Object other$closedByLastname = other.getClosedByLastname();
        if (this$closedByLastname == null ? other$closedByLastname != null : !this$closedByLastname.equals(other$closedByLastname)) return false;
        final java.lang.Object this$actualMaturityDate = this.getActualMaturityDate();
        final java.lang.Object other$actualMaturityDate = other.getActualMaturityDate();
        if (this$actualMaturityDate == null ? other$actualMaturityDate != null : !this$actualMaturityDate.equals(other$actualMaturityDate)) return false;
        final java.lang.Object this$expectedMaturityDate = this.getExpectedMaturityDate();
        final java.lang.Object other$expectedMaturityDate = other.getExpectedMaturityDate();
        if (this$expectedMaturityDate == null ? other$expectedMaturityDate != null : !this$expectedMaturityDate.equals(other$expectedMaturityDate)) return false;
        final java.lang.Object this$writeOffOnDate = this.getWriteOffOnDate();
        final java.lang.Object other$writeOffOnDate = other.getWriteOffOnDate();
        if (this$writeOffOnDate == null ? other$writeOffOnDate != null : !this$writeOffOnDate.equals(other$writeOffOnDate)) return false;
        final java.lang.Object this$writeOffByUsername = this.getWriteOffByUsername();
        final java.lang.Object other$writeOffByUsername = other.getWriteOffByUsername();
        if (this$writeOffByUsername == null ? other$writeOffByUsername != null : !this$writeOffByUsername.equals(other$writeOffByUsername)) return false;
        final java.lang.Object this$writeOffByFirstname = this.getWriteOffByFirstname();
        final java.lang.Object other$writeOffByFirstname = other.getWriteOffByFirstname();
        if (this$writeOffByFirstname == null ? other$writeOffByFirstname != null : !this$writeOffByFirstname.equals(other$writeOffByFirstname)) return false;
        final java.lang.Object this$writeOffByLastname = this.getWriteOffByLastname();
        final java.lang.Object other$writeOffByLastname = other.getWriteOffByLastname();
        if (this$writeOffByLastname == null ? other$writeOffByLastname != null : !this$writeOffByLastname.equals(other$writeOffByLastname)) return false;
        final java.lang.Object this$chargedOffOnDate = this.getChargedOffOnDate();
        final java.lang.Object other$chargedOffOnDate = other.getChargedOffOnDate();
        if (this$chargedOffOnDate == null ? other$chargedOffOnDate != null : !this$chargedOffOnDate.equals(other$chargedOffOnDate)) return false;
        final java.lang.Object this$chargedOffByUsername = this.getChargedOffByUsername();
        final java.lang.Object other$chargedOffByUsername = other.getChargedOffByUsername();
        if (this$chargedOffByUsername == null ? other$chargedOffByUsername != null : !this$chargedOffByUsername.equals(other$chargedOffByUsername)) return false;
        final java.lang.Object this$chargedOffByFirstname = this.getChargedOffByFirstname();
        final java.lang.Object other$chargedOffByFirstname = other.getChargedOffByFirstname();
        if (this$chargedOffByFirstname == null ? other$chargedOffByFirstname != null : !this$chargedOffByFirstname.equals(other$chargedOffByFirstname)) return false;
        final java.lang.Object this$chargedOffByLastname = this.getChargedOffByLastname();
        final java.lang.Object other$chargedOffByLastname = other.getChargedOffByLastname();
        if (this$chargedOffByLastname == null ? other$chargedOffByLastname != null : !this$chargedOffByLastname.equals(other$chargedOffByLastname)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanApplicationTimelineData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $submittedOnDate = this.getSubmittedOnDate();
        result = result * PRIME + ($submittedOnDate == null ? 43 : $submittedOnDate.hashCode());
        final java.lang.Object $submittedByUsername = this.getSubmittedByUsername();
        result = result * PRIME + ($submittedByUsername == null ? 43 : $submittedByUsername.hashCode());
        final java.lang.Object $submittedByFirstname = this.getSubmittedByFirstname();
        result = result * PRIME + ($submittedByFirstname == null ? 43 : $submittedByFirstname.hashCode());
        final java.lang.Object $submittedByLastname = this.getSubmittedByLastname();
        result = result * PRIME + ($submittedByLastname == null ? 43 : $submittedByLastname.hashCode());
        final java.lang.Object $rejectedOnDate = this.getRejectedOnDate();
        result = result * PRIME + ($rejectedOnDate == null ? 43 : $rejectedOnDate.hashCode());
        final java.lang.Object $rejectedByUsername = this.getRejectedByUsername();
        result = result * PRIME + ($rejectedByUsername == null ? 43 : $rejectedByUsername.hashCode());
        final java.lang.Object $rejectedByFirstname = this.getRejectedByFirstname();
        result = result * PRIME + ($rejectedByFirstname == null ? 43 : $rejectedByFirstname.hashCode());
        final java.lang.Object $rejectedByLastname = this.getRejectedByLastname();
        result = result * PRIME + ($rejectedByLastname == null ? 43 : $rejectedByLastname.hashCode());
        final java.lang.Object $withdrawnOnDate = this.getWithdrawnOnDate();
        result = result * PRIME + ($withdrawnOnDate == null ? 43 : $withdrawnOnDate.hashCode());
        final java.lang.Object $withdrawnByUsername = this.getWithdrawnByUsername();
        result = result * PRIME + ($withdrawnByUsername == null ? 43 : $withdrawnByUsername.hashCode());
        final java.lang.Object $withdrawnByFirstname = this.getWithdrawnByFirstname();
        result = result * PRIME + ($withdrawnByFirstname == null ? 43 : $withdrawnByFirstname.hashCode());
        final java.lang.Object $withdrawnByLastname = this.getWithdrawnByLastname();
        result = result * PRIME + ($withdrawnByLastname == null ? 43 : $withdrawnByLastname.hashCode());
        final java.lang.Object $approvedOnDate = this.getApprovedOnDate();
        result = result * PRIME + ($approvedOnDate == null ? 43 : $approvedOnDate.hashCode());
        final java.lang.Object $approvedByUsername = this.getApprovedByUsername();
        result = result * PRIME + ($approvedByUsername == null ? 43 : $approvedByUsername.hashCode());
        final java.lang.Object $approvedByFirstname = this.getApprovedByFirstname();
        result = result * PRIME + ($approvedByFirstname == null ? 43 : $approvedByFirstname.hashCode());
        final java.lang.Object $approvedByLastname = this.getApprovedByLastname();
        result = result * PRIME + ($approvedByLastname == null ? 43 : $approvedByLastname.hashCode());
        final java.lang.Object $expectedDisbursementDate = this.getExpectedDisbursementDate();
        result = result * PRIME + ($expectedDisbursementDate == null ? 43 : $expectedDisbursementDate.hashCode());
        final java.lang.Object $actualDisbursementDate = this.getActualDisbursementDate();
        result = result * PRIME + ($actualDisbursementDate == null ? 43 : $actualDisbursementDate.hashCode());
        final java.lang.Object $disbursedByUsername = this.getDisbursedByUsername();
        result = result * PRIME + ($disbursedByUsername == null ? 43 : $disbursedByUsername.hashCode());
        final java.lang.Object $disbursedByFirstname = this.getDisbursedByFirstname();
        result = result * PRIME + ($disbursedByFirstname == null ? 43 : $disbursedByFirstname.hashCode());
        final java.lang.Object $disbursedByLastname = this.getDisbursedByLastname();
        result = result * PRIME + ($disbursedByLastname == null ? 43 : $disbursedByLastname.hashCode());
        final java.lang.Object $closedOnDate = this.getClosedOnDate();
        result = result * PRIME + ($closedOnDate == null ? 43 : $closedOnDate.hashCode());
        final java.lang.Object $closedByUsername = this.getClosedByUsername();
        result = result * PRIME + ($closedByUsername == null ? 43 : $closedByUsername.hashCode());
        final java.lang.Object $closedByFirstname = this.getClosedByFirstname();
        result = result * PRIME + ($closedByFirstname == null ? 43 : $closedByFirstname.hashCode());
        final java.lang.Object $closedByLastname = this.getClosedByLastname();
        result = result * PRIME + ($closedByLastname == null ? 43 : $closedByLastname.hashCode());
        final java.lang.Object $actualMaturityDate = this.getActualMaturityDate();
        result = result * PRIME + ($actualMaturityDate == null ? 43 : $actualMaturityDate.hashCode());
        final java.lang.Object $expectedMaturityDate = this.getExpectedMaturityDate();
        result = result * PRIME + ($expectedMaturityDate == null ? 43 : $expectedMaturityDate.hashCode());
        final java.lang.Object $writeOffOnDate = this.getWriteOffOnDate();
        result = result * PRIME + ($writeOffOnDate == null ? 43 : $writeOffOnDate.hashCode());
        final java.lang.Object $writeOffByUsername = this.getWriteOffByUsername();
        result = result * PRIME + ($writeOffByUsername == null ? 43 : $writeOffByUsername.hashCode());
        final java.lang.Object $writeOffByFirstname = this.getWriteOffByFirstname();
        result = result * PRIME + ($writeOffByFirstname == null ? 43 : $writeOffByFirstname.hashCode());
        final java.lang.Object $writeOffByLastname = this.getWriteOffByLastname();
        result = result * PRIME + ($writeOffByLastname == null ? 43 : $writeOffByLastname.hashCode());
        final java.lang.Object $chargedOffOnDate = this.getChargedOffOnDate();
        result = result * PRIME + ($chargedOffOnDate == null ? 43 : $chargedOffOnDate.hashCode());
        final java.lang.Object $chargedOffByUsername = this.getChargedOffByUsername();
        result = result * PRIME + ($chargedOffByUsername == null ? 43 : $chargedOffByUsername.hashCode());
        final java.lang.Object $chargedOffByFirstname = this.getChargedOffByFirstname();
        result = result * PRIME + ($chargedOffByFirstname == null ? 43 : $chargedOffByFirstname.hashCode());
        final java.lang.Object $chargedOffByLastname = this.getChargedOffByLastname();
        result = result * PRIME + ($chargedOffByLastname == null ? 43 : $chargedOffByLastname.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanApplicationTimelineData(submittedOnDate=" + this.getSubmittedOnDate() + ", submittedByUsername=" + this.getSubmittedByUsername() + ", submittedByFirstname=" + this.getSubmittedByFirstname() + ", submittedByLastname=" + this.getSubmittedByLastname() + ", rejectedOnDate=" + this.getRejectedOnDate() + ", rejectedByUsername=" + this.getRejectedByUsername() + ", rejectedByFirstname=" + this.getRejectedByFirstname() + ", rejectedByLastname=" + this.getRejectedByLastname() + ", withdrawnOnDate=" + this.getWithdrawnOnDate() + ", withdrawnByUsername=" + this.getWithdrawnByUsername() + ", withdrawnByFirstname=" + this.getWithdrawnByFirstname() + ", withdrawnByLastname=" + this.getWithdrawnByLastname() + ", approvedOnDate=" + this.getApprovedOnDate() + ", approvedByUsername=" + this.getApprovedByUsername() + ", approvedByFirstname=" + this.getApprovedByFirstname() + ", approvedByLastname=" + this.getApprovedByLastname() + ", expectedDisbursementDate=" + this.getExpectedDisbursementDate() + ", actualDisbursementDate=" + this.getActualDisbursementDate() + ", disbursedByUsername=" + this.getDisbursedByUsername() + ", disbursedByFirstname=" + this.getDisbursedByFirstname() + ", disbursedByLastname=" + this.getDisbursedByLastname() + ", closedOnDate=" + this.getClosedOnDate() + ", closedByUsername=" + this.getClosedByUsername() + ", closedByFirstname=" + this.getClosedByFirstname() + ", closedByLastname=" + this.getClosedByLastname() + ", actualMaturityDate=" + this.getActualMaturityDate() + ", expectedMaturityDate=" + this.getExpectedMaturityDate() + ", writeOffOnDate=" + this.getWriteOffOnDate() + ", writeOffByUsername=" + this.getWriteOffByUsername() + ", writeOffByFirstname=" + this.getWriteOffByFirstname() + ", writeOffByLastname=" + this.getWriteOffByLastname() + ", chargedOffOnDate=" + this.getChargedOffOnDate() + ", chargedOffByUsername=" + this.getChargedOffByUsername() + ", chargedOffByFirstname=" + this.getChargedOffByFirstname() + ", chargedOffByLastname=" + this.getChargedOffByLastname() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData(final LocalDate submittedOnDate, final String submittedByUsername, final String submittedByFirstname, final String submittedByLastname, final LocalDate rejectedOnDate, final String rejectedByUsername, final String rejectedByFirstname, final String rejectedByLastname, final LocalDate withdrawnOnDate, final String withdrawnByUsername, final String withdrawnByFirstname, final String withdrawnByLastname, final LocalDate approvedOnDate, final String approvedByUsername, final String approvedByFirstname, final String approvedByLastname, final LocalDate expectedDisbursementDate, final LocalDate actualDisbursementDate, final String disbursedByUsername, final String disbursedByFirstname, final String disbursedByLastname, final LocalDate closedOnDate, final String closedByUsername, final String closedByFirstname, final String closedByLastname, final LocalDate actualMaturityDate, final LocalDate expectedMaturityDate, final LocalDate writeOffOnDate, final String writeOffByUsername, final String writeOffByFirstname, final String writeOffByLastname, final LocalDate chargedOffOnDate, final String chargedOffByUsername, final String chargedOffByFirstname, final String chargedOffByLastname) {
        this.submittedOnDate = submittedOnDate;
        this.submittedByUsername = submittedByUsername;
        this.submittedByFirstname = submittedByFirstname;
        this.submittedByLastname = submittedByLastname;
        this.rejectedOnDate = rejectedOnDate;
        this.rejectedByUsername = rejectedByUsername;
        this.rejectedByFirstname = rejectedByFirstname;
        this.rejectedByLastname = rejectedByLastname;
        this.withdrawnOnDate = withdrawnOnDate;
        this.withdrawnByUsername = withdrawnByUsername;
        this.withdrawnByFirstname = withdrawnByFirstname;
        this.withdrawnByLastname = withdrawnByLastname;
        this.approvedOnDate = approvedOnDate;
        this.approvedByUsername = approvedByUsername;
        this.approvedByFirstname = approvedByFirstname;
        this.approvedByLastname = approvedByLastname;
        this.expectedDisbursementDate = expectedDisbursementDate;
        this.actualDisbursementDate = actualDisbursementDate;
        this.disbursedByUsername = disbursedByUsername;
        this.disbursedByFirstname = disbursedByFirstname;
        this.disbursedByLastname = disbursedByLastname;
        this.closedOnDate = closedOnDate;
        this.closedByUsername = closedByUsername;
        this.closedByFirstname = closedByFirstname;
        this.closedByLastname = closedByLastname;
        this.actualMaturityDate = actualMaturityDate;
        this.expectedMaturityDate = expectedMaturityDate;
        this.writeOffOnDate = writeOffOnDate;
        this.writeOffByUsername = writeOffByUsername;
        this.writeOffByFirstname = writeOffByFirstname;
        this.writeOffByLastname = writeOffByLastname;
        this.chargedOffOnDate = chargedOffOnDate;
        this.chargedOffByUsername = chargedOffByUsername;
        this.chargedOffByFirstname = chargedOffByFirstname;
        this.chargedOffByLastname = chargedOffByLastname;
    }

    @java.lang.SuppressWarnings("all")
        public LoanApplicationTimelineData() {
    }
}
