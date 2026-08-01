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
package org.apache.fineract.organisation.teller.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.organisation.teller.service.TellerManagementReadPlatformService;
import org.apache.fineract.organisation.teller.service.TellerWritePlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

/**
 * Without OSGi on the classpath the registrar must no-op (same pattern as rates/document).
 */
class BranchOsgiServiceRegistrarTest {

    @Test
    void afterPropertiesSet_noOpsWithoutOsgi() {
        @SuppressWarnings("unchecked")
        final ObjectProvider<TellerManagementReadPlatformService> read = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<TellerWritePlatformService> write = mock(ObjectProvider.class);
        when(read.getIfAvailable()).thenReturn(mock(TellerManagementReadPlatformService.class));
        when(write.getIfAvailable()).thenReturn(mock(TellerWritePlatformService.class));

        final BranchOsgiServiceRegistrar registrar = new BranchOsgiServiceRegistrar(read, write);
        assertDoesNotThrow(registrar::afterPropertiesSet);
        assertDoesNotThrow(registrar::destroy);
    }
}
