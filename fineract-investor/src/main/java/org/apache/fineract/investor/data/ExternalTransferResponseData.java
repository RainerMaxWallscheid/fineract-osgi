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
package org.apache.fineract.investor.data;

public class ExternalTransferResponseData {
    private Long resourceId;
    private String resourceExternalId;
    private Long subResourceId;
    private String subResourceExternalId;
    private ExternalTransferChangedData changes;
    private String dateformat;
    private String locale;

    @java.lang.SuppressWarnings("all")
        public ExternalTransferResponseData() {
    }

    @java.lang.SuppressWarnings("all")
        public Long getResourceId() {
        return this.resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public String getResourceExternalId() {
        return this.resourceExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getSubResourceId() {
        return this.subResourceId;
    }

    @java.lang.SuppressWarnings("all")
        public String getSubResourceExternalId() {
        return this.subResourceExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalTransferChangedData getChanges() {
        return this.changes;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateformat() {
        return this.dateformat;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setResourceId(final Long resourceId) {
        this.resourceId = resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public void setResourceExternalId(final String resourceExternalId) {
        this.resourceExternalId = resourceExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setSubResourceId(final Long subResourceId) {
        this.subResourceId = subResourceId;
    }

    @java.lang.SuppressWarnings("all")
        public void setSubResourceExternalId(final String subResourceExternalId) {
        this.subResourceExternalId = subResourceExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setChanges(final ExternalTransferChangedData changes) {
        this.changes = changes;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateformat(final String dateformat) {
        this.dateformat = dateformat;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ExternalTransferResponseData)) return false;
        final ExternalTransferResponseData other = (ExternalTransferResponseData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$resourceId = this.getResourceId();
        final java.lang.Object other$resourceId = other.getResourceId();
        if (this$resourceId == null ? other$resourceId != null : !this$resourceId.equals(other$resourceId)) return false;
        final java.lang.Object this$subResourceId = this.getSubResourceId();
        final java.lang.Object other$subResourceId = other.getSubResourceId();
        if (this$subResourceId == null ? other$subResourceId != null : !this$subResourceId.equals(other$subResourceId)) return false;
        final java.lang.Object this$resourceExternalId = this.getResourceExternalId();
        final java.lang.Object other$resourceExternalId = other.getResourceExternalId();
        if (this$resourceExternalId == null ? other$resourceExternalId != null : !this$resourceExternalId.equals(other$resourceExternalId)) return false;
        final java.lang.Object this$subResourceExternalId = this.getSubResourceExternalId();
        final java.lang.Object other$subResourceExternalId = other.getSubResourceExternalId();
        if (this$subResourceExternalId == null ? other$subResourceExternalId != null : !this$subResourceExternalId.equals(other$subResourceExternalId)) return false;
        final java.lang.Object this$changes = this.getChanges();
        final java.lang.Object other$changes = other.getChanges();
        if (this$changes == null ? other$changes != null : !this$changes.equals(other$changes)) return false;
        final java.lang.Object this$dateformat = this.getDateformat();
        final java.lang.Object other$dateformat = other.getDateformat();
        if (this$dateformat == null ? other$dateformat != null : !this$dateformat.equals(other$dateformat)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ExternalTransferResponseData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $resourceId = this.getResourceId();
        result = result * PRIME + ($resourceId == null ? 43 : $resourceId.hashCode());
        final java.lang.Object $subResourceId = this.getSubResourceId();
        result = result * PRIME + ($subResourceId == null ? 43 : $subResourceId.hashCode());
        final java.lang.Object $resourceExternalId = this.getResourceExternalId();
        result = result * PRIME + ($resourceExternalId == null ? 43 : $resourceExternalId.hashCode());
        final java.lang.Object $subResourceExternalId = this.getSubResourceExternalId();
        result = result * PRIME + ($subResourceExternalId == null ? 43 : $subResourceExternalId.hashCode());
        final java.lang.Object $changes = this.getChanges();
        result = result * PRIME + ($changes == null ? 43 : $changes.hashCode());
        final java.lang.Object $dateformat = this.getDateformat();
        result = result * PRIME + ($dateformat == null ? 43 : $dateformat.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ExternalTransferResponseData(resourceId=" + this.getResourceId() + ", resourceExternalId=" + this.getResourceExternalId() + ", subResourceId=" + this.getSubResourceId() + ", subResourceExternalId=" + this.getSubResourceExternalId() + ", changes=" + this.getChanges() + ", dateformat=" + this.getDateformat() + ", locale=" + this.getLocale() + ")";
    }
}
