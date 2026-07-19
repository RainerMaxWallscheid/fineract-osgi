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
package org.apache.fineract.portfolio.savings.data;

import java.math.BigDecimal;

public final class GroupSavingsIndividualMonitoringAccountData {
    private final BigDecimal gsimId;
    private final BigDecimal groupId;
    private final BigDecimal clientId;
    private final String accountNumber;
    private final BigDecimal childAccountId;
    private final String childAccountNumber;
    private final BigDecimal childDeposit;
    private final BigDecimal parentDeposit;
    private final Long childAccountsCount;
    private final String savingsStatus;

    @java.lang.SuppressWarnings("all")
        GroupSavingsIndividualMonitoringAccountData(final BigDecimal gsimId, final BigDecimal groupId, final BigDecimal clientId, final String accountNumber, final BigDecimal childAccountId, final String childAccountNumber, final BigDecimal childDeposit, final BigDecimal parentDeposit, final Long childAccountsCount, final String savingsStatus) {
        this.gsimId = gsimId;
        this.groupId = groupId;
        this.clientId = clientId;
        this.accountNumber = accountNumber;
        this.childAccountId = childAccountId;
        this.childAccountNumber = childAccountNumber;
        this.childDeposit = childDeposit;
        this.parentDeposit = parentDeposit;
        this.childAccountsCount = childAccountsCount;
        this.savingsStatus = savingsStatus;
    }


    @java.lang.SuppressWarnings("all")
        public static class GroupSavingsIndividualMonitoringAccountDataBuilder {
        @java.lang.SuppressWarnings("all")
                private BigDecimal gsimId;
        @java.lang.SuppressWarnings("all")
                private BigDecimal groupId;
        @java.lang.SuppressWarnings("all")
                private BigDecimal clientId;
        @java.lang.SuppressWarnings("all")
                private String accountNumber;
        @java.lang.SuppressWarnings("all")
                private BigDecimal childAccountId;
        @java.lang.SuppressWarnings("all")
                private String childAccountNumber;
        @java.lang.SuppressWarnings("all")
                private BigDecimal childDeposit;
        @java.lang.SuppressWarnings("all")
                private BigDecimal parentDeposit;
        @java.lang.SuppressWarnings("all")
                private Long childAccountsCount;
        @java.lang.SuppressWarnings("all")
                private String savingsStatus;

        @java.lang.SuppressWarnings("all")
                GroupSavingsIndividualMonitoringAccountDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public GroupSavingsIndividualMonitoringAccountData.GroupSavingsIndividualMonitoringAccountDataBuilder gsimId(final BigDecimal gsimId) {
            this.gsimId = gsimId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public GroupSavingsIndividualMonitoringAccountData.GroupSavingsIndividualMonitoringAccountDataBuilder groupId(final BigDecimal groupId) {
            this.groupId = groupId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public GroupSavingsIndividualMonitoringAccountData.GroupSavingsIndividualMonitoringAccountDataBuilder clientId(final BigDecimal clientId) {
            this.clientId = clientId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public GroupSavingsIndividualMonitoringAccountData.GroupSavingsIndividualMonitoringAccountDataBuilder accountNumber(final String accountNumber) {
            this.accountNumber = accountNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public GroupSavingsIndividualMonitoringAccountData.GroupSavingsIndividualMonitoringAccountDataBuilder childAccountId(final BigDecimal childAccountId) {
            this.childAccountId = childAccountId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public GroupSavingsIndividualMonitoringAccountData.GroupSavingsIndividualMonitoringAccountDataBuilder childAccountNumber(final String childAccountNumber) {
            this.childAccountNumber = childAccountNumber;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public GroupSavingsIndividualMonitoringAccountData.GroupSavingsIndividualMonitoringAccountDataBuilder childDeposit(final BigDecimal childDeposit) {
            this.childDeposit = childDeposit;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public GroupSavingsIndividualMonitoringAccountData.GroupSavingsIndividualMonitoringAccountDataBuilder parentDeposit(final BigDecimal parentDeposit) {
            this.parentDeposit = parentDeposit;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public GroupSavingsIndividualMonitoringAccountData.GroupSavingsIndividualMonitoringAccountDataBuilder childAccountsCount(final Long childAccountsCount) {
            this.childAccountsCount = childAccountsCount;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public GroupSavingsIndividualMonitoringAccountData.GroupSavingsIndividualMonitoringAccountDataBuilder savingsStatus(final String savingsStatus) {
            this.savingsStatus = savingsStatus;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public GroupSavingsIndividualMonitoringAccountData build() {
            return new GroupSavingsIndividualMonitoringAccountData(this.gsimId, this.groupId, this.clientId, this.accountNumber, this.childAccountId, this.childAccountNumber, this.childDeposit, this.parentDeposit, this.childAccountsCount, this.savingsStatus);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "GroupSavingsIndividualMonitoringAccountData.GroupSavingsIndividualMonitoringAccountDataBuilder(gsimId=" + this.gsimId + ", groupId=" + this.groupId + ", clientId=" + this.clientId + ", accountNumber=" + this.accountNumber + ", childAccountId=" + this.childAccountId + ", childAccountNumber=" + this.childAccountNumber + ", childDeposit=" + this.childDeposit + ", parentDeposit=" + this.parentDeposit + ", childAccountsCount=" + this.childAccountsCount + ", savingsStatus=" + this.savingsStatus + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static GroupSavingsIndividualMonitoringAccountData.GroupSavingsIndividualMonitoringAccountDataBuilder builder() {
        return new GroupSavingsIndividualMonitoringAccountData.GroupSavingsIndividualMonitoringAccountDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getGsimId() {
        return this.gsimId;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getGroupId() {
        return this.groupId;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getClientId() {
        return this.clientId;
    }

    @java.lang.SuppressWarnings("all")
        public String getAccountNumber() {
        return this.accountNumber;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getChildAccountId() {
        return this.childAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public String getChildAccountNumber() {
        return this.childAccountNumber;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getChildDeposit() {
        return this.childDeposit;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getParentDeposit() {
        return this.parentDeposit;
    }

    @java.lang.SuppressWarnings("all")
        public Long getChildAccountsCount() {
        return this.childAccountsCount;
    }

    @java.lang.SuppressWarnings("all")
        public String getSavingsStatus() {
        return this.savingsStatus;
    }
}
