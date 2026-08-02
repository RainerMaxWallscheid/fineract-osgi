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

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;

public final class LoanRepaymentScheduleInstallmentData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long id;
    private Integer installmentId;
    private LocalDate date;
    private BigDecimal amount;

    public static LoanRepaymentScheduleInstallmentData instanceOf(final Long id, final Integer installmentId, final LocalDate date, final BigDecimal amount) {
        return new LoanRepaymentScheduleInstallmentData(id, installmentId, date, amount);
    }

    @java.lang.SuppressWarnings("all")
        public LoanRepaymentScheduleInstallmentData(final Long id, final Integer installmentId, final LocalDate date, final BigDecimal amount) {
        this.id = id;
        this.installmentId = installmentId;
        this.date = date;
        this.amount = amount;
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getInstallmentId() {
        return this.installmentId;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getDate() {
        return this.date;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }
}
