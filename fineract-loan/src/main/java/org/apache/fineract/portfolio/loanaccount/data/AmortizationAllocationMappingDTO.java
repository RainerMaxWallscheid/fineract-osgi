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
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.portfolio.loanaccount.domain.AmortizationType;

/**
 * DTO for amortization allocation mapping data
 */
public class AmortizationAllocationMappingDTO {
    private Long amortizationLoanTransactionId;
    private ExternalId amortizationLoanTransactionExternalId;
    private LocalDate amortizationDate;
    private AmortizationType amortizationType;
    private BigDecimal amount;

    @java.lang.SuppressWarnings("all")
        public Long getAmortizationLoanTransactionId() {
        return this.amortizationLoanTransactionId;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getAmortizationLoanTransactionExternalId() {
        return this.amortizationLoanTransactionExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getAmortizationDate() {
        return this.amortizationDate;
    }

    @java.lang.SuppressWarnings("all")
        public AmortizationType getAmortizationType() {
        return this.amortizationType;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public AmortizationAllocationMappingDTO(final Long amortizationLoanTransactionId, final ExternalId amortizationLoanTransactionExternalId, final LocalDate amortizationDate, final AmortizationType amortizationType, final BigDecimal amount) {
        this.amortizationLoanTransactionId = amortizationLoanTransactionId;
        this.amortizationLoanTransactionExternalId = amortizationLoanTransactionExternalId;
        this.amortizationDate = amortizationDate;
        this.amortizationType = amortizationType;
        this.amount = amount;
    }
}
