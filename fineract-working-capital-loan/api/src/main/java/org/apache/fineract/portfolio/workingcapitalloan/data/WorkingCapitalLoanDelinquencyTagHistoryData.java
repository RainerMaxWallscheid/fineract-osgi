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
package org.apache.fineract.portfolio.workingcapitalloan.data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import org.apache.fineract.portfolio.delinquency.data.DelinquencyRangeData;

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
public class WorkingCapitalLoanDelinquencyTagHistoryData implements Serializable {
    private Long id;
    private Long loanId;
    private DelinquencyRangeData delinquencyRange;
    private LocalDate addedOnDate;
    private LocalDate liftedOnDate;
    private Long delinquentDays;
    private Long rangeId;
    private Integer periodNumber;
    private BigDecimal delinquentAmount;

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "WorkingCapitalLoanDelinquencyTagHistoryData(id=" + this.getId() + ", loanId=" + this.getLoanId() + ", delinquencyRange=" + this.getDelinquencyRange() + ", addedOnDate=" + this.getAddedOnDate() + ", liftedOnDate=" + this.getLiftedOnDate() + ", delinquentDays=" + this.getDelinquentDays() + ", rangeId=" + this.getRangeId() + ", periodNumber=" + this.getPeriodNumber() + ", delinquentAmount=" + this.getDelinquentAmount() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanDelinquencyTagHistoryData(final Long id, final Long loanId, final DelinquencyRangeData delinquencyRange, final LocalDate addedOnDate, final LocalDate liftedOnDate, final Long delinquentDays, final Long rangeId, final Integer periodNumber, final BigDecimal delinquentAmount) {
        this.id = id;
        this.loanId = loanId;
        this.delinquencyRange = delinquencyRange;
        this.addedOnDate = addedOnDate;
        this.liftedOnDate = liftedOnDate;
        this.delinquentDays = delinquentDays;
        this.rangeId = rangeId;
        this.periodNumber = periodNumber;
        this.delinquentAmount = delinquentAmount;
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
        public Long getDelinquentDays() {
        return this.delinquentDays;
    }

    @java.lang.SuppressWarnings("all")
        public Long getRangeId() {
        return this.rangeId;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getPeriodNumber() {
        return this.periodNumber;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getDelinquentAmount() {
        return this.delinquentAmount;
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

    @java.lang.SuppressWarnings("all")
        public void setDelinquentDays(final Long delinquentDays) {
        this.delinquentDays = delinquentDays;
    }

    @java.lang.SuppressWarnings("all")
        public void setRangeId(final Long rangeId) {
        this.rangeId = rangeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setPeriodNumber(final Integer periodNumber) {
        this.periodNumber = periodNumber;
    }

    @java.lang.SuppressWarnings("all")
        public void setDelinquentAmount(final BigDecimal delinquentAmount) {
        this.delinquentAmount = delinquentAmount;
    }
}
