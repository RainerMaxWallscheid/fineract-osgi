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

public class TaxPaymentDTO {
    private final Long debitAccountId;
    private final Long creditAccountId;
    private final BigDecimal amount;

    @java.lang.SuppressWarnings("all")
        public TaxPaymentDTO(final Long debitAccountId, final Long creditAccountId, final BigDecimal amount) {
        this.debitAccountId = debitAccountId;
        this.creditAccountId = creditAccountId;
        this.amount = amount;
    }

    @java.lang.SuppressWarnings("all")
        public Long getDebitAccountId() {
        return this.debitAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCreditAccountId() {
        return this.creditAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }
}
