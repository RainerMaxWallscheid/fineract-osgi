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
package org.apache.fineract.shares.shareaccounts.start;

import org.apache.fineract.accounting.moduleapi.SharesJournalPort;
import org.apache.fineract.infrastructure.accountnumberformat.domain.AccountNumberFormatRepositoryWrapper;
import org.apache.fineract.infrastructure.accountnumberformat.service.AccountNumberGeneratorService;
import org.apache.fineract.infrastructure.event.business.service.BusinessEventNotifierService;
import org.apache.fineract.portfolio.note.service.NoteWritePlatformService;
import org.apache.fineract.shares.shareaccounts.domain.ShareAccountRepositoryWrapper;
import org.apache.fineract.shares.shareaccounts.serialization.ShareAccountDataSerializer;
import org.apache.fineract.shares.shareaccounts.service.ShareAccountWritePlatformService;
import org.apache.fineract.shares.shareaccounts.service.ShareAccountWritePlatformServiceJpaRepositoryImpl;
import org.apache.fineract.shares.shareproducts.domain.ShareProductRepositoryWrapper;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ShareAccountWriteConfiguration {

    @Bean
    @ConditionalOnMissingBean(ShareAccountWritePlatformService.class)
    public ShareAccountWritePlatformService shareAccountWritePlatformService(ShareAccountDataSerializer accountDataSerializer,
            ShareAccountRepositoryWrapper shareAccountRepository, ShareProductRepositoryWrapper shareProductRepository,
            AccountNumberGeneratorService accountNumberGenerator, AccountNumberFormatRepositoryWrapper accountNumberFormatRepository,
            SharesJournalPort sharesJournalPort, NoteWritePlatformService noteWritePlatformService,
            BusinessEventNotifierService businessEventNotifierService) {
        return new ShareAccountWritePlatformServiceJpaRepositoryImpl(accountDataSerializer, shareAccountRepository, shareProductRepository,
                accountNumberGenerator, accountNumberFormatRepository, sharesJournalPort, noteWritePlatformService,
                businessEventNotifierService);
    }
}
