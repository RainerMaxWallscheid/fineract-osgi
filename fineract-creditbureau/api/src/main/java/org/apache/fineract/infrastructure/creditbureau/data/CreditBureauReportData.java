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
package org.apache.fineract.infrastructure.creditbureau.data;

import java.io.Serializable;

public final class CreditBureauReportData implements Serializable {
    private static final long serialVersionUID = 1L;
    @SuppressWarnings("unused")
    private String name;
    private String gender;
    private String address;
    private String creditScore;
    private String borrowerInfo;
    private String[] openAccounts;
    private String[] closedAccounts;

    public static CreditBureauReportData instance(final String name, final String gender, final String address, final String creditScore, final String borrowerInfo, final String[] openAccounts, final String[] closedAccounts) {
        return new CreditBureauReportData().setName(name).setGender(gender).setAddress(address).setCreditScore(creditScore).setBorrowerInfo(borrowerInfo).setOpenAccounts(openAccounts).setClosedAccounts(closedAccounts);
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public String getGender() {
        return this.gender;
    }

    @java.lang.SuppressWarnings("all")
        public String getAddress() {
        return this.address;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreditScore() {
        return this.creditScore;
    }

    @java.lang.SuppressWarnings("all")
        public String getBorrowerInfo() {
        return this.borrowerInfo;
    }

    @java.lang.SuppressWarnings("all")
        public String[] getOpenAccounts() {
        return this.openAccounts;
    }

    @java.lang.SuppressWarnings("all")
        public String[] getClosedAccounts() {
        return this.closedAccounts;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauReportData setName(final String name) {
        this.name = name;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauReportData setGender(final String gender) {
        this.gender = gender;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauReportData setAddress(final String address) {
        this.address = address;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauReportData setCreditScore(final String creditScore) {
        this.creditScore = creditScore;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauReportData setBorrowerInfo(final String borrowerInfo) {
        this.borrowerInfo = borrowerInfo;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauReportData setOpenAccounts(final String[] openAccounts) {
        this.openAccounts = openAccounts;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauReportData setClosedAccounts(final String[] closedAccounts) {
        this.closedAccounts = closedAccounts;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CreditBureauReportData)) return false;
        final CreditBureauReportData other = (CreditBureauReportData) o;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$gender = this.getGender();
        final java.lang.Object other$gender = other.getGender();
        if (this$gender == null ? other$gender != null : !this$gender.equals(other$gender)) return false;
        final java.lang.Object this$address = this.getAddress();
        final java.lang.Object other$address = other.getAddress();
        if (this$address == null ? other$address != null : !this$address.equals(other$address)) return false;
        final java.lang.Object this$creditScore = this.getCreditScore();
        final java.lang.Object other$creditScore = other.getCreditScore();
        if (this$creditScore == null ? other$creditScore != null : !this$creditScore.equals(other$creditScore)) return false;
        final java.lang.Object this$borrowerInfo = this.getBorrowerInfo();
        final java.lang.Object other$borrowerInfo = other.getBorrowerInfo();
        if (this$borrowerInfo == null ? other$borrowerInfo != null : !this$borrowerInfo.equals(other$borrowerInfo)) return false;
        if (!java.util.Arrays.deepEquals(this.getOpenAccounts(), other.getOpenAccounts())) return false;
        if (!java.util.Arrays.deepEquals(this.getClosedAccounts(), other.getClosedAccounts())) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $gender = this.getGender();
        result = result * PRIME + ($gender == null ? 43 : $gender.hashCode());
        final java.lang.Object $address = this.getAddress();
        result = result * PRIME + ($address == null ? 43 : $address.hashCode());
        final java.lang.Object $creditScore = this.getCreditScore();
        result = result * PRIME + ($creditScore == null ? 43 : $creditScore.hashCode());
        final java.lang.Object $borrowerInfo = this.getBorrowerInfo();
        result = result * PRIME + ($borrowerInfo == null ? 43 : $borrowerInfo.hashCode());
        result = result * PRIME + java.util.Arrays.deepHashCode(this.getOpenAccounts());
        result = result * PRIME + java.util.Arrays.deepHashCode(this.getClosedAccounts());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CreditBureauReportData(name=" + this.getName() + ", gender=" + this.getGender() + ", address=" + this.getAddress() + ", creditScore=" + this.getCreditScore() + ", borrowerInfo=" + this.getBorrowerInfo() + ", openAccounts=" + java.util.Arrays.deepToString(this.getOpenAccounts()) + ", closedAccounts=" + java.util.Arrays.deepToString(this.getClosedAccounts()) + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CreditBureauReportData() {
    }
}
