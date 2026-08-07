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
package org.apache.fineract.infrastructure.creditbureau.data;

public final class CreditBureauConfigurationData {
    private long creditBureauConfigurationId;
    private String configurationKey;
    private String value;
    private long organizationCreditBureauId;
    private String description;

    public static CreditBureauConfigurationData instance(final long creditBureauConfigurationId, final String configurationKey, final String value, final long organizationCreditBureauId, final String description) {
        return new CreditBureauConfigurationData().setCreditBureauConfigurationId(creditBureauConfigurationId).setConfigurationKey(configurationKey).setValue(value).setOrganizationCreditBureauId(organizationCreditBureauId).setDescription(description);
    }

    @java.lang.SuppressWarnings("all")
        public long getCreditBureauConfigurationId() {
        return this.creditBureauConfigurationId;
    }

    @java.lang.SuppressWarnings("all")
        public String getConfigurationKey() {
        return this.configurationKey;
    }

    @java.lang.SuppressWarnings("all")
        public String getValue() {
        return this.value;
    }

    @java.lang.SuppressWarnings("all")
        public long getOrganizationCreditBureauId() {
        return this.organizationCreditBureauId;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauConfigurationData setCreditBureauConfigurationId(final long creditBureauConfigurationId) {
        this.creditBureauConfigurationId = creditBureauConfigurationId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauConfigurationData setConfigurationKey(final String configurationKey) {
        this.configurationKey = configurationKey;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauConfigurationData setValue(final String value) {
        this.value = value;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauConfigurationData setOrganizationCreditBureauId(final long organizationCreditBureauId) {
        this.organizationCreditBureauId = organizationCreditBureauId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauConfigurationData setDescription(final String description) {
        this.description = description;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CreditBureauConfigurationData)) return false;
        final CreditBureauConfigurationData other = (CreditBureauConfigurationData) o;
        if (this.getCreditBureauConfigurationId() != other.getCreditBureauConfigurationId()) return false;
        if (this.getOrganizationCreditBureauId() != other.getOrganizationCreditBureauId()) return false;
        final java.lang.Object this$configurationKey = this.getConfigurationKey();
        final java.lang.Object other$configurationKey = other.getConfigurationKey();
        if (this$configurationKey == null ? other$configurationKey != null : !this$configurationKey.equals(other$configurationKey)) return false;
        final java.lang.Object this$value = this.getValue();
        final java.lang.Object other$value = other.getValue();
        if (this$value == null ? other$value != null : !this$value.equals(other$value)) return false;
        final java.lang.Object this$description = this.getDescription();
        final java.lang.Object other$description = other.getDescription();
        if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final long $creditBureauConfigurationId = this.getCreditBureauConfigurationId();
        result = result * PRIME + (int) ($creditBureauConfigurationId >>> 32 ^ $creditBureauConfigurationId);
        final long $organizationCreditBureauId = this.getOrganizationCreditBureauId();
        result = result * PRIME + (int) ($organizationCreditBureauId >>> 32 ^ $organizationCreditBureauId);
        final java.lang.Object $configurationKey = this.getConfigurationKey();
        result = result * PRIME + ($configurationKey == null ? 43 : $configurationKey.hashCode());
        final java.lang.Object $value = this.getValue();
        result = result * PRIME + ($value == null ? 43 : $value.hashCode());
        final java.lang.Object $description = this.getDescription();
        result = result * PRIME + ($description == null ? 43 : $description.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CreditBureauConfigurationData(creditBureauConfigurationId=" + this.getCreditBureauConfigurationId() + ", configurationKey=" + this.getConfigurationKey() + ", value=" + this.getValue() + ", organizationCreditBureauId=" + this.getOrganizationCreditBureauId() + ", description=" + this.getDescription() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CreditBureauConfigurationData() {
    }
}
