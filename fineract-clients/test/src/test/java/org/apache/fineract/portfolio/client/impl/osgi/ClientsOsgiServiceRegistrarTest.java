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
package org.apache.fineract.portfolio.client.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.portfolio.client.service.ClientChargeWritePlatformService;
import org.apache.fineract.portfolio.client.service.ClientFamilyMembersReadPlatformService;
import org.apache.fineract.portfolio.client.service.ClientFamilyMembersWritePlatformService;
import org.apache.fineract.portfolio.client.service.ClientIdentifierReadPlatformService;
import org.apache.fineract.portfolio.client.service.ClientIdentifierWritePlatformService;
import org.apache.fineract.portfolio.client.moduleapi.ClientReadPlatformService;
import org.apache.fineract.portfolio.client.service.ClientTemplateReadPlatformService;
import org.apache.fineract.portfolio.client.service.ClientTransactionReadPlatformService;
import org.apache.fineract.portfolio.client.service.ClientTransactionWritePlatformService;
import org.apache.fineract.portfolio.client.service.ClientWritePlatformService;
import org.apache.fineract.portfolio.client.service.search.ClientSearchService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class ClientsOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider[] providers = new ObjectProvider[11];
        for (int i = 0; i < providers.length; i++) {
            providers[i] = mock(ObjectProvider.class);
            when(providers[i].getIfAvailable()).thenReturn(null);
        }
        var reg = new ClientsOsgiServiceRegistrar(
                (ObjectProvider<ClientReadPlatformService>) providers[0],
                (ObjectProvider<ClientWritePlatformService>) providers[1],
                (ObjectProvider<ClientTemplateReadPlatformService>) providers[2],
                (ObjectProvider<ClientFamilyMembersReadPlatformService>) providers[3],
                (ObjectProvider<ClientFamilyMembersWritePlatformService>) providers[4],
                (ObjectProvider<ClientIdentifierReadPlatformService>) providers[5],
                (ObjectProvider<ClientIdentifierWritePlatformService>) providers[6],
                (ObjectProvider<ClientTransactionReadPlatformService>) providers[7],
                (ObjectProvider<ClientTransactionWritePlatformService>) providers[8],
                (ObjectProvider<ClientChargeWritePlatformService>) providers[9],
                (ObjectProvider<ClientSearchService>) providers[10]);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
