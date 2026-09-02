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

import java.io.Serializable;
import java.time.LocalDate;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;

public class LoanScheduleDelinquencyData implements Serializable {

    private Long loanId;
    private LocalDate overdueSinceDate;
    private Long overdueDays;
    private Loan loan;

    @java.lang.SuppressWarnings("all")
    public LoanScheduleDelinquencyData(final Long loanId, final LocalDate overdueSinceDate, final Long overdueDays, final Loan loan) {
        this.loanId = loanId;
        this.overdueSinceDate = overdueSinceDate;
        this.overdueDays = overdueDays;
        this.loan = loan;
    }

    @java.lang.SuppressWarnings("all")
    public LoanScheduleDelinquencyData() {}

    @java.lang.SuppressWarnings("all")
    public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
    public LocalDate getOverdueSinceDate() {
        return this.overdueSinceDate;
    }

    @java.lang.SuppressWarnings("all")
    public Long getOverdueDays() {
        return this.overdueDays;
    }

    @java.lang.SuppressWarnings("all")
    public Loan getLoan() {
        return this.loan;
    }

    @java.lang.SuppressWarnings("all")
    public void setLoanId(final Long loanId) {
        this.loanId = loanId;
    }

    @java.lang.SuppressWarnings("all")
    public void setOverdueSinceDate(final LocalDate overdueSinceDate) {
        this.overdueSinceDate = overdueSinceDate;
    }

    @java.lang.SuppressWarnings("all")
    public void setOverdueDays(final Long overdueDays) {
        this.overdueDays = overdueDays;
    }

    @java.lang.SuppressWarnings("all")
    public void setLoan(final Loan loan) {
        this.loan = loan;
    }
}
