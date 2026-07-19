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
package org.apache.fineract.portfolio.loanaccount.api.pointintime.data;

import java.util.List;
import org.apache.fineract.infrastructure.core.api.DateParam;

public class RetrieveLoansPointInTimeExternalIdsRequest {
    private List<String> externalIds;
    private DateParam date;
    private String dateFormat;
    private String locale;

    @java.lang.SuppressWarnings("all")
        public RetrieveLoansPointInTimeExternalIdsRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public List<String> getExternalIds() {
        return this.externalIds;
    }

    @java.lang.SuppressWarnings("all")
        public DateParam getDate() {
        return this.date;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalIds(final List<String> externalIds) {
        this.externalIds = externalIds;
    }

    @java.lang.SuppressWarnings("all")
        public void setDate(final DateParam date) {
        this.date = date;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof RetrieveLoansPointInTimeExternalIdsRequest)) return false;
        final RetrieveLoansPointInTimeExternalIdsRequest other = (RetrieveLoansPointInTimeExternalIdsRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$externalIds = this.getExternalIds();
        final java.lang.Object other$externalIds = other.getExternalIds();
        if (this$externalIds == null ? other$externalIds != null : !this$externalIds.equals(other$externalIds)) return false;
        final java.lang.Object this$date = this.getDate();
        final java.lang.Object other$date = other.getDate();
        if (this$date == null ? other$date != null : !this$date.equals(other$date)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof RetrieveLoansPointInTimeExternalIdsRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $externalIds = this.getExternalIds();
        result = result * PRIME + ($externalIds == null ? 43 : $externalIds.hashCode());
        final java.lang.Object $date = this.getDate();
        result = result * PRIME + ($date == null ? 43 : $date.hashCode());
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "RetrieveLoansPointInTimeExternalIdsRequest(externalIds=" + this.getExternalIds() + ", date=" + this.getDate() + ", dateFormat=" + this.getDateFormat() + ", locale=" + this.getLocale() + ")";
    }
}
