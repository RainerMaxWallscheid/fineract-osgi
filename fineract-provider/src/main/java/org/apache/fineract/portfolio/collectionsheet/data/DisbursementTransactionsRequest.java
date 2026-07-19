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
import java.util.List;

public class DisbursementTransactionsRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private List<RepaymentTransactionRequest> bulkRepaymentTransactions;
    private List<SavingDueTransactionRequest> bulkSavingsDueTransactions;


    @java.lang.SuppressWarnings("all")
        public static class DisbursementTransactionsRequestBuilder {
        @java.lang.SuppressWarnings("all")
                private List<RepaymentTransactionRequest> bulkRepaymentTransactions;
        @java.lang.SuppressWarnings("all")
                private List<SavingDueTransactionRequest> bulkSavingsDueTransactions;

        @java.lang.SuppressWarnings("all")
                DisbursementTransactionsRequestBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DisbursementTransactionsRequest.DisbursementTransactionsRequestBuilder bulkRepaymentTransactions(final List<RepaymentTransactionRequest> bulkRepaymentTransactions) {
            this.bulkRepaymentTransactions = bulkRepaymentTransactions;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public DisbursementTransactionsRequest.DisbursementTransactionsRequestBuilder bulkSavingsDueTransactions(final List<SavingDueTransactionRequest> bulkSavingsDueTransactions) {
            this.bulkSavingsDueTransactions = bulkSavingsDueTransactions;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public DisbursementTransactionsRequest build() {
            return new DisbursementTransactionsRequest(this.bulkRepaymentTransactions, this.bulkSavingsDueTransactions);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "DisbursementTransactionsRequest.DisbursementTransactionsRequestBuilder(bulkRepaymentTransactions=" + this.bulkRepaymentTransactions + ", bulkSavingsDueTransactions=" + this.bulkSavingsDueTransactions + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static DisbursementTransactionsRequest.DisbursementTransactionsRequestBuilder builder() {
        return new DisbursementTransactionsRequest.DisbursementTransactionsRequestBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public List<RepaymentTransactionRequest> getBulkRepaymentTransactions() {
        return this.bulkRepaymentTransactions;
    }

    @java.lang.SuppressWarnings("all")
        public List<SavingDueTransactionRequest> getBulkSavingsDueTransactions() {
        return this.bulkSavingsDueTransactions;
    }

    @java.lang.SuppressWarnings("all")
        public void setBulkRepaymentTransactions(final List<RepaymentTransactionRequest> bulkRepaymentTransactions) {
        this.bulkRepaymentTransactions = bulkRepaymentTransactions;
    }

    @java.lang.SuppressWarnings("all")
        public void setBulkSavingsDueTransactions(final List<SavingDueTransactionRequest> bulkSavingsDueTransactions) {
        this.bulkSavingsDueTransactions = bulkSavingsDueTransactions;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof DisbursementTransactionsRequest)) return false;
        final DisbursementTransactionsRequest other = (DisbursementTransactionsRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$bulkRepaymentTransactions = this.getBulkRepaymentTransactions();
        final java.lang.Object other$bulkRepaymentTransactions = other.getBulkRepaymentTransactions();
        if (this$bulkRepaymentTransactions == null ? other$bulkRepaymentTransactions != null : !this$bulkRepaymentTransactions.equals(other$bulkRepaymentTransactions)) return false;
        final java.lang.Object this$bulkSavingsDueTransactions = this.getBulkSavingsDueTransactions();
        final java.lang.Object other$bulkSavingsDueTransactions = other.getBulkSavingsDueTransactions();
        if (this$bulkSavingsDueTransactions == null ? other$bulkSavingsDueTransactions != null : !this$bulkSavingsDueTransactions.equals(other$bulkSavingsDueTransactions)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof DisbursementTransactionsRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $bulkRepaymentTransactions = this.getBulkRepaymentTransactions();
        result = result * PRIME + ($bulkRepaymentTransactions == null ? 43 : $bulkRepaymentTransactions.hashCode());
        final java.lang.Object $bulkSavingsDueTransactions = this.getBulkSavingsDueTransactions();
        result = result * PRIME + ($bulkSavingsDueTransactions == null ? 43 : $bulkSavingsDueTransactions.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "DisbursementTransactionsRequest(bulkRepaymentTransactions=" + this.getBulkRepaymentTransactions() + ", bulkSavingsDueTransactions=" + this.getBulkSavingsDueTransactions() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public DisbursementTransactionsRequest() {
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String bulkRepaymentTransactions = "bulkRepaymentTransactions";
        public static final java.lang.String bulkSavingsDueTransactions = "bulkSavingsDueTransactions";
    }

    @java.lang.SuppressWarnings("all")
        public DisbursementTransactionsRequest(final List<RepaymentTransactionRequest> bulkRepaymentTransactions, final List<SavingDueTransactionRequest> bulkSavingsDueTransactions) {
        this.bulkRepaymentTransactions = bulkRepaymentTransactions;
        this.bulkSavingsDueTransactions = bulkSavingsDueTransactions;
    }
}
