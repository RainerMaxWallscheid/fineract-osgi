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

/**
 * Field lookup for leftover {@code PaymentDetail} (ADR-021). Spring-only; not an Equinox catalog port.
 */
public interface PaymentDetailPersistablePort {

    /**
     * Payment-type id, or null when the detail id is null, missing, or the detail has no payment type.
     */
    Long paymentTypeId(Long paymentDetailId);

    /**
     * Account number, or null when the detail id is null, missing, or the number is null.
     */
    String accountNumber(Long paymentDetailId);

    /**
     * Check number, or null when the detail id is null, missing, or the number is null.
     */
    String checkNumber(Long paymentDetailId);

    /**
     * Routing code, or null when the detail id is null, missing, or the code is null.
     */
    String routingCode(Long paymentDetailId);

    /**
     * Receipt number, or null when the detail id is null, missing, or the number is null.
     */
    String receiptNumber(Long paymentDetailId);

    /**
     * Bank number, or null when the detail id is null, missing, or the number is null.
     */
    String bankNumber(Long paymentDetailId);
}
