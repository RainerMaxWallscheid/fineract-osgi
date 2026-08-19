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
package org.apache.fineract.portfolio.workingcapitalloanproduct.service;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import org.apache.fineract.accounting.common.AccountingConstants;
import org.apache.fineract.accounting.glaccount.data.GLAccountData;
import org.apache.fineract.accounting.moduleapi.ProductToGLAccountMappingReadPlatformService;
import org.apache.fineract.accounting.moduleapi.ProductToGLAccountMappingWritePlatformService;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.exception.PlatformApiDataValidationException;
import org.apache.fineract.infrastructure.core.serialization.FromJsonHelper;
import org.apache.fineract.portfolio.workingcapitalloanproduct.domain.WorkingCapitalAccountingRuleType;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class WorkingCapitalProductAccountingMappingServiceImpl implements WorkingCapitalProductAccountingMappingService {
    private final ProductToGLAccountMappingWritePlatformService accountMappingWritePlatformService;
    private final ProductToGLAccountMappingReadPlatformService accountMappingReadPlatformService;
    private final FromJsonHelper fromApiJsonHelper;

    private void validateCreateAccountMapping(final JsonElement element, String arrayName, String key) {
        final JsonArray array = this.fromApiJsonHelper.extractJsonArrayNamed(arrayName, element);
        if (array != null) {
            ArrayList<String> values = new ArrayList<>(array.size());
            for (int i = 0; i < array.size(); i++) {
                final JsonObject jsonObject = array.get(i).getAsJsonObject();
                if (jsonObject.get(key) != null) {
                    String value = jsonObject.get(key).getAsString();
                    if (!values.contains(value)) {
                        values.add(value);
                    } else {
                        String e = arrayName + "." + key;
                        throw new PlatformApiDataValidationException("duplicated.enrty.for." + e, "Duplicated entry for " + e, e);
                    }
                }
            }
        }
    }

    @Override
    @Transactional
    public void createAccountMapping(final Long wcLoanProductId, final JsonCommand command) {
        final JsonElement element = this.fromApiJsonHelper.parse(command.json());
        final String accountingRuleValue = this.fromApiJsonHelper.extractStringNamed("accountingRule", element);
        final WorkingCapitalAccountingRuleType accountingRuleType = WorkingCapitalAccountingRuleType.valueOf(accountingRuleValue);
        validateCreateAccountMapping(element, AccountingConstants.LoanProductAccountingParams.PAYMENT_CHANNEL_FUND_SOURCE_MAPPING.getValue(), AccountingConstants.LoanProductAccountingParams.PAYMENT_TYPE.getValue());
        validateCreateAccountMapping(element, AccountingConstants.LoanProductAccountingParams.PENALTY_INCOME_ACCOUNT_MAPPING.getValue(), AccountingConstants.LoanProductAccountingParams.CHARGE_ID.getValue());
        validateCreateAccountMapping(element, AccountingConstants.LoanProductAccountingParams.FEE_INCOME_ACCOUNT_MAPPING.getValue(), AccountingConstants.LoanProductAccountingParams.CHARGE_ID.getValue());
        validateCreateAccountMapping(element, AccountingConstants.LoanProductAccountingParams.CHARGE_OFF_REASON_TO_EXPENSE_ACCOUNT_MAPPINGS.getValue(), AccountingConstants.LoanProductAccountingParams.CHARGE_OFF_REASON_CODE_VALUE_ID.getValue());
        validateCreateAccountMapping(element, AccountingConstants.LoanProductAccountingParams.WRITE_OFF_REASON_TO_EXPENSE_ACCOUNT_MAPPINGS.getValue(), AccountingConstants.LoanProductAccountingParams.WRITE_OFF_REASON_CODE_VALUE_ID.getValue());
        if (accountingRuleType.isAccrualWithDeferredRevenueAmortization()) {
            this.accountMappingWritePlatformService.createWorkingCapitalLoanProductToGLAccountMapping(wcLoanProductId, command);
        }
    }

    @Override
    @Transactional
    public Map<String, Object> updateAccountMapping(final Long wcLoanProductId, final JsonCommand command, final boolean accountingRuleChanged, final WorkingCapitalAccountingRuleType accountingRuleType) {
        if (accountingRuleChanged) {
            this.accountMappingWritePlatformService.deleteWorkingCapitalLoanProductToGLAccountMapping(wcLoanProductId);
            if (accountingRuleType.isAccrualWithDeferredRevenueAmortization()) {
                return this.accountMappingWritePlatformService.updateWorkingCapitalLoanProductToGLAccountMapping(wcLoanProductId, command,
                        true);
            }
            return new HashMap<>();
        }
        if (accountingRuleType.isAccrualWithDeferredRevenueAmortization()) {
            return this.accountMappingWritePlatformService.updateWorkingCapitalLoanProductToGLAccountMapping(wcLoanProductId, command,
                    false);
        }
        return new HashMap<>();
    }

    @Override
    @Transactional
    public void deleteAccountMapping(final Long wcLoanProductId) {
        this.accountMappingWritePlatformService.deleteWorkingCapitalLoanProductToGLAccountMapping(wcLoanProductId);
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, GLAccountData> fetchAccountMappingDetails(final Long wcLoanProductId, final WorkingCapitalAccountingRuleType accountingRuleType) {
        final Map<String, GLAccountData> accountMappingDetails = new HashMap<>();
        if (!accountingRuleType.isAccrualWithDeferredRevenueAmortization()) {
            return accountMappingDetails;
        }
        return this.accountMappingReadPlatformService.fetchAccountMappingDetailsForWorkingCapitalLoanProduct(wcLoanProductId);
    }

    public WorkingCapitalProductAccountingMappingServiceImpl(final ProductToGLAccountMappingWritePlatformService accountMappingWritePlatformService,
            final ProductToGLAccountMappingReadPlatformService accountMappingReadPlatformService, final FromJsonHelper fromApiJsonHelper) {
        this.accountMappingWritePlatformService = accountMappingWritePlatformService;
        this.accountMappingReadPlatformService = accountMappingReadPlatformService;
        this.fromApiJsonHelper = fromApiJsonHelper;
    }
}
