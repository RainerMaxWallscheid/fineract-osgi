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
package org.apache.fineract.infrastructure.creditbureau.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.portfolio.loanproduct.domain.LoanProduct;

@SuppressWarnings({"MemberName"})
@Entity
@Table(name = "m_creditbureau_loanproduct_mapping")
public class CreditBureauLoanProductMapping extends AbstractPersistableCustom<Long> {
    @Column(name = "is_credit_check_mandatory")
    private boolean creditCheckMandatory;
    @Column(name = "skip_credit_check_in_failure")
    private boolean skipCreditCheckInFailure;
    @Column(name = "stale_period")
    private int stalePeriod;
    @Column(name = "is_active")
    private boolean active;
    @ManyToOne
    private OrganisationCreditBureau organisation_creditbureau;
    @OneToOne
    @JoinColumn(name = "loan_product_id")
    private LoanProduct loanProduct;

    public static CreditBureauLoanProductMapping fromJson(final JsonCommand command, OrganisationCreditBureau organisation_creditbureau, LoanProduct loanProduct) {
        Boolean isCreditCheckMandatory = false;
        Boolean skipCreditCheckInFailure = false;
        Integer stalePeriod = -1;
        Boolean isActive = false;
        if ((Boolean) command.booleanPrimitiveValueOfParameterNamed("isCreditcheckMandatory") != null) {
            isCreditCheckMandatory = command.booleanPrimitiveValueOfParameterNamed("isCreditcheckMandatory");
        }
        if ((Boolean) command.booleanPrimitiveValueOfParameterNamed("skipCreditcheckInFailure") != null) {
            skipCreditCheckInFailure = command.booleanPrimitiveValueOfParameterNamed("skipCreditcheckInFailure");
        }
        if (command.integerValueOfParameterNamed("stalePeriod") != null) {
            stalePeriod = command.integerValueOfParameterNamed("stalePeriod");
        }
        if ((Boolean) command.booleanPrimitiveValueOfParameterNamed("isActive")) {
            isActive = command.booleanPrimitiveValueOfParameterNamed("isActive");
        }
        return new CreditBureauLoanProductMapping().setCreditCheckMandatory(isCreditCheckMandatory).setSkipCreditCheckInFailure(skipCreditCheckInFailure).setStalePeriod(stalePeriod).setActive(isActive).setOrganisation_creditbureau(organisation_creditbureau).setLoanProduct(loanProduct);
    }

    @java.lang.SuppressWarnings("all")
        public boolean isCreditCheckMandatory() {
        return this.creditCheckMandatory;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isSkipCreditCheckInFailure() {
        return this.skipCreditCheckInFailure;
    }

    @java.lang.SuppressWarnings("all")
        public int getStalePeriod() {
        return this.stalePeriod;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isActive() {
        return this.active;
    }

    @java.lang.SuppressWarnings("all")
        public OrganisationCreditBureau getOrganisation_creditbureau() {
        return this.organisation_creditbureau;
    }

    @java.lang.SuppressWarnings("all")
        public LoanProduct getLoanProduct() {
        return this.loanProduct;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauLoanProductMapping setCreditCheckMandatory(final boolean creditCheckMandatory) {
        this.creditCheckMandatory = creditCheckMandatory;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauLoanProductMapping setSkipCreditCheckInFailure(final boolean skipCreditCheckInFailure) {
        this.skipCreditCheckInFailure = skipCreditCheckInFailure;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauLoanProductMapping setStalePeriod(final int stalePeriod) {
        this.stalePeriod = stalePeriod;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauLoanProductMapping setActive(final boolean active) {
        this.active = active;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauLoanProductMapping setOrganisation_creditbureau(final OrganisationCreditBureau organisation_creditbureau) {
        this.organisation_creditbureau = organisation_creditbureau;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public CreditBureauLoanProductMapping setLoanProduct(final LoanProduct loanProduct) {
        this.loanProduct = loanProduct;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public CreditBureauLoanProductMapping() {
    }
}
