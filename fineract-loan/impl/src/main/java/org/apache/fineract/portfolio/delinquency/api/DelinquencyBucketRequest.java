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
package org.apache.fineract.portfolio.delinquency.api;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

public class DelinquencyBucketRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String name;
    private List<Long> ranges;
    private String bucketType;
    private MinimumPaymentPeriodAndRule minimumPaymentPeriodAndRule;


    public static class MinimumPaymentPeriodAndRule implements Serializable {
        @Serial
        private static final long serialVersionUID = 1L;
        private Integer frequency;
        private String frequencyType;
        private BigDecimal minimumPayment;
        private String minimumPaymentType;

        @java.lang.SuppressWarnings("all")
                public void setFrequency(final Integer frequency) {
            this.frequency = frequency;
        }

        @java.lang.SuppressWarnings("all")
                public void setFrequencyType(final String frequencyType) {
            this.frequencyType = frequencyType;
        }

        @java.lang.SuppressWarnings("all")
                public void setMinimumPayment(final BigDecimal minimumPayment) {
            this.minimumPayment = minimumPayment;
        }

        @java.lang.SuppressWarnings("all")
                public void setMinimumPaymentType(final String minimumPaymentType) {
            this.minimumPaymentType = minimumPaymentType;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getFrequency() {
            return this.frequency;
        }

        @java.lang.SuppressWarnings("all")
                public String getFrequencyType() {
            return this.frequencyType;
        }

        @java.lang.SuppressWarnings("all")
                public BigDecimal getMinimumPayment() {
            return this.minimumPayment;
        }

        @java.lang.SuppressWarnings("all")
                public String getMinimumPaymentType() {
            return this.minimumPaymentType;
        }

        @java.lang.SuppressWarnings("all")
                public MinimumPaymentPeriodAndRule() {
        }
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setRanges(final List<Long> ranges) {
        this.ranges = ranges;
    }

    @java.lang.SuppressWarnings("all")
        public void setBucketType(final String bucketType) {
        this.bucketType = bucketType;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinimumPaymentPeriodAndRule(final MinimumPaymentPeriodAndRule minimumPaymentPeriodAndRule) {
        this.minimumPaymentPeriodAndRule = minimumPaymentPeriodAndRule;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public List<Long> getRanges() {
        return this.ranges;
    }

    @java.lang.SuppressWarnings("all")
        public String getBucketType() {
        return this.bucketType;
    }

    @java.lang.SuppressWarnings("all")
        public MinimumPaymentPeriodAndRule getMinimumPaymentPeriodAndRule() {
        return this.minimumPaymentPeriodAndRule;
    }

    @java.lang.SuppressWarnings("all")
        public DelinquencyBucketRequest() {
    }
}
