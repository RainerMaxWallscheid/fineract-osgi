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
import org.apache.fineract.portfolio.paymentdetail.PaymentDetailConstants;
import org.apache.fineract.portfolio.paymentdetail.domain.PaymentDetail;
import org.apache.fineract.portfolio.paymentdetail.domain.PaymentDetailRepository;
import org.apache.fineract.portfolio.paymenttype.domain.PaymentType;
import org.apache.fineract.portfolio.paymenttype.domain.PaymentTypeRepository;
import org.apache.fineract.portfolio.paymenttype.exception.PaymentTypeNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class PaymentDetailWritePlatformServiceJpaRepositoryImpl implements PaymentDetailWritePlatformService {

    private final PaymentDetailRepository paymentDetailRepository;
    private final PaymentTypeRepository paymentTypeRepository;

    @Override
    public Object createPaymentDetail(final JsonCommand command, final Map<String, Object> changes) {
        final Long paymentTypeId = command.longValueOfParameterNamed(PaymentDetailConstants.paymentTypeParamName);
        if (paymentTypeId == null) {
            return null;
        }
        final PaymentType paymentType = this.paymentTypeRepository.findById(paymentTypeId)
                .orElseThrow(() -> new PaymentTypeNotFoundException(paymentTypeId));
        return PaymentDetail.generatePaymentDetail(paymentType, command, changes);
    }

    @Override
    @Transactional
    public Object persistPaymentDetail(final Object paymentDetail) {
        if (!(paymentDetail instanceof PaymentDetail persistable)) {
            return null;
        }
        return this.paymentDetailRepository.saveAndFlush(persistable);
    }

    @Override
    @Transactional
    public Object createAndPersistPaymentDetail(final JsonCommand command, final Map<String, Object> changes) {
        final Object paymentDetail = createPaymentDetail(command, changes);
        if (paymentDetail != null) {
            return persistPaymentDetail(paymentDetail);
        }
        return paymentDetail;
    }

    @Override
    public Object createPaymentDetail(final Long paymentTypeId, final String accountNumber, final String checkNumber,
            final String routingCode, final String receiptNumber, final String bankNumber) {
        if (paymentTypeId == null) {
            return null;
        }
        final PaymentType paymentType = this.paymentTypeRepository.findById(paymentTypeId)
                .orElseThrow(() -> new PaymentTypeNotFoundException(paymentTypeId));
        return PaymentDetail.instance(paymentType, accountNumber, checkNumber, routingCode, receiptNumber, bankNumber);
    }

    @Override
    public Long id(final Object paymentDetail) {
        if (!(paymentDetail instanceof PaymentDetail persistable)) {
            return null;
        }
        return persistable.getId();
    }

    @Override
    public Object persistableById(final Long paymentDetailId) {
        if (paymentDetailId == null) {
            return null;
        }
        return this.paymentDetailRepository.findById(paymentDetailId).orElse(null);
    }

    public PaymentDetailWritePlatformServiceJpaRepositoryImpl(final PaymentDetailRepository paymentDetailRepository,
            final PaymentTypeRepository paymentTypeRepository) {
        this.paymentDetailRepository = paymentDetailRepository;
        this.paymentTypeRepository = paymentTypeRepository;
    }
}
