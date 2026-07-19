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
package org.apache.fineract.infrastructure.event.business.domain.datatable;

import java.util.Map;
import org.apache.fineract.infrastructure.dataqueries.data.EntityTables;

public class DatatableEntryDetails {
    private final String datatableName;
    private final EntityTables entityType;
    private final Long entityId;
    private final Long appTableId;
    private final Map<String, Object> data;

    @java.lang.SuppressWarnings("all")
        public String getDatatableName() {
        return this.datatableName;
    }

    @java.lang.SuppressWarnings("all")
        public EntityTables getEntityType() {
        return this.entityType;
    }

    @java.lang.SuppressWarnings("all")
        public Long getEntityId() {
        return this.entityId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getAppTableId() {
        return this.appTableId;
    }

    @java.lang.SuppressWarnings("all")
        public Map<String, Object> getData() {
        return this.data;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof DatatableEntryDetails)) return false;
        final DatatableEntryDetails other = (DatatableEntryDetails) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$entityId = this.getEntityId();
        final java.lang.Object other$entityId = other.getEntityId();
        if (this$entityId == null ? other$entityId != null : !this$entityId.equals(other$entityId)) return false;
        final java.lang.Object this$appTableId = this.getAppTableId();
        final java.lang.Object other$appTableId = other.getAppTableId();
        if (this$appTableId == null ? other$appTableId != null : !this$appTableId.equals(other$appTableId)) return false;
        final java.lang.Object this$datatableName = this.getDatatableName();
        final java.lang.Object other$datatableName = other.getDatatableName();
        if (this$datatableName == null ? other$datatableName != null : !this$datatableName.equals(other$datatableName)) return false;
        final java.lang.Object this$entityType = this.getEntityType();
        final java.lang.Object other$entityType = other.getEntityType();
        if (this$entityType == null ? other$entityType != null : !this$entityType.equals(other$entityType)) return false;
        final java.lang.Object this$data = this.getData();
        final java.lang.Object other$data = other.getData();
        if (this$data == null ? other$data != null : !this$data.equals(other$data)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof DatatableEntryDetails;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $entityId = this.getEntityId();
        result = result * PRIME + ($entityId == null ? 43 : $entityId.hashCode());
        final java.lang.Object $appTableId = this.getAppTableId();
        result = result * PRIME + ($appTableId == null ? 43 : $appTableId.hashCode());
        final java.lang.Object $datatableName = this.getDatatableName();
        result = result * PRIME + ($datatableName == null ? 43 : $datatableName.hashCode());
        final java.lang.Object $entityType = this.getEntityType();
        result = result * PRIME + ($entityType == null ? 43 : $entityType.hashCode());
        final java.lang.Object $data = this.getData();
        result = result * PRIME + ($data == null ? 43 : $data.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "DatatableEntryDetails(datatableName=" + this.getDatatableName() + ", entityType=" + this.getEntityType() + ", entityId=" + this.getEntityId() + ", appTableId=" + this.getAppTableId() + ", data=" + this.getData() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public DatatableEntryDetails(final String datatableName, final EntityTables entityType, final Long entityId, final Long appTableId, final Map<String, Object> data) {
        this.datatableName = datatableName;
        this.entityType = entityType;
        this.entityId = entityId;
        this.appTableId = appTableId;
        this.data = data;
    }
}
