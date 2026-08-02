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

import org.apache.fineract.portfolio.loanaccount.service.LoanApplicationWritePlatformService;
import org.apache.fineract.portfolio.loanaccount.service.LoanChargeWritePlatformService;
import org.apache.fineract.portfolio.loanproduct.service.LoanDropdownReadPlatformService;
import org.apache.fineract.portfolio.loanproduct.service.LoanProductReadBasicDetailsService;
import org.apache.fineract.portfolio.loanproduct.service.LoanProductWritePlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

/**
 * Spring-only path: registrar is a no-op without OSGi FrameworkUtil on the classpath.
 */
class LoanOsgiServiceRegistrarTest {

    @Test
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        @SuppressWarnings("unchecked")
        final ObjectProvider<LoanProductWritePlatformService> productWrite = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<LoanProductReadBasicDetailsService> productReadBasic = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<LoanDropdownReadPlatformService> dropdownRead = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<LoanApplicationWritePlatformService> applicationWrite = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<LoanChargeWritePlatformService> chargeWrite = mock(ObjectProvider.class);

        when(productWrite.getIfAvailable()).thenReturn(null);
        when(productReadBasic.getIfAvailable()).thenReturn(null);
        when(dropdownRead.getIfAvailable()).thenReturn(null);
        when(applicationWrite.getIfAvailable()).thenReturn(null);
        when(chargeWrite.getIfAvailable()).thenReturn(null);

        final LoanOsgiServiceRegistrar registrar = new LoanOsgiServiceRegistrar(productWrite, productReadBasic, dropdownRead,
                applicationWrite, chargeWrite);
        assertDoesNotThrow(registrar::afterPropertiesSet);
        assertDoesNotThrow(registrar::destroy);
    }
}
