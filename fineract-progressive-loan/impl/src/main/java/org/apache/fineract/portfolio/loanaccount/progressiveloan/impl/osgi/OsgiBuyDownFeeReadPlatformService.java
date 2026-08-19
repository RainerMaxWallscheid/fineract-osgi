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
package org.apache.fineract.portfolio.loanaccount.progressiveloan.impl.osgi;

import java.util.List;
import org.apache.fineract.portfolio.loanaccount.progressiveloan.data.BuyDownFeeAmortizationDetails;
import org.apache.fineract.portfolio.loanaccount.progressiveloan.service.BuyDownFeeReadPlatformService;

/**
 * Empty buy-down fee catalog for Equinox without Spring/JPA.
 * Published by {@code OSGI-INF/progressive-loan.xml} (ADR-022 B6).
 */
public final class OsgiBuyDownFeeReadPlatformService implements BuyDownFeeReadPlatformService {

    @Override
    public List<BuyDownFeeAmortizationDetails> retrieveLoanBuyDownFeeAmortizationDetails(final Long loanId) {
        return List.of();
    }
}
