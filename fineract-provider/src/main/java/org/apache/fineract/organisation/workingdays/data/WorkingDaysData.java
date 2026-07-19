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
import java.util.Collection;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;

public class WorkingDaysData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long id;
    private String recurrence;
    private EnumOptionData repaymentRescheduleType;
    private Boolean extendTermForDailyRepayments;
    private Boolean extendTermForRepaymentsOnHolidays;
    @SuppressWarnings("unused")
    private Collection<EnumOptionData> repaymentRescheduleOptions;


    @java.lang.SuppressWarnings("all")
        public static class WorkingDaysDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String recurrence;
        @java.lang.SuppressWarnings("all")
                private EnumOptionData repaymentRescheduleType;
        @java.lang.SuppressWarnings("all")
                private Boolean extendTermForDailyRepayments;
        @java.lang.SuppressWarnings("all")
                private Boolean extendTermForRepaymentsOnHolidays;
        @java.lang.SuppressWarnings("all")
                private Collection<EnumOptionData> repaymentRescheduleOptions;

        @java.lang.SuppressWarnings("all")
                WorkingDaysDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingDaysData.WorkingDaysDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingDaysData.WorkingDaysDataBuilder recurrence(final String recurrence) {
            this.recurrence = recurrence;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingDaysData.WorkingDaysDataBuilder repaymentRescheduleType(final EnumOptionData repaymentRescheduleType) {
            this.repaymentRescheduleType = repaymentRescheduleType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingDaysData.WorkingDaysDataBuilder extendTermForDailyRepayments(final Boolean extendTermForDailyRepayments) {
            this.extendTermForDailyRepayments = extendTermForDailyRepayments;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingDaysData.WorkingDaysDataBuilder extendTermForRepaymentsOnHolidays(final Boolean extendTermForRepaymentsOnHolidays) {
            this.extendTermForRepaymentsOnHolidays = extendTermForRepaymentsOnHolidays;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingDaysData.WorkingDaysDataBuilder repaymentRescheduleOptions(final Collection<EnumOptionData> repaymentRescheduleOptions) {
            this.repaymentRescheduleOptions = repaymentRescheduleOptions;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public WorkingDaysData build() {
            return new WorkingDaysData(this.id, this.recurrence, this.repaymentRescheduleType, this.extendTermForDailyRepayments, this.extendTermForRepaymentsOnHolidays, this.repaymentRescheduleOptions);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "WorkingDaysData.WorkingDaysDataBuilder(id=" + this.id + ", recurrence=" + this.recurrence + ", repaymentRescheduleType=" + this.repaymentRescheduleType + ", extendTermForDailyRepayments=" + this.extendTermForDailyRepayments + ", extendTermForRepaymentsOnHolidays=" + this.extendTermForRepaymentsOnHolidays + ", repaymentRescheduleOptions=" + this.repaymentRescheduleOptions + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static WorkingDaysData.WorkingDaysDataBuilder builder() {
        return new WorkingDaysData.WorkingDaysDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getRecurrence() {
        return this.recurrence;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getRepaymentRescheduleType() {
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
        public Collection<EnumOptionData> getRepaymentRescheduleOptions() {
        return this.repaymentRescheduleOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setRecurrence(final String recurrence) {
        this.recurrence = recurrence;
    }

    @java.lang.SuppressWarnings("all")
        public void setRepaymentRescheduleType(final EnumOptionData repaymentRescheduleType) {
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
        public void setRepaymentRescheduleOptions(final Collection<EnumOptionData> repaymentRescheduleOptions) {
        this.repaymentRescheduleOptions = repaymentRescheduleOptions;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof WorkingDaysData)) return false;
        final WorkingDaysData other = (WorkingDaysData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$extendTermForDailyRepayments = this.getExtendTermForDailyRepayments();
        final java.lang.Object other$extendTermForDailyRepayments = other.getExtendTermForDailyRepayments();
        if (this$extendTermForDailyRepayments == null ? other$extendTermForDailyRepayments != null : !this$extendTermForDailyRepayments.equals(other$extendTermForDailyRepayments)) return false;
        final java.lang.Object this$extendTermForRepaymentsOnHolidays = this.getExtendTermForRepaymentsOnHolidays();
        final java.lang.Object other$extendTermForRepaymentsOnHolidays = other.getExtendTermForRepaymentsOnHolidays();
        if (this$extendTermForRepaymentsOnHolidays == null ? other$extendTermForRepaymentsOnHolidays != null : !this$extendTermForRepaymentsOnHolidays.equals(other$extendTermForRepaymentsOnHolidays)) return false;
        final java.lang.Object this$recurrence = this.getRecurrence();
        final java.lang.Object other$recurrence = other.getRecurrence();
        if (this$recurrence == null ? other$recurrence != null : !this$recurrence.equals(other$recurrence)) return false;
        final java.lang.Object this$repaymentRescheduleType = this.getRepaymentRescheduleType();
        final java.lang.Object other$repaymentRescheduleType = other.getRepaymentRescheduleType();
        if (this$repaymentRescheduleType == null ? other$repaymentRescheduleType != null : !this$repaymentRescheduleType.equals(other$repaymentRescheduleType)) return false;
        final java.lang.Object this$repaymentRescheduleOptions = this.getRepaymentRescheduleOptions();
        final java.lang.Object other$repaymentRescheduleOptions = other.getRepaymentRescheduleOptions();
        if (this$repaymentRescheduleOptions == null ? other$repaymentRescheduleOptions != null : !this$repaymentRescheduleOptions.equals(other$repaymentRescheduleOptions)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof WorkingDaysData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $extendTermForDailyRepayments = this.getExtendTermForDailyRepayments();
        result = result * PRIME + ($extendTermForDailyRepayments == null ? 43 : $extendTermForDailyRepayments.hashCode());
        final java.lang.Object $extendTermForRepaymentsOnHolidays = this.getExtendTermForRepaymentsOnHolidays();
        result = result * PRIME + ($extendTermForRepaymentsOnHolidays == null ? 43 : $extendTermForRepaymentsOnHolidays.hashCode());
        final java.lang.Object $recurrence = this.getRecurrence();
        result = result * PRIME + ($recurrence == null ? 43 : $recurrence.hashCode());
        final java.lang.Object $repaymentRescheduleType = this.getRepaymentRescheduleType();
        result = result * PRIME + ($repaymentRescheduleType == null ? 43 : $repaymentRescheduleType.hashCode());
        final java.lang.Object $repaymentRescheduleOptions = this.getRepaymentRescheduleOptions();
        result = result * PRIME + ($repaymentRescheduleOptions == null ? 43 : $repaymentRescheduleOptions.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "WorkingDaysData(id=" + this.getId() + ", recurrence=" + this.getRecurrence() + ", repaymentRescheduleType=" + this.getRepaymentRescheduleType() + ", extendTermForDailyRepayments=" + this.getExtendTermForDailyRepayments() + ", extendTermForRepaymentsOnHolidays=" + this.getExtendTermForRepaymentsOnHolidays() + ", repaymentRescheduleOptions=" + this.getRepaymentRescheduleOptions() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public WorkingDaysData() {
    }

    @java.lang.SuppressWarnings("all")
        public WorkingDaysData(final Long id, final String recurrence, final EnumOptionData repaymentRescheduleType, final Boolean extendTermForDailyRepayments, final Boolean extendTermForRepaymentsOnHolidays, final Collection<EnumOptionData> repaymentRescheduleOptions) {
        this.id = id;
        this.recurrence = recurrence;
        this.repaymentRescheduleType = repaymentRescheduleType;
        this.extendTermForDailyRepayments = extendTermForDailyRepayments;
        this.extendTermForRepaymentsOnHolidays = extendTermForRepaymentsOnHolidays;
        this.repaymentRescheduleOptions = repaymentRescheduleOptions;
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String id = "id";
        public static final java.lang.String recurrence = "recurrence";
        public static final java.lang.String repaymentRescheduleType = "repaymentRescheduleType";
        public static final java.lang.String extendTermForDailyRepayments = "extendTermForDailyRepayments";
        public static final java.lang.String extendTermForRepaymentsOnHolidays = "extendTermForRepaymentsOnHolidays";
        public static final java.lang.String repaymentRescheduleOptions = "repaymentRescheduleOptions";
    }
}
