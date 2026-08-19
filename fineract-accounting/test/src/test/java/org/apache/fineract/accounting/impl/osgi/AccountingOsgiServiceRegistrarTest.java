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
package org.apache.fineract.accounting.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.accounting.common.AccountingDropdownReadPlatformService;
import org.apache.fineract.accounting.glaccount.service.GLAccountReadPlatformService;
import org.apache.fineract.accounting.journalentry.service.JournalEntryReadPlatformService;
import org.apache.fineract.accounting.moduleapi.ProductToGLAccountMappingReadPlatformService;
import org.apache.fineract.accounting.moduleapi.ProductToGLAccountMappingWritePlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class AccountingOsgiServiceRegistrarTest {

    @Test
    void afterPropertiesSet_noOpsWithoutOsgi() {
        @SuppressWarnings("unchecked")
        final ObjectProvider<GLAccountReadPlatformService> gl = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<JournalEntryReadPlatformService> je = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<ProductToGLAccountMappingReadPlatformService> mapR = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<ProductToGLAccountMappingWritePlatformService> mapW = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<AccountingDropdownReadPlatformService> dd = mock(ObjectProvider.class);
        when(gl.getIfAvailable()).thenReturn(mock(GLAccountReadPlatformService.class));
        when(je.getIfAvailable()).thenReturn(mock(JournalEntryReadPlatformService.class));
        when(mapR.getIfAvailable()).thenReturn(mock(ProductToGLAccountMappingReadPlatformService.class));
        when(mapW.getIfAvailable()).thenReturn(mock(ProductToGLAccountMappingWritePlatformService.class));
        when(dd.getIfAvailable()).thenReturn(mock(AccountingDropdownReadPlatformService.class));

        final AccountingOsgiServiceRegistrar registrar = new AccountingOsgiServiceRegistrar(gl, je, mapR, mapW, dd);
        assertDoesNotThrow(registrar::afterPropertiesSet);
        assertDoesNotThrow(registrar::destroy);
    }
}
