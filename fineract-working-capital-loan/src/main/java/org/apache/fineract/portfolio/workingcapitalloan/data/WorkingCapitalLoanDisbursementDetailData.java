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
package org.apache.fineract.portfolio.workingcapitalloan.data;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * DTO for a single disbursement detail (expected and actual) of a working capital loan.
 */
public class WorkingCapitalLoanDisbursementDetailData {
    private Long id;
    private Long loanId;
    private LocalDate expectedDisbursementDate;
    private BigDecimal principal;
    private LocalDate expectedMaturityDate;
    private LocalDate actualDisbursementDate;
    private BigDecimal actualAmount;
    private String disbursedByUsername;
    private String disbursedByFirstname;
    private String disbursedByLastname;


    @java.lang.SuppressWarnings("all")
        public static class WorkingCapitalLoanDisbursementDetailDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private Long loanId;
        @java.lang.SuppressWarnings("all")
                private LocalDate expectedDisbursementDate;
        @java.lang.SuppressWarnings("all")
                private BigDecimal principal;
        @java.lang.SuppressWarnings("all")
                private LocalDate expectedMaturityDate;
        @java.lang.SuppressWarnings("all")
                private LocalDate actualDisbursementDate;
        @java.lang.SuppressWarnings("all")
                private BigDecimal actualAmount;
        @java.lang.SuppressWarnings("all")
                private String disbursedByUsername;
        @java.lang.SuppressWarnings("all")
                private String disbursedByFirstname;
        @java.lang.SuppressWarnings("all")
                private String disbursedByLastname;

        @java.lang.SuppressWarnings("all")
                WorkingCapitalLoanDisbursementDetailDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanDisbursementDetailData.WorkingCapitalLoanDisbursementDetailDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanDisbursementDetailData.WorkingCapitalLoanDisbursementDetailDataBuilder loanId(final Long loanId) {
            this.loanId = loanId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanDisbursementDetailData.WorkingCapitalLoanDisbursementDetailDataBuilder expectedDisbursementDate(final LocalDate expectedDisbursementDate) {
            this.expectedDisbursementDate = expectedDisbursementDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanDisbursementDetailData.WorkingCapitalLoanDisbursementDetailDataBuilder principal(final BigDecimal principal) {
            this.principal = principal;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanDisbursementDetailData.WorkingCapitalLoanDisbursementDetailDataBuilder expectedMaturityDate(final LocalDate expectedMaturityDate) {
            this.expectedMaturityDate = expectedMaturityDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanDisbursementDetailData.WorkingCapitalLoanDisbursementDetailDataBuilder actualDisbursementDate(final LocalDate actualDisbursementDate) {
            this.actualDisbursementDate = actualDisbursementDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanDisbursementDetailData.WorkingCapitalLoanDisbursementDetailDataBuilder actualAmount(final BigDecimal actualAmount) {
            this.actualAmount = actualAmount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanDisbursementDetailData.WorkingCapitalLoanDisbursementDetailDataBuilder disbursedByUsername(final String disbursedByUsername) {
            this.disbursedByUsername = disbursedByUsername;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanDisbursementDetailData.WorkingCapitalLoanDisbursementDetailDataBuilder disbursedByFirstname(final String disbursedByFirstname) {
            this.disbursedByFirstname = disbursedByFirstname;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanDisbursementDetailData.WorkingCapitalLoanDisbursementDetailDataBuilder disbursedByLastname(final String disbursedByLastname) {
            this.disbursedByLastname = disbursedByLastname;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public WorkingCapitalLoanDisbursementDetailData build() {
            return new WorkingCapitalLoanDisbursementDetailData(this.id, this.loanId, this.expectedDisbursementDate, this.principal, this.expectedMaturityDate, this.actualDisbursementDate, this.actualAmount, this.disbursedByUsername, this.disbursedByFirstname, this.disbursedByLastname);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "WorkingCapitalLoanDisbursementDetailData.WorkingCapitalLoanDisbursementDetailDataBuilder(id=" + this.id + ", loanId=" + this.loanId + ", expectedDisbursementDate=" + this.expectedDisbursementDate + ", principal=" + this.principal + ", expectedMaturityDate=" + this.expectedMaturityDate + ", actualDisbursementDate=" + this.actualDisbursementDate + ", actualAmount=" + this.actualAmount + ", disbursedByUsername=" + this.disbursedByUsername + ", disbursedByFirstname=" + this.disbursedByFirstname + ", disbursedByLastname=" + this.disbursedByLastname + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static WorkingCapitalLoanDisbursementDetailData.WorkingCapitalLoanDisbursementDetailDataBuilder builder() {
        return new WorkingCapitalLoanDisbursementDetailData.WorkingCapitalLoanDisbursementDetailDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getExpectedDisbursementDate() {
        return this.expectedDisbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipal() {
        return this.principal;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getExpectedMaturityDate() {
        return this.expectedMaturityDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getActualDisbursementDate() {
        return this.actualDisbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getActualAmount() {
        return this.actualAmount;
    }

    @java.lang.SuppressWarnings("all")
        public String getDisbursedByUsername() {
        return this.disbursedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getDisbursedByFirstname() {
        return this.disbursedByFirstname;
    }

    @java.lang.SuppressWarnings("all")
        public String getDisbursedByLastname() {
        return this.disbursedByLastname;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanId(final Long loanId) {
        this.loanId = loanId;
    }

    @java.lang.SuppressWarnings("all")
        public void setExpectedDisbursementDate(final LocalDate expectedDisbursementDate) {
        this.expectedDisbursementDate = expectedDisbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setPrincipal(final BigDecimal principal) {
        this.principal = principal;
    }

    @java.lang.SuppressWarnings("all")
        public void setExpectedMaturityDate(final LocalDate expectedMaturityDate) {
        this.expectedMaturityDate = expectedMaturityDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setActualDisbursementDate(final LocalDate actualDisbursementDate) {
        this.actualDisbursementDate = actualDisbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setActualAmount(final BigDecimal actualAmount) {
        this.actualAmount = actualAmount;
    }

    @java.lang.SuppressWarnings("all")
        public void setDisbursedByUsername(final String disbursedByUsername) {
        this.disbursedByUsername = disbursedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public void setDisbursedByFirstname(final String disbursedByFirstname) {
        this.disbursedByFirstname = disbursedByFirstname;
    }

    @java.lang.SuppressWarnings("all")
        public void setDisbursedByLastname(final String disbursedByLastname) {
        this.disbursedByLastname = disbursedByLastname;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanDisbursementDetailData() {
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanDisbursementDetailData(final Long id, final Long loanId, final LocalDate expectedDisbursementDate, final BigDecimal principal, final LocalDate expectedMaturityDate, final LocalDate actualDisbursementDate, final BigDecimal actualAmount, final String disbursedByUsername, final String disbursedByFirstname, final String disbursedByLastname) {
        this.id = id;
        this.loanId = loanId;
        this.expectedDisbursementDate = expectedDisbursementDate;
        this.principal = principal;
        this.expectedMaturityDate = expectedMaturityDate;
        this.actualDisbursementDate = actualDisbursementDate;
        this.actualAmount = actualAmount;
        this.disbursedByUsername = disbursedByUsername;
        this.disbursedByFirstname = disbursedByFirstname;
        this.disbursedByLastname = disbursedByLastname;
    }
}
