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
package org.apache.fineract.infrastructure.businessdate.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.infrastructure.businessdate.service.BusinessDateReadPlatformService;
import org.apache.fineract.infrastructure.businessdate.service.BusinessDateWritePlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class BusinessDateOsgiServiceRegistrarTest {

    @Test
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        @SuppressWarnings("unchecked")
        final ObjectProvider<BusinessDateReadPlatformService> read = mock(ObjectProvider.class);
        @SuppressWarnings("unchecked")
        final ObjectProvider<BusinessDateWritePlatformService> write = mock(ObjectProvider.class);
        when(read.getIfAvailable()).thenReturn(null);
        when(write.getIfAvailable()).thenReturn(null);

        final BusinessDateOsgiServiceRegistrar registrar = new BusinessDateOsgiServiceRegistrar(read, write);
        assertDoesNotThrow(registrar::afterPropertiesSet);
        assertDoesNotThrow(registrar::destroy);
    }
}
