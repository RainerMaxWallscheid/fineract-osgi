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
package org.apache.fineract.interoperation.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertNull;

import org.junit.jupiter.api.Test;

class OsgiInteropServiceTest {

    private final OsgiInteropService port = new OsgiInteropService();

    @Test
    void emptyCatalogReturnsNullInteropResults() {
        assertNull(port.getAccountIdentifiers(null));
        assertNull(port.getAccountDetails(null));
        assertNull(port.getAccountTransactions(null, false, false, null, null));
        assertNull(port.getAccountByIdentifier(null, null, null));
        assertNull(port.registerAccountIdentifier(null, null, null, null));
        assertNull(port.deleteAccountIdentifier(null, null, null));
        assertNull(port.getTransactionRequest(null, null));
        assertNull(port.createTransactionRequest(null));
        assertNull(port.getQuote(null, null));
        assertNull(port.createQuote(null));
        assertNull(port.getTransfer(null, null));
        assertNull(port.prepareTransfer(null));
        assertNull(port.commitTransfer(null));
        assertNull(port.releaseTransfer(null));
        assertNull(port.getKyc(null));
        assertNull(port.disburseLoan(null, null));
        assertNull(port.loanRepayment(null, null));
    }
}
