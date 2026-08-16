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

import java.util.ArrayList;
import java.util.List;
import org.apache.fineract.infrastructure.core.config.FineractProperties;
import org.apache.fineract.infrastructure.core.config.FineractProperties.FineractSqlValidationPatternProperties;
import org.apache.fineract.infrastructure.core.config.FineractProperties.FineractSqlValidationPatternReferenceProperties;
import org.apache.fineract.infrastructure.core.config.FineractProperties.FineractSqlValidationProfileProperties;
import org.apache.fineract.infrastructure.core.config.FineractProperties.FineractSqlValidationProperties;
import org.apache.fineract.infrastructure.security.exception.SqlValidationException;
import org.apache.fineract.infrastructure.security.service.SqlValidator;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

public class SqlValidatorTest {

    private SqlValidator sqlValidator;

    @BeforeEach
    void setUp() {
        FineractSqlValidationPatternProperties commentPattern = new FineractSqlValidationPatternProperties();
        commentPattern.setName("inject-comment");
        commentPattern.setPattern("(?i).*\\s+(--|/\\*|#|\\(\\{)++.*");

        FineractSqlValidationPatternReferenceProperties commentRef = new FineractSqlValidationPatternReferenceProperties();
        commentRef.setName("inject-comment");
        commentRef.setOrder(0);

        FineractSqlValidationProfileProperties main = new FineractSqlValidationProfileProperties();
        main.setName("main");
        main.setPatternRefs(new ArrayList<>(List.of(commentRef)));
        main.setEnabled(true);

        FineractSqlValidationProperties sqlValidation = new FineractSqlValidationProperties();
        sqlValidation.setPatterns(new ArrayList<>(List.of(commentPattern)));
        sqlValidation.setProfiles(new ArrayList<>(List.of(main)));

        FineractProperties properties = new FineractProperties();
        properties.setSqlValidation(sqlValidation);

        DefaultSqlValidator validator = new DefaultSqlValidator(properties);
        validator.init();
        this.sqlValidator = validator;
    }

    @Test
    public void testSingleDashInParameterName() {
        final String paramToValidate = "Loan Report - Active";
        Assertions.assertDoesNotThrow(() -> sqlValidator.validate(paramToValidate));
    }

    @Test
    public void testCommentInjectionAttempt() {
        final String paramToValidate = "Loan Report -- Active";
        Assertions.assertThrows(SqlValidationException.class, () -> sqlValidator.validate(paramToValidate));
    }
}
