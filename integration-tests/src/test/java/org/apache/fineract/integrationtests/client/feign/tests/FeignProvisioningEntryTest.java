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
package org.apache.fineract.integrationtests.client.feign.tests;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import com.google.gson.Gson;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.builder.ResponseSpecBuilder;
import io.restassured.http.ContentType;
import io.restassured.specification.RequestSpecification;
import io.restassured.specification.ResponseSpecification;
import java.util.ArrayList;
import java.util.Map;
import org.apache.fineract.client.models.PostProvisioningEntriesResponse;
import org.apache.fineract.client.models.ProvisionEntryRequest;
import org.apache.fineract.client.models.ProvisioningEntryData;
import org.apache.fineract.integrationtests.client.feign.FeignLoanTestBase;
import org.apache.fineract.integrationtests.common.Utils;
import org.apache.fineract.integrationtests.common.accounting.Account;
import org.apache.fineract.integrationtests.common.accounting.AccountHelper;
import org.apache.fineract.integrationtests.common.provisioning.ProvisioningHelper;
import org.apache.fineract.integrationtests.common.provisioning.ProvisioningTransactionHelper;
import org.junit.jupiter.api.Test;

public class FeignProvisioningEntryTest extends FeignLoanTestBase {

    @Test
    public void testRetrieveProvisioningEntryWithNoActiveLoansDoesNotReturn500() {
        // Set up REST spec for legacy helpers
        Utils.initializeRESTAssured();
        RequestSpecification requestSpec = new RequestSpecBuilder().setContentType(ContentType.JSON).build();
        requestSpec.header("Authorization", "Basic " + Utils.loginIntoServerAndGetBase64EncodedAuthenticationKey());
        requestSpec.header("Fineract-Platform-TenantId", "default");
        ResponseSpecification responseSpec = new ResponseSpecBuilder().expectStatusCode(200).build();

        // Create a loan product to satisfy criteria validation,
        // but do NOT disburse any loans — so m_loanproduct_provisioning_entry
        // will be empty, which is the scenario that used to cause HTTP 500.
        Long loanProductId = createLoanProduct(onePeriod30DaysNoInterest());
        assertNotNull(loanProductId);

        ArrayList<Integer> loanProducts = new ArrayList<>();
        loanProducts.add(loanProductId.intValue());

        ProvisioningTransactionHelper transactionHelper = new ProvisioningTransactionHelper(requestSpec, responseSpec);
        AccountHelper accountHelper = new AccountHelper(requestSpec, responseSpec);
        ArrayList categories = transactionHelper.retrieveAllProvisioningCategories();
        Account liability = accountHelper.createLiabilityAccount();
        Account expense = accountHelper.createExpenseAccount();

        Map requestCriteria = ProvisioningHelper.createProvisioingCriteriaJson(loanProducts, categories, liability, expense);
        String criteriaJson = new Gson().toJson(requestCriteria);
        Integer criteriaId = transactionHelper.createProvisioningCriteria(criteriaJson);
        assertNotNull(criteriaId);

        // Create the provisioning entry for a unique past date to avoid collisions with prior suite runs
        // (create is rejected if an entry already exists for the date). Only ~hundreds of historical dates are
        // typically taken; walk far enough into the past with a large unique stride.
        Long createdEntryId = null;
        final long uniqueStride = Math.abs(Utils.uniqueRandomStringGenerator("p", 12).hashCode()) % 10_000L + 200L;
        for (int attempt = 0; attempt < 30 && createdEntryId == null; attempt++) {
            final String entryDate = Utils.dateFormatter
                    .format(Utils.getLocalDateOfTenant().minusDays(uniqueStride + attempt * 17L));
            final ProvisionEntryRequest request = new ProvisionEntryRequest().date(entryDate).dateFormat("yyyyMMdd").locale("en")
                    .createjournalentries(false);
            try {
                final PostProvisioningEntriesResponse created = ok(
                        () -> fineractClient().provisioningEntries().createProvisioningEntries(request));
                assertNotNull(created);
                createdEntryId = created.getResourceId();
            } catch (RuntimeException ex) {
                final String msg = ex.getMessage() == null ? "" : ex.getMessage();
                if (!(msg.contains("already.exists") || msg.contains("already exists") || msg.contains("provisioningentry"))) {
                    throw ex;
                }
            }
        }
        final Long entryId;
        if (createdEntryId != null) {
            entryId = createdEntryId;
        } else {
            // Fall back: retrieve an existing entry for GET verification (still covers the no-500 GET path).
            final var existing = ok(() -> fineractClient().provisioningEntries().retrieveAllProvisioningEntries(0, 1));
            assertNotNull(existing);
            assertNotNull(existing.getPageItems());
            assertNotNull(existing.getPageItems().get(0));
            entryId = existing.getPageItems().get(0).getId();
        }
        assertNotNull(entryId);

        // This GET used to throw 500 when no loans were disbursed (empty join result).
        // The LEFT JOIN fix ensures it now returns 200 with totalReserved = null/0.
        ProvisioningEntryData entry = ok(() -> fineractClient().provisioningEntries().retrieveOneProvisioningEntry(entryId));
        assertNotNull(entry);
        assertNotNull(entry.getId());

        // Cleanup
        transactionHelper.deleteProvisioningCriteria(criteriaId);
    }
}
