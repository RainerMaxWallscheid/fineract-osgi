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
package org.apache.fineract.organisation.workingdays.data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Map;

public class WorkingDaysUpdateResponse implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long resourceId;
    private String recurrence;
    private Integer repaymentRescheduleType;
    private Boolean extendTermForDailyRepayments;
    private Boolean extendTermForRepaymentsOnHolidays;
    private Map<String, Object> changes;


    @java.lang.SuppressWarnings("all")
        public static class WorkingDaysUpdateResponseBuilder {
        @java.lang.SuppressWarnings("all")
                private Long resourceId;
        @java.lang.SuppressWarnings("all")
                private String recurrence;
        @java.lang.SuppressWarnings("all")
                private Integer repaymentRescheduleType;
        @java.lang.SuppressWarnings("all")
                private Boolean extendTermForDailyRepayments;
        @java.lang.SuppressWarnings("all")
                private Boolean extendTermForRepaymentsOnHolidays;
        @java.lang.SuppressWarnings("all")
                private Map<String, Object> changes;

        @java.lang.SuppressWarnings("all")
                WorkingDaysUpdateResponseBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingDaysUpdateResponse.WorkingDaysUpdateResponseBuilder resourceId(final Long resourceId) {
            this.resourceId = resourceId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingDaysUpdateResponse.WorkingDaysUpdateResponseBuilder recurrence(final String recurrence) {
            this.recurrence = recurrence;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingDaysUpdateResponse.WorkingDaysUpdateResponseBuilder repaymentRescheduleType(final Integer repaymentRescheduleType) {
            this.repaymentRescheduleType = repaymentRescheduleType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingDaysUpdateResponse.WorkingDaysUpdateResponseBuilder extendTermForDailyRepayments(final Boolean extendTermForDailyRepayments) {
            this.extendTermForDailyRepayments = extendTermForDailyRepayments;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingDaysUpdateResponse.WorkingDaysUpdateResponseBuilder extendTermForRepaymentsOnHolidays(final Boolean extendTermForRepaymentsOnHolidays) {
            this.extendTermForRepaymentsOnHolidays = extendTermForRepaymentsOnHolidays;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingDaysUpdateResponse.WorkingDaysUpdateResponseBuilder changes(final Map<String, Object> changes) {
            this.changes = changes;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public WorkingDaysUpdateResponse build() {
            return new WorkingDaysUpdateResponse(this.resourceId, this.recurrence, this.repaymentRescheduleType, this.extendTermForDailyRepayments, this.extendTermForRepaymentsOnHolidays, this.changes);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "WorkingDaysUpdateResponse.WorkingDaysUpdateResponseBuilder(resourceId=" + this.resourceId + ", recurrence=" + this.recurrence + ", repaymentRescheduleType=" + this.repaymentRescheduleType + ", extendTermForDailyRepayments=" + this.extendTermForDailyRepayments + ", extendTermForRepaymentsOnHolidays=" + this.extendTermForRepaymentsOnHolidays + ", changes=" + this.changes + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static WorkingDaysUpdateResponse.WorkingDaysUpdateResponseBuilder builder() {
        return new WorkingDaysUpdateResponse.WorkingDaysUpdateResponseBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getResourceId() {
        return this.resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public String getRecurrence() {
        return this.recurrence;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRepaymentRescheduleType() {
        return this.repaymentRescheduleType;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getExtendTermForDailyRepayments() {
        return this.extendTermForDailyRepayments;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getExtendTermForRepaymentsOnHolidays() {
        return this.extendTermForRepaymentsOnHolidays;
    }

    @java.lang.SuppressWarnings("all")
        public Map<String, Object> getChanges() {
        return this.changes;
    }

    @java.lang.SuppressWarnings("all")
        public void setResourceId(final Long resourceId) {
        this.resourceId = resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public void setRecurrence(final String recurrence) {
        this.recurrence = recurrence;
    }

    @java.lang.SuppressWarnings("all")
        public void setRepaymentRescheduleType(final Integer repaymentRescheduleType) {
        this.repaymentRescheduleType = repaymentRescheduleType;
    }

    @java.lang.SuppressWarnings("all")
        public void setExtendTermForDailyRepayments(final Boolean extendTermForDailyRepayments) {
        this.extendTermForDailyRepayments = extendTermForDailyRepayments;
    }

    @java.lang.SuppressWarnings("all")
        public void setExtendTermForRepaymentsOnHolidays(final Boolean extendTermForRepaymentsOnHolidays) {
        this.extendTermForRepaymentsOnHolidays = extendTermForRepaymentsOnHolidays;
    }

    @java.lang.SuppressWarnings("all")
        public void setChanges(final Map<String, Object> changes) {
        this.changes = changes;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof WorkingDaysUpdateResponse)) return false;
        final WorkingDaysUpdateResponse other = (WorkingDaysUpdateResponse) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$resourceId = this.getResourceId();
        final java.lang.Object other$resourceId = other.getResourceId();
        if (this$resourceId == null ? other$resourceId != null : !this$resourceId.equals(other$resourceId)) return false;
        final java.lang.Object this$repaymentRescheduleType = this.getRepaymentRescheduleType();
        final java.lang.Object other$repaymentRescheduleType = other.getRepaymentRescheduleType();
        if (this$repaymentRescheduleType == null ? other$repaymentRescheduleType != null : !this$repaymentRescheduleType.equals(other$repaymentRescheduleType)) return false;
        final java.lang.Object this$extendTermForDailyRepayments = this.getExtendTermForDailyRepayments();
        final java.lang.Object other$extendTermForDailyRepayments = other.getExtendTermForDailyRepayments();
        if (this$extendTermForDailyRepayments == null ? other$extendTermForDailyRepayments != null : !this$extendTermForDailyRepayments.equals(other$extendTermForDailyRepayments)) return false;
        final java.lang.Object this$extendTermForRepaymentsOnHolidays = this.getExtendTermForRepaymentsOnHolidays();
        final java.lang.Object other$extendTermForRepaymentsOnHolidays = other.getExtendTermForRepaymentsOnHolidays();
        if (this$extendTermForRepaymentsOnHolidays == null ? other$extendTermForRepaymentsOnHolidays != null : !this$extendTermForRepaymentsOnHolidays.equals(other$extendTermForRepaymentsOnHolidays)) return false;
        final java.lang.Object this$recurrence = this.getRecurrence();
        final java.lang.Object other$recurrence = other.getRecurrence();
        if (this$recurrence == null ? other$recurrence != null : !this$recurrence.equals(other$recurrence)) return false;
        final java.lang.Object this$changes = this.getChanges();
        final java.lang.Object other$changes = other.getChanges();
        if (this$changes == null ? other$changes != null : !this$changes.equals(other$changes)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof WorkingDaysUpdateResponse;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $resourceId = this.getResourceId();
        result = result * PRIME + ($resourceId == null ? 43 : $resourceId.hashCode());
        final java.lang.Object $repaymentRescheduleType = this.getRepaymentRescheduleType();
        result = result * PRIME + ($repaymentRescheduleType == null ? 43 : $repaymentRescheduleType.hashCode());
        final java.lang.Object $extendTermForDailyRepayments = this.getExtendTermForDailyRepayments();
        result = result * PRIME + ($extendTermForDailyRepayments == null ? 43 : $extendTermForDailyRepayments.hashCode());
        final java.lang.Object $extendTermForRepaymentsOnHolidays = this.getExtendTermForRepaymentsOnHolidays();
        result = result * PRIME + ($extendTermForRepaymentsOnHolidays == null ? 43 : $extendTermForRepaymentsOnHolidays.hashCode());
        final java.lang.Object $recurrence = this.getRecurrence();
        result = result * PRIME + ($recurrence == null ? 43 : $recurrence.hashCode());
        final java.lang.Object $changes = this.getChanges();
        result = result * PRIME + ($changes == null ? 43 : $changes.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "WorkingDaysUpdateResponse(resourceId=" + this.getResourceId() + ", recurrence=" + this.getRecurrence() + ", repaymentRescheduleType=" + this.getRepaymentRescheduleType() + ", extendTermForDailyRepayments=" + this.getExtendTermForDailyRepayments() + ", extendTermForRepaymentsOnHolidays=" + this.getExtendTermForRepaymentsOnHolidays() + ", changes=" + this.getChanges() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public WorkingDaysUpdateResponse() {
    }

    @java.lang.SuppressWarnings("all")
        public WorkingDaysUpdateResponse(final Long resourceId, final String recurrence, final Integer repaymentRescheduleType, final Boolean extendTermForDailyRepayments, final Boolean extendTermForRepaymentsOnHolidays, final Map<String, Object> changes) {
        this.resourceId = resourceId;
        this.recurrence = recurrence;
        this.repaymentRescheduleType = repaymentRescheduleType;
        this.extendTermForDailyRepayments = extendTermForDailyRepayments;
        this.extendTermForRepaymentsOnHolidays = extendTermForRepaymentsOnHolidays;
        this.changes = changes;
    }
}
