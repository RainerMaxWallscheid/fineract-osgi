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
package org.apache.fineract.interoperation.data;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.math.BigDecimal;
import org.apache.fineract.interoperation.domain.InteropActionState;
import org.apache.fineract.interoperation.domain.InteropAmountType;
import org.apache.fineract.interoperation.domain.InteropTransactionRole;
import org.junit.jupiter.api.Test;

/**
 * Smoke tests for Interop request/response composition (no inheritance between specialized DTOs).
 */
class InteropDtoCompositionTest {

    @Test
    void quoteRequestComposesSharedRequest() {
        MoneyData amount = MoneyData.build(BigDecimal.TEN, "USD");
        InteropRequestData shared = new InteropRequestData("tx-1", "acc-1", amount, InteropTransactionRole.PAYER);
        InteropQuoteRequestData quote = new InteropQuoteRequestData(shared, "quote-1", InteropAmountType.RECEIVE, null);

        assertSame(shared, quote.getRequest());
        assertEquals("tx-1", quote.getTransactionCode());
        assertEquals("acc-1", quote.getAccountId());
        assertEquals("quote-1", quote.getQuoteCode());
        assertEquals(InteropAmountType.RECEIVE, quote.getAmountType());
        assertTrue(InteropQuoteRequestData.class.getSuperclass().equals(Object.class));
    }

    @Test
    void transferRequestComposesSharedRequest() {
        MoneyData amount = MoneyData.build(BigDecimal.ONE, "USD");
        InteropTransferRequestData transfer = new InteropTransferRequestData("tx-2", "xfer-9", "acc-2", amount,
                InteropTransactionRole.PAYEE);

        assertNotNull(transfer.getRequest());
        assertEquals("tx-2", transfer.getTransactionCode());
        assertEquals("xfer-9", transfer.getTransferCode());
        assertEquals(InteropTransactionRole.PAYEE, transfer.getTransactionRole());
        assertTrue(InteropTransferRequestData.class.getSuperclass().equals(Object.class));
    }

    @Test
    void transactionRequestComposesSharedRequest() {
        MoneyData amount = MoneyData.build(BigDecimal.ONE, "USD");
        InteropRequestData shared = new InteropRequestData("tx-3", "req-3", "acc-3", amount, InteropTransactionRole.PAYER, null, null,
                null, null, null);
        InteropTransactionRequestData txnReq = new InteropTransactionRequestData(shared);

        assertSame(shared, txnReq.getRequest());
        assertEquals("req-3", txnReq.getRequestCode());
        assertTrue(InteropTransactionRequestData.class.getSuperclass().equals(Object.class));
    }

    @Test
    void quoteResponseFlattensSharedResponseFields() {
        InteropQuoteResponseData response = InteropQuoteResponseData.build("tx-q", InteropActionState.ACCEPTED, "quote-z");

        assertEquals("tx-q", response.getTransactionCode());
        assertEquals(InteropActionState.ACCEPTED, response.getState());
        assertEquals("quote-z", response.getQuoteCode());
        // still a CommandProcessingResult for the command pipeline
        assertTrue(response instanceof org.apache.fineract.infrastructure.core.data.CommandProcessingResult);
        assertTrue(InteropQuoteResponseData.class.getSuperclass().getSimpleName().equals("CommandProcessingResult"));
    }

    @Test
    void transferAndTxnRequestResponsesDoNotExtendInteropResponseData() {
        InteropTransferResponseData transfer = InteropTransferResponseData.build("tx-t", InteropActionState.ACCEPTED, "xfer-1");
        InteropTransactionRequestResponseData txn = InteropTransactionRequestResponseData.build("tx-r", InteropActionState.REJECTED,
                "req-1");

        assertEquals("xfer-1", transfer.getTransferCode());
        assertEquals("req-1", txn.getRequestCode());
        assertTrue(InteropTransferResponseData.class.getSuperclass().getSimpleName().equals("CommandProcessingResult"));
        assertTrue(InteropTransactionRequestResponseData.class.getSuperclass().getSimpleName().equals("CommandProcessingResult"));
        assertTrue(InteropResponseData.class.getSuperclass().equals(Object.class));
    }
}
