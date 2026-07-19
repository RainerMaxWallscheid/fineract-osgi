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
package org.apache.fineract.test.data.paymenttype;

import static org.apache.fineract.client.feign.util.FeignCalls.ok;
import java.util.List;
import java.util.Map;
import org.apache.fineract.client.feign.FineractFeignClient;
import org.apache.fineract.client.models.PaymentTypeData;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Component;

@Component
public class PaymentTypeResolver {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(PaymentTypeResolver.class);
    private final FineractFeignClient fineractClient;

    @Cacheable(key = "#paymentType.getName()", value = "paymentTypesByName")
    public long resolve(PaymentType paymentType) {
        String paymentTypeName = paymentType.getName();
        log.debug("Resolving payment type by name [{}]", paymentTypeName);
        List<PaymentTypeData> paymentTypesResponses = ok(() -> fineractClient.paymentType().getAllPaymentTypesUniversal(Map.of()));
        PaymentTypeData foundPtr = paymentTypesResponses.stream().filter(ptr -> paymentTypeName.equals(ptr.getName())).findAny().orElseThrow(() -> new IllegalArgumentException("Payment type [%s] not found".formatted(paymentTypeName)));
        return foundPtr.getId();
    }

    @java.lang.SuppressWarnings("all")
        public PaymentTypeResolver(final FineractFeignClient fineractClient) {
        this.fineractClient = fineractClient;
    }
}
