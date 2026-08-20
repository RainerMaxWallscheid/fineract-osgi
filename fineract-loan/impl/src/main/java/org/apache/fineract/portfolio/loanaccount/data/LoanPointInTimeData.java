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

import org.apache.fineract.infrastructure.core.config.MapstructMapperConfig;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.organisation.monetary.mapper.CurrencyMapper;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;
import org.apache.fineract.portfolio.loanaccount.domain.arrears.LoanArrearsData;
import org.mapstruct.Mapping;

public class LoanPointInTimeData {
    // Loan attributes
    private Long id;
    private String accountNo;
    private LoanStatusEnumData status;
    private String externalId;
    private CurrencyData currency;
    private LoanPrincipalData principal;
    private LoanInterestData interest;
    private LoanFeeData fee;
    private LoanPenaltyData penalty;
    private LoanTotalAmountData total;
    // Client attributes
    private Long clientId;
    private String clientAccountNo;
    private String clientExternalId;
    private String clientDisplayName;
    private Long clientOfficeId;
    // Loan product attributes
    private Long loanProductId;
    private String loanProductName;
    // Arrears data
    private LoanArrearsData arrears;


    @org.mapstruct.Mapper(config = MapstructMapperConfig.class, uses = {LoanStatusEnumData.Mapper.class, CurrencyMapper.class, LoanPrincipalData.Mapper.class, LoanInterestData.Mapper.class, LoanFeeData.Mapper.class, LoanPenaltyData.Mapper.class, LoanTotalAmountData.Mapper.class, org.apache.fineract.portfolio.loanaccount.mapper.ClientIdLookup.class})
    public interface Mapper {
        @Mapping(source = "accountNumber", target = "accountNo")
        @Mapping(source = "source", target = "status")
        @Mapping(source = "clientId", target = "clientId")
        @Mapping(source = "clientId", target = "clientAccountNo", qualifiedByName = "clientAccountNumber")
        @Mapping(source = "clientId", target = "clientExternalId", qualifiedByName = "clientExternalIdValue")
        @Mapping(source = "clientId", target = "clientDisplayName", qualifiedByName = "clientDisplayName")
        @Mapping(source = "officeId", target = "clientOfficeId")
        @Mapping(source = "summary", target = "principal")
        @Mapping(source = "summary", target = "interest")
        @Mapping(source = "summary", target = "fee")
        @Mapping(source = "summary", target = "penalty")
        @Mapping(source = "summary", target = "total")
        @Mapping(source = "loanProduct.id", target = "loanProductId")
        @Mapping(source = "loanProduct.name", target = "loanProductName")
        @Mapping(target = "arrears", ignore = true)
        LoanPointInTimeData map(Loan source);
    }

    @java.lang.SuppressWarnings("all")
        public LoanPointInTimeData() {
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getAccountNo() {
        return this.accountNo;
    }

    @java.lang.SuppressWarnings("all")
        public LoanStatusEnumData getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public String getExternalId() {
        return this.externalId;
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyData getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public LoanPrincipalData getPrincipal() {
        return this.principal;
    }

    @java.lang.SuppressWarnings("all")
        public LoanInterestData getInterest() {
        return this.interest;
    }

    @java.lang.SuppressWarnings("all")
        public LoanFeeData getFee() {
        return this.fee;
    }

    @java.lang.SuppressWarnings("all")
        public LoanPenaltyData getPenalty() {
        return this.penalty;
    }

    @java.lang.SuppressWarnings("all")
        public LoanTotalAmountData getTotal() {
        return this.total;
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientId() {
        return this.clientId;
    }

    @java.lang.SuppressWarnings("all")
        public String getClientAccountNo() {
        return this.clientAccountNo;
    }

    @java.lang.SuppressWarnings("all")
        public String getClientExternalId() {
        return this.clientExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public String getClientDisplayName() {
        return this.clientDisplayName;
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientOfficeId() {
        return this.clientOfficeId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanProductId() {
        return this.loanProductId;
    }

    @java.lang.SuppressWarnings("all")
        public String getLoanProductName() {
        return this.loanProductName;
    }

    @java.lang.SuppressWarnings("all")
        public LoanArrearsData getArrears() {
        return this.arrears;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
    }

    @java.lang.SuppressWarnings("all")
        public void setAccountNo(final String accountNo) {
        this.accountNo = accountNo;
    }

    @java.lang.SuppressWarnings("all")
        public void setStatus(final LoanStatusEnumData status) {
        this.status = status;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalId(final String externalId) {
        this.externalId = externalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setCurrency(final CurrencyData currency) {
        this.currency = currency;
    }

    @java.lang.SuppressWarnings("all")
        public void setPrincipal(final LoanPrincipalData principal) {
        this.principal = principal;
    }

    @java.lang.SuppressWarnings("all")
        public void setInterest(final LoanInterestData interest) {
        this.interest = interest;
    }

    @java.lang.SuppressWarnings("all")
        public void setFee(final LoanFeeData fee) {
        this.fee = fee;
    }

    @java.lang.SuppressWarnings("all")
        public void setPenalty(final LoanPenaltyData penalty) {
        this.penalty = penalty;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotal(final LoanTotalAmountData total) {
        this.total = total;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientId(final Long clientId) {
        this.clientId = clientId;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientAccountNo(final String clientAccountNo) {
        this.clientAccountNo = clientAccountNo;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientExternalId(final String clientExternalId) {
        this.clientExternalId = clientExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientDisplayName(final String clientDisplayName) {
        this.clientDisplayName = clientDisplayName;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientOfficeId(final Long clientOfficeId) {
        this.clientOfficeId = clientOfficeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanProductId(final Long loanProductId) {
        this.loanProductId = loanProductId;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanProductName(final String loanProductName) {
        this.loanProductName = loanProductName;
    }

    @java.lang.SuppressWarnings("all")
        public void setArrears(final LoanArrearsData arrears) {
        this.arrears = arrears;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LoanPointInTimeData)) return false;
        final LoanPointInTimeData other = (LoanPointInTimeData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$clientId = this.getClientId();
        final java.lang.Object other$clientId = other.getClientId();
        if (this$clientId == null ? other$clientId != null : !this$clientId.equals(other$clientId)) return false;
        final java.lang.Object this$clientOfficeId = this.getClientOfficeId();
        final java.lang.Object other$clientOfficeId = other.getClientOfficeId();
        if (this$clientOfficeId == null ? other$clientOfficeId != null : !this$clientOfficeId.equals(other$clientOfficeId)) return false;
        final java.lang.Object this$loanProductId = this.getLoanProductId();
        final java.lang.Object other$loanProductId = other.getLoanProductId();
        if (this$loanProductId == null ? other$loanProductId != null : !this$loanProductId.equals(other$loanProductId)) return false;
        final java.lang.Object this$accountNo = this.getAccountNo();
        final java.lang.Object other$accountNo = other.getAccountNo();
        if (this$accountNo == null ? other$accountNo != null : !this$accountNo.equals(other$accountNo)) return false;
        final java.lang.Object this$status = this.getStatus();
        final java.lang.Object other$status = other.getStatus();
        if (this$status == null ? other$status != null : !this$status.equals(other$status)) return false;
        final java.lang.Object this$externalId = this.getExternalId();
        final java.lang.Object other$externalId = other.getExternalId();
        if (this$externalId == null ? other$externalId != null : !this$externalId.equals(other$externalId)) return false;
        final java.lang.Object this$currency = this.getCurrency();
        final java.lang.Object other$currency = other.getCurrency();
        if (this$currency == null ? other$currency != null : !this$currency.equals(other$currency)) return false;
        final java.lang.Object this$principal = this.getPrincipal();
        final java.lang.Object other$principal = other.getPrincipal();
        if (this$principal == null ? other$principal != null : !this$principal.equals(other$principal)) return false;
        final java.lang.Object this$interest = this.getInterest();
        final java.lang.Object other$interest = other.getInterest();
        if (this$interest == null ? other$interest != null : !this$interest.equals(other$interest)) return false;
        final java.lang.Object this$fee = this.getFee();
        final java.lang.Object other$fee = other.getFee();
        if (this$fee == null ? other$fee != null : !this$fee.equals(other$fee)) return false;
        final java.lang.Object this$penalty = this.getPenalty();
        final java.lang.Object other$penalty = other.getPenalty();
        if (this$penalty == null ? other$penalty != null : !this$penalty.equals(other$penalty)) return false;
        final java.lang.Object this$total = this.getTotal();
        final java.lang.Object other$total = other.getTotal();
        if (this$total == null ? other$total != null : !this$total.equals(other$total)) return false;
        final java.lang.Object this$clientAccountNo = this.getClientAccountNo();
        final java.lang.Object other$clientAccountNo = other.getClientAccountNo();
        if (this$clientAccountNo == null ? other$clientAccountNo != null : !this$clientAccountNo.equals(other$clientAccountNo)) return false;
        final java.lang.Object this$clientExternalId = this.getClientExternalId();
        final java.lang.Object other$clientExternalId = other.getClientExternalId();
        if (this$clientExternalId == null ? other$clientExternalId != null : !this$clientExternalId.equals(other$clientExternalId)) return false;
        final java.lang.Object this$clientDisplayName = this.getClientDisplayName();
        final java.lang.Object other$clientDisplayName = other.getClientDisplayName();
        if (this$clientDisplayName == null ? other$clientDisplayName != null : !this$clientDisplayName.equals(other$clientDisplayName)) return false;
        final java.lang.Object this$loanProductName = this.getLoanProductName();
        final java.lang.Object other$loanProductName = other.getLoanProductName();
        if (this$loanProductName == null ? other$loanProductName != null : !this$loanProductName.equals(other$loanProductName)) return false;
        final java.lang.Object this$arrears = this.getArrears();
        final java.lang.Object other$arrears = other.getArrears();
        if (this$arrears == null ? other$arrears != null : !this$arrears.equals(other$arrears)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LoanPointInTimeData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $clientId = this.getClientId();
        result = result * PRIME + ($clientId == null ? 43 : $clientId.hashCode());
        final java.lang.Object $clientOfficeId = this.getClientOfficeId();
        result = result * PRIME + ($clientOfficeId == null ? 43 : $clientOfficeId.hashCode());
        final java.lang.Object $loanProductId = this.getLoanProductId();
        result = result * PRIME + ($loanProductId == null ? 43 : $loanProductId.hashCode());
        final java.lang.Object $accountNo = this.getAccountNo();
        result = result * PRIME + ($accountNo == null ? 43 : $accountNo.hashCode());
        final java.lang.Object $status = this.getStatus();
        result = result * PRIME + ($status == null ? 43 : $status.hashCode());
        final java.lang.Object $externalId = this.getExternalId();
        result = result * PRIME + ($externalId == null ? 43 : $externalId.hashCode());
        final java.lang.Object $currency = this.getCurrency();
        result = result * PRIME + ($currency == null ? 43 : $currency.hashCode());
        final java.lang.Object $principal = this.getPrincipal();
        result = result * PRIME + ($principal == null ? 43 : $principal.hashCode());
        final java.lang.Object $interest = this.getInterest();
        result = result * PRIME + ($interest == null ? 43 : $interest.hashCode());
        final java.lang.Object $fee = this.getFee();
        result = result * PRIME + ($fee == null ? 43 : $fee.hashCode());
        final java.lang.Object $penalty = this.getPenalty();
        result = result * PRIME + ($penalty == null ? 43 : $penalty.hashCode());
        final java.lang.Object $total = this.getTotal();
        result = result * PRIME + ($total == null ? 43 : $total.hashCode());
        final java.lang.Object $clientAccountNo = this.getClientAccountNo();
        result = result * PRIME + ($clientAccountNo == null ? 43 : $clientAccountNo.hashCode());
        final java.lang.Object $clientExternalId = this.getClientExternalId();
        result = result * PRIME + ($clientExternalId == null ? 43 : $clientExternalId.hashCode());
        final java.lang.Object $clientDisplayName = this.getClientDisplayName();
        result = result * PRIME + ($clientDisplayName == null ? 43 : $clientDisplayName.hashCode());
        final java.lang.Object $loanProductName = this.getLoanProductName();
        result = result * PRIME + ($loanProductName == null ? 43 : $loanProductName.hashCode());
        final java.lang.Object $arrears = this.getArrears();
        result = result * PRIME + ($arrears == null ? 43 : $arrears.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LoanPointInTimeData(id=" + this.getId() + ", accountNo=" + this.getAccountNo() + ", status=" + this.getStatus() + ", externalId=" + this.getExternalId() + ", currency=" + this.getCurrency() + ", principal=" + this.getPrincipal() + ", interest=" + this.getInterest() + ", fee=" + this.getFee() + ", penalty=" + this.getPenalty() + ", total=" + this.getTotal() + ", clientId=" + this.getClientId() + ", clientAccountNo=" + this.getClientAccountNo() + ", clientExternalId=" + this.getClientExternalId() + ", clientDisplayName=" + this.getClientDisplayName() + ", clientOfficeId=" + this.getClientOfficeId() + ", loanProductId=" + this.getLoanProductId() + ", loanProductName=" + this.getLoanProductName() + ", arrears=" + this.getArrears() + ")";
    }
}
