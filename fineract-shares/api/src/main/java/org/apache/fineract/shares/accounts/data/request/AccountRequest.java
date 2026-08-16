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
package org.apache.fineract.shares.accounts.data.request;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.List;

public class AccountRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private BigDecimal unitPrice;
    private Long clientId;
    private Long productId;
    private Integer digitsAfterDecimal;
    private Long requestedShares;
    private String dateFormat;
    private Integer minimumActivePeriod;
    private Long numberOfShares;
    private String allowDividendCalculationForInactiveClients;
    private String externalId;
    private String minimumActivePeriodFrequencyType;
    private Long savingsAccountId;
    private String locale;
    private String submittedDate;
    private String approvedDate;
    private List<AccountChargesRequest> charges;
    private String lockinPeriodFrequencyType;
    private String inMultiplesOf;
    private String purchasedDate;
    private Integer lockinPeriodFrequency;
    private Long id;
    private String currencyCode;
    private String applicationDate;

    @java.lang.SuppressWarnings("all")
        public BigDecimal getUnitPrice() {
        return this.unitPrice;
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientId() {
        return this.clientId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getProductId() {
        return this.productId;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getDigitsAfterDecimal() {
        return this.digitsAfterDecimal;
    }

    @java.lang.SuppressWarnings("all")
        public Long getRequestedShares() {
        return this.requestedShares;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getMinimumActivePeriod() {
        return this.minimumActivePeriod;
    }

    @java.lang.SuppressWarnings("all")
        public Long getNumberOfShares() {
        return this.numberOfShares;
    }

    @java.lang.SuppressWarnings("all")
        public String getAllowDividendCalculationForInactiveClients() {
        return this.allowDividendCalculationForInactiveClients;
    }

    @java.lang.SuppressWarnings("all")
        public String getExternalId() {
        return this.externalId;
    }

    @java.lang.SuppressWarnings("all")
        public String getMinimumActivePeriodFrequencyType() {
        return this.minimumActivePeriodFrequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public Long getSavingsAccountId() {
        return this.savingsAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public String getSubmittedDate() {
        return this.submittedDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getApprovedDate() {
        return this.approvedDate;
    }

    @java.lang.SuppressWarnings("all")
        public List<AccountChargesRequest> getCharges() {
        return this.charges;
    }

    @java.lang.SuppressWarnings("all")
        public String getLockinPeriodFrequencyType() {
        return this.lockinPeriodFrequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public String getInMultiplesOf() {
        return this.inMultiplesOf;
    }

    @java.lang.SuppressWarnings("all")
        public String getPurchasedDate() {
        return this.purchasedDate;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getLockinPeriodFrequency() {
        return this.lockinPeriodFrequency;
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getCurrencyCode() {
        return this.currencyCode;
    }

    @java.lang.SuppressWarnings("all")
        public String getApplicationDate() {
        return this.applicationDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setUnitPrice(final BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientId(final Long clientId) {
        this.clientId = clientId;
    }

    @java.lang.SuppressWarnings("all")
        public void setProductId(final Long productId) {
        this.productId = productId;
    }

    @java.lang.SuppressWarnings("all")
        public void setDigitsAfterDecimal(final Integer digitsAfterDecimal) {
        this.digitsAfterDecimal = digitsAfterDecimal;
    }

    @java.lang.SuppressWarnings("all")
        public void setRequestedShares(final Long requestedShares) {
        this.requestedShares = requestedShares;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinimumActivePeriod(final Integer minimumActivePeriod) {
        this.minimumActivePeriod = minimumActivePeriod;
    }

    @java.lang.SuppressWarnings("all")
        public void setNumberOfShares(final Long numberOfShares) {
        this.numberOfShares = numberOfShares;
    }

    @java.lang.SuppressWarnings("all")
        public void setAllowDividendCalculationForInactiveClients(final String allowDividendCalculationForInactiveClients) {
        this.allowDividendCalculationForInactiveClients = allowDividendCalculationForInactiveClients;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalId(final String externalId) {
        this.externalId = externalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinimumActivePeriodFrequencyType(final String minimumActivePeriodFrequencyType) {
        this.minimumActivePeriodFrequencyType = minimumActivePeriodFrequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public void setSavingsAccountId(final Long savingsAccountId) {
        this.savingsAccountId = savingsAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setSubmittedDate(final String submittedDate) {
        this.submittedDate = submittedDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setApprovedDate(final String approvedDate) {
        this.approvedDate = approvedDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setCharges(final List<AccountChargesRequest> charges) {
        this.charges = charges;
    }

    @java.lang.SuppressWarnings("all")
        public void setLockinPeriodFrequencyType(final String lockinPeriodFrequencyType) {
        this.lockinPeriodFrequencyType = lockinPeriodFrequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public void setInMultiplesOf(final String inMultiplesOf) {
        this.inMultiplesOf = inMultiplesOf;
    }

    @java.lang.SuppressWarnings("all")
        public void setPurchasedDate(final String purchasedDate) {
        this.purchasedDate = purchasedDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setLockinPeriodFrequency(final Integer lockinPeriodFrequency) {
        this.lockinPeriodFrequency = lockinPeriodFrequency;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrencyCode(final String currencyCode) {
        this.currencyCode = currencyCode;
    }

    @java.lang.SuppressWarnings("all")
        public void setApplicationDate(final String applicationDate) {
        this.applicationDate = applicationDate;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof AccountRequest)) return false;
        final AccountRequest other = (AccountRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$clientId = this.getClientId();
        final java.lang.Object other$clientId = other.getClientId();
        if (this$clientId == null ? other$clientId != null : !this$clientId.equals(other$clientId)) return false;
        final java.lang.Object this$productId = this.getProductId();
        final java.lang.Object other$productId = other.getProductId();
        if (this$productId == null ? other$productId != null : !this$productId.equals(other$productId)) return false;
        final java.lang.Object this$digitsAfterDecimal = this.getDigitsAfterDecimal();
        final java.lang.Object other$digitsAfterDecimal = other.getDigitsAfterDecimal();
        if (this$digitsAfterDecimal == null ? other$digitsAfterDecimal != null : !this$digitsAfterDecimal.equals(other$digitsAfterDecimal)) return false;
        final java.lang.Object this$requestedShares = this.getRequestedShares();
        final java.lang.Object other$requestedShares = other.getRequestedShares();
        if (this$requestedShares == null ? other$requestedShares != null : !this$requestedShares.equals(other$requestedShares)) return false;
        final java.lang.Object this$minimumActivePeriod = this.getMinimumActivePeriod();
        final java.lang.Object other$minimumActivePeriod = other.getMinimumActivePeriod();
        if (this$minimumActivePeriod == null ? other$minimumActivePeriod != null : !this$minimumActivePeriod.equals(other$minimumActivePeriod)) return false;
        final java.lang.Object this$numberOfShares = this.getNumberOfShares();
        final java.lang.Object other$numberOfShares = other.getNumberOfShares();
        if (this$numberOfShares == null ? other$numberOfShares != null : !this$numberOfShares.equals(other$numberOfShares)) return false;
        final java.lang.Object this$savingsAccountId = this.getSavingsAccountId();
        final java.lang.Object other$savingsAccountId = other.getSavingsAccountId();
        if (this$savingsAccountId == null ? other$savingsAccountId != null : !this$savingsAccountId.equals(other$savingsAccountId)) return false;
        final java.lang.Object this$lockinPeriodFrequency = this.getLockinPeriodFrequency();
        final java.lang.Object other$lockinPeriodFrequency = other.getLockinPeriodFrequency();
        if (this$lockinPeriodFrequency == null ? other$lockinPeriodFrequency != null : !this$lockinPeriodFrequency.equals(other$lockinPeriodFrequency)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$unitPrice = this.getUnitPrice();
        final java.lang.Object other$unitPrice = other.getUnitPrice();
        if (this$unitPrice == null ? other$unitPrice != null : !this$unitPrice.equals(other$unitPrice)) return false;
        final java.lang.Object this$dateFormat = this.getDateFormat();
        final java.lang.Object other$dateFormat = other.getDateFormat();
        if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
        final java.lang.Object this$allowDividendCalculationForInactiveClients = this.getAllowDividendCalculationForInactiveClients();
        final java.lang.Object other$allowDividendCalculationForInactiveClients = other.getAllowDividendCalculationForInactiveClients();
        if (this$allowDividendCalculationForInactiveClients == null ? other$allowDividendCalculationForInactiveClients != null : !this$allowDividendCalculationForInactiveClients.equals(other$allowDividendCalculationForInactiveClients)) return false;
        final java.lang.Object this$externalId = this.getExternalId();
        final java.lang.Object other$externalId = other.getExternalId();
        if (this$externalId == null ? other$externalId != null : !this$externalId.equals(other$externalId)) return false;
        final java.lang.Object this$minimumActivePeriodFrequencyType = this.getMinimumActivePeriodFrequencyType();
        final java.lang.Object other$minimumActivePeriodFrequencyType = other.getMinimumActivePeriodFrequencyType();
        if (this$minimumActivePeriodFrequencyType == null ? other$minimumActivePeriodFrequencyType != null : !this$minimumActivePeriodFrequencyType.equals(other$minimumActivePeriodFrequencyType)) return false;
        final java.lang.Object this$locale = this.getLocale();
        final java.lang.Object other$locale = other.getLocale();
        if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
        final java.lang.Object this$submittedDate = this.getSubmittedDate();
        final java.lang.Object other$submittedDate = other.getSubmittedDate();
        if (this$submittedDate == null ? other$submittedDate != null : !this$submittedDate.equals(other$submittedDate)) return false;
        final java.lang.Object this$approvedDate = this.getApprovedDate();
        final java.lang.Object other$approvedDate = other.getApprovedDate();
        if (this$approvedDate == null ? other$approvedDate != null : !this$approvedDate.equals(other$approvedDate)) return false;
        final java.lang.Object this$charges = this.getCharges();
        final java.lang.Object other$charges = other.getCharges();
        if (this$charges == null ? other$charges != null : !this$charges.equals(other$charges)) return false;
        final java.lang.Object this$lockinPeriodFrequencyType = this.getLockinPeriodFrequencyType();
        final java.lang.Object other$lockinPeriodFrequencyType = other.getLockinPeriodFrequencyType();
        if (this$lockinPeriodFrequencyType == null ? other$lockinPeriodFrequencyType != null : !this$lockinPeriodFrequencyType.equals(other$lockinPeriodFrequencyType)) return false;
        final java.lang.Object this$inMultiplesOf = this.getInMultiplesOf();
        final java.lang.Object other$inMultiplesOf = other.getInMultiplesOf();
        if (this$inMultiplesOf == null ? other$inMultiplesOf != null : !this$inMultiplesOf.equals(other$inMultiplesOf)) return false;
        final java.lang.Object this$purchasedDate = this.getPurchasedDate();
        final java.lang.Object other$purchasedDate = other.getPurchasedDate();
        if (this$purchasedDate == null ? other$purchasedDate != null : !this$purchasedDate.equals(other$purchasedDate)) return false;
        final java.lang.Object this$currencyCode = this.getCurrencyCode();
        final java.lang.Object other$currencyCode = other.getCurrencyCode();
        if (this$currencyCode == null ? other$currencyCode != null : !this$currencyCode.equals(other$currencyCode)) return false;
        final java.lang.Object this$applicationDate = this.getApplicationDate();
        final java.lang.Object other$applicationDate = other.getApplicationDate();
        if (this$applicationDate == null ? other$applicationDate != null : !this$applicationDate.equals(other$applicationDate)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof AccountRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $clientId = this.getClientId();
        result = result * PRIME + ($clientId == null ? 43 : $clientId.hashCode());
        final java.lang.Object $productId = this.getProductId();
        result = result * PRIME + ($productId == null ? 43 : $productId.hashCode());
        final java.lang.Object $digitsAfterDecimal = this.getDigitsAfterDecimal();
        result = result * PRIME + ($digitsAfterDecimal == null ? 43 : $digitsAfterDecimal.hashCode());
        final java.lang.Object $requestedShares = this.getRequestedShares();
        result = result * PRIME + ($requestedShares == null ? 43 : $requestedShares.hashCode());
        final java.lang.Object $minimumActivePeriod = this.getMinimumActivePeriod();
        result = result * PRIME + ($minimumActivePeriod == null ? 43 : $minimumActivePeriod.hashCode());
        final java.lang.Object $numberOfShares = this.getNumberOfShares();
        result = result * PRIME + ($numberOfShares == null ? 43 : $numberOfShares.hashCode());
        final java.lang.Object $savingsAccountId = this.getSavingsAccountId();
        result = result * PRIME + ($savingsAccountId == null ? 43 : $savingsAccountId.hashCode());
        final java.lang.Object $lockinPeriodFrequency = this.getLockinPeriodFrequency();
        result = result * PRIME + ($lockinPeriodFrequency == null ? 43 : $lockinPeriodFrequency.hashCode());
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $unitPrice = this.getUnitPrice();
        result = result * PRIME + ($unitPrice == null ? 43 : $unitPrice.hashCode());
        final java.lang.Object $dateFormat = this.getDateFormat();
        result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
        final java.lang.Object $allowDividendCalculationForInactiveClients = this.getAllowDividendCalculationForInactiveClients();
        result = result * PRIME + ($allowDividendCalculationForInactiveClients == null ? 43 : $allowDividendCalculationForInactiveClients.hashCode());
        final java.lang.Object $externalId = this.getExternalId();
        result = result * PRIME + ($externalId == null ? 43 : $externalId.hashCode());
        final java.lang.Object $minimumActivePeriodFrequencyType = this.getMinimumActivePeriodFrequencyType();
        result = result * PRIME + ($minimumActivePeriodFrequencyType == null ? 43 : $minimumActivePeriodFrequencyType.hashCode());
        final java.lang.Object $locale = this.getLocale();
        result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
        final java.lang.Object $submittedDate = this.getSubmittedDate();
        result = result * PRIME + ($submittedDate == null ? 43 : $submittedDate.hashCode());
        final java.lang.Object $approvedDate = this.getApprovedDate();
        result = result * PRIME + ($approvedDate == null ? 43 : $approvedDate.hashCode());
        final java.lang.Object $charges = this.getCharges();
        result = result * PRIME + ($charges == null ? 43 : $charges.hashCode());
        final java.lang.Object $lockinPeriodFrequencyType = this.getLockinPeriodFrequencyType();
        result = result * PRIME + ($lockinPeriodFrequencyType == null ? 43 : $lockinPeriodFrequencyType.hashCode());
        final java.lang.Object $inMultiplesOf = this.getInMultiplesOf();
        result = result * PRIME + ($inMultiplesOf == null ? 43 : $inMultiplesOf.hashCode());
        final java.lang.Object $purchasedDate = this.getPurchasedDate();
        result = result * PRIME + ($purchasedDate == null ? 43 : $purchasedDate.hashCode());
        final java.lang.Object $currencyCode = this.getCurrencyCode();
        result = result * PRIME + ($currencyCode == null ? 43 : $currencyCode.hashCode());
        final java.lang.Object $applicationDate = this.getApplicationDate();
        result = result * PRIME + ($applicationDate == null ? 43 : $applicationDate.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "AccountRequest(unitPrice=" + this.getUnitPrice() + ", clientId=" + this.getClientId() + ", productId=" + this.getProductId() + ", digitsAfterDecimal=" + this.getDigitsAfterDecimal() + ", requestedShares=" + this.getRequestedShares() + ", dateFormat=" + this.getDateFormat() + ", minimumActivePeriod=" + this.getMinimumActivePeriod() + ", numberOfShares=" + this.getNumberOfShares() + ", allowDividendCalculationForInactiveClients=" + this.getAllowDividendCalculationForInactiveClients() + ", externalId=" + this.getExternalId() + ", minimumActivePeriodFrequencyType=" + this.getMinimumActivePeriodFrequencyType() + ", savingsAccountId=" + this.getSavingsAccountId() + ", locale=" + this.getLocale() + ", submittedDate=" + this.getSubmittedDate() + ", approvedDate=" + this.getApprovedDate() + ", charges=" + this.getCharges() + ", lockinPeriodFrequencyType=" + this.getLockinPeriodFrequencyType() + ", inMultiplesOf=" + this.getInMultiplesOf() + ", purchasedDate=" + this.getPurchasedDate() + ", lockinPeriodFrequency=" + this.getLockinPeriodFrequency() + ", id=" + this.getId() + ", currencyCode=" + this.getCurrencyCode() + ", applicationDate=" + this.getApplicationDate() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public AccountRequest() {
    }
}
