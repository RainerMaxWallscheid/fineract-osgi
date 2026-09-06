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
package org.apache.fineract.portfolio.paymentdetail.service;

import java.util.Map;
import org.apache.fineract.infrastructure.core.api.JsonCommand;

/**
 * Payment-detail writes (ADR-021). Persistable instances are Object-typed leftover {@code PaymentDetail} — foreign BCs
 * must not depend on leftover JPA graphs.
 */
public interface PaymentDetailWritePlatformService {

    Object createAndPersistPaymentDetail(JsonCommand command, Map<String, Object> changes);

    Object createPaymentDetail(JsonCommand command, Map<String, Object> changes);

    Object persistPaymentDetail(Object paymentDetail);

    Object createPaymentDetail(Long paymentTypeId, String accountNumber, String checkNumber, String routingCode, String receiptNumber,
            String bankNumber);

    /**
     * Payment-detail id from a persistable instance (Object-typed, ADR-021).
     */
    Long id(Object paymentDetail);

    /**
     * Persistable payment detail for association writes (Object-typed, ADR-021).
     */
    Object persistableById(Long paymentDetailId);
}
