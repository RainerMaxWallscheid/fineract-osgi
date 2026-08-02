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
package org.apache.fineract.accounting.journalentry.command;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import org.apache.fineract.accounting.journalentry.api.JournalEntryJsonInputParams;
import org.apache.fineract.infrastructure.core.data.ApiParameterError;
import org.apache.fineract.infrastructure.core.data.DataValidatorBuilder;
import org.apache.fineract.infrastructure.core.exception.PlatformApiDataValidationException;

/**
 * Immutable command for adding an accounting closure
 */
public class JournalEntryCommand {
    private final Long officeId;
    private final String currencyCode;
    private final LocalDate transactionDate;
    private final String comments;
    private final String referenceNumber;
    private final Long accountingRuleId;
    private final BigDecimal amount;
    private final Long paymentTypeId;
    private final String accountNumber;
    private final String checkNumber;
    private final String receiptNumber;
    private final String bankNumber;
    private final String routingCode;
    private final SingleDebitOrCreditEntryCommand[] credits;
    private final SingleDebitOrCreditEntryCommand[] debits;
    private final String locale;
    private final String dateFormat;
    private final String externalAssetOwner;

    public void validateForCreate() {
        final List<ApiParameterError> dataValidationErrors = new ArrayList<>();
        final DataValidatorBuilder baseDataValidator = new DataValidatorBuilder(dataValidationErrors).resource("GLJournalEntry");
        baseDataValidator.reset().parameter("transactionDate").value(this.transactionDate).notBlank();
        baseDataValidator.reset().parameter("officeId").value(this.officeId).notNull().integerGreaterThanZero();
        baseDataValidator.reset().parameter(JournalEntryJsonInputParams.CURRENCY_CODE.getValue()).value(this.currencyCode).notBlank();
        baseDataValidator.reset().parameter("comments").value(this.comments).ignoreIfNull().notExceedingLengthOf(500);
        baseDataValidator.reset().parameter("referenceNumber").value(this.referenceNumber).ignoreIfNull().notExceedingLengthOf(100);
        baseDataValidator.reset().parameter("accountingRule").value(this.accountingRuleId).ignoreIfNull().longGreaterThanZero();
        baseDataValidator.reset().parameter("paymentTypeId").value(this.paymentTypeId).ignoreIfNull().longGreaterThanZero();
        baseDataValidator.reset().parameter(JournalEntryJsonInputParams.EXTERNAL_ASSET_OWNER.getValue()).value(this.externalAssetOwner).ignoreIfNull().notExceedingLengthOf(100);
        // validation for credit array elements
        if (this.credits != null) {
            if (this.credits.length == 0) {
                validateSingleDebitOrCredit(baseDataValidator, "credits", 0, new SingleDebitOrCreditEntryCommand(null, null, null, null));
            } else {
                int i = 0;
                for (final SingleDebitOrCreditEntryCommand credit : this.credits) {
                    validateSingleDebitOrCredit(baseDataValidator, "credits", i, credit);
                    i++;
                }
            }
        }
        // validation for debit array elements
        if (this.debits != null) {
            if (this.debits.length == 0) {
                validateSingleDebitOrCredit(baseDataValidator, "debits", 0, new SingleDebitOrCreditEntryCommand(null, null, null, null));
            } else {
                int i = 0;
                for (final SingleDebitOrCreditEntryCommand debit : this.debits) {
                    validateSingleDebitOrCredit(baseDataValidator, "debits", i, debit);
                    i++;
                }
            }
        }
        baseDataValidator.reset().parameter("amount").value(this.amount).ignoreIfNull().zeroOrPositiveAmount();
        if (!dataValidationErrors.isEmpty()) {
            throw new PlatformApiDataValidationException("validation.msg.validation.errors.exist", "Validation errors exist.", dataValidationErrors);
        }
    }

    /**
     * @param baseDataValidator
     * @param i
     * @param credit
     */
    private void validateSingleDebitOrCredit(final DataValidatorBuilder baseDataValidator, final String paramSuffix, final int arrayPos, final SingleDebitOrCreditEntryCommand credit) {
        baseDataValidator.reset().parameter(paramSuffix + "[" + arrayPos + "].glAccountId").value(credit.getGlAccountId()).notNull().integerGreaterThanZero();
        baseDataValidator.reset().parameter(paramSuffix + "[" + arrayPos + "].amount").value(credit.getAmount()).notNull().zeroOrPositiveAmount();
    }

    @java.lang.SuppressWarnings("all")
        public JournalEntryCommand(final Long officeId, final String currencyCode, final LocalDate transactionDate, final String comments, final String referenceNumber, final Long accountingRuleId, final BigDecimal amount, final Long paymentTypeId, final String accountNumber, final String checkNumber, final String receiptNumber, final String bankNumber, final String routingCode, final SingleDebitOrCreditEntryCommand[] credits, final SingleDebitOrCreditEntryCommand[] debits, final String locale, final String dateFormat, final String externalAssetOwner) {
        this.officeId = officeId;
        this.currencyCode = currencyCode;
        this.transactionDate = transactionDate;
        this.comments = comments;
        this.referenceNumber = referenceNumber;
        this.accountingRuleId = accountingRuleId;
        this.amount = amount;
        this.paymentTypeId = paymentTypeId;
        this.accountNumber = accountNumber;
        this.checkNumber = checkNumber;
        this.receiptNumber = receiptNumber;
        this.bankNumber = bankNumber;
        this.routingCode = routingCode;
        this.credits = credits;
        this.debits = debits;
        this.locale = locale;
        this.dateFormat = dateFormat;
        this.externalAssetOwner = externalAssetOwner;
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
        public LocalDate getTransactionDate() {
        return this.transactionDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getComments() {
        return this.comments;
    }

    @java.lang.SuppressWarnings("all")
        public String getReferenceNumber() {
        return this.referenceNumber;
    }

    @java.lang.SuppressWarnings("all")
        public Long getAccountingRuleId() {
        return this.accountingRuleId;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public Long getPaymentTypeId() {
        return this.paymentTypeId;
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
        public String getReceiptNumber() {
        return this.receiptNumber;
    }

    @java.lang.SuppressWarnings("all")
        public String getBankNumber() {
        return this.bankNumber;
    }

    @java.lang.SuppressWarnings("all")
        public String getRoutingCode() {
        return this.routingCode;
    }

    @java.lang.SuppressWarnings("all")
        public SingleDebitOrCreditEntryCommand[] getCredits() {
        return this.credits;
    }

    @java.lang.SuppressWarnings("all")
        public SingleDebitOrCreditEntryCommand[] getDebits() {
        return this.debits;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getExternalAssetOwner() {
        return this.externalAssetOwner;
    }
}
