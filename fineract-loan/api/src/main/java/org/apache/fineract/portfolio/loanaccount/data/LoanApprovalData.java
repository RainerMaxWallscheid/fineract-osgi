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
import java.time.LocalDate;
import org.apache.fineract.organisation.monetary.data.CurrencyData;

/**
 * Immutable data object representing a loan transaction.
 */
public class LoanApprovalData {
    private final LocalDate approvalDate;
    private final BigDecimal approvalAmount;
    private final BigDecimal netDisbursalAmount;
    private final BigDecimal availableDisbursementAmountWithOverApplied;
    private final LocalDate expectedDisbursementDate;
    // import fields
    private LocalDate approvedOnDate;
    private String note;
    private String dateFormat;
    private String locale;
    private transient Integer rowIndex;
    private CurrencyData currency;

    public static LoanApprovalData importInstance(LocalDate approvedOnDate, Integer rowIndex, String locale, String dateFormat) {
        return new LoanApprovalData(approvedOnDate, rowIndex, locale, dateFormat);
    }

    private LoanApprovalData(LocalDate approvedOnDate, Integer rowIndex, String locale, String dateFormat) {
        this.approvedOnDate = approvedOnDate;
        this.rowIndex = rowIndex;
        this.dateFormat = dateFormat;
        this.locale = locale;
        this.note = "";
        this.approvalAmount = null;
        this.approvalDate = null;
        this.netDisbursalAmount = null;
        this.availableDisbursementAmountWithOverApplied = null;
        this.expectedDisbursementDate = null;
    }

    public LoanApprovalData(final BigDecimal approvalAmount, final LocalDate approvalDate, final BigDecimal netDisbursalAmount, final CurrencyData currency, final BigDecimal availableDisbursementAmountWithOverApplied, final LocalDate expectedDisbursementDate) {
        this.approvalDate = approvalDate;
        this.approvalAmount = approvalAmount;
        this.netDisbursalAmount = netDisbursalAmount;
        this.currency = currency;
        this.availableDisbursementAmountWithOverApplied = availableDisbursementAmountWithOverApplied;
        this.expectedDisbursementDate = expectedDisbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getApprovalDate() {
        return this.approvalDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getApprovalAmount() {
        return this.approvalAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getNetDisbursalAmount() {
        return this.netDisbursalAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAvailableDisbursementAmountWithOverApplied() {
        return this.availableDisbursementAmountWithOverApplied;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getExpectedDisbursementDate() {
        return this.expectedDisbursementDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getApprovedOnDate() {
        return this.approvedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getNote() {
        return this.note;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getRowIndex() {
        return this.rowIndex;
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyData getCurrency() {
        return this.currency;
    }
}
