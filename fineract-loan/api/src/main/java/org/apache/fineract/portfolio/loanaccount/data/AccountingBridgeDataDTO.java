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
import java.util.ArrayList;
import java.util.List;
import org.apache.fineract.accounting.journalentry.data.AdvancedMappingtDTO;

public class AccountingBridgeDataDTO {
    private Long loanId;
    private Long loanProductId;
    private Long officeId;
    private String currencyCode;
    private BigDecimal calculatedInterest;
    private boolean cashBasedAccountingEnabled;
    private boolean upfrontAccrualBasedAccountingEnabled;
    private boolean periodicAccrualBasedAccountingEnabled;
    private boolean isAccountTransfer;
    private boolean isChargeOff;
    private boolean isFraud;
    private Long chargeOffReasonCodeValue;
    private boolean isWrittenOff;
    private List<AccountingBridgeLoanTransactionDTO> newLoanTransactions = new ArrayList<>();
    private boolean merchantBuyDownFee;
    private List<AdvancedMappingtDTO> buydownFeeClassificationCodeValue;
    private List<AdvancedMappingtDTO> capitalizedIncomeClassificationCodeValue;
    private AdvancedMappingtDTO writeOffReasonCodeValue;

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
        public BigDecimal getCalculatedInterest() {
        return this.calculatedInterest;
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
        public boolean isAccountTransfer() {
        return this.isAccountTransfer;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isChargeOff() {
        return this.isChargeOff;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isFraud() {
        return this.isFraud;
    }

    @java.lang.SuppressWarnings("all")
        public Long getChargeOffReasonCodeValue() {
        return this.chargeOffReasonCodeValue;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isWrittenOff() {
        return this.isWrittenOff;
    }

    @java.lang.SuppressWarnings("all")
        public List<AccountingBridgeLoanTransactionDTO> getNewLoanTransactions() {
        return this.newLoanTransactions;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isMerchantBuyDownFee() {
        return this.merchantBuyDownFee;
    }

    @java.lang.SuppressWarnings("all")
        public List<AdvancedMappingtDTO> getBuydownFeeClassificationCodeValue() {
        return this.buydownFeeClassificationCodeValue;
    }

    @java.lang.SuppressWarnings("all")
        public List<AdvancedMappingtDTO> getCapitalizedIncomeClassificationCodeValue() {
        return this.capitalizedIncomeClassificationCodeValue;
    }

    @java.lang.SuppressWarnings("all")
        public AdvancedMappingtDTO getWriteOffReasonCodeValue() {
        return this.writeOffReasonCodeValue;
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
        public void setCalculatedInterest(final BigDecimal calculatedInterest) {
        this.calculatedInterest = calculatedInterest;
    }

    @java.lang.SuppressWarnings("all")
        public void setCashBasedAccountingEnabled(final boolean cashBasedAccountingEnabled) {
        this.cashBasedAccountingEnabled = cashBasedAccountingEnabled;
    }

    @java.lang.SuppressWarnings("all")
        public void setUpfrontAccrualBasedAccountingEnabled(final boolean upfrontAccrualBasedAccountingEnabled) {
        this.upfrontAccrualBasedAccountingEnabled = upfrontAccrualBasedAccountingEnabled;
    }

    @java.lang.SuppressWarnings("all")
        public void setPeriodicAccrualBasedAccountingEnabled(final boolean periodicAccrualBasedAccountingEnabled) {
        this.periodicAccrualBasedAccountingEnabled = periodicAccrualBasedAccountingEnabled;
    }

    @java.lang.SuppressWarnings("all")
        public void setAccountTransfer(final boolean isAccountTransfer) {
        this.isAccountTransfer = isAccountTransfer;
    }

    @java.lang.SuppressWarnings("all")
        public void setChargeOff(final boolean isChargeOff) {
        this.isChargeOff = isChargeOff;
    }

    @java.lang.SuppressWarnings("all")
        public void setFraud(final boolean isFraud) {
        this.isFraud = isFraud;
    }

    @java.lang.SuppressWarnings("all")
        public void setChargeOffReasonCodeValue(final Long chargeOffReasonCodeValue) {
        this.chargeOffReasonCodeValue = chargeOffReasonCodeValue;
    }

    @java.lang.SuppressWarnings("all")
        public void setWrittenOff(final boolean isWrittenOff) {
        this.isWrittenOff = isWrittenOff;
    }

    @java.lang.SuppressWarnings("all")
        public void setNewLoanTransactions(final List<AccountingBridgeLoanTransactionDTO> newLoanTransactions) {
        this.newLoanTransactions = newLoanTransactions;
    }

    @java.lang.SuppressWarnings("all")
        public void setMerchantBuyDownFee(final boolean merchantBuyDownFee) {
        this.merchantBuyDownFee = merchantBuyDownFee;
    }

    @java.lang.SuppressWarnings("all")
        public void setBuydownFeeClassificationCodeValue(final List<AdvancedMappingtDTO> buydownFeeClassificationCodeValue) {
        this.buydownFeeClassificationCodeValue = buydownFeeClassificationCodeValue;
    }

    @java.lang.SuppressWarnings("all")
        public void setCapitalizedIncomeClassificationCodeValue(final List<AdvancedMappingtDTO> capitalizedIncomeClassificationCodeValue) {
        this.capitalizedIncomeClassificationCodeValue = capitalizedIncomeClassificationCodeValue;
    }

    @java.lang.SuppressWarnings("all")
        public void setWriteOffReasonCodeValue(final AdvancedMappingtDTO writeOffReasonCodeValue) {
        this.writeOffReasonCodeValue = writeOffReasonCodeValue;
    }

    @java.lang.SuppressWarnings("all")
        public AccountingBridgeDataDTO() {
    }

    @java.lang.SuppressWarnings("all")
        public AccountingBridgeDataDTO(final Long loanId, final Long loanProductId, final Long officeId, final String currencyCode, final BigDecimal calculatedInterest, final boolean cashBasedAccountingEnabled, final boolean upfrontAccrualBasedAccountingEnabled, final boolean periodicAccrualBasedAccountingEnabled, final boolean isAccountTransfer, final boolean isChargeOff, final boolean isFraud, final Long chargeOffReasonCodeValue, final boolean isWrittenOff, final List<AccountingBridgeLoanTransactionDTO> newLoanTransactions, final boolean merchantBuyDownFee, final List<AdvancedMappingtDTO> buydownFeeClassificationCodeValue, final List<AdvancedMappingtDTO> capitalizedIncomeClassificationCodeValue, final AdvancedMappingtDTO writeOffReasonCodeValue) {
        this.loanId = loanId;
        this.loanProductId = loanProductId;
        this.officeId = officeId;
        this.currencyCode = currencyCode;
        this.calculatedInterest = calculatedInterest;
        this.cashBasedAccountingEnabled = cashBasedAccountingEnabled;
        this.upfrontAccrualBasedAccountingEnabled = upfrontAccrualBasedAccountingEnabled;
        this.periodicAccrualBasedAccountingEnabled = periodicAccrualBasedAccountingEnabled;
        this.isAccountTransfer = isAccountTransfer;
        this.isChargeOff = isChargeOff;
        this.isFraud = isFraud;
        this.chargeOffReasonCodeValue = chargeOffReasonCodeValue;
        this.isWrittenOff = isWrittenOff;
        this.newLoanTransactions = newLoanTransactions;
        this.merchantBuyDownFee = merchantBuyDownFee;
        this.buydownFeeClassificationCodeValue = buydownFeeClassificationCodeValue;
        this.capitalizedIncomeClassificationCodeValue = capitalizedIncomeClassificationCodeValue;
        this.writeOffReasonCodeValue = writeOffReasonCodeValue;
    }
}
