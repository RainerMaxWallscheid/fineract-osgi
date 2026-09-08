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
package org.apache.fineract.portfolio.paymenttype.service;

import org.apache.fineract.portfolio.paymenttype.domain.PaymentType;
import org.apache.fineract.portfolio.paymenttype.domain.PaymentTypeRepository;
import org.apache.fineract.portfolio.paymenttype.moduleapi.PaymentTypePersistablePort;
import org.springframework.stereotype.Service;

@Service
public class PaymentTypePersistablePortAdapter implements PaymentTypePersistablePort {

    private final PaymentTypeRepository paymentTypeRepository;

    public PaymentTypePersistablePortAdapter(final PaymentTypeRepository paymentTypeRepository) {
        this.paymentTypeRepository = paymentTypeRepository;
    }

    @Override
    public Long id(final Object paymentType) {
        if (paymentType instanceof Long paymentTypeId) {
            return paymentTypeId;
        }
        if (paymentType == null) {
            return null;
        }
        return ((PaymentType) paymentType).getId();
    }

    @Override
    public Object persistableById(final Long paymentTypeId) {
        if (paymentTypeId == null) {
            return null;
        }
        return this.paymentTypeRepository.findById(paymentTypeId).orElse(null);
    }
}
