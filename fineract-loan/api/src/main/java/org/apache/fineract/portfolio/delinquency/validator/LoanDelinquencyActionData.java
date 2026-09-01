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
package org.apache.fineract.portfolio.delinquency.validator;

import java.time.LocalDate;
import java.time.OffsetDateTime;
import org.apache.fineract.portfolio.delinquency.domain.DelinquencyAction;

public class LoanDelinquencyActionData {
    private Long id;
    private DelinquencyAction action;
    private LocalDate startDate;
    private LocalDate endDate;
    private Long createdById;
    private OffsetDateTime createdOn;
    private Long updatedById;
    private OffsetDateTime lastModifiedOn;

    public LoanDelinquencyActionData() {}

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public DelinquencyAction getAction() {
        return this.action;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getStartDate() {
        return this.startDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getEndDate() {
        return this.endDate;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCreatedById() {
        return this.createdById;
    }

    @java.lang.SuppressWarnings("all")
        public OffsetDateTime getCreatedOn() {
        return this.createdOn;
    }

    @java.lang.SuppressWarnings("all")
        public Long getUpdatedById() {
        return this.updatedById;
    }

    @java.lang.SuppressWarnings("all")
        public OffsetDateTime getLastModifiedOn() {
        return this.lastModifiedOn;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setAction(final DelinquencyAction action) {
        this.action = action;
    }

    @java.lang.SuppressWarnings("all")
        public void setStartDate(final LocalDate startDate) {
        this.startDate = startDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setEndDate(final LocalDate endDate) {
        this.endDate = endDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setCreatedById(final Long createdById) {
        this.createdById = createdById;
    }

    @java.lang.SuppressWarnings("all")
        public void setCreatedOn(final OffsetDateTime createdOn) {
        this.createdOn = createdOn;
    }

    @java.lang.SuppressWarnings("all")
        public void setUpdatedById(final Long updatedById) {
        this.updatedById = updatedById;
    }

    @java.lang.SuppressWarnings("all")
        public void setLastModifiedOn(final OffsetDateTime lastModifiedOn) {
        this.lastModifiedOn = lastModifiedOn;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanDelinquencyActionData)) return false;
        final LoanDelinquencyActionData other = (LoanDelinquencyActionData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$createdById = this.getCreatedById();
        final java.lang.Object other$createdById = other.getCreatedById();
        if (this$createdById == null ? other$createdById != null : !this$createdById.equals(other$createdById)) return false;
        final java.lang.Object this$updatedById = this.getUpdatedById();
        final java.lang.Object other$updatedById = other.getUpdatedById();
        if (this$updatedById == null ? other$updatedById != null : !this$updatedById.equals(other$updatedById)) return false;
        final java.lang.Object this$action = this.getAction();
        final java.lang.Object other$action = other.getAction();
        if (this$action == null ? other$action != null : !this$action.equals(other$action)) return false;
        final java.lang.Object this$startDate = this.getStartDate();
        final java.lang.Object other$startDate = other.getStartDate();
        if (this$startDate == null ? other$startDate != null : !this$startDate.equals(other$startDate)) return false;
        final java.lang.Object this$endDate = this.getEndDate();
        final java.lang.Object other$endDate = other.getEndDate();
        if (this$endDate == null ? other$endDate != null : !this$endDate.equals(other$endDate)) return false;
        final java.lang.Object this$createdOn = this.getCreatedOn();
        final java.lang.Object other$createdOn = other.getCreatedOn();
        if (this$createdOn == null ? other$createdOn != null : !this$createdOn.equals(other$createdOn)) return false;
        final java.lang.Object this$lastModifiedOn = this.getLastModifiedOn();
        final java.lang.Object other$lastModifiedOn = other.getLastModifiedOn();
        if (this$lastModifiedOn == null ? other$lastModifiedOn != null : !this$lastModifiedOn.equals(other$lastModifiedOn)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanDelinquencyActionData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $createdById = this.getCreatedById();
        result = result * PRIME + ($createdById == null ? 43 : $createdById.hashCode());
        final java.lang.Object $updatedById = this.getUpdatedById();
        result = result * PRIME + ($updatedById == null ? 43 : $updatedById.hashCode());
        final java.lang.Object $action = this.getAction();
        result = result * PRIME + ($action == null ? 43 : $action.hashCode());
        final java.lang.Object $startDate = this.getStartDate();
        result = result * PRIME + ($startDate == null ? 43 : $startDate.hashCode());
        final java.lang.Object $endDate = this.getEndDate();
        result = result * PRIME + ($endDate == null ? 43 : $endDate.hashCode());
        final java.lang.Object $createdOn = this.getCreatedOn();
        result = result * PRIME + ($createdOn == null ? 43 : $createdOn.hashCode());
        final java.lang.Object $lastModifiedOn = this.getLastModifiedOn();
        result = result * PRIME + ($lastModifiedOn == null ? 43 : $lastModifiedOn.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanDelinquencyActionData(id=" + this.getId() + ", action=" + this.getAction() + ", startDate=" + this.getStartDate() + ", endDate=" + this.getEndDate() + ", createdById=" + this.getCreatedById() + ", createdOn=" + this.getCreatedOn() + ", updatedById=" + this.getUpdatedById() + ", lastModifiedOn=" + this.getLastModifiedOn() + ")";
    }
}
