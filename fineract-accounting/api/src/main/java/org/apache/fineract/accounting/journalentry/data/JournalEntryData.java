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

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import org.apache.fineract.accounting.glaccount.data.GLAccountData;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.organisation.monetary.data.CurrencyData;

/**
 * Immutable object representing a General Ledger Account
 *
 * Note: no getter/setters required as google will produce json from fields of object.
 */
public class JournalEntryData {
    private Long id;
    private Long officeId;
    @SuppressWarnings("unused")
    private String officeName;
    @SuppressWarnings("unused")
    private String glAccountName;
    private Long glAccountId;
    @SuppressWarnings("unused")
    private String glAccountCode;
    private EnumOptionData glAccountType;
    @SuppressWarnings("unused")
    private LocalDate transactionDate;
    private EnumOptionData entryType;
    private BigDecimal amount;
    @SuppressWarnings("unused")
    private CurrencyData currency;
    private String transactionId;
    @SuppressWarnings("unused")
    private Boolean manualEntry;
    @SuppressWarnings("unused")
    private EnumOptionData entityType;
    @SuppressWarnings("unused")
    private Long entityId;
    @SuppressWarnings("unused")
    private Long createdByUserId;
    @SuppressWarnings("unused")
    private LocalDate createdDate;
    @SuppressWarnings("unused")
    private String createdByUserName;
    @SuppressWarnings("unused")
    private String comments;
    @SuppressWarnings("unused")
    private Boolean reversed;
    @SuppressWarnings("unused")
    private String referenceNumber;
    @SuppressWarnings("unused")
    private BigDecimal officeRunningBalance;
    @SuppressWarnings("unused")
    private BigDecimal organizationRunningBalance;
    @SuppressWarnings("unused")
    private Boolean runningBalanceComputed;
    @SuppressWarnings("unused")
    private TransactionDetailData transactionDetails;
    @SuppressWarnings("unused")
    private LocalDate submittedOnDate;
    // import fields
    private transient Integer rowIndex;
    private String dateFormat;
    private String locale;
    private List<CreditDebit> credits;
    private List<CreditDebit> debits;
    private Long paymentTypeId;
    private String currencyCode;
    private String accountNumber;
    private String checkNumber;
    private String routingCode;
    private String receiptNumber;
    private String bankNumber;
    private String externalAssetOwner;
    private transient Long savingTransactionId;

    public JournalEntryData() {
    }

    // for opening bal bulk import
    public JournalEntryData(Long officeId, LocalDate transactionDate, String currencyCode, List<CreditDebit> credits, List<CreditDebit> debits, String locale, String dateFormat) {
        this.officeId = officeId;
        this.dateFormat = dateFormat;
        this.locale = locale;
        this.transactionDate = transactionDate;
        this.currencyCode = currencyCode;
        this.credits = credits;
        this.debits = debits;
        this.rowIndex = null;
        this.paymentTypeId = null;
        this.accountNumber = null;
        this.checkNumber = null;
        this.routingCode = null;
        this.receiptNumber = null;
        this.bankNumber = null;
        this.comments = null;
        this.id = null;
        this.officeName = null;
        this.glAccountName = null;
        this.glAccountId = null;
        this.glAccountCode = null;
        this.glAccountType = null;
        this.entryType = null;
        this.amount = null;
        this.currency = null;
        this.transactionId = null;
        this.manualEntry = null;
        this.entityType = null;
        this.entityId = null;
        this.createdByUserId = null;
        this.createdDate = null;
        this.createdByUserName = null;
        this.reversed = null;
        this.referenceNumber = null;
        this.officeRunningBalance = null;
        this.organizationRunningBalance = null;
        this.runningBalanceComputed = null;
        this.transactionDetails = null;
        this.submittedOnDate = null;
    }

    private JournalEntryData(Long officeId, LocalDate transactionDate, String currencyCode, Long paymentTypeId, Integer rowIndex, List<CreditDebit> credits, List<CreditDebit> debits, String accountNumber, String checkNumber, String routingCode, String receiptNumber, String bankNumber, String comments, String locale, String dateFormat) {
        this.officeId = officeId;
        this.dateFormat = dateFormat;
        this.locale = locale;
        this.transactionDate = transactionDate;
        this.currencyCode = currencyCode;
        this.rowIndex = rowIndex;
        this.credits = credits;
        this.debits = debits;
        this.paymentTypeId = paymentTypeId;
        this.accountNumber = accountNumber;
        this.checkNumber = checkNumber;
        this.routingCode = routingCode;
        this.receiptNumber = receiptNumber;
        this.bankNumber = bankNumber;
        this.comments = comments;
        this.id = null;
        this.officeName = null;
        this.glAccountName = null;
        this.glAccountId = null;
        this.glAccountCode = null;
        this.glAccountType = null;
        this.entryType = null;
        this.amount = null;
        this.currency = null;
        this.transactionId = null;
        this.manualEntry = null;
        this.entityType = null;
        this.entityId = null;
        this.createdByUserId = null;
        this.submittedOnDate = null;
        this.createdDate = null;
        this.createdByUserName = null;
        this.reversed = null;
        this.referenceNumber = null;
        this.officeRunningBalance = null;
        this.organizationRunningBalance = null;
        this.runningBalanceComputed = null;
        this.transactionDetails = null;
    }

    public JournalEntryData(final Long id, final Long officeId, final String officeName, final String glAccountName, final Long glAccountId, final String glAccountCode, final EnumOptionData glAccountClassification, final LocalDate transactionDate, final EnumOptionData entryType, final BigDecimal amount, final String transactionId, final Boolean manualEntry, final EnumOptionData entityType, final Long entityId, final Long createdByUserId, final LocalDate submittedOnDate, final String createdByUserName, final String comments, final Boolean reversed, final String referenceNumber, final BigDecimal officeRunningBalance, final BigDecimal organizationRunningBalance, final Boolean runningBalanceComputed, final TransactionDetailData transactionDetailData, final CurrencyData currency, final String externalAssetOwner) {
        this.id = id;
        this.officeId = officeId;
        this.officeName = officeName;
        this.glAccountName = glAccountName;
        this.glAccountId = glAccountId;
        this.glAccountCode = glAccountCode;
        this.glAccountType = glAccountClassification;
        this.transactionDate = transactionDate;
        this.entryType = entryType;
        this.amount = amount;
        this.transactionId = transactionId;
        this.manualEntry = manualEntry;
        this.entityType = entityType;
        this.entityId = entityId;
        this.createdByUserId = createdByUserId;
        this.createdDate = submittedOnDate;
        this.submittedOnDate = submittedOnDate;
        this.createdByUserName = createdByUserName;
        this.comments = comments;
        this.reversed = reversed;
        this.referenceNumber = referenceNumber;
        this.officeRunningBalance = officeRunningBalance;
        this.organizationRunningBalance = organizationRunningBalance;
        this.runningBalanceComputed = runningBalanceComputed;
        this.transactionDetails = transactionDetailData;
        this.currency = currency;
        this.externalAssetOwner = externalAssetOwner;
    }

    public static JournalEntryData importInstance(Long officeId, LocalDate transactionDate, String currencyCode, Long paymentTypeId, Integer rowIndex, List<CreditDebit> credits, List<CreditDebit> debits, String accountNumber, String checkNumber, String routingCode, String receiptNumber, String bankNumber, String comments, String locale, String dateFormat) {
        return new JournalEntryData(officeId, transactionDate, currencyCode, paymentTypeId, rowIndex, credits, debits, accountNumber, checkNumber, routingCode, receiptNumber, bankNumber, comments, locale, dateFormat);
    }

    public static JournalEntryData importInstance1(Long officeId, LocalDate transactionDate, String currencyCode, List<CreditDebit> credits, List<CreditDebit> debits, String locale, String dateFormat) {
        return new JournalEntryData(officeId, transactionDate, currencyCode, credits, debits, locale, dateFormat);
    }

    public static JournalEntryData fromGLAccountData(final GLAccountData glAccountData) {
        final Long id = null;
        final Long officeId = null;
        final String officeName = null;
        final String glAccountName = glAccountData.getName();
        final Long glAccountId = glAccountData.getId();
        final String glAccountCode = glAccountData.getGlCode();
        final EnumOptionData glAccountClassification = glAccountData.getType();
        final LocalDate transactionDate = null;
        final EnumOptionData entryType = null;
        final BigDecimal amount = null;
        final String transactionId = null;
        final Boolean manualEntry = null;
        final EnumOptionData entityType = null;
        final Long entityId = null;
        final Long createdByUserId = null;
        final LocalDate submittedOnDate = null;
        final String createdByUserName = null;
        final String comments = null;
        final Boolean reversed = null;
        final String referenceNumber = null;
        final BigDecimal officeRunningBalance = null;
        final BigDecimal organizationRunningBalance = null;
        final Boolean runningBalanceComputed = null;
        final TransactionDetailData transactionDetailData = null;
        final CurrencyData currency = null;
        final String externalAssetOwner = null;
        return new JournalEntryData(id, officeId, officeName, glAccountName, glAccountId, glAccountCode, glAccountClassification, transactionDate, entryType, amount, transactionId, manualEntry, entityType, entityId, createdByUserId, submittedOnDate, createdByUserName, comments, reversed, referenceNumber, officeRunningBalance, organizationRunningBalance, runningBalanceComputed, transactionDetailData, currency, externalAssetOwner);
    }

    public Integer getRowIndex() {
        return rowIndex;
    }

    public LocalDate getTransactionDate() {
        return transactionDate;
    }

    public void addDebits(CreditDebit debit) {
        this.debits.add(debit);
    }

    public void addCredits(CreditDebit credit) {
        this.credits.add(credit);
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getOfficeName() {
        return this.officeName;
    }

    @java.lang.SuppressWarnings("all")
        public String getGlAccountName() {
        return this.glAccountName;
    }

    @java.lang.SuppressWarnings("all")
        public Long getGlAccountId() {
        return this.glAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public String getGlAccountCode() {
        return this.glAccountCode;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getGlAccountType() {
        return this.glAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getEntryType() {
        return this.entryType;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyData getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public String getTransactionId() {
        return this.transactionId;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getManualEntry() {
        return this.manualEntry;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getEntityType() {
        return this.entityType;
    }

    @java.lang.SuppressWarnings("all")
        public Long getEntityId() {
        return this.entityId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCreatedByUserId() {
        return this.createdByUserId;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getCreatedDate() {
        return this.createdDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreatedByUserName() {
        return this.createdByUserName;
    }

    @java.lang.SuppressWarnings("all")
        public String getComments() {
        return this.comments;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getReversed() {
        return this.reversed;
    }

    @java.lang.SuppressWarnings("all")
        public String getReferenceNumber() {
        return this.referenceNumber;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getOfficeRunningBalance() {
        return this.officeRunningBalance;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getOrganizationRunningBalance() {
        return this.organizationRunningBalance;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getRunningBalanceComputed() {
        return this.runningBalanceComputed;
    }

    @java.lang.SuppressWarnings("all")
        public TransactionDetailData getTransactionDetails() {
        return this.transactionDetails;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getSubmittedOnDate() {
        return this.submittedOnDate;
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
        public List<CreditDebit> getCredits() {
        return this.credits;
    }

    @java.lang.SuppressWarnings("all")
        public List<CreditDebit> getDebits() {
        return this.debits;
    }

    @java.lang.SuppressWarnings("all")
        public Long getPaymentTypeId() {
        return this.paymentTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public String getCurrencyCode() {
        return this.currencyCode;
    }

    @java.lang.SuppressWarnings("all")
        public String getAccountNumber() {
        return this.accountNumber;
    }

    @java.lang.SuppressWarnings("all")
        public String getCheckNumber() {
        return this.checkNumber;
    }

    @java.lang.SuppressWarnings("all")
        public String getRoutingCode() {
        return this.routingCode;
    }

    @java.lang.SuppressWarnings("all")
        public String getReceiptNumber() {
        return this.receiptNumber;
    }

    @java.lang.SuppressWarnings("all")
        public String getBankNumber() {
        return this.bankNumber;
    }

    @java.lang.SuppressWarnings("all")
        public String getExternalAssetOwner() {
        return this.externalAssetOwner;
    }

    @java.lang.SuppressWarnings("all")
        public Long getSavingTransactionId() {
        return this.savingTransactionId;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setOfficeId(final Long officeId) {
        this.officeId = officeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setOfficeName(final String officeName) {
        this.officeName = officeName;
    }

    @java.lang.SuppressWarnings("all")
        public void setGlAccountName(final String glAccountName) {
        this.glAccountName = glAccountName;
    }

    @java.lang.SuppressWarnings("all")
        public void setGlAccountId(final Long glAccountId) {
        this.glAccountId = glAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public void setGlAccountCode(final String glAccountCode) {
        this.glAccountCode = glAccountCode;
    }

    @java.lang.SuppressWarnings("all")
        public void setGlAccountType(final EnumOptionData glAccountType) {
        this.glAccountType = glAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransactionDate(final LocalDate transactionDate) {
        this.transactionDate = transactionDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setEntryType(final EnumOptionData entryType) {
        this.entryType = entryType;
    }

    @java.lang.SuppressWarnings("all")
        public void setAmount(final BigDecimal amount) {
        this.amount = amount;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrency(final CurrencyData currency) {
        this.currency = currency;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransactionId(final String transactionId) {
        this.transactionId = transactionId;
    }

    @java.lang.SuppressWarnings("all")
        public void setManualEntry(final Boolean manualEntry) {
        this.manualEntry = manualEntry;
    }

    @java.lang.SuppressWarnings("all")
        public void setEntityType(final EnumOptionData entityType) {
        this.entityType = entityType;
    }

    @java.lang.SuppressWarnings("all")
        public void setEntityId(final Long entityId) {
        this.entityId = entityId;
    }

    @java.lang.SuppressWarnings("all")
        public void setCreatedByUserId(final Long createdByUserId) {
        this.createdByUserId = createdByUserId;
    }

    @java.lang.SuppressWarnings("all")
        public void setCreatedDate(final LocalDate createdDate) {
        this.createdDate = createdDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setCreatedByUserName(final String createdByUserName) {
        this.createdByUserName = createdByUserName;
    }

    @java.lang.SuppressWarnings("all")
        public void setComments(final String comments) {
        this.comments = comments;
    }

    @java.lang.SuppressWarnings("all")
        public void setReversed(final Boolean reversed) {
        this.reversed = reversed;
    }

    @java.lang.SuppressWarnings("all")
        public void setReferenceNumber(final String referenceNumber) {
        this.referenceNumber = referenceNumber;
    }

    @java.lang.SuppressWarnings("all")
        public void setOfficeRunningBalance(final BigDecimal officeRunningBalance) {
        this.officeRunningBalance = officeRunningBalance;
    }

    @java.lang.SuppressWarnings("all")
        public void setOrganizationRunningBalance(final BigDecimal organizationRunningBalance) {
        this.organizationRunningBalance = organizationRunningBalance;
    }

    @java.lang.SuppressWarnings("all")
        public void setRunningBalanceComputed(final Boolean runningBalanceComputed) {
        this.runningBalanceComputed = runningBalanceComputed;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransactionDetails(final TransactionDetailData transactionDetails) {
        this.transactionDetails = transactionDetails;
    }

    @java.lang.SuppressWarnings("all")
        public void setSubmittedOnDate(final LocalDate submittedOnDate) {
        this.submittedOnDate = submittedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setRowIndex(final Integer rowIndex) {
        this.rowIndex = rowIndex;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setCredits(final List<CreditDebit> credits) {
        this.credits = credits;
    }

    @java.lang.SuppressWarnings("all")
        public void setDebits(final List<CreditDebit> debits) {
        this.debits = debits;
    }

    @java.lang.SuppressWarnings("all")
        public void setPaymentTypeId(final Long paymentTypeId) {
        this.paymentTypeId = paymentTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrencyCode(final String currencyCode) {
        this.currencyCode = currencyCode;
    }

    @java.lang.SuppressWarnings("all")
        public void setAccountNumber(final String accountNumber) {
        this.accountNumber = accountNumber;
    }

    @java.lang.SuppressWarnings("all")
        public void setCheckNumber(final String checkNumber) {
        this.checkNumber = checkNumber;
    }

    @java.lang.SuppressWarnings("all")
        public void setRoutingCode(final String routingCode) {
        this.routingCode = routingCode;
    }

    @java.lang.SuppressWarnings("all")
        public void setReceiptNumber(final String receiptNumber) {
        this.receiptNumber = receiptNumber;
    }

    @java.lang.SuppressWarnings("all")
        public void setBankNumber(final String bankNumber) {
        this.bankNumber = bankNumber;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalAssetOwner(final String externalAssetOwner) {
        this.externalAssetOwner = externalAssetOwner;
    }

    @java.lang.SuppressWarnings("all")
        public void setSavingTransactionId(final Long savingTransactionId) {
        this.savingTransactionId = savingTransactionId;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof JournalEntryData)) return false;
        final JournalEntryData other = (JournalEntryData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$officeId = this.getOfficeId();
        final java.lang.Object other$officeId = other.getOfficeId();
        if (this$officeId == null ? other$officeId != null : !this$officeId.equals(other$officeId)) return false;
        final java.lang.Object this$glAccountId = this.getGlAccountId();
        final java.lang.Object other$glAccountId = other.getGlAccountId();
        if (this$glAccountId == null ? other$glAccountId != null : !this$glAccountId.equals(other$glAccountId)) return false;
        final java.lang.Object this$manualEntry = this.getManualEntry();
        final java.lang.Object other$manualEntry = other.getManualEntry();
        if (this$manualEntry == null ? other$manualEntry != null : !this$manualEntry.equals(other$manualEntry)) return false;
        final java.lang.Object this$entityId = this.getEntityId();
        final java.lang.Object other$entityId = other.getEntityId();
        if (this$entityId == null ? other$entityId != null : !this$entityId.equals(other$entityId)) return false;
        final java.lang.Object this$createdByUserId = this.getCreatedByUserId();
        final java.lang.Object other$createdByUserId = other.getCreatedByUserId();
        if (this$createdByUserId == null ? other$createdByUserId != null : !this$createdByUserId.equals(other$createdByUserId)) return false;
        final java.lang.Object this$reversed = this.getReversed();
        final java.lang.Object other$reversed = other.getReversed();
        if (this$reversed == null ? other$reversed != null : !this$reversed.equals(other$reversed)) return false;
        final java.lang.Object this$runningBalanceComputed = this.getRunningBalanceComputed();
        final java.lang.Object other$runningBalanceComputed = other.getRunningBalanceComputed();
        if (this$runningBalanceComputed == null ? other$runningBalanceComputed != null : !this$runningBalanceComputed.equals(other$runningBalanceComputed)) return false;
        final java.lang.Object this$paymentTypeId = this.getPaymentTypeId();
        final java.lang.Object other$paymentTypeId = other.getPaymentTypeId();
        if (this$paymentTypeId == null ? other$paymentTypeId != null : !this$paymentTypeId.equals(other$paymentTypeId)) return false;
        final java.lang.Object this$officeName = this.getOfficeName();
        final java.lang.Object other$officeName = other.getOfficeName();
        if (this$officeName == null ? other$officeName != null : !this$officeName.equals(other$officeName)) return false;
        final java.lang.Object this$glAccountName = this.getGlAccountName();
        final java.lang.Object other$glAccountName = other.getGlAccountName();
        if (this$glAccountName == null ? other$glAccountName != null : !this$glAccountName.equals(other$glAccountName)) return false;
        final java.lang.Object this$glAccountCode = this.getGlAccountCode();
        final java.lang.Object other$glAccountCode = other.getGlAccountCode();
        if (this$glAccountCode == null ? other$glAccountCode != null : !this$glAccountCode.equals(other$glAccountCode)) return false;
        final java.lang.Object this$glAccountType = this.getGlAccountType();
        final java.lang.Object other$glAccountType = other.getGlAccountType();
        if (this$glAccountType == null ? other$glAccountType != null : !this$glAccountType.equals(other$glAccountType)) return false;
        final java.lang.Object this$transactionDate = this.getTransactionDate();
        final java.lang.Object other$transactionDate = other.getTransactionDate();
        if (this$transactionDate == null ? other$transactionDate != null : !this$transactionDate.equals(other$transactionDate)) return false;
        final java.lang.Object this$entryType = this.getEntryType();
        final java.lang.Object other$entryType = other.getEntryType();
        if (this$entryType == null ? other$entryType != null : !this$entryType.equals(other$entryType)) return false;
        final java.lang.Object this$amount = this.getAmount();
        final java.lang.Object other$amount = other.getAmount();
        if (this$amount == null ? other$amount != null : !this$amount.equals(other$amount)) return false;
        final java.lang.Object this$currency = this.getCurrency();
        final java.lang.Object other$currency = other.getCurrency();
        if (this$currency == null ? other$currency != null : !this$currency.equals(other$currency)) return false;
        final java.lang.Object this$transactionId = this.getTransactionId();
        final java.lang.Object other$transactionId = other.getTransactionId();
        if (this$transactionId == null ? other$transactionId != null : !this$transactionId.equals(other$transactionId)) return false;
        final java.lang.Object this$entityType = this.getEntityType();
        final java.lang.Object other$entityType = other.getEntityType();
        if (this$entityType == null ? other$entityType != null : !this$entityType.equals(other$entityType)) return false;
        final java.lang.Object this$createdDate = this.getCreatedDate();
        final java.lang.Object other$createdDate = other.getCreatedDate();
        if (this$createdDate == null ? other$createdDate != null : !this$createdDate.equals(other$createdDate)) return false;
        final java.lang.Object this$createdByUserName = this.getCreatedByUserName();
        final java.lang.Object other$createdByUserName = other.getCreatedByUserName();
        if (this$createdByUserName == null ? other$createdByUserName != null : !this$createdByUserName.equals(other$createdByUserName)) return false;
        final java.lang.Object this$comments = this.getComments();
        final java.lang.Object other$comments = other.getComments();
        if (this$comments == null ? other$comments != null : !this$comments.equals(other$comments)) return false;
        final java.lang.Object this$referenceNumber = this.getReferenceNumber();
        final java.lang.Object other$referenceNumber = other.getReferenceNumber();
        if (this$referenceNumber == null ? other$referenceNumber != null : !this$referenceNumber.equals(other$referenceNumber)) return false;
        final java.lang.Object this$officeRunningBalance = this.getOfficeRunningBalance();
        final java.lang.Object other$officeRunningBalance = other.getOfficeRunningBalance();
        if (this$officeRunningBalance == null ? other$officeRunningBalance != null : !this$officeRunningBalance.equals(other$officeRunningBalance)) return false;
        final java.lang.Object this$organizationRunningBalance = this.getOrganizationRunningBalance();
        final java.lang.Object other$organizationRunningBalance = other.getOrganizationRunningBalance();
        if (this$organizationRunningBalance == null ? other$organizationRunningBalance != null : !this$organizationRunningBalance.equals(other$organizationRunningBalance)) return false;
        final java.lang.Object this$transactionDetails = this.getTransactionDetails();
        final java.lang.Object other$transactionDetails = other.getTransactionDetails();
        if (this$transactionDetails == null ? other$transactionDetails != null : !this$transactionDetails.equals(other$transactionDetails)) return false;
        final java.lang.Object this$submittedOnDate = this.getSubmittedOnDate();
        final java.lang.Object other$submittedOnDate = other.getSubmittedOnDate();
        if (this$submittedOnDate == null ? other$submittedOnDate != null : !this$submittedOnDate.equals(other$submittedOnDate)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$credits = this.getCredits();
        final java.lang.Object other$credits = other.getCredits();
        if (this$credits == null ? other$credits != null : !this$credits.equals(other$credits)) return false;
        final java.lang.Object this$debits = this.getDebits();
        final java.lang.Object other$debits = other.getDebits();
        if (this$debits == null ? other$debits != null : !this$debits.equals(other$debits)) return false;
        final java.lang.Object this$currencyCode = this.getCurrencyCode();
        final java.lang.Object other$currencyCode = other.getCurrencyCode();
        if (this$currencyCode == null ? other$currencyCode != null : !this$currencyCode.equals(other$currencyCode)) return false;
        final java.lang.Object this$accountNumber = this.getAccountNumber();
        final java.lang.Object other$accountNumber = other.getAccountNumber();
        if (this$accountNumber == null ? other$accountNumber != null : !this$accountNumber.equals(other$accountNumber)) return false;
        final java.lang.Object this$checkNumber = this.getCheckNumber();
        final java.lang.Object other$checkNumber = other.getCheckNumber();
        if (this$checkNumber == null ? other$checkNumber != null : !this$checkNumber.equals(other$checkNumber)) return false;
        final java.lang.Object this$routingCode = this.getRoutingCode();
        final java.lang.Object other$routingCode = other.getRoutingCode();
        if (this$routingCode == null ? other$routingCode != null : !this$routingCode.equals(other$routingCode)) return false;
        final java.lang.Object this$receiptNumber = this.getReceiptNumber();
        final java.lang.Object other$receiptNumber = other.getReceiptNumber();
        if (this$receiptNumber == null ? other$receiptNumber != null : !this$receiptNumber.equals(other$receiptNumber)) return false;
        final java.lang.Object this$bankNumber = this.getBankNumber();
        final java.lang.Object other$bankNumber = other.getBankNumber();
        if (this$bankNumber == null ? other$bankNumber != null : !this$bankNumber.equals(other$bankNumber)) return false;
        final java.lang.Object this$externalAssetOwner = this.getExternalAssetOwner();
        final java.lang.Object other$externalAssetOwner = other.getExternalAssetOwner();
        if (this$externalAssetOwner == null ? other$externalAssetOwner != null : !this$externalAssetOwner.equals(other$externalAssetOwner)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof JournalEntryData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $officeId = this.getOfficeId();
        result = result * PRIME + ($officeId == null ? 43 : $officeId.hashCode());
        final java.lang.Object $glAccountId = this.getGlAccountId();
        result = result * PRIME + ($glAccountId == null ? 43 : $glAccountId.hashCode());
        final java.lang.Object $manualEntry = this.getManualEntry();
        result = result * PRIME + ($manualEntry == null ? 43 : $manualEntry.hashCode());
        final java.lang.Object $entityId = this.getEntityId();
        result = result * PRIME + ($entityId == null ? 43 : $entityId.hashCode());
        final java.lang.Object $createdByUserId = this.getCreatedByUserId();
        result = result * PRIME + ($createdByUserId == null ? 43 : $createdByUserId.hashCode());
        final java.lang.Object $reversed = this.getReversed();
        result = result * PRIME + ($reversed == null ? 43 : $reversed.hashCode());
        final java.lang.Object $runningBalanceComputed = this.getRunningBalanceComputed();
        result = result * PRIME + ($runningBalanceComputed == null ? 43 : $runningBalanceComputed.hashCode());
        final java.lang.Object $paymentTypeId = this.getPaymentTypeId();
        result = result * PRIME + ($paymentTypeId == null ? 43 : $paymentTypeId.hashCode());
        final java.lang.Object $officeName = this.getOfficeName();
        result = result * PRIME + ($officeName == null ? 43 : $officeName.hashCode());
        final java.lang.Object $glAccountName = this.getGlAccountName();
        result = result * PRIME + ($glAccountName == null ? 43 : $glAccountName.hashCode());
        final java.lang.Object $glAccountCode = this.getGlAccountCode();
        result = result * PRIME + ($glAccountCode == null ? 43 : $glAccountCode.hashCode());
        final java.lang.Object $glAccountType = this.getGlAccountType();
        result = result * PRIME + ($glAccountType == null ? 43 : $glAccountType.hashCode());
        final java.lang.Object $transactionDate = this.getTransactionDate();
        result = result * PRIME + ($transactionDate == null ? 43 : $transactionDate.hashCode());
        final java.lang.Object $entryType = this.getEntryType();
        result = result * PRIME + ($entryType == null ? 43 : $entryType.hashCode());
        final java.lang.Object $amount = this.getAmount();
        result = result * PRIME + ($amount == null ? 43 : $amount.hashCode());
        final java.lang.Object $currency = this.getCurrency();
        result = result * PRIME + ($currency == null ? 43 : $currency.hashCode());
        final java.lang.Object $transactionId = this.getTransactionId();
        result = result * PRIME + ($transactionId == null ? 43 : $transactionId.hashCode());
        final java.lang.Object $entityType = this.getEntityType();
        result = result * PRIME + ($entityType == null ? 43 : $entityType.hashCode());
        final java.lang.Object $createdDate = this.getCreatedDate();
        result = result * PRIME + ($createdDate == null ? 43 : $createdDate.hashCode());
        final java.lang.Object $createdByUserName = this.getCreatedByUserName();
        result = result * PRIME + ($createdByUserName == null ? 43 : $createdByUserName.hashCode());
        final java.lang.Object $comments = this.getComments();
        result = result * PRIME + ($comments == null ? 43 : $comments.hashCode());
        final java.lang.Object $referenceNumber = this.getReferenceNumber();
        result = result * PRIME + ($referenceNumber == null ? 43 : $referenceNumber.hashCode());
        final java.lang.Object $officeRunningBalance = this.getOfficeRunningBalance();
        result = result * PRIME + ($officeRunningBalance == null ? 43 : $officeRunningBalance.hashCode());
        final java.lang.Object $organizationRunningBalance = this.getOrganizationRunningBalance();
        result = result * PRIME + ($organizationRunningBalance == null ? 43 : $organizationRunningBalance.hashCode());
        final java.lang.Object $transactionDetails = this.getTransactionDetails();
        result = result * PRIME + ($transactionDetails == null ? 43 : $transactionDetails.hashCode());
        final java.lang.Object $submittedOnDate = this.getSubmittedOnDate();
        result = result * PRIME + ($submittedOnDate == null ? 43 : $submittedOnDate.hashCode());
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $credits = this.getCredits();
        result = result * PRIME + ($credits == null ? 43 : $credits.hashCode());
        final java.lang.Object $debits = this.getDebits();
        result = result * PRIME + ($debits == null ? 43 : $debits.hashCode());
        final java.lang.Object $currencyCode = this.getCurrencyCode();
        result = result * PRIME + ($currencyCode == null ? 43 : $currencyCode.hashCode());
        final java.lang.Object $accountNumber = this.getAccountNumber();
        result = result * PRIME + ($accountNumber == null ? 43 : $accountNumber.hashCode());
        final java.lang.Object $checkNumber = this.getCheckNumber();
        result = result * PRIME + ($checkNumber == null ? 43 : $checkNumber.hashCode());
        final java.lang.Object $routingCode = this.getRoutingCode();
        result = result * PRIME + ($routingCode == null ? 43 : $routingCode.hashCode());
        final java.lang.Object $receiptNumber = this.getReceiptNumber();
        result = result * PRIME + ($receiptNumber == null ? 43 : $receiptNumber.hashCode());
        final java.lang.Object $bankNumber = this.getBankNumber();
        result = result * PRIME + ($bankNumber == null ? 43 : $bankNumber.hashCode());
        final java.lang.Object $externalAssetOwner = this.getExternalAssetOwner();
        result = result * PRIME + ($externalAssetOwner == null ? 43 : $externalAssetOwner.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "JournalEntryData(id=" + this.getId() + ", officeId=" + this.getOfficeId() + ", officeName=" + this.getOfficeName() + ", glAccountName=" + this.getGlAccountName() + ", glAccountId=" + this.getGlAccountId() + ", glAccountCode=" + this.getGlAccountCode() + ", glAccountType=" + this.getGlAccountType() + ", transactionDate=" + this.getTransactionDate() + ", entryType=" + this.getEntryType() + ", amount=" + this.getAmount() + ", currency=" + this.getCurrency() + ", transactionId=" + this.getTransactionId() + ", manualEntry=" + this.getManualEntry() + ", entityType=" + this.getEntityType() + ", entityId=" + this.getEntityId() + ", createdByUserId=" + this.getCreatedByUserId() + ", createdDate=" + this.getCreatedDate() + ", createdByUserName=" + this.getCreatedByUserName() + ", comments=" + this.getComments() + ", reversed=" + this.getReversed() + ", referenceNumber=" + this.getReferenceNumber() + ", officeRunningBalance=" + this.getOfficeRunningBalance() + ", organizationRunningBalance=" + this.getOrganizationRunningBalance() + ", runningBalanceComputed=" + this.getRunningBalanceComputed() + ", transactionDetails=" + this.getTransactionDetails() + ", submittedOnDate=" + this.getSubmittedOnDate() + ", rowIndex=" + this.getRowIndex() + ", dateFormat=" + this.getDateFormat() + ", locale=" + this.getLocale() + ", credits=" + this.getCredits() + ", debits=" + this.getDebits() + ", paymentTypeId=" + this.getPaymentTypeId() + ", currencyCode=" + this.getCurrencyCode() + ", accountNumber=" + this.getAccountNumber() + ", checkNumber=" + this.getCheckNumber() + ", routingCode=" + this.getRoutingCode() + ", receiptNumber=" + this.getReceiptNumber() + ", bankNumber=" + this.getBankNumber() + ", externalAssetOwner=" + this.getExternalAssetOwner() + ", savingTransactionId=" + this.getSavingTransactionId() + ")";
    }
}
