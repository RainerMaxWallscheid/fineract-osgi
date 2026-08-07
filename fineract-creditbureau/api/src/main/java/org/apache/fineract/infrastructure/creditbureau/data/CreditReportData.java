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

public final class CreditReportData implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long id;
    @SuppressWarnings("unused")
    private Long creditBureauId;
    @SuppressWarnings("unused")
    private String nationalId;

    public static CreditReportData instance(final Long id, final Long creditBureauId, final String nationalId) {
        return new CreditReportData().setId(id).setCreditBureauId(creditBureauId).setNationalId(nationalId);
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCreditBureauId() {
        return this.creditBureauId;
    }

    @java.lang.SuppressWarnings("all")
        public String getNationalId() {
        return this.nationalId;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditReportData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditReportData setCreditBureauId(final Long creditBureauId) {
        this.creditBureauId = creditBureauId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditReportData setNationalId(final String nationalId) {
        this.nationalId = nationalId;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof CreditReportData)) return false;
        final CreditReportData other = (CreditReportData) o;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$creditBureauId = this.getCreditBureauId();
        final java.lang.Object other$creditBureauId = other.getCreditBureauId();
        if (this$creditBureauId == null ? other$creditBureauId != null : !this$creditBureauId.equals(other$creditBureauId)) return false;
        final java.lang.Object this$nationalId = this.getNationalId();
        final java.lang.Object other$nationalId = other.getNationalId();
        if (this$nationalId == null ? other$nationalId != null : !this$nationalId.equals(other$nationalId)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $creditBureauId = this.getCreditBureauId();
        result = result * PRIME + ($creditBureauId == null ? 43 : $creditBureauId.hashCode());
        final java.lang.Object $nationalId = this.getNationalId();
        result = result * PRIME + ($nationalId == null ? 43 : $nationalId.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CreditReportData(id=" + this.getId() + ", creditBureauId=" + this.getCreditBureauId() + ", nationalId=" + this.getNationalId() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public CreditReportData() {
    }
}
