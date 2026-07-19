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

import static org.assertj.core.api.AssertionsForInterfaceTypes.assertThat;
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
@ContextConfiguration(classes = {LocalDateValidationTest.TestConfig.class})
class LocaleValidationTest {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(LocaleValidationTest.class);


    @Configuration
    @Import({MessageSourceAutoConfiguration.class})
    static class TestConfig {
        @Bean
        public jakarta.validation.Validator validator() {
            return Validation.byProvider(HibernateValidator.class).configure().buildValidatorFactory().getValidator();
        }
    }

    @Autowired
    private Validator validator;

    @Test
    void invalidBlank() {
        var request = LocaleModel.builder().locale(null).build();
        var errors = validator.validate(request);
        assertThat(errors).hasSize(1);
        assertThat(errors).anyMatch(e -> e.getPropertyPath().toString().equals("locale"));
    }

    // invalid format
    // non-existent locale
    // random text
    // numbers
    // extra segment
    @ParameterizedTest
    @ValueSource(strings = {"invalid-locale", "xx-YY", "random text", "123", "en-US-extra"})
    void invalidFormats(String locale) {
        var request = LocaleModel.builder().locale(locale).build();
        var errors = validator.validate(request);
        assertThat(errors).as("Expected locale \'%s\' to be invalid but it was valid", locale).hasSize(1);
    }

    // language only
    // uppercase language only
    // language with country (hyphen)
    // language with country (underscore)
    @ParameterizedTest
    @ValueSource(strings = {"en", "EN", "en-US", "en_US"})
    void validLocales(String locale) {
        var request = LocaleModel.builder().locale(locale).build();
        var errors = validator.validate(request);
        assertThat(errors).as("Expected locale \'%s\' to be valid but it was invalid", locale).hasSize(0);
    }


    static class LocaleModel {
        @Locale
        private String locale;


        @java.lang.SuppressWarnings("all")
                public static class LocaleModelBuilder {
            @java.lang.SuppressWarnings("all")
                        private String locale;

            @java.lang.SuppressWarnings("all")
                        LocaleModelBuilder() {
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public LocaleValidationTest.LocaleModel.LocaleModelBuilder locale(final String locale) {
                this.locale = locale;
                return this;
            }

            @java.lang.SuppressWarnings("all")
                        public LocaleValidationTest.LocaleModel build() {
                return new LocaleValidationTest.LocaleModel(this.locale);
            }

            @java.lang.Override
            @java.lang.SuppressWarnings("all")
                        public java.lang.String toString() {
                return "LocaleValidationTest.LocaleModel.LocaleModelBuilder(locale=" + this.locale + ")";
            }
        }

        @java.lang.SuppressWarnings("all")
                public static LocaleValidationTest.LocaleModel.LocaleModelBuilder builder() {
            return new LocaleValidationTest.LocaleModel.LocaleModelBuilder();
        }

        @java.lang.SuppressWarnings("all")
                public String getLocale() {
            return this.locale;
        }

        @java.lang.SuppressWarnings("all")
                public void setLocale(final String locale) {
            this.locale = locale;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public boolean equals(final java.lang.Object o) {
            if (o == this) return true;
            if (!(o instanceof LocaleValidationTest.LocaleModel)) return false;
            final LocaleValidationTest.LocaleModel other = (LocaleValidationTest.LocaleModel) o;
            if (!other.canEqual((java.lang.Object) this)) return false;
            final java.lang.Object this$locale = this.getLocale();
            final java.lang.Object other$locale = other.getLocale();
            if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
            return true;
        }

        @java.lang.SuppressWarnings("all")
                protected boolean canEqual(final java.lang.Object other) {
            return other instanceof LocaleValidationTest.LocaleModel;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public int hashCode() {
            final int PRIME = 59;
            int result = 1;
            final java.lang.Object $locale = this.getLocale();
            result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
            return result;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "LocaleValidationTest.LocaleModel(locale=" + this.getLocale() + ")";
        }

        @java.lang.SuppressWarnings("all")
                public LocaleModel() {
        }

        @java.lang.SuppressWarnings("all")
                public LocaleModel(final String locale) {
            this.locale = locale;
        }
    }
}
