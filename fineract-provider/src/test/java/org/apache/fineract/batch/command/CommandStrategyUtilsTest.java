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
package org.apache.fineract.batch.command;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Stream;
import org.apache.fineract.batch.domain.BatchRequest;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;

class CommandStrategyUtilsTest {
    @Test
    public void testRelativeUrlWithoutVersionRemovesV1() {
        // given
        BatchRequest request = new BatchRequest();
        request.setRelativeUrl("v1/clients/123");
        // when
        String result = CommandStrategyUtils.relativeUrlWithoutVersion(request);
        // then
        assertThat(result).isEqualTo("clients/123");
    }

    @Test
    public void testRelativeUrlWithoutVersionRemovesV2() {
        // given
        BatchRequest request = new BatchRequest();
        request.setRelativeUrl("v2/clients/123");
        // when
        String result = CommandStrategyUtils.relativeUrlWithoutVersion(request);
        // then
        assertThat(result).isEqualTo("clients/123");
    }

    @Test
    public void testRelativeUrlWithoutVersionRemovesV12() {
        // given
        BatchRequest request = new BatchRequest();
        request.setRelativeUrl("v12/clients/123");
        // when
        String result = CommandStrategyUtils.relativeUrlWithoutVersion(request);
        // then
        assertThat(result).isEqualTo("clients/123");
    }

    @Test
    public void testRelativeUrlWithoutVersionRemovesV1WhenQueryParamsPresent() {
        // given
        BatchRequest request = new BatchRequest();
        request.setRelativeUrl("v1/clients/123?command=action&something=else");
        // when
        String result = CommandStrategyUtils.relativeUrlWithoutVersion(request);
        // then
        assertThat(result).isEqualTo("clients/123?command=action&something=else");
    }

    @Test
    public void testRelativeUrlWithoutVersionRemovesNothing() {
        // given
        BatchRequest request = new BatchRequest();
        request.setRelativeUrl("clients/123");
        // when
        String result = CommandStrategyUtils.relativeUrlWithoutVersion(request);
        // then
        assertThat(result).isEqualTo("clients/123");
    }

    @Test
    public void testRelativeUrlWithoutVersionRemovesNothingWhenQueryParamsPresent() {
        // given
        BatchRequest request = new BatchRequest();
        request.setRelativeUrl("clients/123?command=action&something=else");
        // when
        String result = CommandStrategyUtils.relativeUrlWithoutVersion(request);
        // then
        assertThat(result).isEqualTo("clients/123?command=action&something=else");
    }

    // Tests for buildRequestFromQueryParameters method
    private static Stream<Arguments> typeConversionTestCases() {
        return Stream.of(Arguments.of("stringField", "testValue", (Object) "testValue"), Arguments.of("integerField", "42", 42), Arguments.of("longField", "9876543210", 9876543210L), Arguments.of("bigDecimalField", "123.456", new BigDecimal("123.456")), Arguments.of("bigDecimalField", "0.1000000000000000055511151231257827021181583404541015625", new BigDecimal("0.1000000000000000055511151231257827021181583404541015625")), Arguments.of("doubleField", "3.14", 3.14), Arguments.of("booleanField", "true", true), Arguments.of("booleanField", "false", false), Arguments.of("booleanField", "TRUE", true));
    }

    @ParameterizedTest
    @MethodSource("typeConversionTestCases")
    public void testBuildRequestFromQueryParametersTypeConversion(String fieldName, String value, Object expectedValue) {
        // given
        Map<String, String> queryParams = new HashMap<>();
        queryParams.put(fieldName, value);
        // when
        TestRequest result = CommandStrategyUtils.buildRequestFromQueryParameters(queryParams, TestRequest.class);
        // then
        assertThat(result).isNotNull();
        Object actualValue = getFieldValue(result, fieldName);
        if (expectedValue instanceof BigDecimal) {
            assertThat((BigDecimal) actualValue).isEqualByComparingTo((BigDecimal) expectedValue);
        } else {
            assertThat(actualValue).isEqualTo(expectedValue);
        }
    }

    private static Stream<Arguments> invalidTypeConversionTestCases() {
        return Stream.of(Arguments.of("integerField", "notANumber"), Arguments.of("longField", "notANumber"), Arguments.of("bigDecimalField", "notANumber"), Arguments.of("doubleField", "notANumber"));
    }

    @ParameterizedTest
    @MethodSource("invalidTypeConversionTestCases")
    public void testBuildRequestFromQueryParametersInvalidTypeConversion(String fieldName, String invalidValue) {
        // given
        Map<String, String> queryParams = new HashMap<>();
        queryParams.put(fieldName, invalidValue);
        // when/then
        assertThatThrownBy(() -> CommandStrategyUtils.buildRequestFromQueryParameters(queryParams, TestRequest.class)).isInstanceOf(RuntimeException.class).hasMessageContaining("Failed to build request object from query parameters").hasCauseInstanceOf(NumberFormatException.class);
    }

    @Test
    public void testBuildRequestFromQueryParametersWithAllFieldTypes() {
        // given
        Map<String, String> queryParams = new HashMap<>();
        queryParams.put("stringField", "testValue");
        queryParams.put("integerField", "42");
        queryParams.put("longField", "9876543210");
        queryParams.put("bigDecimalField", "3.14");
        queryParams.put("doubleField", "2.71");
        queryParams.put("booleanField", "true");
        // when
        TestRequest result = CommandStrategyUtils.buildRequestFromQueryParameters(queryParams, TestRequest.class);
        // then
        assertThat(result).isNotNull();
        assertThat(result.getStringField()).isEqualTo("testValue");
        assertThat(result.getIntegerField()).isEqualTo(42);
        assertThat(result.getLongField()).isEqualTo(9876543210L);
        assertThat(result.getBigDecimalField()).isEqualByComparingTo(new BigDecimal("3.14"));
        assertThat(result.getDoubleField()).isEqualTo(2.71);
        assertThat(result.getBooleanField()).isTrue();
    }

    @Test
    public void testBuildRequestFromQueryParametersWithMissingFields() {
        // given
        Map<String, String> queryParams = new HashMap<>();
        queryParams.put("stringField", "testValue");
        // when
        TestRequest result = CommandStrategyUtils.buildRequestFromQueryParameters(queryParams, TestRequest.class);
        // then
        assertThat(result).isNotNull();
        assertThat(result.getStringField()).isEqualTo("testValue");
        assertThat(result.getIntegerField()).isNull();
        assertThat(result.getLongField()).isNull();
        assertThat(result.getBigDecimalField()).isNull();
        assertThat(result.getDoubleField()).isNull();
        assertThat(result.getBooleanField()).isNull();
    }

    @Test
    public void testBuildRequestFromQueryParametersWithEmptyMap() {
        // given
        Map<String, String> queryParams = new HashMap<>();
        // when
        TestRequest result = CommandStrategyUtils.buildRequestFromQueryParameters(queryParams, TestRequest.class);
        // then
        assertThat(result).isNotNull();
        assertThat(result.getStringField()).isNull();
        assertThat(result.getIntegerField()).isNull();
        assertThat(result.getLongField()).isNull();
        assertThat(result.getBigDecimalField()).isNull();
        assertThat(result.getDoubleField()).isNull();
        assertThat(result.getBooleanField()).isNull();
    }

    @Test
    public void testBuildRequestFromQueryParametersSkipsSerialVersionUID() {
        // given
        Map<String, String> queryParams = new HashMap<>();
        queryParams.put("serialVersionUID", "12345");
        queryParams.put("stringField", "testValue");
        // when
        TestRequest result = CommandStrategyUtils.buildRequestFromQueryParameters(queryParams, TestRequest.class);
        // then
        assertThat(result).isNotNull();
        assertThat(result.getStringField()).isEqualTo("testValue");
    }

    @Test
    public void testBuildRequestFromQueryParametersWithClassWithoutBuilder() {
        // given
        Map<String, String> queryParams = new HashMap<>();
        queryParams.put("field", "value");
        // when/then
        assertThatThrownBy(() -> CommandStrategyUtils.buildRequestFromQueryParameters(queryParams, ClassWithoutBuilder.class)).isInstanceOf(RuntimeException.class).hasMessageContaining("Failed to build request object from query parameters");
    }

    private Object getFieldValue(TestRequest request, String fieldName) {
        switch (fieldName) {
        case "stringField": 
            return request.getStringField();
        case "integerField": 
            return request.getIntegerField();
        case "longField": 
            return request.getLongField();
        case "bigDecimalField": 
            return request.getBigDecimalField();
        case "doubleField": 
            return request.getDoubleField();
        case "booleanField": 
            return request.getBooleanField();
        default: 
            return null;
        }
    }


    static class TestRequest {
        private String stringField;
        private Integer integerField;
        private Long longField;
        private BigDecimal bigDecimalField;
        private Double doubleField;
        private Boolean booleanField;


        @java.lang.SuppressWarnings("all")
                public static class TestRequestBuilder {
            @java.lang.SuppressWarnings("all")
                        private String stringField;
            @java.lang.SuppressWarnings("all")
                        private Integer integerField;
            @java.lang.SuppressWarnings("all")
                        private Long longField;
            @java.lang.SuppressWarnings("all")
                        private BigDecimal bigDecimalField;
            @java.lang.SuppressWarnings("all")
                        private Double doubleField;
            @java.lang.SuppressWarnings("all")
                        private Boolean booleanField;

            @java.lang.SuppressWarnings("all")
                        TestRequestBuilder() {
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public CommandStrategyUtilsTest.TestRequest.TestRequestBuilder stringField(final String stringField) {
                this.stringField = stringField;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public CommandStrategyUtilsTest.TestRequest.TestRequestBuilder integerField(final Integer integerField) {
                this.integerField = integerField;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public CommandStrategyUtilsTest.TestRequest.TestRequestBuilder longField(final Long longField) {
                this.longField = longField;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public CommandStrategyUtilsTest.TestRequest.TestRequestBuilder bigDecimalField(final BigDecimal bigDecimalField) {
                this.bigDecimalField = bigDecimalField;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public CommandStrategyUtilsTest.TestRequest.TestRequestBuilder doubleField(final Double doubleField) {
                this.doubleField = doubleField;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public CommandStrategyUtilsTest.TestRequest.TestRequestBuilder booleanField(final Boolean booleanField) {
                this.booleanField = booleanField;
                return this;
            }

            @java.lang.SuppressWarnings("all")
                        public CommandStrategyUtilsTest.TestRequest build() {
                return new CommandStrategyUtilsTest.TestRequest(this.stringField, this.integerField, this.longField, this.bigDecimalField, this.doubleField, this.booleanField);
            }

            @java.lang.Override
            @java.lang.SuppressWarnings("all")
                        public java.lang.String toString() {
                return "CommandStrategyUtilsTest.TestRequest.TestRequestBuilder(stringField=" + this.stringField + ", integerField=" + this.integerField + ", longField=" + this.longField + ", bigDecimalField=" + this.bigDecimalField + ", doubleField=" + this.doubleField + ", booleanField=" + this.booleanField + ")";
            }
        }

        @java.lang.SuppressWarnings("all")
                public static CommandStrategyUtilsTest.TestRequest.TestRequestBuilder builder() {
            return new CommandStrategyUtilsTest.TestRequest.TestRequestBuilder();
        }

        @java.lang.SuppressWarnings("all")
                public String getStringField() {
            return this.stringField;
        }

        @java.lang.SuppressWarnings("all")
                public Integer getIntegerField() {
            return this.integerField;
        }

        @java.lang.SuppressWarnings("all")
                public Long getLongField() {
            return this.longField;
        }

        @java.lang.SuppressWarnings("all")
                public BigDecimal getBigDecimalField() {
            return this.bigDecimalField;
        }

        @java.lang.SuppressWarnings("all")
                public Double getDoubleField() {
            return this.doubleField;
        }

        @java.lang.SuppressWarnings("all")
                public Boolean getBooleanField() {
            return this.booleanField;
        }

        @java.lang.SuppressWarnings("all")
                public void setStringField(final String stringField) {
            this.stringField = stringField;
        }

        @java.lang.SuppressWarnings("all")
                public void setIntegerField(final Integer integerField) {
            this.integerField = integerField;
        }

        @java.lang.SuppressWarnings("all")
                public void setLongField(final Long longField) {
            this.longField = longField;
        }

        @java.lang.SuppressWarnings("all")
                public void setBigDecimalField(final BigDecimal bigDecimalField) {
            this.bigDecimalField = bigDecimalField;
        }

        @java.lang.SuppressWarnings("all")
                public void setDoubleField(final Double doubleField) {
            this.doubleField = doubleField;
        }

        @java.lang.SuppressWarnings("all")
                public void setBooleanField(final Boolean booleanField) {
            this.booleanField = booleanField;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public boolean equals(final java.lang.Object o) {
            if (o == this) return true;
            if (!(o instanceof CommandStrategyUtilsTest.TestRequest)) return false;
            final CommandStrategyUtilsTest.TestRequest other = (CommandStrategyUtilsTest.TestRequest) o;
            if (!other.canEqual((java.lang.Object) this)) return false;
            final java.lang.Object this$integerField = this.getIntegerField();
            final java.lang.Object other$integerField = other.getIntegerField();
            if (this$integerField == null ? other$integerField != null : !this$integerField.equals(other$integerField)) return false;
            final java.lang.Object this$longField = this.getLongField();
            final java.lang.Object other$longField = other.getLongField();
            if (this$longField == null ? other$longField != null : !this$longField.equals(other$longField)) return false;
            final java.lang.Object this$doubleField = this.getDoubleField();
            final java.lang.Object other$doubleField = other.getDoubleField();
            if (this$doubleField == null ? other$doubleField != null : !this$doubleField.equals(other$doubleField)) return false;
            final java.lang.Object this$booleanField = this.getBooleanField();
            final java.lang.Object other$booleanField = other.getBooleanField();
            if (this$booleanField == null ? other$booleanField != null : !this$booleanField.equals(other$booleanField)) return false;
            final java.lang.Object this$stringField = this.getStringField();
            final java.lang.Object other$stringField = other.getStringField();
            if (this$stringField == null ? other$stringField != null : !this$stringField.equals(other$stringField)) return false;
            final java.lang.Object this$bigDecimalField = this.getBigDecimalField();
            final java.lang.Object other$bigDecimalField = other.getBigDecimalField();
            if (this$bigDecimalField == null ? other$bigDecimalField != null : !this$bigDecimalField.equals(other$bigDecimalField)) return false;
            return true;
        }

        @java.lang.SuppressWarnings("all")
                protected boolean canEqual(final java.lang.Object other) {
            return other instanceof CommandStrategyUtilsTest.TestRequest;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public int hashCode() {
            final int PRIME = 59;
            int result = 1;
            final java.lang.Object $integerField = this.getIntegerField();
            result = result * PRIME + ($integerField == null ? 43 : $integerField.hashCode());
            final java.lang.Object $longField = this.getLongField();
            result = result * PRIME + ($longField == null ? 43 : $longField.hashCode());
            final java.lang.Object $doubleField = this.getDoubleField();
            result = result * PRIME + ($doubleField == null ? 43 : $doubleField.hashCode());
            final java.lang.Object $booleanField = this.getBooleanField();
            result = result * PRIME + ($booleanField == null ? 43 : $booleanField.hashCode());
            final java.lang.Object $stringField = this.getStringField();
            result = result * PRIME + ($stringField == null ? 43 : $stringField.hashCode());
            final java.lang.Object $bigDecimalField = this.getBigDecimalField();
            result = result * PRIME + ($bigDecimalField == null ? 43 : $bigDecimalField.hashCode());
            return result;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "CommandStrategyUtilsTest.TestRequest(stringField=" + this.getStringField() + ", integerField=" + this.getIntegerField() + ", longField=" + this.getLongField() + ", bigDecimalField=" + this.getBigDecimalField() + ", doubleField=" + this.getDoubleField() + ", booleanField=" + this.getBooleanField() + ")";
        }

        @java.lang.SuppressWarnings("all")
                public TestRequest() {
        }

        @java.lang.SuppressWarnings("all")
                public TestRequest(final String stringField, final Integer integerField, final Long longField, final BigDecimal bigDecimalField, final Double doubleField, final Boolean booleanField) {
            this.stringField = stringField;
            this.integerField = integerField;
            this.longField = longField;
            this.bigDecimalField = bigDecimalField;
            this.doubleField = doubleField;
            this.booleanField = booleanField;
        }
    }


    static class ClassWithoutBuilder {
        private String field;

        ClassWithoutBuilder(String field) {
            this.field = field;
        }
    }

    // Tests for getQueryParameters method with URL decoding
    private static Stream<Arguments> urlDecodingTestCases() {
        return Stream.of(
        // URL-encoded forward slashes
        Arguments.of("loans/123?dateFormat=MM%2Fdd%2Fyyyy", "dateFormat", "MM/dd/yyyy"), Arguments.of("loans/123?startDate=02%2F05%2F2026", "startDate", "02/05/2026"), 
        // URL-encoded spaces
        Arguments.of("loans/123?name=John%20Doe", "name", "John Doe"), 
        // URL-encoded special characters
        Arguments.of("loans/123?email=user%40example.com", "email", "user@example.com"), Arguments.of("loans/123?query=hello%26world", "query", "hello&world"), 
        // URL-encoded percentage sign
        Arguments.of("loans/123?discount=50%25", "discount", "50%"), 
        // Non-encoded values (should remain unchanged)
        Arguments.of("loans/123?locale=en_US", "locale", "en_US"), Arguments.of("loans/123?frequencyType=MONTHS", "frequencyType", "MONTHS"), Arguments.of("loans/123?frequencyNumber=1", "frequencyNumber", "1"));
    }

    @ParameterizedTest
    @MethodSource("urlDecodingTestCases")
    public void testGetQueryParametersWithUrlDecoding(String relativeUrl, String expectedKey, String expectedValue) {
        // when
        Map<String, String> result = CommandStrategyUtils.getQueryParameters(relativeUrl);
        // then
        assertThat(result).isNotNull();
        assertThat(result).containsKey(expectedKey);
        assertThat(result.get(expectedKey)).isEqualTo(expectedValue);
    }

    @Test
    public void testGetQueryParametersWithMultipleUrlEncodedParams() {
        // given
        String relativeUrl = "loans/123?dateFormat=MM%2Fdd%2Fyyyy&startDate=02%2F05%2F2026&locale=en_US&name=John%20Doe";
        // when
        Map<String, String> result = CommandStrategyUtils.getQueryParameters(relativeUrl);
        // then
        assertThat(result).isNotNull();
        assertThat(result).hasSize(4);
        assertThat(result.get("dateFormat")).isEqualTo("MM/dd/yyyy");
        assertThat(result.get("startDate")).isEqualTo("02/05/2026");
        assertThat(result.get("locale")).isEqualTo("en_US");
        assertThat(result.get("name")).isEqualTo("John Doe");
    }

    @Test
    public void testGetQueryParametersWithComplexUrlEncodedQuery() {
        // given - using the actual sample URL from the requirement
        String relativeUrl = "loans/external-id/0083477d-ea2a-45a4-a244-cb79a9ecf741/transactions/reage-preview" + "?frequencyType=MONTHS&locale=en_US&frequencyNumber=1&dateFormat=MM%2Fdd%2Fyyyy" + "&startDate=02%2F05%2F2026&numberOfInstallments=6";
        // when
        Map<String, String> result = CommandStrategyUtils.getQueryParameters(relativeUrl);
        // then
        assertThat(result).isNotNull();
        assertThat(result).hasSize(6);
        assertThat(result.get("frequencyType")).isEqualTo("MONTHS");
        assertThat(result.get("locale")).isEqualTo("en_US");
        assertThat(result.get("frequencyNumber")).isEqualTo("1");
        assertThat(result.get("dateFormat")).isEqualTo("MM/dd/yyyy");
        assertThat(result.get("startDate")).isEqualTo("02/05/2026");
        assertThat(result.get("numberOfInstallments")).isEqualTo("6");
    }

    @Test
    public void testGetQueryParametersWithEmptyValue() {
        // given
        String relativeUrl = "loans/123?param1=value1&param2=&param3=value3";
        // when
        Map<String, String> result = CommandStrategyUtils.getQueryParameters(relativeUrl);
        // then
        assertThat(result).isNotNull();
        assertThat(result).hasSize(3);
        assertThat(result.get("param1")).isEqualTo("value1");
        assertThat(result.get("param2")).isEqualTo("");
        assertThat(result.get("param3")).isEqualTo("value3");
    }

    @Test
    public void testGetQueryParametersWithNoQueryParams() {
        // given
        String relativeUrl = "loans/123";
        // when
        Map<String, String> result = CommandStrategyUtils.getQueryParameters(relativeUrl);
        // then
        assertThat(result).isNotNull();
        assertThat(result).isEmpty();
    }

    @Test
    public void testBuildRequestFromQueryParametersWithUrlEncodedValues() {
        // given
        Map<String, String> queryParams = new HashMap<>();
        queryParams.put("stringField", "Hello World"); // Already decoded by getQueryParameters
        queryParams.put("integerField", "42");
        // when
        TestRequest result = CommandStrategyUtils.buildRequestFromQueryParameters(queryParams, TestRequest.class);
        // then
        assertThat(result).isNotNull();
        assertThat(result.getStringField()).isEqualTo("Hello World");
        assertThat(result.getIntegerField()).isEqualTo(42);
    }
}
