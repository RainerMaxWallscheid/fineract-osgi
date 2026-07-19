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
package org.apache.fineract.mix.data;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.Map;

public class MixReportXBRLData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Map<MixTaxonomyData, BigDecimal> resultMap;
    private Date startDate;
    private Date endDate;
    private String currency;


    @java.lang.SuppressWarnings("all")
        public static class MixReportXBRLDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Map<MixTaxonomyData, BigDecimal> resultMap;
        @java.lang.SuppressWarnings("all")
                private Date startDate;
        @java.lang.SuppressWarnings("all")
                private Date endDate;
        @java.lang.SuppressWarnings("all")
                private String currency;

        @java.lang.SuppressWarnings("all")
                MixReportXBRLDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MixReportXBRLData.MixReportXBRLDataBuilder resultMap(final Map<MixTaxonomyData, BigDecimal> resultMap) {
            this.resultMap = resultMap;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MixReportXBRLData.MixReportXBRLDataBuilder startDate(final Date startDate) {
            this.startDate = startDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MixReportXBRLData.MixReportXBRLDataBuilder endDate(final Date endDate) {
            this.endDate = endDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MixReportXBRLData.MixReportXBRLDataBuilder currency(final String currency) {
            this.currency = currency;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public MixReportXBRLData build() {
            return new MixReportXBRLData(this.resultMap, this.startDate, this.endDate, this.currency);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "MixReportXBRLData.MixReportXBRLDataBuilder(resultMap=" + this.resultMap + ", startDate=" + this.startDate + ", endDate=" + this.endDate + ", currency=" + this.currency + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static MixReportXBRLData.MixReportXBRLDataBuilder builder() {
        return new MixReportXBRLData.MixReportXBRLDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Map<MixTaxonomyData, BigDecimal> getResultMap() {
        return this.resultMap;
    }

    @java.lang.SuppressWarnings("all")
        public Date getStartDate() {
        return this.startDate;
    }

    @java.lang.SuppressWarnings("all")
        public Date getEndDate() {
        return this.endDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getCurrency() {
        return this.currency;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixReportXBRLData setResultMap(final Map<MixTaxonomyData, BigDecimal> resultMap) {
        this.resultMap = resultMap;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixReportXBRLData setStartDate(final Date startDate) {
        this.startDate = startDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixReportXBRLData setEndDate(final Date endDate) {
        this.endDate = endDate;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixReportXBRLData setCurrency(final String currency) {
        this.currency = currency;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof MixReportXBRLData)) return false;
        final MixReportXBRLData other = (MixReportXBRLData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$resultMap = this.getResultMap();
        final java.lang.Object other$resultMap = other.getResultMap();
        if (this$resultMap == null ? other$resultMap != null : !this$resultMap.equals(other$resultMap)) return false;
        final java.lang.Object this$startDate = this.getStartDate();
        final java.lang.Object other$startDate = other.getStartDate();
        if (this$startDate == null ? other$startDate != null : !this$startDate.equals(other$startDate)) return false;
        final java.lang.Object this$endDate = this.getEndDate();
        final java.lang.Object other$endDate = other.getEndDate();
        if (this$endDate == null ? other$endDate != null : !this$endDate.equals(other$endDate)) return false;
        final java.lang.Object this$currency = this.getCurrency();
        final java.lang.Object other$currency = other.getCurrency();
        if (this$currency == null ? other$currency != null : !this$currency.equals(other$currency)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof MixReportXBRLData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $resultMap = this.getResultMap();
        result = result * PRIME + ($resultMap == null ? 43 : $resultMap.hashCode());
        final java.lang.Object $startDate = this.getStartDate();
        result = result * PRIME + ($startDate == null ? 43 : $startDate.hashCode());
        final java.lang.Object $endDate = this.getEndDate();
        result = result * PRIME + ($endDate == null ? 43 : $endDate.hashCode());
        final java.lang.Object $currency = this.getCurrency();
        result = result * PRIME + ($currency == null ? 43 : $currency.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "MixReportXBRLData(resultMap=" + this.getResultMap() + ", startDate=" + this.getStartDate() + ", endDate=" + this.getEndDate() + ", currency=" + this.getCurrency() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public MixReportXBRLData() {
    }

    @java.lang.SuppressWarnings("all")
        public MixReportXBRLData(final Map<MixTaxonomyData, BigDecimal> resultMap, final Date startDate, final Date endDate, final String currency) {
        this.resultMap = resultMap;
        this.startDate = startDate;
        this.endDate = endDate;
        this.currency = currency;
    }
}
