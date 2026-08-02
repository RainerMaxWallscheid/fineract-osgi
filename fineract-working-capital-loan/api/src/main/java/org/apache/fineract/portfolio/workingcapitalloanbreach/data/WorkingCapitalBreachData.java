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
package org.apache.fineract.portfolio.workingcapitalloanbreach.data;

import io.swagger.v3.oas.annotations.media.Schema;
import java.math.BigDecimal;
import org.apache.fineract.infrastructure.core.data.StringEnumOptionData;

public class WorkingCapitalBreachData {
    private Long id;
    @Schema(example = "Default WCL Breach")
    private String name;
    private Integer breachFrequency;
    private StringEnumOptionData breachFrequencyType;
    private StringEnumOptionData breachAmountCalculationType;
    private BigDecimal breachAmount;


    @java.lang.SuppressWarnings("all")
        public static class WorkingCapitalBreachDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private Integer breachFrequency;
        @java.lang.SuppressWarnings("all")
                private StringEnumOptionData breachFrequencyType;
        @java.lang.SuppressWarnings("all")
                private StringEnumOptionData breachAmountCalculationType;
        @java.lang.SuppressWarnings("all")
                private BigDecimal breachAmount;

        @java.lang.SuppressWarnings("all")
                WorkingCapitalBreachDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalBreachData.WorkingCapitalBreachDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalBreachData.WorkingCapitalBreachDataBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalBreachData.WorkingCapitalBreachDataBuilder breachFrequency(final Integer breachFrequency) {
            this.breachFrequency = breachFrequency;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalBreachData.WorkingCapitalBreachDataBuilder breachFrequencyType(final StringEnumOptionData breachFrequencyType) {
            this.breachFrequencyType = breachFrequencyType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalBreachData.WorkingCapitalBreachDataBuilder breachAmountCalculationType(final StringEnumOptionData breachAmountCalculationType) {
            this.breachAmountCalculationType = breachAmountCalculationType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalBreachData.WorkingCapitalBreachDataBuilder breachAmount(final BigDecimal breachAmount) {
            this.breachAmount = breachAmount;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public WorkingCapitalBreachData build() {
            return new WorkingCapitalBreachData(this.id, this.name, this.breachFrequency, this.breachFrequencyType, this.breachAmountCalculationType, this.breachAmount);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "WorkingCapitalBreachData.WorkingCapitalBreachDataBuilder(id=" + this.id + ", name=" + this.name + ", breachFrequency=" + this.breachFrequency + ", breachFrequencyType=" + this.breachFrequencyType + ", breachAmountCalculationType=" + this.breachAmountCalculationType + ", breachAmount=" + this.breachAmount + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static WorkingCapitalBreachData.WorkingCapitalBreachDataBuilder builder() {
        return new WorkingCapitalBreachData.WorkingCapitalBreachDataBuilder();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getBreachFrequency() {
        return this.breachFrequency;
    }

    @java.lang.SuppressWarnings("all")
        public StringEnumOptionData getBreachFrequencyType() {
        return this.breachFrequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public StringEnumOptionData getBreachAmountCalculationType() {
        return this.breachAmountCalculationType;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getBreachAmount() {
        return this.breachAmount;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalBreachData(final Long id, final String name, final Integer breachFrequency, final StringEnumOptionData breachFrequencyType, final StringEnumOptionData breachAmountCalculationType, final BigDecimal breachAmount) {
        this.id = id;
        this.name = name;
        this.breachFrequency = breachFrequency;
        this.breachFrequencyType = breachFrequencyType;
        this.breachAmountCalculationType = breachAmountCalculationType;
        this.breachAmount = breachAmount;
    }
}
