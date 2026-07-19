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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.context.MessageSourceAutoConfiguration;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.test.context.ContextConfiguration;

@SpringBootTest
@ContextConfiguration(classes = {LocalDateValidationTest.TestConfig.class})
class LocalDateValidationTest {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(LocalDateValidationTest.class);


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
    void invalidAllBlank() {
        var request = LocalDateModel.builder().format("").date("  ").locale(null).build();
        var errors = validator.validate(request);
        assertThat(errors).hasSize(1);
        assertThat(errors).allMatch(e -> "Wrong local date fields.".equals(e.getMessage()));
    }

    @Test
    void invalidLocaleFormat() {
        var request = LocalDateModel.builder().format("dd-MM-yyyy").date("12-05-2025").locale("").build();
        var errors = validator.validate(request);
        assertThat(errors).hasSize(1);
        assertThat(errors).allMatch(e -> "Wrong local date fields.".equals(e.getMessage()));
    }

    @Test
    void invalidDateFormat() {
        var request = LocalDateModel.builder().format("dd/MM/yyyy").date("12-05-2025").locale("en").build();
        var errors = validator.validate(request);
        assertThat(errors).hasSize(1);
        assertThat(errors).allMatch(e -> "Wrong local date fields.".equals(e.getMessage()));
    }

    @Test
    void valid() {
        var request = LocalDateModel.builder().format("dd-MM-yyyy").date("12-05-2025").locale("en").build();
        var errors = validator.validate(request);
        assertThat(errors).isEmpty();
    }


    @LocalDate(dateField = "date", formatField = "format", localeField = "locale")
    static class LocalDateModel {
        private String date;
        private String format;
        private String locale;


        @java.lang.SuppressWarnings("all")
                public static class LocalDateModelBuilder {
            @java.lang.SuppressWarnings("all")
                        private String date;
            @java.lang.SuppressWarnings("all")
                        private String format;
            @java.lang.SuppressWarnings("all")
                        private String locale;

            @java.lang.SuppressWarnings("all")
                        LocalDateModelBuilder() {
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public LocalDateValidationTest.LocalDateModel.LocalDateModelBuilder date(final String date) {
                this.date = date;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public LocalDateValidationTest.LocalDateModel.LocalDateModelBuilder format(final String format) {
                this.format = format;
                return this;
            }

            /**
             * @return {@code this}.
             */
            @java.lang.SuppressWarnings("all")
                        public LocalDateValidationTest.LocalDateModel.LocalDateModelBuilder locale(final String locale) {
                this.locale = locale;
                return this;
            }

            @java.lang.SuppressWarnings("all")
                        public LocalDateValidationTest.LocalDateModel build() {
                return new LocalDateValidationTest.LocalDateModel(this.date, this.format, this.locale);
            }

            @java.lang.Override
            @java.lang.SuppressWarnings("all")
                        public java.lang.String toString() {
                return "LocalDateValidationTest.LocalDateModel.LocalDateModelBuilder(date=" + this.date + ", format=" + this.format + ", locale=" + this.locale + ")";
            }
        }

        @java.lang.SuppressWarnings("all")
                public static LocalDateValidationTest.LocalDateModel.LocalDateModelBuilder builder() {
            return new LocalDateValidationTest.LocalDateModel.LocalDateModelBuilder();
        }

        @java.lang.SuppressWarnings("all")
                public String getDate() {
            return this.date;
        }

        @java.lang.SuppressWarnings("all")
                public String getFormat() {
            return this.format;
        }

        @java.lang.SuppressWarnings("all")
                public String getLocale() {
            return this.locale;
        }

        @java.lang.SuppressWarnings("all")
                public void setDate(final String date) {
            this.date = date;
        }

        @java.lang.SuppressWarnings("all")
                public void setFormat(final String format) {
            this.format = format;
        }

        @java.lang.SuppressWarnings("all")
                public void setLocale(final String locale) {
            this.locale = locale;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public boolean equals(final java.lang.Object o) {
            if (o == this) return true;
            if (!(o instanceof LocalDateValidationTest.LocalDateModel)) return false;
            final LocalDateValidationTest.LocalDateModel other = (LocalDateValidationTest.LocalDateModel) o;
            if (!other.canEqual((java.lang.Object) this)) return false;
            final java.lang.Object this$date = this.getDate();
            final java.lang.Object other$date = other.getDate();
            if (this$date == null ? other$date != null : !this$date.equals(other$date)) return false;
            final java.lang.Object this$format = this.getFormat();
            final java.lang.Object other$format = other.getFormat();
            if (this$format == null ? other$format != null : !this$format.equals(other$format)) return false;
            final java.lang.Object this$locale = this.getLocale();
            final java.lang.Object other$locale = other.getLocale();
            if (this$locale == null ? other$locale != null : !this$locale.equals(other$locale)) return false;
            return true;
        }

        @java.lang.SuppressWarnings("all")
                protected boolean canEqual(final java.lang.Object other) {
            return other instanceof LocalDateValidationTest.LocalDateModel;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public int hashCode() {
            final int PRIME = 59;
            int result = 1;
            final java.lang.Object $date = this.getDate();
            result = result * PRIME + ($date == null ? 43 : $date.hashCode());
            final java.lang.Object $format = this.getFormat();
            result = result * PRIME + ($format == null ? 43 : $format.hashCode());
            final java.lang.Object $locale = this.getLocale();
            result = result * PRIME + ($locale == null ? 43 : $locale.hashCode());
            return result;
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "LocalDateValidationTest.LocalDateModel(date=" + this.getDate() + ", format=" + this.getFormat() + ", locale=" + this.getLocale() + ")";
        }

        @java.lang.SuppressWarnings("all")
                public LocalDateModel() {
        }

        @java.lang.SuppressWarnings("all")
                public LocalDateModel(final String date, final String format, final String locale) {
            this.date = date;
            this.format = format;
            this.locale = locale;
        }
    }
}
