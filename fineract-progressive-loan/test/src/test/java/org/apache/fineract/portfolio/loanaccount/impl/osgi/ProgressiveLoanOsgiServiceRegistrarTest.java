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
package org.apache.fineract.portfolio.loanaccount.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.portfolio.loanaccount.service.BuyDownFeeReadPlatformService;
import org.apache.fineract.portfolio.loanaccount.service.CapitalizedIncomeBalanceReadService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class ProgressiveLoanOsgiServiceRegistrarTest {

    @Test
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        @SuppressWarnings("unchecked")
        final ObjectProvider<CapitalizedIncomeBalanceReadService> capitalized = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<BuyDownFeeReadPlatformService> buyDown = mock(ObjectProvider.class);
        when(capitalized.getIfAvailable()).thenReturn(null);
        when(buyDown.getIfAvailable()).thenReturn(null);

        final ProgressiveLoanOsgiServiceRegistrar registrar = new ProgressiveLoanOsgiServiceRegistrar(capitalized, buyDown);
        assertDoesNotThrow(registrar::afterPropertiesSet);
        assertDoesNotThrow(registrar::destroy);
    }
}
