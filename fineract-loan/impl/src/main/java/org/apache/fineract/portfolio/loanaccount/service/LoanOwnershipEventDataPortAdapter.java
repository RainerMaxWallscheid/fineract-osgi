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
package org.apache.fineract.portfolio.loanaccount.service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.organisation.monetary.domain.MonetaryCurrency;
import org.apache.fineract.portfolio.loanaccount.data.UnpaidChargeData;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;
import org.apache.fineract.portfolio.loanaccount.domain.LoanCharge;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanOwnershipEventDataPort;
import org.springframework.stereotype.Service;

@Service
public class LoanOwnershipEventDataPortAdapter implements LoanOwnershipEventDataPort {

    @Override
    public CurrencyData currency(final Object loanObj) {
        final MonetaryCurrency loanCurrency = ((Loan) loanObj).getCurrency();
        return new CurrencyData(loanCurrency.getCode(), loanCurrency.getDigitsAfterDecimal(), loanCurrency.getInMultiplesOf());
    }

    @Override
    public List<UnpaidChargeData> unpaidCharges(final Object loanObj) {
        final Map<Long, UnpaidChargeData> map = new HashMap<>();
        ((Loan) loanObj).getLoanCharges().forEach(loanCharge -> addToMap(map, loanCharge));
        return map.values().stream().toList();
    }

    private void addToMap(final Map<Long, UnpaidChargeData> map, final LoanCharge loanCharge) {
        if (loanCharge.amountOutstanding().compareTo(BigDecimal.ZERO) > 0) {
            final UnpaidChargeData toAdd = new UnpaidChargeData(loanCharge.getChargeId(), loanCharge.name(),
                    loanCharge.amountOutstanding());
            final UnpaidChargeData existing = map.get(loanCharge.getChargeId());
            if (existing == null) {
                map.put(toAdd.getChargeId(), toAdd);
            } else {
                map.put(existing.getChargeId(),
                        new UnpaidChargeData(existing.getChargeId(), existing.getChargeName(),
                                existing.getOutstandingAmount().add(toAdd.getOutstandingAmount())));
            }
        }
    }
}
