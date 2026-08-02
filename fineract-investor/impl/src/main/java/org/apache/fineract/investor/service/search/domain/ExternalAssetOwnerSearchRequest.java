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
package org.apache.fineract.investor.service.search.domain;

import java.time.LocalDate;

public class ExternalAssetOwnerSearchRequest {
    private String text;
    private LocalDate submittedFromDate;
    private LocalDate submittedToDate;
    private LocalDate effectiveFromDate;
    private LocalDate effectiveToDate;

    @java.lang.SuppressWarnings("all")
        public ExternalAssetOwnerSearchRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public String getText() {
        return this.text;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getSubmittedFromDate() {
        return this.submittedFromDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getSubmittedToDate() {
        return this.submittedToDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getEffectiveFromDate() {
        return this.effectiveFromDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getEffectiveToDate() {
        return this.effectiveToDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setText(final String text) {
        this.text = text;
    }

    @java.lang.SuppressWarnings("all")
        public void setSubmittedFromDate(final LocalDate submittedFromDate) {
        this.submittedFromDate = submittedFromDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setSubmittedToDate(final LocalDate submittedToDate) {
        this.submittedToDate = submittedToDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setEffectiveFromDate(final LocalDate effectiveFromDate) {
        this.effectiveFromDate = effectiveFromDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setEffectiveToDate(final LocalDate effectiveToDate) {
        this.effectiveToDate = effectiveToDate;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ExternalAssetOwnerSearchRequest)) return false;
        final ExternalAssetOwnerSearchRequest other = (ExternalAssetOwnerSearchRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$text = this.getText();
        final java.lang.Object other$text = other.getText();
        if (this$text == null ? other$text != null : !this$text.equals(other$text)) return false;
        final java.lang.Object this$submittedFromDate = this.getSubmittedFromDate();
        final java.lang.Object other$submittedFromDate = other.getSubmittedFromDate();
        if (this$submittedFromDate == null ? other$submittedFromDate != null : !this$submittedFromDate.equals(other$submittedFromDate)) return false;
        final java.lang.Object this$submittedToDate = this.getSubmittedToDate();
        final java.lang.Object other$submittedToDate = other.getSubmittedToDate();
        if (this$submittedToDate == null ? other$submittedToDate != null : !this$submittedToDate.equals(other$submittedToDate)) return false;
        final java.lang.Object this$effectiveFromDate = this.getEffectiveFromDate();
        final java.lang.Object other$effectiveFromDate = other.getEffectiveFromDate();
        if (this$effectiveFromDate == null ? other$effectiveFromDate != null : !this$effectiveFromDate.equals(other$effectiveFromDate)) return false;
        final java.lang.Object this$effectiveToDate = this.getEffectiveToDate();
        final java.lang.Object other$effectiveToDate = other.getEffectiveToDate();
        if (this$effectiveToDate == null ? other$effectiveToDate != null : !this$effectiveToDate.equals(other$effectiveToDate)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ExternalAssetOwnerSearchRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $text = this.getText();
        result = result * PRIME + ($text == null ? 43 : $text.hashCode());
        final java.lang.Object $submittedFromDate = this.getSubmittedFromDate();
        result = result * PRIME + ($submittedFromDate == null ? 43 : $submittedFromDate.hashCode());
        final java.lang.Object $submittedToDate = this.getSubmittedToDate();
        result = result * PRIME + ($submittedToDate == null ? 43 : $submittedToDate.hashCode());
        final java.lang.Object $effectiveFromDate = this.getEffectiveFromDate();
        result = result * PRIME + ($effectiveFromDate == null ? 43 : $effectiveFromDate.hashCode());
        final java.lang.Object $effectiveToDate = this.getEffectiveToDate();
        result = result * PRIME + ($effectiveToDate == null ? 43 : $effectiveToDate.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ExternalAssetOwnerSearchRequest(text=" + this.getText() + ", submittedFromDate=" + this.getSubmittedFromDate() + ", submittedToDate=" + this.getSubmittedToDate() + ", effectiveFromDate=" + this.getEffectiveFromDate() + ", effectiveToDate=" + this.getEffectiveToDate() + ")";
    }
}
