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
package org.apache.fineract.portfolio.charge.adapter;

import java.util.List;
import java.util.Map;
import org.apache.fineract.accounting.common.AccountingDropdownReadPlatformService;
import org.apache.fineract.accounting.glaccount.data.GLAccountData;
import org.apache.fineract.portfolio.charge.service.ChargeAccountingDropdownPort;
import org.springframework.stereotype.Component;

/**
 * Bridges charge-impl accounting dropdown port to the accounting module service
 * (avoids charge-impl → accounting → charge cycle).
 */
@Component
public class ChargeAccountingDropdownPortAdapter implements ChargeAccountingDropdownPort {

    private final AccountingDropdownReadPlatformService accountingDropdownReadPlatformService;

    public ChargeAccountingDropdownPortAdapter(final AccountingDropdownReadPlatformService accountingDropdownReadPlatformService) {
        this.accountingDropdownReadPlatformService = accountingDropdownReadPlatformService;
    }

    @Override
    public Map<String, List<GLAccountData>> retrieveAccountMappingOptionsForCharges() {
        return this.accountingDropdownReadPlatformService.retrieveAccountMappingOptionsForCharges();
    }

    @Override
    public List<GLAccountData> retrieveExpenseAccountOptions() {
        return this.accountingDropdownReadPlatformService.retrieveExpenseAccountOptions();
    }

    @Override
    public List<GLAccountData> retrieveAssetAccountOptions() {
        return this.accountingDropdownReadPlatformService.retrieveAssetAccountOptions();
    }
}
