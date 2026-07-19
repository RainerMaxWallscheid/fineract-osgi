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
package org.apache.fineract.portfolio.workingcapitalloannearbreach.data;

import java.math.BigDecimal;
import org.apache.fineract.infrastructure.core.data.StringEnumOptionData;

public class WorkingCapitalNearBreachData {
    private Long id;
    private String name;
    private Integer frequency;
    private StringEnumOptionData frequencyType;
    private BigDecimal threshold;


    @java.lang.SuppressWarnings("all")
        public static class WorkingCapitalNearBreachDataBuilder {
        @java.lang.SuppressWarnings("all")
                private Long id;
        @java.lang.SuppressWarnings("all")
                private String name;
        @java.lang.SuppressWarnings("all")
                private Integer frequency;
        @java.lang.SuppressWarnings("all")
                private StringEnumOptionData frequencyType;
        @java.lang.SuppressWarnings("all")
                private BigDecimal threshold;

        @java.lang.SuppressWarnings("all")
                WorkingCapitalNearBreachDataBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalNearBreachData.WorkingCapitalNearBreachDataBuilder id(final Long id) {
            this.id = id;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalNearBreachData.WorkingCapitalNearBreachDataBuilder name(final String name) {
            this.name = name;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalNearBreachData.WorkingCapitalNearBreachDataBuilder frequency(final Integer frequency) {
            this.frequency = frequency;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalNearBreachData.WorkingCapitalNearBreachDataBuilder frequencyType(final StringEnumOptionData frequencyType) {
            this.frequencyType = frequencyType;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public WorkingCapitalNearBreachData.WorkingCapitalNearBreachDataBuilder threshold(final BigDecimal threshold) {
            this.threshold = threshold;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public WorkingCapitalNearBreachData build() {
            return new WorkingCapitalNearBreachData(this.id, this.name, this.frequency, this.frequencyType, this.threshold);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "WorkingCapitalNearBreachData.WorkingCapitalNearBreachDataBuilder(id=" + this.id + ", name=" + this.name + ", frequency=" + this.frequency + ", frequencyType=" + this.frequencyType + ", threshold=" + this.threshold + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static WorkingCapitalNearBreachData.WorkingCapitalNearBreachDataBuilder builder() {
        return new WorkingCapitalNearBreachData.WorkingCapitalNearBreachDataBuilder();
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
        public Integer getFrequency() {
        return this.frequency;
    }

    @java.lang.SuppressWarnings("all")
        public StringEnumOptionData getFrequencyType() {
        return this.frequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getThreshold() {
        return this.threshold;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalNearBreachData(final Long id, final String name, final Integer frequency, final StringEnumOptionData frequencyType, final BigDecimal threshold) {
        this.id = id;
        this.name = name;
        this.frequency = frequency;
        this.frequencyType = frequencyType;
        this.threshold = threshold;
    }
}
