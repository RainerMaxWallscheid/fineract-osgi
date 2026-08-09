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
package org.apache.fineract.infrastructure.campaigns.email.data;

import java.time.LocalDate;

public class EmailCampaignTimeLine {
    private LocalDate submittedOnDate;
    private String submittedByUsername;
    private LocalDate activatedOnDate;
    private String activatedByUsername;
    private LocalDate closedOnDate;
    private String closedByUsername;

    @java.lang.SuppressWarnings("all")
        public LocalDate getSubmittedOnDate() {
        return this.submittedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getSubmittedByUsername() {
        return this.submittedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getActivatedOnDate() {
        return this.activatedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getActivatedByUsername() {
        return this.activatedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getClosedOnDate() {
        return this.closedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getClosedByUsername() {
        return this.closedByUsername;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignTimeLine setSubmittedOnDate(final LocalDate submittedOnDate) {
        this.submittedOnDate = submittedOnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignTimeLine setSubmittedByUsername(final String submittedByUsername) {
        this.submittedByUsername = submittedByUsername;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignTimeLine setActivatedOnDate(final LocalDate activatedOnDate) {
        this.activatedOnDate = activatedOnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignTimeLine setActivatedByUsername(final String activatedByUsername) {
        this.activatedByUsername = activatedByUsername;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignTimeLine setClosedOnDate(final LocalDate closedOnDate) {
        this.closedOnDate = closedOnDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public EmailCampaignTimeLine setClosedByUsername(final String closedByUsername) {
        this.closedByUsername = closedByUsername;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof EmailCampaignTimeLine)) return false;
        final EmailCampaignTimeLine other = (EmailCampaignTimeLine) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$submittedOnDate = this.getSubmittedOnDate();
        final java.lang.Object other$submittedOnDate = other.getSubmittedOnDate();
        if (this$submittedOnDate == null ? other$submittedOnDate != null : !this$submittedOnDate.equals(other$submittedOnDate)) return false;
        final java.lang.Object this$submittedByUsername = this.getSubmittedByUsername();
        final java.lang.Object other$submittedByUsername = other.getSubmittedByUsername();
        if (this$submittedByUsername == null ? other$submittedByUsername != null : !this$submittedByUsername.equals(other$submittedByUsername)) return false;
        final java.lang.Object this$activatedOnDate = this.getActivatedOnDate();
        final java.lang.Object other$activatedOnDate = other.getActivatedOnDate();
        if (this$activatedOnDate == null ? other$activatedOnDate != null : !this$activatedOnDate.equals(other$activatedOnDate)) return false;
        final java.lang.Object this$activatedByUsername = this.getActivatedByUsername();
        final java.lang.Object other$activatedByUsername = other.getActivatedByUsername();
        if (this$activatedByUsername == null ? other$activatedByUsername != null : !this$activatedByUsername.equals(other$activatedByUsername)) return false;
        final java.lang.Object this$closedOnDate = this.getClosedOnDate();
        final java.lang.Object other$closedOnDate = other.getClosedOnDate();
        if (this$closedOnDate == null ? other$closedOnDate != null : !this$closedOnDate.equals(other$closedOnDate)) return false;
        final java.lang.Object this$closedByUsername = this.getClosedByUsername();
        final java.lang.Object other$closedByUsername = other.getClosedByUsername();
        if (this$closedByUsername == null ? other$closedByUsername != null : !this$closedByUsername.equals(other$closedByUsername)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof EmailCampaignTimeLine;
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
        final java.lang.Object $activatedOnDate = this.getActivatedOnDate();
        result = result * PRIME + ($activatedOnDate == null ? 43 : $activatedOnDate.hashCode());
        final java.lang.Object $activatedByUsername = this.getActivatedByUsername();
        result = result * PRIME + ($activatedByUsername == null ? 43 : $activatedByUsername.hashCode());
        final java.lang.Object $closedOnDate = this.getClosedOnDate();
        result = result * PRIME + ($closedOnDate == null ? 43 : $closedOnDate.hashCode());
        final java.lang.Object $closedByUsername = this.getClosedByUsername();
        result = result * PRIME + ($closedByUsername == null ? 43 : $closedByUsername.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "EmailCampaignTimeLine(submittedOnDate=" + this.getSubmittedOnDate() + ", submittedByUsername=" + this.getSubmittedByUsername() + ", activatedOnDate=" + this.getActivatedOnDate() + ", activatedByUsername=" + this.getActivatedByUsername() + ", closedOnDate=" + this.getClosedOnDate() + ", closedByUsername=" + this.getClosedByUsername() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public EmailCampaignTimeLine() {
    }
}
