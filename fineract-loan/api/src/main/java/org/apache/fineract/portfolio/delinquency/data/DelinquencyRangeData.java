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

public class DelinquencyRangeData implements Serializable {
    private Long id;
    private String classification;
    private Integer minimumAgeDays;
    private Integer maximumAgeDays;

    public static DelinquencyRangeData instance(String classification, Integer minimumAgeDays, Integer maximumAgeDays) {
        return new DelinquencyRangeData(null, classification, minimumAgeDays, maximumAgeDays);
    }

    public static DelinquencyRangeData reference(Long id) {
        return new DelinquencyRangeData(id, "", 0, 0);
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "DelinquencyRangeData(id=" + this.getId() + ", classification=" + this.getClassification() + ", minimumAgeDays=" + this.getMinimumAgeDays() + ", maximumAgeDays=" + this.getMaximumAgeDays() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public DelinquencyRangeData(final Long id, final String classification, final Integer minimumAgeDays, final Integer maximumAgeDays) {
        this.id = id;
        this.classification = classification;
        this.minimumAgeDays = minimumAgeDays;
        this.maximumAgeDays = maximumAgeDays;
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getClassification() {
        return this.classification;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getMinimumAgeDays() {
        return this.minimumAgeDays;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getMaximumAgeDays() {
        return this.maximumAgeDays;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setClassification(final String classification) {
        this.classification = classification;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinimumAgeDays(final Integer minimumAgeDays) {
        this.minimumAgeDays = minimumAgeDays;
    }

    @java.lang.SuppressWarnings("all")
        public void setMaximumAgeDays(final Integer maximumAgeDays) {
        this.maximumAgeDays = maximumAgeDays;
    }
}
