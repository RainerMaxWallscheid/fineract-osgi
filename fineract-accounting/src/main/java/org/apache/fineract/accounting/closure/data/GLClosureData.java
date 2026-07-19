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
package org.apache.fineract.accounting.closure.data;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;
import org.apache.fineract.organisation.office.data.OfficeData;

/**
 * Immutable object representing a General Ledger Account
 *
 * Note: no getter/setters required as google-gson will produce json from fields of object.
 */
public class GLClosureData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private final Long id;
    private final Long officeId;
    private final String officeName;
    private final LocalDate closingDate;
    private final boolean deleted;
    private final LocalDate createdDate;
    private final LocalDate lastUpdatedDate;
    private final Long createdByUserId;
    private final String createdByUsername;
    private final Long lastUpdatedByUserId;
    private final String lastUpdatedByUsername;
    private final String comments;
    private Collection<OfficeData> allowedOffices = new ArrayList<>();

    @java.lang.SuppressWarnings("all")
        public GLClosureData(final Long id, final Long officeId, final String officeName, final LocalDate closingDate, final boolean deleted, final LocalDate createdDate, final LocalDate lastUpdatedDate, final Long createdByUserId, final String createdByUsername, final Long lastUpdatedByUserId, final String lastUpdatedByUsername, final String comments) {
        this.id = id;
        this.officeId = officeId;
        this.officeName = officeName;
        this.closingDate = closingDate;
        this.deleted = deleted;
        this.createdDate = createdDate;
        this.lastUpdatedDate = lastUpdatedDate;
        this.createdByUserId = createdByUserId;
        this.createdByUsername = createdByUsername;
        this.lastUpdatedByUserId = lastUpdatedByUserId;
        this.lastUpdatedByUsername = lastUpdatedByUsername;
        this.comments = comments;
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getOfficeName() {
        return this.officeName;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getClosingDate() {
        return this.closingDate;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isDeleted() {
        return this.deleted;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getCreatedDate() {
        return this.createdDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getLastUpdatedDate() {
        return this.lastUpdatedDate;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCreatedByUserId() {
        return this.createdByUserId;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreatedByUsername() {
        return this.createdByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLastUpdatedByUserId() {
        return this.lastUpdatedByUserId;
    }

    @java.lang.SuppressWarnings("all")
        public String getLastUpdatedByUsername() {
        return this.lastUpdatedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getComments() {
        return this.comments;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<OfficeData> getAllowedOffices() {
        return this.allowedOffices;
    }

    @java.lang.SuppressWarnings("all")
        public void setAllowedOffices(final Collection<OfficeData> allowedOffices) {
        this.allowedOffices = allowedOffices;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof GLClosureData)) return false;
        final GLClosureData other = (GLClosureData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.isDeleted() != other.isDeleted()) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$officeId = this.getOfficeId();
        final java.lang.Object other$officeId = other.getOfficeId();
        if (this$officeId == null ? other$officeId != null : !this$officeId.equals(other$officeId)) return false;
        final java.lang.Object this$createdByUserId = this.getCreatedByUserId();
        final java.lang.Object other$createdByUserId = other.getCreatedByUserId();
        if (this$createdByUserId == null ? other$createdByUserId != null : !this$createdByUserId.equals(other$createdByUserId)) return false;
        final java.lang.Object this$lastUpdatedByUserId = this.getLastUpdatedByUserId();
        final java.lang.Object other$lastUpdatedByUserId = other.getLastUpdatedByUserId();
        if (this$lastUpdatedByUserId == null ? other$lastUpdatedByUserId != null : !this$lastUpdatedByUserId.equals(other$lastUpdatedByUserId)) return false;
        final java.lang.Object this$officeName = this.getOfficeName();
        final java.lang.Object other$officeName = other.getOfficeName();
        if (this$officeName == null ? other$officeName != null : !this$officeName.equals(other$officeName)) return false;
        final java.lang.Object this$closingDate = this.getClosingDate();
        final java.lang.Object other$closingDate = other.getClosingDate();
        if (this$closingDate == null ? other$closingDate != null : !this$closingDate.equals(other$closingDate)) return false;
        final java.lang.Object this$createdDate = this.getCreatedDate();
        final java.lang.Object other$createdDate = other.getCreatedDate();
        if (this$createdDate == null ? other$createdDate != null : !this$createdDate.equals(other$createdDate)) return false;
        final java.lang.Object this$lastUpdatedDate = this.getLastUpdatedDate();
        final java.lang.Object other$lastUpdatedDate = other.getLastUpdatedDate();
        if (this$lastUpdatedDate == null ? other$lastUpdatedDate != null : !this$lastUpdatedDate.equals(other$lastUpdatedDate)) return false;
        final java.lang.Object this$createdByUsername = this.getCreatedByUsername();
        final java.lang.Object other$createdByUsername = other.getCreatedByUsername();
        if (this$createdByUsername == null ? other$createdByUsername != null : !this$createdByUsername.equals(other$createdByUsername)) return false;
        final java.lang.Object this$lastUpdatedByUsername = this.getLastUpdatedByUsername();
        final java.lang.Object other$lastUpdatedByUsername = other.getLastUpdatedByUsername();
        if (this$lastUpdatedByUsername == null ? other$lastUpdatedByUsername != null : !this$lastUpdatedByUsername.equals(other$lastUpdatedByUsername)) return false;
        final java.lang.Object this$comments = this.getComments();
        final java.lang.Object other$comments = other.getComments();
        if (this$comments == null ? other$comments != null : !this$comments.equals(other$comments)) return false;
        final java.lang.Object this$allowedOffices = this.getAllowedOffices();
        final java.lang.Object other$allowedOffices = other.getAllowedOffices();
        if (this$allowedOffices == null ? other$allowedOffices != null : !this$allowedOffices.equals(other$allowedOffices)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof GLClosureData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isDeleted() ? 79 : 97);
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $officeId = this.getOfficeId();
        result = result * PRIME + ($officeId == null ? 43 : $officeId.hashCode());
        final java.lang.Object $createdByUserId = this.getCreatedByUserId();
        result = result * PRIME + ($createdByUserId == null ? 43 : $createdByUserId.hashCode());
        final java.lang.Object $lastUpdatedByUserId = this.getLastUpdatedByUserId();
        result = result * PRIME + ($lastUpdatedByUserId == null ? 43 : $lastUpdatedByUserId.hashCode());
        final java.lang.Object $officeName = this.getOfficeName();
        result = result * PRIME + ($officeName == null ? 43 : $officeName.hashCode());
        final java.lang.Object $closingDate = this.getClosingDate();
        result = result * PRIME + ($closingDate == null ? 43 : $closingDate.hashCode());
        final java.lang.Object $createdDate = this.getCreatedDate();
        result = result * PRIME + ($createdDate == null ? 43 : $createdDate.hashCode());
        final java.lang.Object $lastUpdatedDate = this.getLastUpdatedDate();
        result = result * PRIME + ($lastUpdatedDate == null ? 43 : $lastUpdatedDate.hashCode());
        final java.lang.Object $createdByUsername = this.getCreatedByUsername();
        result = result * PRIME + ($createdByUsername == null ? 43 : $createdByUsername.hashCode());
        final java.lang.Object $lastUpdatedByUsername = this.getLastUpdatedByUsername();
        result = result * PRIME + ($lastUpdatedByUsername == null ? 43 : $lastUpdatedByUsername.hashCode());
        final java.lang.Object $comments = this.getComments();
        result = result * PRIME + ($comments == null ? 43 : $comments.hashCode());
        final java.lang.Object $allowedOffices = this.getAllowedOffices();
        result = result * PRIME + ($allowedOffices == null ? 43 : $allowedOffices.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "GLClosureData(id=" + this.getId() + ", officeId=" + this.getOfficeId() + ", officeName=" + this.getOfficeName() + ", closingDate=" + this.getClosingDate() + ", deleted=" + this.isDeleted() + ", createdDate=" + this.getCreatedDate() + ", lastUpdatedDate=" + this.getLastUpdatedDate() + ", createdByUserId=" + this.getCreatedByUserId() + ", createdByUsername=" + this.getCreatedByUsername() + ", lastUpdatedByUserId=" + this.getLastUpdatedByUserId() + ", lastUpdatedByUsername=" + this.getLastUpdatedByUsername() + ", comments=" + this.getComments() + ", allowedOffices=" + this.getAllowedOffices() + ")";
    }
}
