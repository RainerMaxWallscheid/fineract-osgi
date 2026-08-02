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
import java.time.LocalDate;

public class LoanDelinquencyTagHistoryData implements Serializable {
    private Long id;
    private Long loanId;
    private DelinquencyRangeData delinquencyRange;
    private LocalDate addedOnDate;
    private LocalDate liftedOnDate;

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanDelinquencyTagHistoryData(id=" + this.getId() + ", loanId=" + this.getLoanId() + ", delinquencyRange=" + this.getDelinquencyRange() + ", addedOnDate=" + this.getAddedOnDate() + ", liftedOnDate=" + this.getLiftedOnDate() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public LoanDelinquencyTagHistoryData(final Long id, final Long loanId, final DelinquencyRangeData delinquencyRange, final LocalDate addedOnDate, final LocalDate liftedOnDate) {
        this.id = id;
        this.loanId = loanId;
        this.delinquencyRange = delinquencyRange;
        this.addedOnDate = addedOnDate;
        this.liftedOnDate = liftedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public DelinquencyRangeData getDelinquencyRange() {
        return this.delinquencyRange;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getAddedOnDate() {
        return this.addedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getLiftedOnDate() {
        return this.liftedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanId(final Long loanId) {
        this.loanId = loanId;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquencyRange(final DelinquencyRangeData delinquencyRange) {
        this.delinquencyRange = delinquencyRange;
    }

    @java.lang.SuppressWarnings("all")
        public void setAddedOnDate(final LocalDate addedOnDate) {
        this.addedOnDate = addedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setLiftedOnDate(final LocalDate liftedOnDate) {
        this.liftedOnDate = liftedOnDate;
    }
}
