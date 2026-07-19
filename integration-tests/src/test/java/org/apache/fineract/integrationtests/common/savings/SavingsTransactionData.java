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
package org.apache.fineract.integrationtests.common.savings;

import com.google.gson.Gson;
import java.util.HashMap;
import org.apache.fineract.integrationtests.common.CommonConstants;

public class SavingsTransactionData {
    private String locale;
    private String dateFormat;
    private String transactionDate;
    private String transactionAmount;
    private Long paymentTypeId;
    private String withdrawnOnDate;
    private String note;
    private Boolean isBulk;
    private Boolean lienAllowed;
    private String reasonForBlock;

    public String getJson() {
        final HashMap<String, Object> map = new HashMap<>();
        map.put("locale", locale == null ? CommonConstants.LOCALE : locale);
        map.put("dateFormat", dateFormat == null ? CommonConstants.DATE_FORMAT : dateFormat);
        map.put("transactionDate", transactionDate);
        map.put("transactionAmount", transactionAmount);
        map.put("paymentTypeId", paymentTypeId);
        map.put("withdrawnOnDate", withdrawnOnDate);
        map.put("note", note);
        map.put("isBulk", isBulk);
        map.put("lienAllowed", lienAllowed);
        map.put("reasonForBlock", reasonForBlock);
        return new Gson().toJson(map);
    }

    @java.lang.SuppressWarnings("all")
        SavingsTransactionData(final String locale, final String dateFormat, final String transactionDate, final String transactionAmount, final Long paymentTypeId, final String withdrawnOnDate, final String note, final Boolean isBulk, final Boolean lienAllowed, final String reasonForBlock) {
        this.locale = locale;
        this.dateFormat = dateFormat;
        this.transactionDate = transactionDate;
        this.transactionAmount = transactionAmount;
        this.paymentTypeId = paymentTypeId;
        this.withdrawnOnDate = withdrawnOnDate;
        this.note = note;
        this.isBulk = isBulk;
        this.lienAllowed = lienAllowed;
        this.reasonForBlock = reasonForBlock;
    }


    @java.lang.SuppressWarnings("all")
        public static class SavingsTransactionDataBuilder {
        @java.lang.SuppressWarnings("all")
                private String locale;
        @java.lang.SuppressWarnings("all")
                private String dateFormat;
        @java.lang.SuppressWarnings("all")
                private String transactionDate;
        @java.lang.SuppressWarnings("all")
                private String transactionAmount;
        @java.lang.SuppressWarnings("all")
                private Long paymentTypeId;
        @java.lang.SuppressWarnings("all")
                private String withdrawnOnDate;
        @java.lang.SuppressWarnings("all")
                private String note;
        @java.lang.SuppressWarnings("all")
                private Boolean isBulk;
        @java.lang.SuppressWarnings("all")
                private Boolean lienAllowed;
        @java.lang.SuppressWarnings("all")
                private String reasonForBlock;

        @java.lang.SuppressWarnings("all")
                SavingsTransactionDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SavingsTransactionData.SavingsTransactionDataBuilder locale(final String locale) {
            this.locale = locale;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SavingsTransactionData.SavingsTransactionDataBuilder dateFormat(final String dateFormat) {
            this.dateFormat = dateFormat;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SavingsTransactionData.SavingsTransactionDataBuilder transactionDate(final String transactionDate) {
            this.transactionDate = transactionDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SavingsTransactionData.SavingsTransactionDataBuilder transactionAmount(final String transactionAmount) {
            this.transactionAmount = transactionAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SavingsTransactionData.SavingsTransactionDataBuilder paymentTypeId(final Long paymentTypeId) {
            this.paymentTypeId = paymentTypeId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SavingsTransactionData.SavingsTransactionDataBuilder withdrawnOnDate(final String withdrawnOnDate) {
            this.withdrawnOnDate = withdrawnOnDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SavingsTransactionData.SavingsTransactionDataBuilder note(final String note) {
            this.note = note;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SavingsTransactionData.SavingsTransactionDataBuilder isBulk(final Boolean isBulk) {
            this.isBulk = isBulk;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SavingsTransactionData.SavingsTransactionDataBuilder lienAllowed(final Boolean lienAllowed) {
            this.lienAllowed = lienAllowed;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SavingsTransactionData.SavingsTransactionDataBuilder reasonForBlock(final String reasonForBlock) {
            this.reasonForBlock = reasonForBlock;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public SavingsTransactionData build() {
            return new SavingsTransactionData(this.locale, this.dateFormat, this.transactionDate, this.transactionAmount, this.paymentTypeId, this.withdrawnOnDate, this.note, this.isBulk, this.lienAllowed, this.reasonForBlock);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "SavingsTransactionData.SavingsTransactionDataBuilder(locale=" + this.locale + ", dateFormat=" + this.dateFormat + ", transactionDate=" + this.transactionDate + ", transactionAmount=" + this.transactionAmount + ", paymentTypeId=" + this.paymentTypeId + ", withdrawnOnDate=" + this.withdrawnOnDate + ", note=" + this.note + ", isBulk=" + this.isBulk + ", lienAllowed=" + this.lienAllowed + ", reasonForBlock=" + this.reasonForBlock + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static SavingsTransactionData.SavingsTransactionDataBuilder builder() {
        return new SavingsTransactionData.SavingsTransactionDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getTransactionDate() {
        return this.transactionDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getTransactionAmount() {
        return this.transactionAmount;
    }

    @java.lang.SuppressWarnings("all")
        public Long getPaymentTypeId() {
        return this.paymentTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getWithdrawnOnDate() {
        return this.withdrawnOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getNote() {
        return this.note;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getIsBulk() {
        return this.isBulk;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getLienAllowed() {
        return this.lienAllowed;
    }

    @java.lang.SuppressWarnings("all")
        public String getReasonForBlock() {
        return this.reasonForBlock;
    }
}
