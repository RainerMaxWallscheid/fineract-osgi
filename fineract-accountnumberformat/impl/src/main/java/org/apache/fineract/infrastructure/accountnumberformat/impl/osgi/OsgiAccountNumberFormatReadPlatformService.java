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
package org.apache.fineract.infrastructure.accountnumberformat.impl.osgi;

import java.util.List;
import org.apache.fineract.infrastructure.accountnumberformat.data.AccountNumberFormatData;
import org.apache.fineract.infrastructure.accountnumberformat.domain.EntityAccountType;
import org.apache.fineract.infrastructure.accountnumberformat.service.AccountNumberFormatReadPlatformService;

/**
 * Empty account-number-format catalog for Equinox without Spring/JPA.
 */
final class OsgiAccountNumberFormatReadPlatformService implements AccountNumberFormatReadPlatformService {

    @Override
    public List<AccountNumberFormatData> getAllAccountNumberFormats() {
        return List.of();
    }

    @Override
    public AccountNumberFormatData getAccountNumberFormat(final Long id) {
        return null;
    }

    @Override
    public AccountNumberFormatData retrieveTemplate(final EntityAccountType entityAccountTypeForTemplate) {
        return null;
    }
}
