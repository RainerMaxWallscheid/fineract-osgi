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

public class AccrualBalances {
    private BigDecimal interestPortion = BigDecimal.ZERO;
    private BigDecimal feePortion = BigDecimal.ZERO;
    private BigDecimal penaltyPortion = BigDecimal.ZERO;

    @java.lang.SuppressWarnings("all")
        public BigDecimal getInterestPortion() {
        return this.interestPortion;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getFeePortion() {
        return this.feePortion;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPenaltyPortion() {
        return this.penaltyPortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setInterestPortion(final BigDecimal interestPortion) {
        this.interestPortion = interestPortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setFeePortion(final BigDecimal feePortion) {
        this.feePortion = feePortion;
    }

    @java.lang.SuppressWarnings("all")
        public void setPenaltyPortion(final BigDecimal penaltyPortion) {
        this.penaltyPortion = penaltyPortion;
    }
}
