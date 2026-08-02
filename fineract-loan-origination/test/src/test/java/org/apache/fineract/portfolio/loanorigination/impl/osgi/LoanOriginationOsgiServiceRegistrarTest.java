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
package org.apache.fineract.portfolio.loanorigination.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.portfolio.loanorigination.service.LoanOriginatorReadPlatformService;
import org.apache.fineract.portfolio.loanorigination.service.LoanOriginatorWritePlatformService;
import org.apache.fineract.portfolio.loanorigination.service.WorkingCapitalLoanOriginatorWritePlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

/**
 * Without OSGi on the classpath the registrar must no-op (same pattern as branch/document).
 */
class LoanOriginationOsgiServiceRegistrarTest {

    @Test
    void afterPropertiesSet_noOpsWithoutOsgi() {
        @SuppressWarnings("unchecked")
        final ObjectProvider<LoanOriginatorReadPlatformService> read = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<LoanOriginatorWritePlatformService> write = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<WorkingCapitalLoanOriginatorWritePlatformService> wcWrite = mock(ObjectProvider.class);
        when(read.getIfAvailable()).thenReturn(mock(LoanOriginatorReadPlatformService.class));
        when(write.getIfAvailable()).thenReturn(mock(LoanOriginatorWritePlatformService.class));
        when(wcWrite.getIfAvailable()).thenReturn(mock(WorkingCapitalLoanOriginatorWritePlatformService.class));

        final LoanOriginationOsgiServiceRegistrar registrar = new LoanOriginationOsgiServiceRegistrar(read, write, wcWrite);
        assertDoesNotThrow(registrar::afterPropertiesSet);
        assertDoesNotThrow(registrar::destroy);
    }
}
