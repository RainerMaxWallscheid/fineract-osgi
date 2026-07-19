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
package org.apache.fineract.infrastructure.businessdate.data.api;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import java.io.Serial;
import java.io.Serializable;
import org.apache.fineract.infrastructure.businessdate.domain.BusinessDateType;
import org.apache.fineract.validation.constraints.DateFormat;
import org.apache.fineract.validation.constraints.EnumValue;
import org.apache.fineract.validation.constraints.LocalDate;
import org.apache.fineract.validation.constraints.Locale;

@LocalDate(dateField = "date", formatField = "dateFormat", localeField = "locale")
public class BusinessDateUpdateRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @NotBlank(message = "{org.apache.fineract.businessdate.date-format.not-blank}")
    @DateFormat
    private String dateFormat;
    @Schema(description = "Type of business date", example = "BUSINESS_DATE", allowableValues = {"BUSINESS_DATE", "COB_DATE"})
    @EnumValue(enumClass = BusinessDateType.class, message = "{org.apache.fineract.businessdate.type.invalid}")
    @NotNull(message = "{org.apache.fineract.businessdate.type.not-blank}")
    private String type;
    @NotBlank(message = "{org.apache.fineract.businessdate.date.not-blank}")
    private String date;
    @NotBlank(message = "{org.apache.fineract.businessdate.locale.not-blank}")
    @Locale
    private String locale;


    @java.lang.SuppressWarnings("all")
        public static class BusinessDateUpdateRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private String dateFormat;
        @java.lang.SuppressWarnings("all")
                private String type;
        @java.lang.SuppressWarnings("all")
                private String date;
        @java.lang.SuppressWarnings("all")
                private String locale;

        @java.lang.SuppressWarnings("all")
                BusinessDateUpdateRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public BusinessDateUpdateRequest.BusinessDateUpdateRequestBuilder dateFormat(final String dateFormat) {
            this.dateFormat = dateFormat;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public BusinessDateUpdateRequest.BusinessDateUpdateRequestBuilder type(final String type) {
            this.type = type;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public BusinessDateUpdateRequest.BusinessDateUpdateRequestBuilder date(final String date) {
            this.date = date;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public BusinessDateUpdateRequest.BusinessDateUpdateRequestBuilder locale(final String locale) {
            this.locale = locale;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public BusinessDateUpdateRequest build() {
            return new BusinessDateUpdateRequest(this.dateFormat, this.type, this.date, this.locale);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "BusinessDateUpdateRequest.BusinessDateUpdateRequestBuilder(dateFormat=" + this.dateFormat + ", type=" + this.type + ", date=" + this.date + ", locale=" + this.locale + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static BusinessDateUpdateRequest.BusinessDateUpdateRequestBuilder builder() {
        return new BusinessDateUpdateRequest.BusinessDateUpdateRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public String getDate() {
        return this.date;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setType(final String type) {
        this.type = type;
    }

    @java.lang.SuppressWarnings("all")
        public void setDate(final String date) {
        this.date = date;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof BusinessDateUpdateRequest)) return false;
        final BusinessDateUpdateRequest other = (BusinessDateUpdateRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        final java.lang.Object this$type = this.getType();
        final java.lang.Object other$type = other.getType();
        if (this$type == null ? other$type != null : !this$type.equals(other$type)) return false;
        final java.lang.Object this$date = this.getDate();
        final java.lang.Object other$date = other.getDate();
        if (this$date == null ? other$date != null : !this$date.equals(other$date)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof BusinessDateUpdateRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        final java.lang.Object $type = this.getType();
        result = result * PRIME + ($type == null ? 43 : $type.hashCode());
        final java.lang.Object $date = this.getDate();
        result = result * PRIME + ($date == null ? 43 : $date.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "BusinessDateUpdateRequest(dateFormat=" + this.getDateFormat() + ", type=" + this.getType() + ", date=" + this.getDate() + ", locale=" + this.getLocale() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public BusinessDateUpdateRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public BusinessDateUpdateRequest(final String dateFormat, final String type, final String date, final String locale) {
        this.dateFormat = dateFormat;
        this.type = type;
        this.date = date;
        this.locale = locale;
    }
}
