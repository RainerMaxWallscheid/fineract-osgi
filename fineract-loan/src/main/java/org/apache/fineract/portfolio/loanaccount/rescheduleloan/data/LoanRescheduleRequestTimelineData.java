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
package org.apache.fineract.portfolio.loanaccount.rescheduleloan.data;

import java.time.LocalDate;

/**
 * Immutable data object represent the timeline events of a loan reschedule request
 */
@SuppressWarnings("unused")
public class LoanRescheduleRequestTimelineData {
    private final LocalDate submittedOnDate;
    private final String submittedByUsername;
    private final String submittedByFirstname;
    private final String submittedByLastname;
    private final LocalDate approvedOnDate;
    private final String approvedByUsername;
    private final String approvedByFirstname;
    private final String approvedByLastname;
    private final LocalDate rejectedOnDate;
    private final String rejectedByUsername;
    private final String rejectedByFirstname;
    private final String rejectedByLastname;

    public LoanRescheduleRequestTimelineData(final LocalDate submittedOnDate, final String submittedByUsername, final String submittedByFirstname, final String submittedByLastname, final LocalDate approvedOnDate, final String approvedByUsername, final String approvedByFirstname, final String approvedByLastname, final LocalDate rejectedOnDate, final String rejectedByUsername, final String rejectedByFirstname, final String rejectedByLastname) {
        this.submittedOnDate = submittedOnDate;
        this.submittedByUsername = submittedByUsername;
        this.submittedByFirstname = submittedByFirstname;
        this.submittedByLastname = submittedByLastname;
        this.approvedOnDate = approvedOnDate;
        this.approvedByUsername = approvedByUsername;
        this.approvedByFirstname = approvedByFirstname;
        this.approvedByLastname = approvedByLastname;
        this.rejectedOnDate = rejectedOnDate;
        this.rejectedByUsername = rejectedByUsername;
        this.rejectedByFirstname = rejectedByFirstname;
        this.rejectedByLastname = rejectedByLastname;
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

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanRescheduleRequestTimelineData)) return false;
        final LoanRescheduleRequestTimelineData other = (LoanRescheduleRequestTimelineData) o;
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
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanRescheduleRequestTimelineData;
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
        final java.lang.Object $approvedOnDate = this.getApprovedOnDate();
        result = result * PRIME + ($approvedOnDate == null ? 43 : $approvedOnDate.hashCode());
        final java.lang.Object $approvedByUsername = this.getApprovedByUsername();
        result = result * PRIME + ($approvedByUsername == null ? 43 : $approvedByUsername.hashCode());
        final java.lang.Object $approvedByFirstname = this.getApprovedByFirstname();
        result = result * PRIME + ($approvedByFirstname == null ? 43 : $approvedByFirstname.hashCode());
        final java.lang.Object $approvedByLastname = this.getApprovedByLastname();
        result = result * PRIME + ($approvedByLastname == null ? 43 : $approvedByLastname.hashCode());
        final java.lang.Object $rejectedOnDate = this.getRejectedOnDate();
        result = result * PRIME + ($rejectedOnDate == null ? 43 : $rejectedOnDate.hashCode());
        final java.lang.Object $rejectedByUsername = this.getRejectedByUsername();
        result = result * PRIME + ($rejectedByUsername == null ? 43 : $rejectedByUsername.hashCode());
        final java.lang.Object $rejectedByFirstname = this.getRejectedByFirstname();
        result = result * PRIME + ($rejectedByFirstname == null ? 43 : $rejectedByFirstname.hashCode());
        final java.lang.Object $rejectedByLastname = this.getRejectedByLastname();
        result = result * PRIME + ($rejectedByLastname == null ? 43 : $rejectedByLastname.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanRescheduleRequestTimelineData(submittedOnDate=" + this.getSubmittedOnDate() + ", submittedByUsername=" + this.getSubmittedByUsername() + ", submittedByFirstname=" + this.getSubmittedByFirstname() + ", submittedByLastname=" + this.getSubmittedByLastname() + ", approvedOnDate=" + this.getApprovedOnDate() + ", approvedByUsername=" + this.getApprovedByUsername() + ", approvedByFirstname=" + this.getApprovedByFirstname() + ", approvedByLastname=" + this.getApprovedByLastname() + ", rejectedOnDate=" + this.getRejectedOnDate() + ", rejectedByUsername=" + this.getRejectedByUsername() + ", rejectedByFirstname=" + this.getRejectedByFirstname() + ", rejectedByLastname=" + this.getRejectedByLastname() + ")";
    }
}
