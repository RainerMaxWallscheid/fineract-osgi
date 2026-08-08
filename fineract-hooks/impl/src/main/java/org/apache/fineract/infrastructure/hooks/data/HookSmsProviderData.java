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
package org.apache.fineract.infrastructure.hooks.data;

import static org.apache.fineract.infrastructure.hooks.api.HookApiConstants.payloadURLName;
import static org.apache.fineract.infrastructure.hooks.api.HookApiConstants.phoneNumberName;
import static org.apache.fineract.infrastructure.hooks.api.HookApiConstants.smsProviderAccountIdName;
import static org.apache.fineract.infrastructure.hooks.api.HookApiConstants.smsProviderName;
import static org.apache.fineract.infrastructure.hooks.api.HookApiConstants.smsProviderTokenIdName;
import java.util.Set;
import org.apache.fineract.infrastructure.hooks.domain.HookConfiguration;

public class HookSmsProviderData {
    private String url;
    private String phoneNo;
    private String smsProvider;
    private String smsProviderAccountId;
    private String smsProviderToken;
    private String tenantId;
    private String mifosToken;
    private String endpoint;

    public HookSmsProviderData(final Set<HookConfiguration> config) {
        for (final HookConfiguration conf : config) {
            final String fieldName = conf.getFieldName();
            if (fieldName.equals(payloadURLName)) {
                this.url = conf.getFieldValue();
            }
            if (fieldName.equals(smsProviderName)) {
                this.smsProvider = conf.getFieldValue();
            }
            if (fieldName.equals(smsProviderAccountIdName)) {
                this.smsProviderAccountId = conf.getFieldValue();
            }
            if (fieldName.equals(smsProviderTokenIdName)) {
                this.smsProviderToken = conf.getFieldValue();
            }
            if (fieldName.equals(phoneNumberName)) {
                this.phoneNo = conf.getFieldValue();
            }
        }
    }

    @java.lang.SuppressWarnings("all")
        public String getUrl() {
        return this.url;
    }

    @java.lang.SuppressWarnings("all")
        public String getPhoneNo() {
        return this.phoneNo;
    }

    @java.lang.SuppressWarnings("all")
        public String getSmsProvider() {
        return this.smsProvider;
    }

    @java.lang.SuppressWarnings("all")
        public String getSmsProviderAccountId() {
        return this.smsProviderAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public String getSmsProviderToken() {
        return this.smsProviderToken;
    }

    @java.lang.SuppressWarnings("all")
        public String getTenantId() {
        return this.tenantId;
    }

    @java.lang.SuppressWarnings("all")
        public String getMifosToken() {
        return this.mifosToken;
    }

    @java.lang.SuppressWarnings("all")
        public String getEndpoint() {
        return this.endpoint;
    }

    @java.lang.SuppressWarnings("all")
        public void setUrl(final String url) {
        this.url = url;
    }

    @java.lang.SuppressWarnings("all")
        public void setPhoneNo(final String phoneNo) {
        this.phoneNo = phoneNo;
    }

    @java.lang.SuppressWarnings("all")
        public void setSmsProvider(final String smsProvider) {
        this.smsProvider = smsProvider;
    }

    @java.lang.SuppressWarnings("all")
        public void setSmsProviderAccountId(final String smsProviderAccountId) {
        this.smsProviderAccountId = smsProviderAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public void setSmsProviderToken(final String smsProviderToken) {
        this.smsProviderToken = smsProviderToken;
    }

    @java.lang.SuppressWarnings("all")
        public void setTenantId(final String tenantId) {
        this.tenantId = tenantId;
    }

    @java.lang.SuppressWarnings("all")
        public void setMifosToken(final String mifosToken) {
        this.mifosToken = mifosToken;
    }

    @java.lang.SuppressWarnings("all")
        public void setEndpoint(final String endpoint) {
        this.endpoint = endpoint;
    }
}
