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
package org.apache.fineract.organisation.workingdays.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;

@Entity
@Table(name = "m_working_days")
public class WorkingDays extends AbstractPersistableCustom<Long> {
    @Column(name = "recurrence", length = 100, nullable = true)
    private String recurrence;
    @Column(name = "repayment_rescheduling_enum", nullable = false)
    private Integer repaymentReschedulingType;
    @Column(name = "extend_term_daily_repayments", nullable = false)
    private Boolean extendTermForDailyRepayments;
    @Column(name = "extend_term_holiday_repayment", nullable = false)
    private Boolean extendTermForRepaymentsOnHolidays;


    @java.lang.SuppressWarnings("all")
        public static class WorkingDaysBuilder {
        @java.lang.SuppressWarnings("all")
                private String recurrence;
        @java.lang.SuppressWarnings("all")
                private Integer repaymentReschedulingType;
        @java.lang.SuppressWarnings("all")
                private Boolean extendTermForDailyRepayments;
        @java.lang.SuppressWarnings("all")
                private Boolean extendTermForRepaymentsOnHolidays;

        @java.lang.SuppressWarnings("all")
                WorkingDaysBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingDays.WorkingDaysBuilder recurrence(final String recurrence) {
            this.recurrence = recurrence;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingDays.WorkingDaysBuilder repaymentReschedulingType(final Integer repaymentReschedulingType) {
            this.repaymentReschedulingType = repaymentReschedulingType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingDays.WorkingDaysBuilder extendTermForDailyRepayments(final Boolean extendTermForDailyRepayments) {
            this.extendTermForDailyRepayments = extendTermForDailyRepayments;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingDays.WorkingDaysBuilder extendTermForRepaymentsOnHolidays(final Boolean extendTermForRepaymentsOnHolidays) {
            this.extendTermForRepaymentsOnHolidays = extendTermForRepaymentsOnHolidays;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public WorkingDays build() {
            return new WorkingDays(this.recurrence, this.repaymentReschedulingType, this.extendTermForDailyRepayments, this.extendTermForRepaymentsOnHolidays);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "WorkingDays.WorkingDaysBuilder(recurrence=" + this.recurrence + ", repaymentReschedulingType=" + this.repaymentReschedulingType + ", extendTermForDailyRepayments=" + this.extendTermForDailyRepayments + ", extendTermForRepaymentsOnHolidays=" + this.extendTermForRepaymentsOnHolidays + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static WorkingDays.WorkingDaysBuilder builder() {
        return new WorkingDays.WorkingDaysBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getRecurrence() {
        return this.recurrence;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRepaymentReschedulingType() {
        return this.repaymentReschedulingType;
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
        public void setRecurrence(final String recurrence) {
        this.recurrence = recurrence;
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
        public WorkingDays() {
    }

    @java.lang.SuppressWarnings("all")
        public WorkingDays(final String recurrence, final Integer repaymentReschedulingType, final Boolean extendTermForDailyRepayments, final Boolean extendTermForRepaymentsOnHolidays) {
        this.recurrence = recurrence;
        this.repaymentReschedulingType = repaymentReschedulingType;
        this.extendTermForDailyRepayments = extendTermForDailyRepayments;
        this.extendTermForRepaymentsOnHolidays = extendTermForRepaymentsOnHolidays;
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String recurrence = "recurrence";
        public static final java.lang.String repaymentReschedulingType = "repaymentReschedulingType";
        public static final java.lang.String extendTermForDailyRepayments = "extendTermForDailyRepayments";
        public static final java.lang.String extendTermForRepaymentsOnHolidays = "extendTermForRepaymentsOnHolidays";
    }

    @java.lang.SuppressWarnings("all")
        public void setRepaymentReschedulingType(final Integer repaymentReschedulingType) {
        this.repaymentReschedulingType = repaymentReschedulingType;
    }
}
