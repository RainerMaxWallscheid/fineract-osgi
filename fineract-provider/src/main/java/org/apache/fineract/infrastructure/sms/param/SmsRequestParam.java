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
package org.apache.fineract.infrastructure.sms.param;

import jakarta.ws.rs.QueryParam;
import org.apache.fineract.infrastructure.core.api.DateParam;

public class SmsRequestParam {
    @QueryParam("status")
    private Long status;
    @QueryParam("fromDate")
    private DateParam fromDate;
    @QueryParam("toDate")
    private DateParam toDate;
    @QueryParam("locale")
    private String locale;
    @QueryParam("dateFormat")
    private String rawDateFormat;
    @QueryParam("offset")
    private Integer offset;
    @QueryParam("limit")
    private Integer limit;
    @QueryParam("orderBy")
    private String orderBy;
    @QueryParam("sortOrder")
    private String sortOrder;

    @java.lang.SuppressWarnings("all")
        public Long getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public DateParam getFromDate() {
        return this.fromDate;
    }

    @java.lang.SuppressWarnings("all")
        public DateParam getToDate() {
        return this.toDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public String getRawDateFormat() {
        return this.rawDateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getOffset() {
        return this.offset;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getLimit() {
        return this.limit;
    }

    @java.lang.SuppressWarnings("all")
        public String getOrderBy() {
        return this.orderBy;
    }

    @java.lang.SuppressWarnings("all")
        public String getSortOrder() {
        return this.sortOrder;
    }

    @java.lang.SuppressWarnings("all")
        public void setStatus(final Long status) {
        this.status = status;
    }

    @java.lang.SuppressWarnings("all")
        public void setFromDate(final DateParam fromDate) {
        this.fromDate = fromDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setToDate(final DateParam toDate) {
        this.toDate = toDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setRawDateFormat(final String rawDateFormat) {
        this.rawDateFormat = rawDateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setOffset(final Integer offset) {
        this.offset = offset;
    }

    @java.lang.SuppressWarnings("all")
        public void setLimit(final Integer limit) {
        this.limit = limit;
    }

    @java.lang.SuppressWarnings("all")
        public void setOrderBy(final String orderBy) {
        this.orderBy = orderBy;
    }

    @java.lang.SuppressWarnings("all")
        public void setSortOrder(final String sortOrder) {
        this.sortOrder = sortOrder;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof SmsRequestParam)) return false;
        final SmsRequestParam other = (SmsRequestParam) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$status = this.getStatus();
        final java.lang.Object other$status = other.getStatus();
        if (this$status == null ? other$status != null : !this$status.equals(other$status)) return false;
        final java.lang.Object this$offset = this.getOffset();
        final java.lang.Object other$offset = other.getOffset();
        if (this$offset == null ? other$offset != null : !this$offset.equals(other$offset)) return false;
        final java.lang.Object this$limit = this.getLimit();
        final java.lang.Object other$limit = other.getLimit();
        if (this$limit == null ? other$limit != null : !this$limit.equals(other$limit)) return false;
        final java.lang.Object this$fromDate = this.getFromDate();
        final java.lang.Object other$fromDate = other.getFromDate();
        if (this$fromDate == null ? other$fromDate != null : !this$fromDate.equals(other$fromDate)) return false;
        final java.lang.Object this$toDate = this.getToDate();
        final java.lang.Object other$toDate = other.getToDate();
        if (this$toDate == null ? other$toDate != null : !this$toDate.equals(other$toDate)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$rawDateFormat = this.getRawDateFormat();
        final java.lang.Object other$rawDateFormat = other.getRawDateFormat();
        if (this$rawDateFormat == null ? other$rawDateFormat != null : !this$rawDateFormat.equals(other$rawDateFormat)) return false;
        final java.lang.Object this$orderBy = this.getOrderBy();
        final java.lang.Object other$orderBy = other.getOrderBy();
        if (this$orderBy == null ? other$orderBy != null : !this$orderBy.equals(other$orderBy)) return false;
        final java.lang.Object this$sortOrder = this.getSortOrder();
        final java.lang.Object other$sortOrder = other.getSortOrder();
        if (this$sortOrder == null ? other$sortOrder != null : !this$sortOrder.equals(other$sortOrder)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof SmsRequestParam;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $status = this.getStatus();
        result = result * PRIME + ($status == null ? 43 : $status.hashCode());
        final java.lang.Object $offset = this.getOffset();
        result = result * PRIME + ($offset == null ? 43 : $offset.hashCode());
        final java.lang.Object $limit = this.getLimit();
        result = result * PRIME + ($limit == null ? 43 : $limit.hashCode());
        final java.lang.Object $fromDate = this.getFromDate();
        result = result * PRIME + ($fromDate == null ? 43 : $fromDate.hashCode());
        final java.lang.Object $toDate = this.getToDate();
        result = result * PRIME + ($toDate == null ? 43 : $toDate.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $rawDateFormat = this.getRawDateFormat();
        result = result * PRIME + ($rawDateFormat == null ? 43 : $rawDateFormat.hashCode());
        final java.lang.Object $orderBy = this.getOrderBy();
        result = result * PRIME + ($orderBy == null ? 43 : $orderBy.hashCode());
        final java.lang.Object $sortOrder = this.getSortOrder();
        result = result * PRIME + ($sortOrder == null ? 43 : $sortOrder.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "SmsRequestParam(status=" + this.getStatus() + ", fromDate=" + this.getFromDate() + ", toDate=" + this.getToDate() + ", locale=" + this.getLocale() + ", rawDateFormat=" + this.getRawDateFormat() + ", offset=" + this.getOffset() + ", limit=" + this.getLimit() + ", orderBy=" + this.getOrderBy() + ", sortOrder=" + this.getSortOrder() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public SmsRequestParam() {
    }
}
