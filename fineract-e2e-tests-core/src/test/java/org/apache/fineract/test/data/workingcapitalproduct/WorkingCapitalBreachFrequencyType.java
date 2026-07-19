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
package org.apache.fineract.test.data.workingcapitalproduct;

public enum WorkingCapitalBreachFrequencyType {
    DAYS(0L, "DAYS", "Days"),  //
    MONTHS(1L, "MONTHS", "Months"),  //
    YEARS(2L, "YEARS", "Years");
    private final Long id;
    private final String code;
    private final String value;

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getCode() {
        return this.code;
    }

    @java.lang.SuppressWarnings("all")
        public String getValue() {
        return this.value;
    }

    @java.lang.SuppressWarnings("all")
        private WorkingCapitalBreachFrequencyType(final Long id, final String code, final String value) {
        this.id = id;
        this.code = code;
        this.value = value;
    }
}
