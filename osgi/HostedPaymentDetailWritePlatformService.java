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

import java.util.Map;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.portfolio.paymentdetail.service.PaymentDetailWritePlatformService;

/** Composition-root hosted payment-detail writes for the Equinox bridge smoke. */
final class HostedPaymentDetailWritePlatformService implements PaymentDetailWritePlatformService {

    static final long HOSTED_ID = 1L;
    private static final Object HOSTED = new Object();

    @Override
    public Object createAndPersistPaymentDetail(final JsonCommand command, final Map<String, Object> changes) {
        return HOSTED;
    }

    @Override
    public Object createPaymentDetail(final JsonCommand command, final Map<String, Object> changes) {
        return HOSTED;
    }

    @Override
    public Object persistPaymentDetail(final Object paymentDetail) {
        return HOSTED;
    }

    @Override
    public Object createPaymentDetail(final Long paymentTypeId, final String accountNumber, final String checkNumber,
            final String routingCode, final String receiptNumber, final String bankNumber) {
        return HOSTED;
    }

    @Override
    public Long id(final Object paymentDetail) {
        return paymentDetail == null ? null : HOSTED_ID;
    }

    @Override
    public Object persistableById(final Long paymentDetailId) {
        return HOSTED;
    }
}
