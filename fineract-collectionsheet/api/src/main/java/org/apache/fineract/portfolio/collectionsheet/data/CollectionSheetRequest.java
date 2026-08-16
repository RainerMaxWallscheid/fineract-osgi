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
package org.apache.fineract.portfolio.collectionsheet.data;

import java.io.Serial;
import java.io.Serializable;

public class CollectionSheetRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long officeId;
    private String dateFormat;
    private String locale;
    private String actualDisbursementDate;
    private String transactionDate;
    private DisbursementTransactionsRequest bulkDisbursementTransactions;


    @java.lang.SuppressWarnings("all")
        public static class CollectionSheetRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private Long officeId;
        @java.lang.SuppressWarnings("all")
                private String dateFormat;
        @java.lang.SuppressWarnings("all")
                private String locale;
        @java.lang.SuppressWarnings("all")
                private String actualDisbursementDate;
        @java.lang.SuppressWarnings("all")
                private String transactionDate;
        @java.lang.SuppressWarnings("all")
                private DisbursementTransactionsRequest bulkDisbursementTransactions;

        @java.lang.SuppressWarnings("all")
                CollectionSheetRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollectionSheetRequest.CollectionSheetRequestBuilder officeId(final Long officeId) {
            this.officeId = officeId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollectionSheetRequest.CollectionSheetRequestBuilder dateFormat(final String dateFormat) {
            this.dateFormat = dateFormat;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollectionSheetRequest.CollectionSheetRequestBuilder locale(final String locale) {
            this.locale = locale;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollectionSheetRequest.CollectionSheetRequestBuilder actualDisbursementDate(final String actualDisbursementDate) {
            this.actualDisbursementDate = actualDisbursementDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollectionSheetRequest.CollectionSheetRequestBuilder transactionDate(final String transactionDate) {
            this.transactionDate = transactionDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CollectionSheetRequest.CollectionSheetRequestBuilder bulkDisbursementTransactions(final DisbursementTransactionsRequest bulkDisbursementTransactions) {
            this.bulkDisbursementTransactions = bulkDisbursementTransactions;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public CollectionSheetRequest build() {
            return new CollectionSheetRequest(this.officeId, this.dateFormat, this.locale, this.actualDisbursementDate, this.transactionDate, this.bulkDisbursementTransactions);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "CollectionSheetRequest.CollectionSheetRequestBuilder(officeId=" + this.officeId + ", dateFormat=" + this.dateFormat + ", locale=" + this.locale + ", actualDisbursementDate=" + this.actualDisbursementDate + ", transactionDate=" + this.transactionDate + ", bulkDisbursementTransactions=" + this.bulkDisbursementTransactions + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static CollectionSheetRequest.CollectionSheetRequestBuilder builder() {
        return new CollectionSheetRequest.CollectionSheetRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
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
        public String getActualDisbursementDate() {
        return this.actualDisbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getTransactionDate() {
        return this.transactionDate;
    }

    @java.lang.SuppressWarnings("all")
        public DisbursementTransactionsRequest getBulkDisbursementTransactions() {
        return this.bulkDisbursementTransactions;
    }

    @java.lang.SuppressWarnings("all")
        public void setOfficeId(final Long officeId) {
        this.officeId = officeId;
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
        public void setActualDisbursementDate(final String actualDisbursementDate) {
        this.actualDisbursementDate = actualDisbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransactionDate(final String transactionDate) {
        this.transactionDate = transactionDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setBulkDisbursementTransactions(final DisbursementTransactionsRequest bulkDisbursementTransactions) {
        this.bulkDisbursementTransactions = bulkDisbursementTransactions;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CollectionSheetRequest)) return false;
        final CollectionSheetRequest other = (CollectionSheetRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$officeId = this.getOfficeId();
        final java.lang.Object other$officeId = other.getOfficeId();
        if (this$officeId == null ? other$officeId != null : !this$officeId.equals(other$officeId)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$actualDisbursementDate = this.getActualDisbursementDate();
        final java.lang.Object other$actualDisbursementDate = other.getActualDisbursementDate();
        if (this$actualDisbursementDate == null ? other$actualDisbursementDate != null : !this$actualDisbursementDate.equals(other$actualDisbursementDate)) return false;
        final java.lang.Object this$transactionDate = this.getTransactionDate();
        final java.lang.Object other$transactionDate = other.getTransactionDate();
        if (this$transactionDate == null ? other$transactionDate != null : !this$transactionDate.equals(other$transactionDate)) return false;
        final java.lang.Object this$bulkDisbursementTransactions = this.getBulkDisbursementTransactions();
        final java.lang.Object other$bulkDisbursementTransactions = other.getBulkDisbursementTransactions();
        if (this$bulkDisbursementTransactions == null ? other$bulkDisbursementTransactions != null : !this$bulkDisbursementTransactions.equals(other$bulkDisbursementTransactions)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof CollectionSheetRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $officeId = this.getOfficeId();
        result = result * PRIME + ($officeId == null ? 43 : $officeId.hashCode());
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $actualDisbursementDate = this.getActualDisbursementDate();
        result = result * PRIME + ($actualDisbursementDate == null ? 43 : $actualDisbursementDate.hashCode());
        final java.lang.Object $transactionDate = this.getTransactionDate();
        result = result * PRIME + ($transactionDate == null ? 43 : $transactionDate.hashCode());
        final java.lang.Object $bulkDisbursementTransactions = this.getBulkDisbursementTransactions();
        result = result * PRIME + ($bulkDisbursementTransactions == null ? 43 : $bulkDisbursementTransactions.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CollectionSheetRequest(officeId=" + this.getOfficeId() + ", dateFormat=" + this.getDateFormat() + ", locale=" + this.getLocale() + ", actualDisbursementDate=" + this.getActualDisbursementDate() + ", transactionDate=" + this.getTransactionDate() + ", bulkDisbursementTransactions=" + this.getBulkDisbursementTransactions() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CollectionSheetRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public CollectionSheetRequest(final Long officeId, final String dateFormat, final String locale, final String actualDisbursementDate, final String transactionDate, final DisbursementTransactionsRequest bulkDisbursementTransactions) {
        this.officeId = officeId;
        this.dateFormat = dateFormat;
        this.locale = locale;
        this.actualDisbursementDate = actualDisbursementDate;
        this.transactionDate = transactionDate;
        this.bulkDisbursementTransactions = bulkDisbursementTransactions;
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String officeId = "officeId";
        public static final java.lang.String dateFormat = "dateFormat";
        public static final java.lang.String locale = "locale";
        public static final java.lang.String actualDisbursementDate = "actualDisbursementDate";
        public static final java.lang.String transactionDate = "transactionDate";
        public static final java.lang.String bulkDisbursementTransactions = "bulkDisbursementTransactions";
    }
}
