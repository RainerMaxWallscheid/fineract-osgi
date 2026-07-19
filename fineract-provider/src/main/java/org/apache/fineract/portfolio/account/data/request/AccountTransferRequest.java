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

import java.io.Serial;
import java.io.Serializable;

public class AccountTransferRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String transferDescription;
    private String toOfficeId;
    private String toAccountType;
    private String dateFormat;
    private String transferAmount;
    private String toAccountId;
    private String fromClientId;
    private String locale;
    private String transferDate;
    private String fromAccountType;
    private String toClientId;
    private String fromAccountId;
    private String fromOfficeId;

    @java.lang.SuppressWarnings("all")
        public String getTransferDescription() {
        return this.transferDescription;
    }

    @java.lang.SuppressWarnings("all")
        public String getToOfficeId() {
        return this.toOfficeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getToAccountType() {
        return this.toAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getTransferAmount() {
        return this.transferAmount;
    }

    @java.lang.SuppressWarnings("all")
        public String getToAccountId() {
        return this.toAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public String getFromClientId() {
        return this.fromClientId;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public String getTransferDate() {
        return this.transferDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getFromAccountType() {
        return this.fromAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public String getToClientId() {
        return this.toClientId;
    }

    @java.lang.SuppressWarnings("all")
        public String getFromAccountId() {
        return this.fromAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public String getFromOfficeId() {
        return this.fromOfficeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransferDescription(final String transferDescription) {
        this.transferDescription = transferDescription;
    }

    @java.lang.SuppressWarnings("all")
        public void setToOfficeId(final String toOfficeId) {
        this.toOfficeId = toOfficeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setToAccountType(final String toAccountType) {
        this.toAccountType = toAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransferAmount(final String transferAmount) {
        this.transferAmount = transferAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setToAccountId(final String toAccountId) {
        this.toAccountId = toAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public void setFromClientId(final String fromClientId) {
        this.fromClientId = fromClientId;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransferDate(final String transferDate) {
        this.transferDate = transferDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setFromAccountType(final String fromAccountType) {
        this.fromAccountType = fromAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public void setToClientId(final String toClientId) {
        this.toClientId = toClientId;
    }

    @java.lang.SuppressWarnings("all")
        public void setFromAccountId(final String fromAccountId) {
        this.fromAccountId = fromAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public void setFromOfficeId(final String fromOfficeId) {
        this.fromOfficeId = fromOfficeId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof AccountTransferRequest)) return false;
        final AccountTransferRequest other = (AccountTransferRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$transferDescription = this.getTransferDescription();
        final java.lang.Object other$transferDescription = other.getTransferDescription();
        if (this$transferDescription == null ? other$transferDescription != null : !this$transferDescription.equals(other$transferDescription)) return false;
        final java.lang.Object this$toOfficeId = this.getToOfficeId();
        final java.lang.Object other$toOfficeId = other.getToOfficeId();
        if (this$toOfficeId == null ? other$toOfficeId != null : !this$toOfficeId.equals(other$toOfficeId)) return false;
        final java.lang.Object this$toAccountType = this.getToAccountType();
        final java.lang.Object other$toAccountType = other.getToAccountType();
        if (this$toAccountType == null ? other$toAccountType != null : !this$toAccountType.equals(other$toAccountType)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        final java.lang.Object this$transferAmount = this.getTransferAmount();
        final java.lang.Object other$transferAmount = other.getTransferAmount();
        if (this$transferAmount == null ? other$transferAmount != null : !this$transferAmount.equals(other$transferAmount)) return false;
        final java.lang.Object this$toAccountId = this.getToAccountId();
        final java.lang.Object other$toAccountId = other.getToAccountId();
        if (this$toAccountId == null ? other$toAccountId != null : !this$toAccountId.equals(other$toAccountId)) return false;
        final java.lang.Object this$fromClientId = this.getFromClientId();
        final java.lang.Object other$fromClientId = other.getFromClientId();
        if (this$fromClientId == null ? other$fromClientId != null : !this$fromClientId.equals(other$fromClientId)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$transferDate = this.getTransferDate();
        final java.lang.Object other$transferDate = other.getTransferDate();
        if (this$transferDate == null ? other$transferDate != null : !this$transferDate.equals(other$transferDate)) return false;
        final java.lang.Object this$fromAccountType = this.getFromAccountType();
        final java.lang.Object other$fromAccountType = other.getFromAccountType();
        if (this$fromAccountType == null ? other$fromAccountType != null : !this$fromAccountType.equals(other$fromAccountType)) return false;
        final java.lang.Object this$toClientId = this.getToClientId();
        final java.lang.Object other$toClientId = other.getToClientId();
        if (this$toClientId == null ? other$toClientId != null : !this$toClientId.equals(other$toClientId)) return false;
        final java.lang.Object this$fromAccountId = this.getFromAccountId();
        final java.lang.Object other$fromAccountId = other.getFromAccountId();
        if (this$fromAccountId == null ? other$fromAccountId != null : !this$fromAccountId.equals(other$fromAccountId)) return false;
        final java.lang.Object this$fromOfficeId = this.getFromOfficeId();
        final java.lang.Object other$fromOfficeId = other.getFromOfficeId();
        if (this$fromOfficeId == null ? other$fromOfficeId != null : !this$fromOfficeId.equals(other$fromOfficeId)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof AccountTransferRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $transferDescription = this.getTransferDescription();
        result = result * PRIME + ($transferDescription == null ? 43 : $transferDescription.hashCode());
        final java.lang.Object $toOfficeId = this.getToOfficeId();
        result = result * PRIME + ($toOfficeId == null ? 43 : $toOfficeId.hashCode());
        final java.lang.Object $toAccountType = this.getToAccountType();
        result = result * PRIME + ($toAccountType == null ? 43 : $toAccountType.hashCode());
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        final java.lang.Object $transferAmount = this.getTransferAmount();
        result = result * PRIME + ($transferAmount == null ? 43 : $transferAmount.hashCode());
        final java.lang.Object $toAccountId = this.getToAccountId();
        result = result * PRIME + ($toAccountId == null ? 43 : $toAccountId.hashCode());
        final java.lang.Object $fromClientId = this.getFromClientId();
        result = result * PRIME + ($fromClientId == null ? 43 : $fromClientId.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $transferDate = this.getTransferDate();
        result = result * PRIME + ($transferDate == null ? 43 : $transferDate.hashCode());
        final java.lang.Object $fromAccountType = this.getFromAccountType();
        result = result * PRIME + ($fromAccountType == null ? 43 : $fromAccountType.hashCode());
        final java.lang.Object $toClientId = this.getToClientId();
        result = result * PRIME + ($toClientId == null ? 43 : $toClientId.hashCode());
        final java.lang.Object $fromAccountId = this.getFromAccountId();
        result = result * PRIME + ($fromAccountId == null ? 43 : $fromAccountId.hashCode());
        final java.lang.Object $fromOfficeId = this.getFromOfficeId();
        result = result * PRIME + ($fromOfficeId == null ? 43 : $fromOfficeId.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "AccountTransferRequest(transferDescription=" + this.getTransferDescription() + ", toOfficeId=" + this.getToOfficeId() + ", toAccountType=" + this.getToAccountType() + ", dateFormat=" + this.getDateFormat() + ", transferAmount=" + this.getTransferAmount() + ", toAccountId=" + this.getToAccountId() + ", fromClientId=" + this.getFromClientId() + ", locale=" + this.getLocale() + ", transferDate=" + this.getTransferDate() + ", fromAccountType=" + this.getFromAccountType() + ", toClientId=" + this.getToClientId() + ", fromAccountId=" + this.getFromAccountId() + ", fromOfficeId=" + this.getFromOfficeId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public AccountTransferRequest() {
    }
}
