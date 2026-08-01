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
package org.apache.fineract.organisation.teller.moduleapi;

import java.math.BigDecimal;

/**
 * Branch/teller port for cashier cash validation used by foreign BCs (loan disbursal).
 *
 * <p>Implementation lives in branch-impl ({@code CashierTransactionDataValidator}). Foreign modules
 * must not depend on that class or on teller JPA types.
 */
public interface CashierTxnValidationPort {

    /**
     * When the acting staff has an open cashier session, ensure the cashier net cash covers
     * {@code transactionAmount} for {@code currencyCode}.
     *
     * @param staffId
     *            staff primary key, or {@code null} if the user has no staff assignment (no-op)
     */
    void validateOnLoanDisbursal(Long staffId, String currencyCode, BigDecimal transactionAmount);
}
