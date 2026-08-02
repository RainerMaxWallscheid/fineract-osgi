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

/**
 * DTO for base transaction information for AmortizationAllocationMapping
 */
public class AmortizationAllocationBaseTransactionDTO {
    private Long loanId;
    private ExternalId loanExternalId;
    private Long baseLoanTransactionId;
    private LocalDate baseLoanTransactionDate;
    private BigDecimal baseLoanTransactionAmount;
    private BigDecimal unrecognizedAmount;
    private BigDecimal chargedOffAmount;
    private BigDecimal adjustmentAmount;

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getLoanExternalId() {
        return this.loanExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getBaseLoanTransactionId() {
        return this.baseLoanTransactionId;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getBaseLoanTransactionDate() {
        return this.baseLoanTransactionDate;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getBaseLoanTransactionAmount() {
        return this.baseLoanTransactionAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getUnrecognizedAmount() {
        return this.unrecognizedAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getChargedOffAmount() {
        return this.chargedOffAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAdjustmentAmount() {
        return this.adjustmentAmount;
    }

    @java.lang.SuppressWarnings("all")
        public AmortizationAllocationBaseTransactionDTO(final Long loanId, final ExternalId loanExternalId, final Long baseLoanTransactionId, final LocalDate baseLoanTransactionDate, final BigDecimal baseLoanTransactionAmount, final BigDecimal unrecognizedAmount, final BigDecimal chargedOffAmount, final BigDecimal adjustmentAmount) {
        this.loanId = loanId;
        this.loanExternalId = loanExternalId;
        this.baseLoanTransactionId = baseLoanTransactionId;
        this.baseLoanTransactionDate = baseLoanTransactionDate;
        this.baseLoanTransactionAmount = baseLoanTransactionAmount;
        this.unrecognizedAmount = unrecognizedAmount;
        this.chargedOffAmount = chargedOffAmount;
        this.adjustmentAmount = adjustmentAmount;
    }
}
