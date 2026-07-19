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
package org.apache.fineract.integrationtests.common.externalevents;

import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
import io.restassured.specification.RequestSpecification;
import io.restassured.specification.ResponseSpecification;
import java.util.List;
import java.util.Map;
import org.apache.fineract.client.models.ExternalEventConfigurationUpdateRequest;
import org.apache.fineract.client.models.ExternalEventConfigurationUpdateResponse;
import org.apache.fineract.client.util.Calls;
import org.apache.fineract.client.util.JSON;
import org.apache.fineract.infrastructure.event.external.data.ExternalEventResponse;
import org.apache.fineract.integrationtests.common.ExternalEventConfigurationHelper;
import org.apache.fineract.integrationtests.common.FineractClientHelper;
import org.apache.fineract.integrationtests.common.Utils;
import org.junit.jupiter.api.Assertions;

public final class ExternalEventHelper {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(ExternalEventHelper.class);
    private static final Gson GSON = new JSON().getGson();

    public ExternalEventHelper() {
    }


    public static class Filter {
        private final String idempotencyKey;
        private final String type;
        private final String category;
        private final Long aggregateRootId;

        public String toQueryParams() {
            StringBuilder stringBuilder = new StringBuilder();
            if (idempotencyKey != null) {
                stringBuilder.append("idempotencyKey=").append(idempotencyKey).append("&");
            }
            if (type != null) {
                stringBuilder.append("type=").append(type).append("&");
            }
            if (category != null) {
                stringBuilder.append("category=").append(category).append("&");
            }
            if (aggregateRootId != null) {
                stringBuilder.append("aggregateRootId=").append(aggregateRootId).append("&");
            }
            return stringBuilder.toString();
        }

        @java.lang.SuppressWarnings("all")
                Filter(final String idempotencyKey, final String type, final String category, final Long aggregateRootId) {
            this.idempotencyKey = idempotencyKey;
            this.type = type;
            this.category = category;
            this.aggregateRootId = aggregateRootId;
        }


        @java.lang.SuppressWarnings("all")
                public static class FilterBuilder {
            @java.lang.SuppressWarnings("all")
                        private String idempotencyKey;
            @java.lang.SuppressWarnings("all")
                        private String type;
            @java.lang.SuppressWarnings("all")
                        private String category;
            @java.lang.SuppressWarnings("all")
                        private Long aggregateRootId;

            @java.lang.SuppressWarnings("all")
                        FilterBuilder() {
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public ExternalEventHelper.Filter.FilterBuilder idempotencyKey(final String idempotencyKey) {
                this.idempotencyKey = idempotencyKey;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public ExternalEventHelper.Filter.FilterBuilder type(final String type) {
                this.type = type;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public ExternalEventHelper.Filter.FilterBuilder category(final String category) {
                this.category = category;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public ExternalEventHelper.Filter.FilterBuilder aggregateRootId(final Long aggregateRootId) {
                this.aggregateRootId = aggregateRootId;
                return this;
            }

            @java.lang.SuppressWarnings("all")
                        public ExternalEventHelper.Filter build() {
                return new ExternalEventHelper.Filter(this.idempotencyKey, this.type, this.category, this.aggregateRootId);
            }

            @java.lang.Override
            @java.lang.SuppressWarnings("all")
                        public java.lang.String toString() {
                return "ExternalEventHelper.Filter.FilterBuilder(idempotencyKey=" + this.idempotencyKey + ", type=" + this.type + ", category=" + this.category + ", aggregateRootId=" + this.aggregateRootId + ")";
            }
        }

        @java.lang.SuppressWarnings("all")
                public static ExternalEventHelper.Filter.FilterBuilder builder() {
            return new ExternalEventHelper.Filter.FilterBuilder();
        }
    }

    // TODO: Rewrite to use fineract-client instead!
    // Example: org.apache.fineract.integrationtests.common.loans.LoanTransactionHelper.disburseLoan(java.lang.Long,
    // org.apache.fineract.client.models.PostLoansLoanIdRequest)
    @Deprecated(forRemoval = true)
    public static List<ExternalEventResponse> getAllExternalEvents(final RequestSpecification requestSpec, final ResponseSpecification responseSpec) {
        final String url = "/fineract-provider/api/v1/internal/externalevents?" + Utils.TENANT_IDENTIFIER;
        log.info("---------------------------------GETTING ALL EXTERNAL EVENTS---------------------------------------------");
        String response = Utils.performServerGet(requestSpec, responseSpec, url);
        return GSON.fromJson(response, new TypeToken<List<ExternalEventResponse>>() {
        }.getType());
    }

    // TODO: Rewrite to use fineract-client instead!
    // Example: org.apache.fineract.integrationtests.common.loans.LoanTransactionHelper.disburseLoan(java.lang.Long,
    // org.apache.fineract.client.models.PostLoansLoanIdRequest)
    @Deprecated(forRemoval = true)
    public static List<ExternalEventResponse> getAllExternalEvents(final RequestSpecification requestSpec, final ResponseSpecification responseSpec, Filter filter) {
        final String url = "/fineract-provider/api/v1/internal/externalevents?" + filter.toQueryParams() + Utils.TENANT_IDENTIFIER;
        log.info("---------------------------------GETTING ALL EXTERNAL EVENTS---------------------------------------------");
        String response = Utils.performServerGet(requestSpec, responseSpec, url);
        return GSON.fromJson(response, new TypeToken<List<ExternalEventResponse>>() {
        }.getType());
    }

    // TODO: Rewrite to use fineract-client instead!
    // Example: org.apache.fineract.integrationtests.common.loans.LoanTransactionHelper.disburseLoan(java.lang.Long,
    // org.apache.fineract.client.models.PostLoansLoanIdRequest)
    @Deprecated(forRemoval = true)
    public static void deleteAllExternalEvents(final RequestSpecification requestSpec, final ResponseSpecification responseSpec) {
        final String url = "/fineract-provider/api/v1/internal/externalevents?" + Utils.TENANT_IDENTIFIER;
        log.info("-----------------------------DELETE ALL EXTERNAL EVENTS PARTITIONS----------------------------------------");
        Utils.performServerDelete(requestSpec, responseSpec, url, null);
    }

    // TODO: Rewrite to use fineract-client instead!
    // Example: org.apache.fineract.integrationtests.common.loans.LoanTransactionHelper.disburseLoan(java.lang.Long,
    // org.apache.fineract.client.models.PostLoansLoanIdRequest)
    @Deprecated(forRemoval = true)
    public static void changeEventState(final RequestSpecification requestSpec, final ResponseSpecification responseSpec, String eventName, boolean status) {
        final Map<String, Boolean> updatedConfigurations = ExternalEventConfigurationHelper.updateExternalEventConfigurations(requestSpec, responseSpec, "{\"externalEventConfigurations\":{\"" + eventName + "\":" + status + "}}\n");
        Assertions.assertEquals(updatedConfigurations.size(), 1);
        Assertions.assertTrue(updatedConfigurations.containsKey(eventName));
        Assertions.assertEquals(status, updatedConfigurations.get(eventName));
    }

    public void configureBusinessEvent(String eventName, boolean enabled) {
        ExternalEventConfigurationUpdateResponse result = Calls.ok(FineractClientHelper.getFineractClient().externalEventConfigurationApi.updateExternalEventConfigurations(new ExternalEventConfigurationUpdateRequest().externalEventConfigurations(Map.of(eventName, enabled))));
        Map<String, Object> changes = result.getChanges();
        Assertions.assertNotNull(changes);
        Assertions.assertInstanceOf(Map.class, changes);
        Map<String, Boolean> updatedConfigurations = (Map<String, Boolean>) changes.get("externalEventConfigurations");
        Assertions.assertNotNull(updatedConfigurations);
        Assertions.assertEquals(1, updatedConfigurations.size());
        Assertions.assertTrue(updatedConfigurations.containsKey(eventName));
        Assertions.assertEquals(enabled, updatedConfigurations.get(eventName));
    }

    public void enableBusinessEvent(String eventName) {
        configureBusinessEvent(eventName, true);
    }

    public void disableBusinessEvent(String eventName) {
        configureBusinessEvent(eventName, false);
    }
}
