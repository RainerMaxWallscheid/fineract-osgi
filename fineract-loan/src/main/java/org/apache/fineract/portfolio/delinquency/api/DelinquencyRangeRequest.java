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

public class DelinquencyRangeRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String classification;
    private Integer minimumAgeDays;
    private Integer maximumAgeDays;
    private String locale;

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

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
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
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public DelinquencyRangeRequest() {
    }
}
