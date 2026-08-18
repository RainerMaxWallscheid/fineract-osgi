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

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;
import org.apache.fineract.portfolio.loanaccount.progressiveloan.data.BuyDownFeeAmortizationDetails;
import org.apache.fineract.portfolio.loanaccount.progressiveloan.service.BuyDownFeeReadPlatformService;

/** Composition-root hosted buy-down fee catalog for the Equinox bridge smoke. */
final class HostedBuyDownFeeReadPlatformService implements BuyDownFeeReadPlatformService {

    static final long HOSTED_ID = 1L;

    @Override
    public List<BuyDownFeeAmortizationDetails> retrieveLoanBuyDownFeeAmortizationDetails(final Long loanId) {
        if (!Long.valueOf(HOSTED_ID).equals(loanId)) {
            return List.of();
        }
        return List.of(new BuyDownFeeAmortizationDetails(HOSTED_ID, HOSTED_ID, HOSTED_ID, LocalDate.of(2020, 1, 1), BigDecimal.TEN,
                BigDecimal.ONE, BigDecimal.ONE, BigDecimal.ZERO, BigDecimal.ZERO));
    }
}
