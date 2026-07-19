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
package org.apache.fineract.infrastructure.core.service;

import org.apache.commons.lang3.StringUtils;

public class SearchParameters {
    public static final int DEFAULT_MAX_LIMIT = 200;
    private Long officeId;
    private String externalId;
    private String name;
    private String hierarchy;
    private String firstname;
    private String lastname;
    private String status;
    private Integer offset;
    private Integer limit;
    private String orderBy;
    private String sortOrder;
    private String accountNo;
    private String currencyCode;
    private Long staffId;
    private Long loanId;
    private Long clientId;
    private Long savingsId;
    private Boolean orphansOnly;
    private Long provisioningEntryId;
    private Long productId;
    private Long categoryId;
    private Integer legalForm;

    public Integer getLimit() {
        if (limit == null) {
            return DEFAULT_MAX_LIMIT;
        }
        if (limit > 0) {
            return limit;
        }
        return null; // unlimited (0 or less)
    }

    public Boolean getOrphansOnly() {
        return Boolean.TRUE.equals(orphansOnly);
    }

    public boolean hasOrderBy() {
        return StringUtils.isNotBlank(this.orderBy);
    }

    public boolean hasSortOrder() {
        return StringUtils.isNotBlank(this.sortOrder);
    }

    public boolean hasOfficeId() {
        return this.officeId != null && this.officeId != 0;
    }

    public boolean hasCurrencyCode() {
        return StringUtils.isNotBlank(this.currencyCode);
    }

    public boolean hasLimit() {
        return this.limit != null && this.limit > 0;
    }

    public boolean hasOffset() {
        return this.offset != null;
    }

    public boolean hasHierarchy() {
        return StringUtils.isNotBlank(this.hierarchy);
    }

    public boolean hasStaffId() {
        return this.staffId != null && this.staffId != 0;
    }

    public boolean hasLoanId() {
        return this.loanId != null && this.loanId != 0;
    }

    public boolean hasSavingsId() {
        return this.savingsId != null && this.savingsId != 0;
    }

    public boolean hasProvisioningEntryId() {
        return this.provisioningEntryId != null && this.provisioningEntryId != 0;
    }

    public boolean hasProductId() {
        return this.productId != null && this.productId != 0;
    }

    public boolean hasCategoryId() {
        return this.categoryId != null && this.categoryId != 0;
    }

    public boolean isPerson() {
        return this.legalForm != null && this.legalForm == 1;
    }

    public boolean isEntity() {
        return this.legalForm != null && this.legalForm == 2;
    }

    public boolean hasLegalForm() {
        return this.legalForm != null;
    }


    @java.lang.SuppressWarnings("all")
        public static class SearchParametersBuilder {
        @java.lang.SuppressWarnings("all")
                private Long officeId;
        @java.lang.SuppressWarnings("all")
                private String externalId;
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private String hierarchy;
        @java.lang.SuppressWarnings("all")
                private String firstname;
        @java.lang.SuppressWarnings("all")
                private String lastname;
        @java.lang.SuppressWarnings("all")
                private String status;
        @java.lang.SuppressWarnings("all")
                private Integer offset;
        @java.lang.SuppressWarnings("all")
                private Integer limit;
        @java.lang.SuppressWarnings("all")
                private String orderBy;
        @java.lang.SuppressWarnings("all")
                private String sortOrder;
        @java.lang.SuppressWarnings("all")
                private String accountNo;
        @java.lang.SuppressWarnings("all")
                private String currencyCode;
        @java.lang.SuppressWarnings("all")
                private Long staffId;
        @java.lang.SuppressWarnings("all")
                private Long loanId;
        @java.lang.SuppressWarnings("all")
                private Long clientId;
        @java.lang.SuppressWarnings("all")
                private Long savingsId;
        @java.lang.SuppressWarnings("all")
                private Boolean orphansOnly;
        @java.lang.SuppressWarnings("all")
                private Long provisioningEntryId;
        @java.lang.SuppressWarnings("all")
                private Long productId;
        @java.lang.SuppressWarnings("all")
                private Long categoryId;
        @java.lang.SuppressWarnings("all")
                private Integer legalForm;

        @java.lang.SuppressWarnings("all")
                SearchParametersBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder officeId(final Long officeId) {
            this.officeId = officeId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder externalId(final String externalId) {
            this.externalId = externalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder hierarchy(final String hierarchy) {
            this.hierarchy = hierarchy;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder firstname(final String firstname) {
            this.firstname = firstname;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder lastname(final String lastname) {
            this.lastname = lastname;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder status(final String status) {
            this.status = status;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder offset(final Integer offset) {
            this.offset = offset;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder limit(final Integer limit) {
            this.limit = limit;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder orderBy(final String orderBy) {
            this.orderBy = orderBy;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder sortOrder(final String sortOrder) {
            this.sortOrder = sortOrder;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder accountNo(final String accountNo) {
            this.accountNo = accountNo;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder currencyCode(final String currencyCode) {
            this.currencyCode = currencyCode;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder staffId(final Long staffId) {
            this.staffId = staffId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder loanId(final Long loanId) {
            this.loanId = loanId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder clientId(final Long clientId) {
            this.clientId = clientId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder savingsId(final Long savingsId) {
            this.savingsId = savingsId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder orphansOnly(final Boolean orphansOnly) {
            this.orphansOnly = orphansOnly;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder provisioningEntryId(final Long provisioningEntryId) {
            this.provisioningEntryId = provisioningEntryId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder productId(final Long productId) {
            this.productId = productId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder categoryId(final Long categoryId) {
            this.categoryId = categoryId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public SearchParameters.SearchParametersBuilder legalForm(final Integer legalForm) {
            this.legalForm = legalForm;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public SearchParameters build() {
            return new SearchParameters(this.officeId, this.externalId, this.name, this.hierarchy, this.firstname, this.lastname, this.status, this.offset, this.limit, this.orderBy, this.sortOrder, this.accountNo, this.currencyCode, this.staffId, this.loanId, this.clientId, this.savingsId, this.orphansOnly, this.provisioningEntryId, this.productId, this.categoryId, this.legalForm);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "SearchParameters.SearchParametersBuilder(officeId=" + this.officeId + ", externalId=" + this.externalId + ", name=" + this.name + ", hierarchy=" + this.hierarchy + ", firstname=" + this.firstname + ", lastname=" + this.lastname + ", status=" + this.status + ", offset=" + this.offset + ", limit=" + this.limit + ", orderBy=" + this.orderBy + ", sortOrder=" + this.sortOrder + ", accountNo=" + this.accountNo + ", currencyCode=" + this.currencyCode + ", staffId=" + this.staffId + ", loanId=" + this.loanId + ", clientId=" + this.clientId + ", savingsId=" + this.savingsId + ", orphansOnly=" + this.orphansOnly + ", provisioningEntryId=" + this.provisioningEntryId + ", productId=" + this.productId + ", categoryId=" + this.categoryId + ", legalForm=" + this.legalForm + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static SearchParameters.SearchParametersBuilder builder() {
        return new SearchParameters.SearchParametersBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getExternalId() {
        return this.externalId;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public String getHierarchy() {
        return this.hierarchy;
    }

    @java.lang.SuppressWarnings("all")
        public String getFirstname() {
        return this.firstname;
    }

    @java.lang.SuppressWarnings("all")
        public String getLastname() {
        return this.lastname;
    }

    @java.lang.SuppressWarnings("all")
        public String getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getOffset() {
        return this.offset;
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
        public String getAccountNo() {
        return this.accountNo;
    }

    @java.lang.SuppressWarnings("all")
        public String getCurrencyCode() {
        return this.currencyCode;
    }

    @java.lang.SuppressWarnings("all")
        public Long getStaffId() {
        return this.staffId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientId() {
        return this.clientId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getSavingsId() {
        return this.savingsId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getProvisioningEntryId() {
        return this.provisioningEntryId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getProductId() {
        return this.productId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCategoryId() {
        return this.categoryId;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getLegalForm() {
        return this.legalForm;
    }

    @java.lang.SuppressWarnings("all")
        public SearchParameters(final Long officeId, final String externalId, final String name, final String hierarchy, final String firstname, final String lastname, final String status, final Integer offset, final Integer limit, final String orderBy, final String sortOrder, final String accountNo, final String currencyCode, final Long staffId, final Long loanId, final Long clientId, final Long savingsId, final Boolean orphansOnly, final Long provisioningEntryId, final Long productId, final Long categoryId, final Integer legalForm) {
        this.officeId = officeId;
        this.externalId = externalId;
        this.name = name;
        this.hierarchy = hierarchy;
        this.firstname = firstname;
        this.lastname = lastname;
        this.status = status;
        this.offset = offset;
        this.limit = limit;
        this.orderBy = orderBy;
        this.sortOrder = sortOrder;
        this.accountNo = accountNo;
        this.currencyCode = currencyCode;
        this.staffId = staffId;
        this.loanId = loanId;
        this.clientId = clientId;
        this.savingsId = savingsId;
        this.orphansOnly = orphansOnly;
        this.provisioningEntryId = provisioningEntryId;
        this.productId = productId;
        this.categoryId = categoryId;
        this.legalForm = legalForm;
    }
}
