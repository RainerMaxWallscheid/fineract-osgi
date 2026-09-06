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
package org.apache.fineract.portfolio.loanaccount.mapper;

import java.util.List;
import org.apache.fineract.infrastructure.core.config.MapstructMapperConfig;
import org.apache.fineract.portfolio.loanaccount.data.LoanTransactionRelationData;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransaction;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransactionRelation;
import org.apache.fineract.portfolio.paymentdetail.domain.PaymentDetail;
import org.apache.fineract.portfolio.paymentdetail.service.PaymentDetailAssociation;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(config = MapstructMapperConfig.class)
public interface LoanTransactionRelationMapper {

    @Mapping(target = "fromLoanTransaction", source = "source.fromTransaction.id")
    @Mapping(target = "toLoanTransaction", source = "source.toTransaction.id")
    @Mapping(target = "toLoanCharge", source = "source.toCharge.id")
    @Mapping(target = "amount", source = "source.toTransaction.amount")
    @Mapping(target = "paymentType", expression = "java(paymentTypeName(source))")
    LoanTransactionRelationData map(LoanTransactionRelation source);

    List<LoanTransactionRelationData> map(List<LoanTransactionRelation> sources);

    default String paymentTypeName(final LoanTransactionRelation source) {
        final LoanTransaction toTransaction = source.getToTransaction();
        if (toTransaction == null) {
            return null;
        }
        final Object persistable = PaymentDetailAssociation.persistableById(toTransaction.getPaymentDetailId());
        if (!(persistable instanceof PaymentDetail detail) || detail.getPaymentType() == null) {
            return null;
        }
        return detail.getPaymentType().getName();
    }

}
