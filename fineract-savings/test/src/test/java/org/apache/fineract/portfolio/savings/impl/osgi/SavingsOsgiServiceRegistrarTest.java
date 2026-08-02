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
package org.apache.fineract.portfolio.savings.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.portfolio.savings.service.DepositApplicationProcessWritePlatformService;
import org.apache.fineract.portfolio.savings.service.DepositProductReadPlatformService;
import org.apache.fineract.portfolio.savings.service.SavingsApplicationProcessWritePlatformService;
import org.apache.fineract.portfolio.savings.service.SavingsProductReadPlatformService;
import org.apache.fineract.portfolio.savings.service.SavingsProductWritePlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class SavingsOsgiServiceRegistrarTest {

    @Test
    void afterPropertiesSet_noOpsWithoutOsgi() {
        @SuppressWarnings("unchecked")
        final ObjectProvider<SavingsProductReadPlatformService> pr = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<SavingsProductWritePlatformService> pw = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<SavingsApplicationProcessWritePlatformService> aw = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<DepositProductReadPlatformService> dpr = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<DepositApplicationProcessWritePlatformService> daw = mock(ObjectProvider.class);
        when(pr.getIfAvailable()).thenReturn(mock(SavingsProductReadPlatformService.class));
        when(pw.getIfAvailable()).thenReturn(mock(SavingsProductWritePlatformService.class));
        when(aw.getIfAvailable()).thenReturn(mock(SavingsApplicationProcessWritePlatformService.class));
        when(dpr.getIfAvailable()).thenReturn(mock(DepositProductReadPlatformService.class));
        when(daw.getIfAvailable()).thenReturn(mock(DepositApplicationProcessWritePlatformService.class));

        final SavingsOsgiServiceRegistrar registrar = new SavingsOsgiServiceRegistrar(pr, pw, aw, dpr, daw);
        assertDoesNotThrow(registrar::afterPropertiesSet);
        assertDoesNotThrow(registrar::destroy);
    }
}
