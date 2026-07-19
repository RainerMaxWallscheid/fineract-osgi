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

import java.time.LocalDate;

public class AdjustedDateDetailsDTO {
    /**
     * Variable tracks the current schedule date that has been changed
     */
    LocalDate changedScheduleDate;
    /**
     * Variable tracks If the meeting has been changed , i.e future schedule also changes along with the current
     * repayments date.
     */
    LocalDate changedActualRepaymentDate;
    /**
     * Variable tracks the next repayment period due date
     */
    LocalDate nextRepaymentPeriodDueDate;

    public AdjustedDateDetailsDTO(final LocalDate changedScheduleDate, final LocalDate changedActualRepaymentDate) {
        this.changedScheduleDate = changedScheduleDate;
        this.changedActualRepaymentDate = changedActualRepaymentDate;
    }

    public AdjustedDateDetailsDTO(final LocalDate changedScheduleDate, final LocalDate changedActualRepaymentDate, final LocalDate nextRepaymentPeriodDueDate) {
        this.changedScheduleDate = changedScheduleDate;
        this.changedActualRepaymentDate = changedActualRepaymentDate;
        this.nextRepaymentPeriodDueDate = nextRepaymentPeriodDueDate;
    }

    /**
     * Variable tracks the current schedule date that has been changed
     */
    @java.lang.SuppressWarnings("all")
        public void setChangedScheduleDate(final LocalDate changedScheduleDate) {
        this.changedScheduleDate = changedScheduleDate;
    }

    /**
     * Variable tracks If the meeting has been changed , i.e future schedule also changes along with the current
     * repayments date.
     */
    @java.lang.SuppressWarnings("all")
        public void setChangedActualRepaymentDate(final LocalDate changedActualRepaymentDate) {
        this.changedActualRepaymentDate = changedActualRepaymentDate;
    }

    /**
     * Variable tracks the next repayment period due date
     */
    @java.lang.SuppressWarnings("all")
        public void setNextRepaymentPeriodDueDate(final LocalDate nextRepaymentPeriodDueDate) {
        this.nextRepaymentPeriodDueDate = nextRepaymentPeriodDueDate;
    }

    /**
     * Variable tracks the current schedule date that has been changed
     */
    @java.lang.SuppressWarnings("all")
        public LocalDate getChangedScheduleDate() {
        return this.changedScheduleDate;
    }

    /**
     * Variable tracks If the meeting has been changed , i.e future schedule also changes along with the current
     * repayments date.
     */
    @java.lang.SuppressWarnings("all")
        public LocalDate getChangedActualRepaymentDate() {
        return this.changedActualRepaymentDate;
    }

    /**
     * Variable tracks the next repayment period due date
     */
    @java.lang.SuppressWarnings("all")
        public LocalDate getNextRepaymentPeriodDueDate() {
        return this.nextRepaymentPeriodDueDate;
    }
}
