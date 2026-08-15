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
package org.apache.fineract.portfolio.account.data.request;

import jakarta.ws.rs.QueryParam;
import java.io.Serial;
import java.io.Serializable;

public class AccountTransSearchParam implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @QueryParam("fromOfficeId")
    private Long fromOfficeId;
    @QueryParam("fromClientId")
    private Long fromClientId;
    @QueryParam("fromAccountId")
    private Long fromAccountId;
    @QueryParam("fromAccountType")
    private Integer fromAccountType;
    @QueryParam("toOfficeId")
    private Long toOfficeId;
    @QueryParam("toClientId")
    private Long toClientId;
    @QueryParam("toAccountId")
    private Long toAccountId;
    @QueryParam("toAccountType")
    private Integer toAccountType;

    @java.lang.SuppressWarnings("all")
        public Long getFromOfficeId() {
        return this.fromOfficeId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getFromClientId() {
        return this.fromClientId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getFromAccountId() {
        return this.fromAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getFromAccountType() {
        return this.fromAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public Long getToOfficeId() {
        return this.toOfficeId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getToClientId() {
        return this.toClientId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getToAccountId() {
        return this.toAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getToAccountType() {
        return this.toAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public void setFromOfficeId(final Long fromOfficeId) {
        this.fromOfficeId = fromOfficeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setFromClientId(final Long fromClientId) {
        this.fromClientId = fromClientId;
    }

    @java.lang.SuppressWarnings("all")
        public void setFromAccountId(final Long fromAccountId) {
        this.fromAccountId = fromAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public void setFromAccountType(final Integer fromAccountType) {
        this.fromAccountType = fromAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public void setToOfficeId(final Long toOfficeId) {
        this.toOfficeId = toOfficeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setToClientId(final Long toClientId) {
        this.toClientId = toClientId;
    }

    @java.lang.SuppressWarnings("all")
        public void setToAccountId(final Long toAccountId) {
        this.toAccountId = toAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public void setToAccountType(final Integer toAccountType) {
        this.toAccountType = toAccountType;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof AccountTransSearchParam)) return false;
        final AccountTransSearchParam other = (AccountTransSearchParam) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$fromOfficeId = this.getFromOfficeId();
        final java.lang.Object other$fromOfficeId = other.getFromOfficeId();
        if (this$fromOfficeId == null ? other$fromOfficeId != null : !this$fromOfficeId.equals(other$fromOfficeId)) return false;
        final java.lang.Object this$fromClientId = this.getFromClientId();
        final java.lang.Object other$fromClientId = other.getFromClientId();
        if (this$fromClientId == null ? other$fromClientId != null : !this$fromClientId.equals(other$fromClientId)) return false;
        final java.lang.Object this$fromAccountId = this.getFromAccountId();
        final java.lang.Object other$fromAccountId = other.getFromAccountId();
        if (this$fromAccountId == null ? other$fromAccountId != null : !this$fromAccountId.equals(other$fromAccountId)) return false;
        final java.lang.Object this$fromAccountType = this.getFromAccountType();
        final java.lang.Object other$fromAccountType = other.getFromAccountType();
        if (this$fromAccountType == null ? other$fromAccountType != null : !this$fromAccountType.equals(other$fromAccountType)) return false;
        final java.lang.Object this$toOfficeId = this.getToOfficeId();
        final java.lang.Object other$toOfficeId = other.getToOfficeId();
        if (this$toOfficeId == null ? other$toOfficeId != null : !this$toOfficeId.equals(other$toOfficeId)) return false;
        final java.lang.Object this$toClientId = this.getToClientId();
        final java.lang.Object other$toClientId = other.getToClientId();
        if (this$toClientId == null ? other$toClientId != null : !this$toClientId.equals(other$toClientId)) return false;
        final java.lang.Object this$toAccountId = this.getToAccountId();
        final java.lang.Object other$toAccountId = other.getToAccountId();
        if (this$toAccountId == null ? other$toAccountId != null : !this$toAccountId.equals(other$toAccountId)) return false;
        final java.lang.Object this$toAccountType = this.getToAccountType();
        final java.lang.Object other$toAccountType = other.getToAccountType();
        if (this$toAccountType == null ? other$toAccountType != null : !this$toAccountType.equals(other$toAccountType)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof AccountTransSearchParam;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $fromOfficeId = this.getFromOfficeId();
        result = result * PRIME + ($fromOfficeId == null ? 43 : $fromOfficeId.hashCode());
        final java.lang.Object $fromClientId = this.getFromClientId();
        result = result * PRIME + ($fromClientId == null ? 43 : $fromClientId.hashCode());
        final java.lang.Object $fromAccountId = this.getFromAccountId();
        result = result * PRIME + ($fromAccountId == null ? 43 : $fromAccountId.hashCode());
        final java.lang.Object $fromAccountType = this.getFromAccountType();
        result = result * PRIME + ($fromAccountType == null ? 43 : $fromAccountType.hashCode());
        final java.lang.Object $toOfficeId = this.getToOfficeId();
        result = result * PRIME + ($toOfficeId == null ? 43 : $toOfficeId.hashCode());
        final java.lang.Object $toClientId = this.getToClientId();
        result = result * PRIME + ($toClientId == null ? 43 : $toClientId.hashCode());
        final java.lang.Object $toAccountId = this.getToAccountId();
        result = result * PRIME + ($toAccountId == null ? 43 : $toAccountId.hashCode());
        final java.lang.Object $toAccountType = this.getToAccountType();
        result = result * PRIME + ($toAccountType == null ? 43 : $toAccountType.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "AccountTransSearchParam(fromOfficeId=" + this.getFromOfficeId() + ", fromClientId=" + this.getFromClientId() + ", fromAccountId=" + this.getFromAccountId() + ", fromAccountType=" + this.getFromAccountType() + ", toOfficeId=" + this.getToOfficeId() + ", toClientId=" + this.getToClientId() + ", toAccountId=" + this.getToAccountId() + ", toAccountType=" + this.getToAccountType() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public AccountTransSearchParam() {
    }

    @java.lang.SuppressWarnings("all")
        public AccountTransSearchParam(final Long fromOfficeId, final Long fromClientId, final Long fromAccountId, final Integer fromAccountType, final Long toOfficeId, final Long toClientId, final Long toAccountId, final Integer toAccountType) {
        this.fromOfficeId = fromOfficeId;
        this.fromClientId = fromClientId;
        this.fromAccountId = fromAccountId;
        this.fromAccountType = fromAccountType;
        this.toOfficeId = toOfficeId;
        this.toClientId = toClientId;
        this.toAccountId = toAccountId;
        this.toAccountType = toAccountType;
    }
}
