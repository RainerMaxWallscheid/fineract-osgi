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
package org.apache.fineract.portfolio.shares.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.portfolio.accounts.service.AccountReadPlatformService;
import org.apache.fineract.portfolio.shareaccounts.service.PurchasedSharesReadPlatformService;
import org.apache.fineract.portfolio.shareaccounts.service.ShareAccountDividendReadPlatformService;
import org.apache.fineract.portfolio.shareaccounts.service.ShareAccountReadPlatformService;
import org.apache.fineract.portfolio.shareaccounts.service.ShareAccountSchedularService;
import org.apache.fineract.portfolio.shareaccounts.service.ShareAccountWritePlatformService;
import org.apache.fineract.portfolio.shareproducts.service.ShareProductDividendReadPlatformService;
import org.apache.fineract.portfolio.shareproducts.service.ShareProductDropdownReadPlatformService;
import org.apache.fineract.portfolio.shareproducts.service.ShareProductWritePlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class SharesOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider[] providers = new ObjectProvider[9];
        for (int i = 0; i < providers.length; i++) {
            providers[i] = mock(ObjectProvider.class);
            when(providers[i].getIfAvailable()).thenReturn(null);
        }
        var reg = new SharesOsgiServiceRegistrar(
                (ObjectProvider<ShareAccountReadPlatformService>) providers[0],
                (ObjectProvider<ShareAccountWritePlatformService>) providers[1],
                (ObjectProvider<ShareAccountSchedularService>) providers[2],
                (ObjectProvider<ShareAccountDividendReadPlatformService>) providers[3],
                (ObjectProvider<PurchasedSharesReadPlatformService>) providers[4],
                (ObjectProvider<ShareProductWritePlatformService>) providers[5],
                (ObjectProvider<ShareProductDropdownReadPlatformService>) providers[6],
                (ObjectProvider<ShareProductDividendReadPlatformService>) providers[7],
                (ObjectProvider<AccountReadPlatformService>) providers[8]);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
