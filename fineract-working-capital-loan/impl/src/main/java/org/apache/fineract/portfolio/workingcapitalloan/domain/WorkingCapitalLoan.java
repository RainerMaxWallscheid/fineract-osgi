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
package org.apache.fineract.portfolio.workingcapitalloan.domain;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Convert;
import jakarta.persistence.Embedded;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;
import jakarta.persistence.Version;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import org.apache.fineract.infrastructure.core.domain.AbstractAuditableWithUTCDateTimeCustom;
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.portfolio.client.domain.Client;
import org.apache.fineract.portfolio.client.moduleapi.ClientActivePort;
import org.apache.fineract.portfolio.fund.domain.Fund;
import org.apache.fineract.portfolio.loanaccount.domain.LoanStatus;
import org.apache.fineract.portfolio.loanaccount.domain.LoanStatusConverter;
import org.apache.fineract.portfolio.workingcapitalloanproduct.domain.WorkingCapitalLoanProduct;
import org.apache.fineract.portfolio.workingcapitalloanproduct.domain.WorkingCapitalLoanProductRelatedDetails;
import org.apache.fineract.useradministration.domain.AppUser;

@Entity
@Table(name = "m_wc_loan", uniqueConstraints = {@UniqueConstraint(columnNames = {"account_no"}, name = "wc_loan_account_no_UNIQUE"), @UniqueConstraint(columnNames = {"external_id"}, name = "wc_loan_externalid_UNIQUE")})
public class WorkingCapitalLoan extends AbstractAuditableWithUTCDateTimeCustom<Long> {
    private static ClientActivePort clientActivePort;

    public static void setActivePorts(final ClientActivePort clientActivePort) {
        WorkingCapitalLoan.clientActivePort = clientActivePort;
    }

    @Version
    int version;
    @Column(name = "last_closed_business_date")
    private LocalDate lastClosedBusinessDate;
    @Column(name = "account_no", length = 20, unique = true, nullable = false)
    private String accountNumber;
    @Column(name = "external_id")
    private ExternalId externalId;
    @ManyToOne
    @JoinColumn(name = "client_id")
    private Client client;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "fund_id")
    private Fund fund;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id", nullable = false)
    private WorkingCapitalLoanProduct loanProduct;
    @Column(name = "loan_status_id", nullable = false)
    @Convert(converter = LoanStatusConverter.class)
    private LoanStatus loanStatus;
    /**
     * Sequential counter of all WC loans for this client
     */
    @Column(name = "loan_counter")
    private Integer loanCounter;
    /**
     * Sequential counter of WC loans per client+product, used as loan cycle in summaries.
     */
    @Column(name = "loan_product_counter")
    private Integer loanProductCounter;
    @Column(name = "submittedon_date")
    private LocalDate submittedOnDate;
    @Column(name = "rejectedon_date")
    private LocalDate rejectedOnDate;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "rejectedon_userid")
    private AppUser rejectedBy;
    @Column(name = "approvedon_date")
    private LocalDate approvedOnDate;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "approvedon_userid")
    private AppUser approvedBy;
    @Column(name = "closedon_date")
    private LocalDate closedOnDate;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "closedon_userid")
    private AppUser closedBy;
    @Column(name = "expected_maturedon_date")
    private LocalDate expectedMaturityDate;
    /**
     * Date when the loan was fully paid (matured). Update only when loan is fully paid.
     */
    @Column(name = "maturedon_date")
    private LocalDate maturedOnDate;
    @Column(name = "principal_amount_proposed", scale = 6, precision = 19, nullable = false)
    private BigDecimal proposedPrincipal;
    @Column(name = "approved_principal", scale = 6, precision = 19, nullable = false)
    private BigDecimal approvedPrincipal;
    @OneToOne(mappedBy = "wcLoan", cascade = CascadeType.ALL, orphanRemoval = true)
    private WorkingCapitalLoanBalance balance;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "wcLoan", orphanRemoval = true, fetch = FetchType.LAZY)
    private List<WorkingCapitalLoanPaymentAllocationRule> paymentAllocationRules = new ArrayList<>();
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "wcLoan", orphanRemoval = true, fetch = FetchType.LAZY)
    private List<WorkingCapitalLoanDisbursementDetails> disbursementDetails = new ArrayList<>();
    @Embedded
    private WorkingCapitalLoanProductRelatedDetails loanProductRelatedDetails;
    @Column(name = "total_payment_volume", scale = 6, precision = 19, nullable = false)
    private BigDecimal totalPaymentVolume;

    public Long getOfficeId() {
        return this.client != null ? clientActivePort.officeId(getClientId()) : null;
    }

    public Long getClientId() {
        return clientActivePort.id(this.client);
    }

    @java.lang.SuppressWarnings("all")
        public int getVersion() {
        return this.version;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getLastClosedBusinessDate() {
        return this.lastClosedBusinessDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getAccountNumber() {
        return this.accountNumber;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getExternalId() {
        return this.externalId;
    }

    @java.lang.SuppressWarnings("all")
        public Client getClient() {
        return this.client;
    }

    @java.lang.SuppressWarnings("all")
        public Fund getFund() {
        return this.fund;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanProduct getLoanProduct() {
        return this.loanProduct;
    }

    @java.lang.SuppressWarnings("all")
        public LoanStatus getLoanStatus() {
        return this.loanStatus;
    }

    /**
     * Sequential counter of all WC loans for this client
     */
    @java.lang.SuppressWarnings("all")
        public Integer getLoanCounter() {
        return this.loanCounter;
    }

    /**
     * Sequential counter of WC loans per client+product, used as loan cycle in summaries.
     */
    @java.lang.SuppressWarnings("all")
        public Integer getLoanProductCounter() {
        return this.loanProductCounter;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getSubmittedOnDate() {
        return this.submittedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getRejectedOnDate() {
        return this.rejectedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public AppUser getRejectedBy() {
        return this.rejectedBy;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getApprovedOnDate() {
        return this.approvedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public AppUser getApprovedBy() {
        return this.approvedBy;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getClosedOnDate() {
        return this.closedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public AppUser getClosedBy() {
        return this.closedBy;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getExpectedMaturityDate() {
        return this.expectedMaturityDate;
    }

    /**
     * Date when the loan was fully paid (matured). Update only when loan is fully paid.
     */
    @java.lang.SuppressWarnings("all")
        public LocalDate getMaturedOnDate() {
        return this.maturedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getProposedPrincipal() {
        return this.proposedPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getApprovedPrincipal() {
        return this.approvedPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanBalance getBalance() {
        return this.balance;
    }

    @java.lang.SuppressWarnings("all")
        public List<WorkingCapitalLoanPaymentAllocationRule> getPaymentAllocationRules() {
        return this.paymentAllocationRules;
    }

    @java.lang.SuppressWarnings("all")
        public List<WorkingCapitalLoanDisbursementDetails> getDisbursementDetails() {
        return this.disbursementDetails;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanProductRelatedDetails getLoanProductRelatedDetails() {
        return this.loanProductRelatedDetails;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalPaymentVolume() {
        return this.totalPaymentVolume;
    }

    @java.lang.SuppressWarnings("all")
        public void setLastClosedBusinessDate(final LocalDate lastClosedBusinessDate) {
        this.lastClosedBusinessDate = lastClosedBusinessDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setAccountNumber(final String accountNumber) {
        this.accountNumber = accountNumber;
    }

    @java.lang.SuppressWarnings("all")
        public void setExternalId(final ExternalId externalId) {
        this.externalId = externalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setClient(final Object client) {
        this.client = (Client) client;
    }

    @java.lang.SuppressWarnings("all")
        public void setFund(final Fund fund) {
        this.fund = fund;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanProduct(final WorkingCapitalLoanProduct loanProduct) {
        this.loanProduct = loanProduct;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanStatus(final LoanStatus loanStatus) {
        this.loanStatus = loanStatus;
    }

    /**
     * Sequential counter of all WC loans for this client
     */
    @java.lang.SuppressWarnings("all")
        public void setLoanCounter(final Integer loanCounter) {
        this.loanCounter = loanCounter;
    }

    /**
     * Sequential counter of WC loans per client+product, used as loan cycle in summaries.
     */
    @java.lang.SuppressWarnings("all")
        public void setLoanProductCounter(final Integer loanProductCounter) {
        this.loanProductCounter = loanProductCounter;
    }

    @java.lang.SuppressWarnings("all")
        public void setSubmittedOnDate(final LocalDate submittedOnDate) {
        this.submittedOnDate = submittedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setRejectedOnDate(final LocalDate rejectedOnDate) {
        this.rejectedOnDate = rejectedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setRejectedBy(final AppUser rejectedBy) {
        this.rejectedBy = rejectedBy;
    }

    @java.lang.SuppressWarnings("all")
        public void setApprovedOnDate(final LocalDate approvedOnDate) {
        this.approvedOnDate = approvedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setApprovedBy(final AppUser approvedBy) {
        this.approvedBy = approvedBy;
    }

    @java.lang.SuppressWarnings("all")
        public void setClosedOnDate(final LocalDate closedOnDate) {
        this.closedOnDate = closedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setClosedBy(final AppUser closedBy) {
        this.closedBy = closedBy;
    }

    @java.lang.SuppressWarnings("all")
        public void setExpectedMaturityDate(final LocalDate expectedMaturityDate) {
        this.expectedMaturityDate = expectedMaturityDate;
    }

    /**
     * Date when the loan was fully paid (matured). Update only when loan is fully paid.
     */
    @java.lang.SuppressWarnings("all")
        public void setMaturedOnDate(final LocalDate maturedOnDate) {
        this.maturedOnDate = maturedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setProposedPrincipal(final BigDecimal proposedPrincipal) {
        this.proposedPrincipal = proposedPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public void setApprovedPrincipal(final BigDecimal approvedPrincipal) {
        this.approvedPrincipal = approvedPrincipal;
    }

    @java.lang.SuppressWarnings("all")
        public void setBalance(final WorkingCapitalLoanBalance balance) {
        this.balance = balance;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanProductRelatedDetails(final WorkingCapitalLoanProductRelatedDetails loanProductRelatedDetails) {
        this.loanProductRelatedDetails = loanProductRelatedDetails;
    }

    @java.lang.SuppressWarnings("all")
        public void setTotalPaymentVolume(final BigDecimal totalPaymentVolume) {
        this.totalPaymentVolume = totalPaymentVolume;
    }
}
