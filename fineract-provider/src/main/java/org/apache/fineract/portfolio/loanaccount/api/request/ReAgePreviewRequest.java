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
package org.apache.fineract.portfolio.loanaccount.api.request;

import io.swagger.v3.oas.annotations.Parameter;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.ws.rs.QueryParam;
import java.io.Serial;
import java.io.Serializable;
import org.apache.fineract.portfolio.common.domain.PeriodFrequencyType;
import org.apache.fineract.validation.constraints.EnumValue;
import org.apache.fineract.validation.constraints.LocalDate;
import org.apache.fineract.validation.constraints.Locale;

@LocalDate(dateField = "startDate", formatField = "dateFormat", localeField = "locale")
public class ReAgePreviewRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @QueryParam("frequencyNumber")
    @Parameter(description = "The frequency number for the re-aging schedule", required = true)
    @NotNull(message = "{org.apache.fineract.reage.frequency-number.not-blank}")
    @Min(value = 1, message = "{org.apache.fineract.reage.frequency-number.min}")
    private Integer frequencyNumber;
    @QueryParam("frequencyType")
    @Parameter(description = "The frequency type (DAYS, WEEKS, MONTHS, YEARS)", required = true)
    @NotBlank(message = "{org.apache.fineract.reage.frequency-type.not-blank}")
    @EnumValue(enumClass = PeriodFrequencyType.class, message = "{org.apache.fineract.frequency-type.invalid}")
    private String frequencyType;
    @QueryParam("startDate")
    @Parameter(description = "The start date for the re-aging schedule", required = true)
    @NotBlank(message = "{org.apache.fineract.reage.start-date.not-blank}")
    private String startDate;
    @QueryParam("numberOfInstallments")
    @Parameter(description = "The number of installments for the re-aged loan", required = true)
    @NotNull(message = "{org.apache.fineract.reage.number-of-installments.not-blank}")
    @Min(value = 1, message = "{org.apache.fineract.reage.number-of-installments.min}")
    private Integer numberOfInstallments;
    @QueryParam("dateFormat")
    @Parameter(description = "The date format used for the startDate parameter", required = true)
    @NotBlank(message = "{org.apache.fineract.businessdate.date-format.not-blank}")
    private String dateFormat;
    @QueryParam("locale")
    @Parameter(description = "The locale to use for formatting", required = true)
    @NotBlank(message = "{org.apache.fineract.businessdate.locale.not-blank}")
    @Locale
    private String locale;
    @QueryParam("reAgeInterestHandling")
    @Parameter(description = "The interest handling type. Applied only for progressive interest-bearing loans. DEFAULT if not provided.")
    private String reAgeInterestHandling;


    @java.lang.SuppressWarnings("all")
        public static class ReAgePreviewRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Integer frequencyNumber;
        @java.lang.SuppressWarnings("all")
                private String frequencyType;
        @java.lang.SuppressWarnings("all")
                private String startDate;
        @java.lang.SuppressWarnings("all")
                private Integer numberOfInstallments;
        @java.lang.SuppressWarnings("all")
                private String dateFormat;
        @java.lang.SuppressWarnings("all")
                private String locale;
        @java.lang.SuppressWarnings("all")
                private String reAgeInterestHandling;

        @java.lang.SuppressWarnings("all")
                ReAgePreviewRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ReAgePreviewRequest.ReAgePreviewRequestBuilder frequencyNumber(final Integer frequencyNumber) {
            this.frequencyNumber = frequencyNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ReAgePreviewRequest.ReAgePreviewRequestBuilder frequencyType(final String frequencyType) {
            this.frequencyType = frequencyType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ReAgePreviewRequest.ReAgePreviewRequestBuilder startDate(final String startDate) {
            this.startDate = startDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ReAgePreviewRequest.ReAgePreviewRequestBuilder numberOfInstallments(final Integer numberOfInstallments) {
            this.numberOfInstallments = numberOfInstallments;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ReAgePreviewRequest.ReAgePreviewRequestBuilder dateFormat(final String dateFormat) {
            this.dateFormat = dateFormat;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ReAgePreviewRequest.ReAgePreviewRequestBuilder locale(final String locale) {
            this.locale = locale;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public ReAgePreviewRequest.ReAgePreviewRequestBuilder reAgeInterestHandling(final String reAgeInterestHandling) {
            this.reAgeInterestHandling = reAgeInterestHandling;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public ReAgePreviewRequest build() {
            return new ReAgePreviewRequest(this.frequencyNumber, this.frequencyType, this.startDate, this.numberOfInstallments, this.dateFormat, this.locale, this.reAgeInterestHandling);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "ReAgePreviewRequest.ReAgePreviewRequestBuilder(frequencyNumber=" + this.frequencyNumber + ", frequencyType=" + this.frequencyType + ", startDate=" + this.startDate + ", numberOfInstallments=" + this.numberOfInstallments + ", dateFormat=" + this.dateFormat + ", locale=" + this.locale + ", reAgeInterestHandling=" + this.reAgeInterestHandling + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static ReAgePreviewRequest.ReAgePreviewRequestBuilder builder() {
        return new ReAgePreviewRequest.ReAgePreviewRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Integer getFrequencyNumber() {
        return this.frequencyNumber;
    }

    @java.lang.SuppressWarnings("all")
        public String getFrequencyType() {
        return this.frequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public String getStartDate() {
        return this.startDate;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getNumberOfInstallments() {
        return this.numberOfInstallments;
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
        public String getReAgeInterestHandling() {
        return this.reAgeInterestHandling;
    }

    @java.lang.SuppressWarnings("all")
        public void setFrequencyNumber(final Integer frequencyNumber) {
        this.frequencyNumber = frequencyNumber;
    }

    @java.lang.SuppressWarnings("all")
        public void setFrequencyType(final String frequencyType) {
        this.frequencyType = frequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public void setStartDate(final String startDate) {
        this.startDate = startDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setNumberOfInstallments(final Integer numberOfInstallments) {
        this.numberOfInstallments = numberOfInstallments;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setReAgeInterestHandling(final String reAgeInterestHandling) {
        this.reAgeInterestHandling = reAgeInterestHandling;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ReAgePreviewRequest)) return false;
        final ReAgePreviewRequest other = (ReAgePreviewRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$frequencyNumber = this.getFrequencyNumber();
        final java.lang.Object other$frequencyNumber = other.getFrequencyNumber();
        if (this$frequencyNumber == null ? other$frequencyNumber != null : !this$frequencyNumber.equals(other$frequencyNumber)) return false;
        final java.lang.Object this$numberOfInstallments = this.getNumberOfInstallments();
        final java.lang.Object other$numberOfInstallments = other.getNumberOfInstallments();
        if (this$numberOfInstallments == null ? other$numberOfInstallments != null : !this$numberOfInstallments.equals(other$numberOfInstallments)) return false;
        final java.lang.Object this$frequencyType = this.getFrequencyType();
        final java.lang.Object other$frequencyType = other.getFrequencyType();
        if (this$frequencyType == null ? other$frequencyType != null : !this$frequencyType.equals(other$frequencyType)) return false;
        final java.lang.Object this$startDate = this.getStartDate();
        final java.lang.Object other$startDate = other.getStartDate();
        if (this$startDate == null ? other$startDate != null : !this$startDate.equals(other$startDate)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$reAgeInterestHandling = this.getReAgeInterestHandling();
        final java.lang.Object other$reAgeInterestHandling = other.getReAgeInterestHandling();
        if (this$reAgeInterestHandling == null ? other$reAgeInterestHandling != null : !this$reAgeInterestHandling.equals(other$reAgeInterestHandling)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ReAgePreviewRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $frequencyNumber = this.getFrequencyNumber();
        result = result * PRIME + ($frequencyNumber == null ? 43 : $frequencyNumber.hashCode());
        final java.lang.Object $numberOfInstallments = this.getNumberOfInstallments();
        result = result * PRIME + ($numberOfInstallments == null ? 43 : $numberOfInstallments.hashCode());
        final java.lang.Object $frequencyType = this.getFrequencyType();
        result = result * PRIME + ($frequencyType == null ? 43 : $frequencyType.hashCode());
        final java.lang.Object $startDate = this.getStartDate();
        result = result * PRIME + ($startDate == null ? 43 : $startDate.hashCode());
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $reAgeInterestHandling = this.getReAgeInterestHandling();
        result = result * PRIME + ($reAgeInterestHandling == null ? 43 : $reAgeInterestHandling.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ReAgePreviewRequest(frequencyNumber=" + this.getFrequencyNumber() + ", frequencyType=" + this.getFrequencyType() + ", startDate=" + this.getStartDate() + ", numberOfInstallments=" + this.getNumberOfInstallments() + ", dateFormat=" + this.getDateFormat() + ", locale=" + this.getLocale() + ", reAgeInterestHandling=" + this.getReAgeInterestHandling() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ReAgePreviewRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public ReAgePreviewRequest(final Integer frequencyNumber, final String frequencyType, final String startDate, final Integer numberOfInstallments, final String dateFormat, final String locale, final String reAgeInterestHandling) {
        this.frequencyNumber = frequencyNumber;
        this.frequencyType = frequencyType;
        this.startDate = startDate;
        this.numberOfInstallments = numberOfInstallments;
        this.dateFormat = dateFormat;
        this.locale = locale;
        this.reAgeInterestHandling = reAgeInterestHandling;
    }
}
