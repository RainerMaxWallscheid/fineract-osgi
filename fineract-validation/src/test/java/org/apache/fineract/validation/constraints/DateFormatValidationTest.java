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
package org.apache.fineract.validation.constraints;

import static org.assertj.core.api.Assertions.assertThat;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import org.hibernate.validator.HibernateValidator;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.context.MessageSourceAutoConfiguration;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.test.context.ContextConfiguration;

@SpringBootTest
@ContextConfiguration(classes = {DateFormatValidationTest.TestConfig.class})
class DateFormatValidationTest {

    @Configuration
    @Import({MessageSourceAutoConfiguration.class})
    static class TestConfig {
        @Bean
        public Validator validator() {
            return Validation.byProvider(HibernateValidator.class).configure().buildValidatorFactory().getValidator();
        }
    }

    @Autowired
    private Validator validator;

    @Test
    void blankIsValid() {
        var request = DateFormatModel.builder().dateFormat("").build();
        var errors = validator.validate(request);
        assertThat(errors).isEmpty();
    }

    // literal date value, not a format pattern (unknown letters) — do not convert to yyyyMMdd
    // 'b' is not a valid pattern letter
    @ParameterizedTest
    @ValueSource(strings = {"02 February 2026", "invalid", "dd bbb yyyy"})
    void invalidPatterns(String dateFormat) {
        var request = DateFormatModel.builder().dateFormat(dateFormat).build();
        var errors = validator.validate(request);
        assertThat(errors).as("Expected dateFormat \'%s\' to be invalid", dateFormat).hasSize(1);
        assertThat(errors).anyMatch(e -> "dateFormat".equals(e.getPropertyPath().toString()));
    }

    @ParameterizedTest
    @ValueSource(strings = {"yyyyMMdd", "yyyy-MM-dd", "dd/MM/yyyy", "MMM dd, yyyy"})
    void validPatterns(String dateFormat) {
        var request = DateFormatModel.builder().dateFormat(dateFormat).build();
        var errors = validator.validate(request);
        assertThat(errors).as("Expected dateFormat \'%s\' to be valid", dateFormat).isEmpty();
    }

    @Test
    void staticIsValidPattern_invalid() {
        // digits-only is a valid all-literal pattern; use a non-pattern string here
        assertThat(DateFormatValidator.isValidPattern("02 February 2026")).isFalse();
        assertThat(DateFormatValidator.isValidPattern("unknown")).isFalse();
    }

    @Test
    void staticIsValidPattern_valid() {
        assertThat(DateFormatValidator.isValidPattern("yyyyMMdd")).isTrue();
        assertThat(DateFormatValidator.isValidPattern("yyyy-MM-dd")).isTrue();
    }


    static class DateFormatModel {
        @DateFormat
        private String dateFormat;


        @java.lang.SuppressWarnings("all")
                public static class DateFormatModelBuilder {
            @java.lang.SuppressWarnings("all")
                        private String dateFormat;

            @java.lang.SuppressWarnings("all")
                        DateFormatModelBuilder() {
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public DateFormatValidationTest.DateFormatModel.DateFormatModelBuilder dateFormat(final String dateFormat) {
                this.dateFormat = dateFormat;
                return this;
            }

            @java.lang.SuppressWarnings("all")
                        public DateFormatValidationTest.DateFormatModel build() {
                return new DateFormatValidationTest.DateFormatModel(this.dateFormat);
            }

            @java.lang.Override
            @java.lang.SuppressWarnings("all")
                        public java.lang.String toString() {
                return "DateFormatValidationTest.DateFormatModel.DateFormatModelBuilder(dateFormat=" + this.dateFormat + ")";
            }
        }

        @java.lang.SuppressWarnings("all")
                public static DateFormatValidationTest.DateFormatModel.DateFormatModelBuilder builder() {
            return new DateFormatValidationTest.DateFormatModel.DateFormatModelBuilder();
        }

        @java.lang.SuppressWarnings("all")
                public String getDateFormat() {
            return this.dateFormat;
        }

        @java.lang.SuppressWarnings("all")
                public void setDateFormat(final String dateFormat) {
            this.dateFormat = dateFormat;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public boolean equals(final java.lang.Object o) {
            if (o == this) return true;
            if (!(o instanceof DateFormatValidationTest.DateFormatModel)) return false;
            final DateFormatValidationTest.DateFormatModel other = (DateFormatValidationTest.DateFormatModel) o;
            if (!other.canEqual((java.lang.Object) this)) return false;
            final java.lang.Object this$dateFormat = this.getDateFormat();
            final java.lang.Object other$dateFormat = other.getDateFormat();
            if (this$dateFormat == null ? other$dateFormat != null : !this$dateFormat.equals(other$dateFormat)) return false;
            return true;
        }

        @java.lang.SuppressWarnings("all")
                protected boolean canEqual(final java.lang.Object other) {
            return other instanceof DateFormatValidationTest.DateFormatModel;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public int hashCode() {
            final int PRIME = 59;
            int result = 1;
            final java.lang.Object $dateFormat = this.getDateFormat();
            result = result * PRIME + ($dateFormat == null ? 43 : $dateFormat.hashCode());
            return result;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "DateFormatValidationTest.DateFormatModel(dateFormat=" + this.getDateFormat() + ")";
        }

        @java.lang.SuppressWarnings("all")
                public DateFormatModel() {
        }

        @java.lang.SuppressWarnings("all")
                public DateFormatModel(final String dateFormat) {
            this.dateFormat = dateFormat;
        }
    }
}
