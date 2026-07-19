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
package org.apache.fineract.portfolio.workingcapitalloan.domain;

import org.apache.fineract.infrastructure.core.api.ApiFacingEnum;
import org.apache.fineract.infrastructure.core.data.StringEnumOptionData;
import org.springframework.util.StringUtils;

/**
 * Period frequency types for Working Capital Loan Product.
 */
public enum WorkingCapitalLoanPeriodFrequencyType implements ApiFacingEnum<WorkingCapitalLoanPeriodFrequencyType> {
    DAYS(1, "DAYS", "Days"),  //
    WEEKS(2, "WEEKS", "Weeks"),  //
    MONTHS(3, "MONTHS", "Months"),  //
    YEARS(4, "YEARS", "Years") //
    ;
    private final Integer value;
    private final String code;
    private final String humanReadableName;

    /**
     * Resolve enum from its string name/code (e.g. "DAYS", "MONTHS", "YEARS").
     */
    public static WorkingCapitalLoanPeriodFrequencyType fromString(final String periodFrequencyTypeValue) {
        if (!StringUtils.hasText(periodFrequencyTypeValue)) {
            return null;
        }
        if (periodFrequencyTypeValue.trim().equalsIgnoreCase(DAYS.name())) {
            return DAYS;
        }
        if (periodFrequencyTypeValue.trim().equalsIgnoreCase(WEEKS.name())) {
            return WEEKS;
        }
        if (periodFrequencyTypeValue.trim().equalsIgnoreCase(MONTHS.name())) {
            return MONTHS;
        }
        if (periodFrequencyTypeValue.trim().equalsIgnoreCase(YEARS.name())) {
            return YEARS;
        }
        return null;
    }

    public StringEnumOptionData toStringEnumOptionData() {
        return new StringEnumOptionData(name(), getCode(), name());
    }

    @java.lang.SuppressWarnings("all")
        public Integer getValue() {
        return this.value;
    }

    @java.lang.SuppressWarnings("all")
        public String getCode() {
        return this.code;
    }

    @java.lang.SuppressWarnings("all")
        public String getHumanReadableName() {
        return this.humanReadableName;
    }

    @java.lang.SuppressWarnings("all")
        private WorkingCapitalLoanPeriodFrequencyType(final Integer value, final String code, final String humanReadableName) {
        this.value = value;
        this.code = code;
        this.humanReadableName = humanReadableName;
    }
}
