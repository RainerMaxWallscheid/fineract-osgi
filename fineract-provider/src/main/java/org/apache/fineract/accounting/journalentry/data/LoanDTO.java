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
package org.apache.fineract.accounting.journalentry.data;

import java.util.List;

public class LoanDTO {
    private Long loanId;
    private Long loanProductId;
    private Long officeId;
    private String currencyCode;
    private boolean cashBasedAccountingEnabled;
    private final boolean upfrontAccrualBasedAccountingEnabled;
    private final boolean periodicAccrualBasedAccountingEnabled;
    private List<LoanTransactionDTO> newLoanTransactions;
    private boolean markedAsChargeOff;
    private boolean markedAsFraud;
    private Long chargeOffReasonCodeValue;
    private boolean markedAsWrittenOff;
    private boolean merchantBuyDownFee;
    private List<AdvancedMappingtDTO> buydownFeeAdvancedMappingData;
    private List<AdvancedMappingtDTO> capitalizedIncomeAdvancedMappingData;
    private AdvancedMappingtDTO writeOffReasonAdvancedMappingData;

    @java.lang.SuppressWarnings("all")
        public LoanDTO(final Long loanId, final Long loanProductId, final Long officeId, final String currencyCode, final boolean cashBasedAccountingEnabled, final boolean upfrontAccrualBasedAccountingEnabled, final boolean periodicAccrualBasedAccountingEnabled, final List<LoanTransactionDTO> newLoanTransactions, final boolean markedAsChargeOff, final boolean markedAsFraud, final Long chargeOffReasonCodeValue, final boolean markedAsWrittenOff, final boolean merchantBuyDownFee, final List<AdvancedMappingtDTO> buydownFeeAdvancedMappingData, final List<AdvancedMappingtDTO> capitalizedIncomeAdvancedMappingData, final AdvancedMappingtDTO writeOffReasonAdvancedMappingData) {
        this.loanId = loanId;
        this.loanProductId = loanProductId;
        this.officeId = officeId;
        this.currencyCode = currencyCode;
        this.cashBasedAccountingEnabled = cashBasedAccountingEnabled;
        this.upfrontAccrualBasedAccountingEnabled = upfrontAccrualBasedAccountingEnabled;
        this.periodicAccrualBasedAccountingEnabled = periodicAccrualBasedAccountingEnabled;
        this.newLoanTransactions = newLoanTransactions;
        this.markedAsChargeOff = markedAsChargeOff;
        this.markedAsFraud = markedAsFraud;
        this.chargeOffReasonCodeValue = chargeOffReasonCodeValue;
        this.markedAsWrittenOff = markedAsWrittenOff;
        this.merchantBuyDownFee = merchantBuyDownFee;
        this.buydownFeeAdvancedMappingData = buydownFeeAdvancedMappingData;
        this.capitalizedIncomeAdvancedMappingData = capitalizedIncomeAdvancedMappingData;
        this.writeOffReasonAdvancedMappingData = writeOffReasonAdvancedMappingData;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanProductId() {
        return this.loanProductId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getCurrencyCode() {
        return this.currencyCode;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isCashBasedAccountingEnabled() {
        return this.cashBasedAccountingEnabled;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isUpfrontAccrualBasedAccountingEnabled() {
        return this.upfrontAccrualBasedAccountingEnabled;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isPeriodicAccrualBasedAccountingEnabled() {
        return this.periodicAccrualBasedAccountingEnabled;
    }

    @java.lang.SuppressWarnings("all")
        public List<LoanTransactionDTO> getNewLoanTransactions() {
        return this.newLoanTransactions;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isMarkedAsChargeOff() {
        return this.markedAsChargeOff;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isMarkedAsFraud() {
        return this.markedAsFraud;
    }

    @java.lang.SuppressWarnings("all")
        public Long getChargeOffReasonCodeValue() {
        return this.chargeOffReasonCodeValue;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isMarkedAsWrittenOff() {
        return this.markedAsWrittenOff;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isMerchantBuyDownFee() {
        return this.merchantBuyDownFee;
    }

    @java.lang.SuppressWarnings("all")
        public List<AdvancedMappingtDTO> getBuydownFeeAdvancedMappingData() {
        return this.buydownFeeAdvancedMappingData;
    }

    @java.lang.SuppressWarnings("all")
        public List<AdvancedMappingtDTO> getCapitalizedIncomeAdvancedMappingData() {
        return this.capitalizedIncomeAdvancedMappingData;
    }

    @java.lang.SuppressWarnings("all")
        public AdvancedMappingtDTO getWriteOffReasonAdvancedMappingData() {
        return this.writeOffReasonAdvancedMappingData;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanId(final Long loanId) {
        this.loanId = loanId;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanProductId(final Long loanProductId) {
        this.loanProductId = loanProductId;
    }

    @java.lang.SuppressWarnings("all")
        public void setOfficeId(final Long officeId) {
        this.officeId = officeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrencyCode(final String currencyCode) {
        this.currencyCode = currencyCode;
    }

    @java.lang.SuppressWarnings("all")
        public void setCashBasedAccountingEnabled(final boolean cashBasedAccountingEnabled) {
        this.cashBasedAccountingEnabled = cashBasedAccountingEnabled;
    }

    @java.lang.SuppressWarnings("all")
        public void setNewLoanTransactions(final List<LoanTransactionDTO> newLoanTransactions) {
        this.newLoanTransactions = newLoanTransactions;
    }

    @java.lang.SuppressWarnings("all")
        public void setMarkedAsChargeOff(final boolean markedAsChargeOff) {
        this.markedAsChargeOff = markedAsChargeOff;
    }

    @java.lang.SuppressWarnings("all")
        public void setMarkedAsFraud(final boolean markedAsFraud) {
        this.markedAsFraud = markedAsFraud;
    }
}
