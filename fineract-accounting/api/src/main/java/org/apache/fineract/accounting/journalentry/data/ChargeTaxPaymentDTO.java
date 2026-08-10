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

public class ChargeTaxPaymentDTO {
    private final Long loanChargeId;
    private final Long creditAccountId;
    private final BigDecimal amount;
    private final boolean penalty;

    @java.lang.SuppressWarnings("all")
        public ChargeTaxPaymentDTO(final Long loanChargeId, final Long creditAccountId, final BigDecimal amount, final boolean penalty) {
        this.loanChargeId = loanChargeId;
        this.creditAccountId = creditAccountId;
        this.amount = amount;
        this.penalty = penalty;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanChargeId() {
        return this.loanChargeId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCreditAccountId() {
        return this.creditAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isPenalty() {
        return this.penalty;
    }
}
