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
import java.math.BigDecimal;
import org.apache.fineract.organisation.teller.moduleapi.CashierTxnValidationPort;

/**
 * Composition-root hosted cashier validation for the Equinox bridge smoke.
 * Not JPA — records the last staff id so the smoke can tell it from the empty stub.
 */
final class HostedCashierTxnValidationPort implements CashierTxnValidationPort {

    static final long HOSTED_STAFF_ID = 1L;

    private Long lastStaffId;

    @Override
    public void validateOnLoanDisbursal(final Long staffId, final String currencyCode, final BigDecimal transactionAmount) {
        lastStaffId = staffId;
    }

    Long lastStaffId() {
        return lastStaffId;
    }
}
