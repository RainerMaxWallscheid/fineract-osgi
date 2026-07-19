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

public class MixReportXBRLContextData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String dimensionType;
    private String dimension;
    private Integer periodType;


    @java.lang.SuppressWarnings("all")
        public static class MixReportXBRLContextDataBuilder {
        @java.lang.SuppressWarnings("all")
                private String dimensionType;
        @java.lang.SuppressWarnings("all")
                private String dimension;
        @java.lang.SuppressWarnings("all")
                private Integer periodType;

        @java.lang.SuppressWarnings("all")
                MixReportXBRLContextDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MixReportXBRLContextData.MixReportXBRLContextDataBuilder dimensionType(final String dimensionType) {
            this.dimensionType = dimensionType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MixReportXBRLContextData.MixReportXBRLContextDataBuilder dimension(final String dimension) {
            this.dimension = dimension;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public MixReportXBRLContextData.MixReportXBRLContextDataBuilder periodType(final Integer periodType) {
            this.periodType = periodType;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public MixReportXBRLContextData build() {
            return new MixReportXBRLContextData(this.dimensionType, this.dimension, this.periodType);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "MixReportXBRLContextData.MixReportXBRLContextDataBuilder(dimensionType=" + this.dimensionType + ", dimension=" + this.dimension + ", periodType=" + this.periodType + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static MixReportXBRLContextData.MixReportXBRLContextDataBuilder builder() {
        return new MixReportXBRLContextData.MixReportXBRLContextDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public String getDimensionType() {
        return this.dimensionType;
    }

    @java.lang.SuppressWarnings("all")
        public String getDimension() {
        return this.dimension;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getPeriodType() {
        return this.periodType;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixReportXBRLContextData setDimensionType(final String dimensionType) {
        this.dimensionType = dimensionType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixReportXBRLContextData setDimension(final String dimension) {
        this.dimension = dimension;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public MixReportXBRLContextData setPeriodType(final Integer periodType) {
        this.periodType = periodType;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof MixReportXBRLContextData)) return false;
        final MixReportXBRLContextData other = (MixReportXBRLContextData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$periodType = this.getPeriodType();
        final java.lang.Object other$periodType = other.getPeriodType();
        if (this$periodType == null ? other$periodType != null : !this$periodType.equals(other$periodType)) return false;
        final java.lang.Object this$dimensionType = this.getDimensionType();
        final java.lang.Object other$dimensionType = other.getDimensionType();
        if (this$dimensionType == null ? other$dimensionType != null : !this$dimensionType.equals(other$dimensionType)) return false;
        final java.lang.Object this$dimension = this.getDimension();
        final java.lang.Object other$dimension = other.getDimension();
        if (this$dimension == null ? other$dimension != null : !this$dimension.equals(other$dimension)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof MixReportXBRLContextData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $periodType = this.getPeriodType();
        result = result * PRIME + ($periodType == null ? 43 : $periodType.hashCode());
        final java.lang.Object $dimensionType = this.getDimensionType();
        result = result * PRIME + ($dimensionType == null ? 43 : $dimensionType.hashCode());
        final java.lang.Object $dimension = this.getDimension();
        result = result * PRIME + ($dimension == null ? 43 : $dimension.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "MixReportXBRLContextData(dimensionType=" + this.getDimensionType() + ", dimension=" + this.getDimension() + ", periodType=" + this.getPeriodType() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public MixReportXBRLContextData() {
    }

    @java.lang.SuppressWarnings("all")
        public MixReportXBRLContextData(final String dimensionType, final String dimension, final Integer periodType) {
        this.dimensionType = dimensionType;
        this.dimension = dimension;
        this.periodType = periodType;
    }
}
