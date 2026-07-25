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
package org.apache.fineract.integrationtests.organization.teller;

import com.google.gson.Gson;
import io.restassured.specification.RequestSpecification;
import io.restassured.specification.ResponseSpecification;
import java.util.HashMap;
import java.util.Map;
import org.apache.fineract.client.models.GetTellersTellerIdCashiersCashiersIdSummaryAndTransactionsResponse;
import org.apache.fineract.client.models.GetTellersTellerIdCashiersCashiersIdTransactionsResponse;
import org.apache.fineract.client.util.Calls;
import org.apache.fineract.integrationtests.common.FineractClientHelper;
import org.apache.fineract.integrationtests.common.Utils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CashierTransactionsHelper {

    private final ResponseSpecification responseSpecification;
    private final RequestSpecification requestSpecification;

    private static final String CREATE_TELLER_URL = "/fineract-provider/api/v1/tellers";
    private static final Logger LOG = LoggerFactory.getLogger(CashierTransactionsHelper.class);

    // TODO: Rewrite to use fineract-client instead!
    // Example: org.apache.fineract.integrationtests.common.loans.LoanTransactionHelper.disburseLoan(java.lang.Long,
    // org.apache.fineract.client.models.PostLoansLoanIdRequest)
    @Deprecated(forRemoval = true)
    public CashierTransactionsHelper(final RequestSpecification requestSpecification, final ResponseSpecification responseSpecification) {
        this.requestSpecification = requestSpecification;
        this.responseSpecification = responseSpecification;
    }

    public GetTellersTellerIdCashiersCashiersIdTransactionsResponse getTellersTellerIdCashiersCashiersIdTransactionsResponse(Long tellerId,
            Long cashierId, String currencyCode, int offset, int limit, String orderBy, String sortOrder) {
        return Calls.ok(FineractClientHelper.getFineractClient().tellers.retrieveCashierTransactions(tellerId, cashierId, currencyCode,
                offset, limit, orderBy, sortOrder));
    }

    public GetTellersTellerIdCashiersCashiersIdSummaryAndTransactionsResponse getTellersTellerIdCashiersCashiersIdSummaryAndTransactionsResponse(
            Long tellerId, Long cashierId, String currencyCode, int offset, int limit, String orderBy, String sortOrder) {
        return Calls.ok(FineractClientHelper.getFineractClient().tellers.retrieveCashierTransactionsWithSummary(tellerId, cashierId,
                currencyCode, offset, limit, orderBy, sortOrder));
    }

    // TODO: Rewrite to use fineract-client instead!
    // Example: org.apache.fineract.integrationtests.common.loans.LoanTransactionHelper.disburseLoan(java.lang.Long,
    // org.apache.fineract.client.models.PostLoansLoanIdRequest)
    @Deprecated(forRemoval = true)
    public static Integer createTeller(final RequestSpecification requestSpec, final ResponseSpecification responseSpec) {
        return (Integer) createTellerWithJson(requestSpec, responseSpec, createTellerAsJSON()).get("resourceId");
    }

    // TODO: Rewrite to use fineract-client instead!
    // Example: org.apache.fineract.integrationtests.common.loans.LoanTransactionHelper.disburseLoan(java.lang.Long,
    // org.apache.fineract.client.models.PostLoansLoanIdRequest)
    @Deprecated(forRemoval = true)
    public static Map<String, Object> createTellerWithJson(final RequestSpecification requestSpec, final ResponseSpecification responseSpec,
            final String json) {

        final String url = CREATE_TELLER_URL + "?" + Utils.TENANT_IDENTIFIER;
        return Utils.performServerPost(requestSpec, responseSpec, url, json, "");
    }

    // TODO: Rewrite to use fineract-client instead!
    // Example: org.apache.fineract.integrationtests.common.loans.LoanTransactionHelper.disburseLoan(java.lang.Long,
    // org.apache.fineract.client.models.PostLoansLoanIdRequest)
    @Deprecated(forRemoval = true)
    public static String createTellerAsJSON() {

        final Map<String, Object> map = getMapWithStartDate();

        map.put("officeId", 1);
        map.put("name", Utils.uniqueRandomStringGenerator("Teller 1", 5));
        map.put("description", Utils.uniqueRandomStringGenerator("Teller For Testing", 4));
        map.put("status", 300);

        LOG.info("map :  {}", map);
        return new Gson().toJson(map);
    }

    // TODO: Rewrite to use fineract-client instead!
    // Example: org.apache.fineract.integrationtests.common.loans.LoanTransactionHelper.disburseLoan(java.lang.Long,
    // org.apache.fineract.client.models.PostLoansLoanIdRequest)
    @Deprecated(forRemoval = true)
    public static Map<String, Object> getMapWithStartDate() {
        HashMap<String, Object> map = new HashMap<>();

        map.put("locale", "en");
        map.put("dateFormat", "yyyyMMdd");
        map.put("startDate", "20110920");

        return map;
    }

    // TODO: Rewrite to use fineract-client instead!
    // Example: org.apache.fineract.integrationtests.common.loans.LoanTransactionHelper.disburseLoan(java.lang.Long,
    // org.apache.fineract.client.models.PostLoansLoanIdRequest)
    @Deprecated(forRemoval = true)
    public static Integer createCashier(final RequestSpecification requestSpec, final ResponseSpecification responseSpec) {
        return createCashier(requestSpec, responseSpec, 1, 1);
    }

    /**
     * Allocate a cashier on the given teller/staff with a unique date range to avoid
     * {@code CashierAlreadyAllocated} collisions across suite runs.
     */
    @Deprecated(forRemoval = true)
    public static Integer createCashier(final RequestSpecification requestSpec, final ResponseSpecification responseSpec,
            final Integer tellerId, final Integer staffId) {
        return (Integer) createCashierWithJson(requestSpec, responseSpec, tellerId, createCashierAsJSON(staffId)).get("resourceId");
    }

    public static Map<String, Object> createCashierWithJson(final RequestSpecification requestSpec,
            final ResponseSpecification responseSpec, final Integer tellerId, final String json) {
        final String url = "/fineract-provider/api/v1/tellers/" + tellerId + "/cashiers?" + Utils.TENANT_IDENTIFIER;
        return Utils.performServerPost(requestSpec, responseSpec, url, json, "");
    }

    // TODO: Rewrite to use fineract-client instead!
    // Example: org.apache.fineract.integrationtests.common.loans.LoanTransactionHelper.disburseLoan(java.lang.Long,
    // org.apache.fineract.client.models.PostLoansLoanIdRequest)
    @Deprecated(forRemoval = true)
    public static String createCashierAsJSON() {
        return createCashierAsJSON(1);
    }

    @Deprecated(forRemoval = true)
    public static String createCashierAsJSON(final Integer staffId) {

        final Map<String, Object> map = getMapWithDates();

        map.put("staffId", staffId);
        map.put("description", Utils.uniqueRandomStringGenerator("test__", 4));
        LOG.info("map :  {}", map);
        return new Gson().toJson(map);
    }

    // TODO: Rewrite to use fineract-client instead!
    // Example: org.apache.fineract.integrationtests.common.loans.LoanTransactionHelper.disburseLoan(java.lang.Long,
    // org.apache.fineract.client.models.PostLoansLoanIdRequest)
    @Deprecated(forRemoval = true)
    public static Map<String, Object> getMapWithDates() {
        HashMap<String, Object> map = new HashMap<>();

        map.put("locale", "en");
        map.put("dateFormat", "yyyyMMdd");
        // Teller fixtures start on 20110920 (see getMapWithStartDate). Cashier range must sit inside the teller
        // window; use a unique single day after that to avoid CashierAlreadyAllocated when staff is reused.
        final int dayOffset = Math.floorMod(Utils.uniqueRandomStringGenerator("c", 8).hashCode(), 5000);
        final java.time.LocalDate day = java.time.LocalDate.of(2012, 1, 1).plusDays(dayOffset);
        final String dayStr = day.format(java.time.format.DateTimeFormatter.BASIC_ISO_DATE);
        map.put("startDate", dayStr);
        map.put("endDate", dayStr);
        map.put("isFullDay", true);

        return map;
    }

}
