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
package org.apache.fineract.portfolio.loanaccount.data;

import java.math.BigDecimal;

public class LoanBorrowerCycleData {
    private final BigDecimal principal;
    private final BigDecimal interestRatePerPeriod;
    private final Integer numberOfRepayments;
    private final Integer termFrequency;

    @java.lang.SuppressWarnings("all")
        public LoanBorrowerCycleData(final BigDecimal principal, final BigDecimal interestRatePerPeriod, final Integer numberOfRepayments, final Integer termFrequency) {
        this.principal = principal;
        this.interestRatePerPeriod = interestRatePerPeriod;
        this.numberOfRepayments = numberOfRepayments;
        this.termFrequency = termFrequency;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPrincipal() {
        return this.principal;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestRatePerPeriod() {
        return this.interestRatePerPeriod;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getNumberOfRepayments() {
        return this.numberOfRepayments;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getTermFrequency() {
        return this.termFrequency;
    }
}
