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
package org.apache.fineract.infrastructure.security.utils;

import static org.junit.jupiter.api.Assertions.assertEquals;

import io.cucumber.java8.En;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.fineract.infrastructure.core.config.FineractProperties;
import org.apache.fineract.infrastructure.core.config.FineractProperties.FineractSqlValidationPatternProperties;
import org.apache.fineract.infrastructure.core.config.FineractProperties.FineractSqlValidationPatternReferenceProperties;
import org.apache.fineract.infrastructure.core.config.FineractProperties.FineractSqlValidationProfileProperties;
import org.apache.fineract.infrastructure.core.config.FineractProperties.FineractSqlValidationProperties;
import org.apache.fineract.infrastructure.security.exception.SqlValidationException;
import org.apache.fineract.infrastructure.security.service.SqlValidator;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.function.Executable;

public class SqlValidatorStepDefinitions implements En {

    private final SqlValidator sqlValidator = createSqlValidator();

    private Executable executable;
    private String statement;
    private Integer fuzzy = 0;

    public SqlValidatorStepDefinitions() {
        Given("/^A partial SQL statement (.*) with whitespaces fuzzy degree (\\d*)$/", (String statement, Integer fuzzy) -> {
            this.statement = statement;
            if (fuzzy != null) {
                this.fuzzy = fuzzy;
            }
        });

        When("Validating the partial statement", () -> {
            if (fuzzy != null && fuzzy > 0) {
                String whitespaces = RandomStringUtils.random(fuzzy, '\n', '\r', '\t', ' ');
                statement = statement.replaceAll(" ", whitespaces);
            }

            executable = () -> sqlValidator.validate(statement);
        });

        Then("/^The validator had exception message (.*)$/", (String expectedMessage) -> {
            if (StringUtils.isBlank(expectedMessage)) {
                Assertions.assertDoesNotThrow(executable);
            } else {
                var exception = Assertions.assertThrows(SqlValidationException.class, executable);

                assertEquals(expectedMessage, exception.getMessage());
            }
        });
    }

    private static SqlValidator createSqlValidator() {
        List<FineractSqlValidationPatternProperties> patterns = new ArrayList<>();
        patterns.add(pattern("inject-blind",
                "(?i).*[\\\"'`]?\\s*[and|or]+\\s*[\\\"'`]?([\\d\\w])+[\\\"'`]?\\s*=\\s*[\\\"'`]?(\\1)[\\\"'`]?\\s*.*"));
        patterns.add(pattern("detect-entry-point", "(?i)^[\\\"'`]?[\\)\\s]+"));
        patterns.add(pattern("inject-timing",
                "(?i).*[\\\"'`]?\\s*[and|\\+|&|\\|]+.*\\s*[sleep|pg_sleep|benchmark]+\\s*(\\(\\s*\\d+\\s*[,]?\\s*.*\\s*\\))+.*"));
        patterns.add(pattern("detect-backend", "(?i).*\\[\\s*\\\"(\\w+\\(.*\\))=(\\1)\\\"\\s*,\\s*\\\"\\w+\\\"\\s*\\].*"));
        patterns.add(pattern("detect-column",
                "(?i).*[\\\"'`]?\\s*(order\\s*by|group\\s*by|union\\s*select)+\\s+([\\d+|null]?\\s*,*\\s*)+\\s*.*"));
        patterns.add(pattern("detect-out-of-bands", "(?i).*(select)+\\s+(load_file)+.*"));
        patterns.add(pattern("inject-stacked-query",
                "(?i).*[;]+\\s*(create|drop|alter|truncate|comment|select|insert|update|delete|merge|upsert|call|exec)+.*(from|into|set|table|column|database)*.*"));
        patterns.add(pattern("inject-comment", "(?i).*\\s+(--|/\\*|#|\\(\\{)++.*"));

        String[] patternNames = { "inject-blind", "detect-entry-point", "inject-timing", "detect-backend", "detect-column",
                "detect-out-of-bands", "inject-stacked-query", "inject-comment" };
        List<FineractSqlValidationPatternReferenceProperties> refs = new ArrayList<>();
        for (int i = 0; i < patternNames.length; i++) {
            FineractSqlValidationPatternReferenceProperties ref = new FineractSqlValidationPatternReferenceProperties();
            ref.setName(patternNames[i]);
            ref.setOrder(i);
            refs.add(ref);
        }

        FineractSqlValidationProfileProperties main = new FineractSqlValidationProfileProperties();
        main.setName("main");
        main.setDescription("Main Query Validation Profile");
        main.setPatternRefs(refs);
        main.setEnabled(true);

        FineractSqlValidationProperties sqlValidation = new FineractSqlValidationProperties();
        sqlValidation.setPatterns(patterns);
        sqlValidation.setProfiles(new ArrayList<>(List.of(main)));

        FineractProperties properties = new FineractProperties();
        properties.setSqlValidation(sqlValidation);

        DefaultSqlValidator validator = new DefaultSqlValidator(properties);
        validator.init();
        return validator;
    }

    private static FineractSqlValidationPatternProperties pattern(String name, String regex) {
        FineractSqlValidationPatternProperties pattern = new FineractSqlValidationPatternProperties();
        pattern.setName(name);
        pattern.setPattern(regex);
        return pattern;
    }
}
