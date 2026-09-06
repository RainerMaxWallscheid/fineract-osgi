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
 * Id / persistable lookup for leftover {@code PaymentDetail} without JPA associations on
 * transaction entities (ADR-021).
 */
public final class PaymentDetailAssociation {

    private static PaymentDetailWritePlatformService write;

    private PaymentDetailAssociation() {}

    public static void setWritePlatformService(final PaymentDetailWritePlatformService write) {
        PaymentDetailAssociation.write = write;
    }

    public static Long id(final Object paymentDetail) {
        if (paymentDetail instanceof Long paymentDetailId) {
            return paymentDetailId;
        }
        if (write != null) {
            return write.id(paymentDetail);
        }
        if (paymentDetail == null) {
            return null;
        }
        try {
            final Object id = paymentDetail.getClass().getMethod("getId").invoke(paymentDetail);
            return id instanceof Long paymentDetailId ? paymentDetailId : null;
        } catch (final ReflectiveOperationException ignored) {
            return null;
        }
    }

    public static Object persistableById(final Long paymentDetailId) {
        return write == null ? null : write.persistableById(paymentDetailId);
    }
}
