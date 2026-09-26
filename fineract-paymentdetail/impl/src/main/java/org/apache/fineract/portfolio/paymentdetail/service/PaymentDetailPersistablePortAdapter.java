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

import org.apache.fineract.portfolio.paymentdetail.data.PaymentDetailData;
import org.apache.fineract.portfolio.paymentdetail.domain.PaymentDetail;
import org.apache.fineract.portfolio.paymentdetail.domain.PaymentDetailRepository;
import org.apache.fineract.portfolio.paymenttype.data.PaymentTypeData;
import org.apache.fineract.portfolio.paymenttype.domain.PaymentType;
import org.springframework.stereotype.Service;

@Service
public class PaymentDetailPersistablePortAdapter implements PaymentDetailPersistablePort {

    private final PaymentDetailRepository paymentDetailRepository;

    public PaymentDetailPersistablePortAdapter(final PaymentDetailRepository paymentDetailRepository) {
        this.paymentDetailRepository = paymentDetailRepository;
    }

    @Override
    public PaymentDetailData toData(final Long paymentDetailId) {
        final PaymentDetail detail = detail(paymentDetailId);
        if (detail == null) {
            return null;
        }
        return PaymentDetailData.builder().id(detail.getId()).paymentType(paymentTypeData(detail.getPaymentType()))
                .accountNumber(detail.getAccountNumber()).checkNumber(detail.getCheckNumber()).routingCode(detail.getRoutingCode())
                .receiptNumber(detail.getReceiptNumber()).bankNumber(detail.getBankNumber()).build();
    }

    @Override
    public Long paymentTypeId(final Long paymentDetailId) {
        final PaymentDetail detail = detail(paymentDetailId);
        if (detail == null || detail.getPaymentType() == null) {
            return null;
        }
        return detail.getPaymentType().getId();
    }

    @Override
    public String accountNumber(final Long paymentDetailId) {
        final PaymentDetail detail = detail(paymentDetailId);
        return detail == null ? null : detail.getAccountNumber();
    }

    @Override
    public String checkNumber(final Long paymentDetailId) {
        final PaymentDetail detail = detail(paymentDetailId);
        return detail == null ? null : detail.getCheckNumber();
    }

    @Override
    public String routingCode(final Long paymentDetailId) {
        final PaymentDetail detail = detail(paymentDetailId);
        return detail == null ? null : detail.getRoutingCode();
    }

    @Override
    public String receiptNumber(final Long paymentDetailId) {
        final PaymentDetail detail = detail(paymentDetailId);
        return detail == null ? null : detail.getReceiptNumber();
    }

    @Override
    public String bankNumber(final Long paymentDetailId) {
        final PaymentDetail detail = detail(paymentDetailId);
        return detail == null ? null : detail.getBankNumber();
    }

    private PaymentTypeData paymentTypeData(final PaymentType paymentType) {
        if (paymentType == null) {
            return null;
        }
        return PaymentTypeData.builder().id(paymentType.getId()).name(paymentType.getName()).description(paymentType.getDescription())
                .isCashPayment(paymentType.getIsCashPayment()).position(paymentType.getPosition()).codeName(paymentType.getCodeName())
                .isSystemDefined(paymentType.getIsSystemDefined()).build();
    }

    private PaymentDetail detail(final Long paymentDetailId) {
        if (paymentDetailId == null) {
            return null;
        }
        return this.paymentDetailRepository.findById(paymentDetailId).orElse(null);
    }
}
