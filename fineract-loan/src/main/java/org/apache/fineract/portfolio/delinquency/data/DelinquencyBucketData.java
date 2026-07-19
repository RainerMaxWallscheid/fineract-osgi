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
package org.apache.fineract.portfolio.delinquency.data;

import java.io.Serializable;
import java.util.List;
import org.apache.fineract.portfolio.delinquency.domain.DelinquencyBucketType;

public class DelinquencyBucketData implements Serializable {
    private Long id;
    private String name;
    private List<DelinquencyRangeData> ranges;
    private DelinquencyBucketType bucketType;
    private DelinquencyMinimumPaymentPeriodAndRuleData minimumPaymentPeriodAndRule;

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "DelinquencyBucketData(id=" + this.getId() + ", name=" + this.getName() + ", ranges=" + this.getRanges() + ", bucketType=" + this.getBucketType() + ", minimumPaymentPeriodAndRule=" + this.getMinimumPaymentPeriodAndRule() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public DelinquencyBucketData(final Long id, final String name, final List<DelinquencyRangeData> ranges, final DelinquencyBucketType bucketType, final DelinquencyMinimumPaymentPeriodAndRuleData minimumPaymentPeriodAndRule) {
        this.id = id;
        this.name = name;
        this.ranges = ranges;
        this.bucketType = bucketType;
        this.minimumPaymentPeriodAndRule = minimumPaymentPeriodAndRule;
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
        public List<DelinquencyRangeData> getRanges() {
        return this.ranges;
    }

    @java.lang.SuppressWarnings("all")
        public DelinquencyBucketType getBucketType() {
        return this.bucketType;
    }

    @java.lang.SuppressWarnings("all")
        public DelinquencyMinimumPaymentPeriodAndRuleData getMinimumPaymentPeriodAndRule() {
        return this.minimumPaymentPeriodAndRule;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setRanges(final List<DelinquencyRangeData> ranges) {
        this.ranges = ranges;
    }

    @java.lang.SuppressWarnings("all")
        public void setBucketType(final DelinquencyBucketType bucketType) {
        this.bucketType = bucketType;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinimumPaymentPeriodAndRule(final DelinquencyMinimumPaymentPeriodAndRuleData minimumPaymentPeriodAndRule) {
        this.minimumPaymentPeriodAndRule = minimumPaymentPeriodAndRule;
    }
}
