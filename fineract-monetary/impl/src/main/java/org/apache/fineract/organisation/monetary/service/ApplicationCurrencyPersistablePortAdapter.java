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
package org.apache.fineract.organisation.monetary.service;

import org.apache.fineract.organisation.monetary.domain.ApplicationCurrency;
import org.apache.fineract.organisation.monetary.domain.ApplicationCurrencyRepository;
import org.apache.fineract.organisation.monetary.moduleapi.ApplicationCurrencyPersistablePort;
import org.springframework.stereotype.Service;

@Service
public class ApplicationCurrencyPersistablePortAdapter implements ApplicationCurrencyPersistablePort {

    private final ApplicationCurrencyRepository applicationCurrencyRepository;

    public ApplicationCurrencyPersistablePortAdapter(final ApplicationCurrencyRepository applicationCurrencyRepository) {
        this.applicationCurrencyRepository = applicationCurrencyRepository;
    }

    @Override
    public Long id(final Object applicationCurrency) {
        if (applicationCurrency instanceof Long applicationCurrencyId) {
            return applicationCurrencyId;
        }
        if (applicationCurrency == null) {
            return null;
        }
        return ((ApplicationCurrency) applicationCurrency).getId();
    }

    @Override
    public Object persistableById(final Long applicationCurrencyId) {
        if (applicationCurrencyId == null) {
            return null;
        }
        return this.applicationCurrencyRepository.findById(applicationCurrencyId).orElse(null);
    }
}
