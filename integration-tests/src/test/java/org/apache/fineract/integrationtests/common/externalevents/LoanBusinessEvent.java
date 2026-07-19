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
package org.apache.fineract.integrationtests.common.externalevents;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import org.apache.commons.collections4.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.fineract.infrastructure.event.external.data.ExternalEventResponse;

public class LoanBusinessEvent extends BusinessEvent {
    private Integer statusId;
    private Double principalDisbursed;
    private Double principalOutstanding;
    private List<String> loanTermVariationType;

    public LoanBusinessEvent(String type, String businessDate, Integer statusId, Double principalDisbursed, Double principalOutstanding) {
        super(type, businessDate);
        this.statusId = statusId;
        this.principalDisbursed = principalDisbursed;
        this.principalOutstanding = principalOutstanding;
    }

    public LoanBusinessEvent(String type, String businessDate, Integer statusId, Double principalDisbursed, Double principalOutstanding, List<String> loanTermVariationType) {
        super(type, businessDate);
        this.statusId = statusId;
        this.principalDisbursed = principalDisbursed;
        this.principalOutstanding = principalOutstanding;
        this.loanTermVariationType = loanTermVariationType;
    }

    @Override
    public boolean verify(ExternalEventResponse externalEvent, DateTimeFormatter formatter) {
        Object summaryRes = externalEvent.getPayLoad().get("summary");
        Object statusRes = externalEvent.getPayLoad().get("status");
        Map<String, Object> summary = summaryRes instanceof Map ? (Map<String, Object>) summaryRes : Map.of();
        Map<String, Object> status = statusRes instanceof Map ? (Map<String, Object>) statusRes : Map.of();
        var principalDisbursed = summary.get("principalDisbursed");
        var principalOutstanding = summary.get("principalOutstanding");
        Double statusId = (Double) status.get("id");
        return super.verify(externalEvent, formatter) && Objects.equals(statusId, getStatusId().doubleValue()) && Objects.equals(principalDisbursed, getPrincipalDisbursed()) && Objects.equals(principalOutstanding, getPrincipalOutstanding()) && loanTermVariationsMatch((List<Map<String, Object>>) externalEvent.getPayLoad().get("loanTermVariations"), loanTermVariationType);
    }

    private boolean loanTermVariationsMatch(final List<Map<String, Object>> loanTermVariations, final List<String> expectedTypes) {
        if (CollectionUtils.isEmpty(expectedTypes)) {
            return true;
        }
        final long numberOfMatches = expectedTypes.stream().filter(expectedType -> loanTermVariations.stream().anyMatch(variation -> StringUtils.equals((String) ((Map<String, Object>) variation.get("termType")).get("value"), expectedType))).count();
        return numberOfMatches == expectedTypes.size();
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanBusinessEvent)) return false;
        final LoanBusinessEvent other = (LoanBusinessEvent) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (!super.equals(o)) return false;
        final java.lang.Object this$statusId = this.getStatusId();
        final java.lang.Object other$statusId = other.getStatusId();
        if (this$statusId == null ? other$statusId != null : !this$statusId.equals(other$statusId)) return false;
        final java.lang.Object this$principalDisbursed = this.getPrincipalDisbursed();
        final java.lang.Object other$principalDisbursed = other.getPrincipalDisbursed();
        if (this$principalDisbursed == null ? other$principalDisbursed != null : !this$principalDisbursed.equals(other$principalDisbursed)) return false;
        final java.lang.Object this$principalOutstanding = this.getPrincipalOutstanding();
        final java.lang.Object other$principalOutstanding = other.getPrincipalOutstanding();
        if (this$principalOutstanding == null ? other$principalOutstanding != null : !this$principalOutstanding.equals(other$principalOutstanding)) return false;
        final java.lang.Object this$loanTermVariationType = this.getLoanTermVariationType();
        final java.lang.Object other$loanTermVariationType = other.getLoanTermVariationType();
        if (this$loanTermVariationType == null ? other$loanTermVariationType != null : !this$loanTermVariationType.equals(other$loanTermVariationType)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanBusinessEvent;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = super.hashCode();
        final java.lang.Object $statusId = this.getStatusId();
        result = result * PRIME + ($statusId == null ? 43 : $statusId.hashCode());
        final java.lang.Object $principalDisbursed = this.getPrincipalDisbursed();
        result = result * PRIME + ($principalDisbursed == null ? 43 : $principalDisbursed.hashCode());
        final java.lang.Object $principalOutstanding = this.getPrincipalOutstanding();
        result = result * PRIME + ($principalOutstanding == null ? 43 : $principalOutstanding.hashCode());
        final java.lang.Object $loanTermVariationType = this.getLoanTermVariationType();
        result = result * PRIME + ($loanTermVariationType == null ? 43 : $loanTermVariationType.hashCode());
        return result;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getStatusId() {
        return this.statusId;
    }

    @java.lang.SuppressWarnings("all")
        public Double getPrincipalDisbursed() {
        return this.principalDisbursed;
    }

    @java.lang.SuppressWarnings("all")
        public Double getPrincipalOutstanding() {
        return this.principalOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public List<String> getLoanTermVariationType() {
        return this.loanTermVariationType;
    }

    @java.lang.SuppressWarnings("all")
        public void setStatusId(final Integer statusId) {
        this.statusId = statusId;
    }

    @java.lang.SuppressWarnings("all")
        public void setPrincipalDisbursed(final Double principalDisbursed) {
        this.principalDisbursed = principalDisbursed;
    }

    @java.lang.SuppressWarnings("all")
        public void setPrincipalOutstanding(final Double principalOutstanding) {
        this.principalOutstanding = principalOutstanding;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanTermVariationType(final List<String> loanTermVariationType) {
        this.loanTermVariationType = loanTermVariationType;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanBusinessEvent(statusId=" + this.getStatusId() + ", principalDisbursed=" + this.getPrincipalDisbursed() + ", principalOutstanding=" + this.getPrincipalOutstanding() + ", loanTermVariationType=" + this.getLoanTermVariationType() + ")";
    }
}
