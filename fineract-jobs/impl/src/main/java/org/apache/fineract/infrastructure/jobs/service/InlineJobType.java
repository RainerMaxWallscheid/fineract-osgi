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
package org.apache.fineract.infrastructure.jobs.service;

import java.util.Arrays;
import java.util.Optional;

/**
 * Maps batch job names to Spring bean names of {@link InlineExecutorService} implementations.
 * <p>
 * Bean names match the default Spring names for the provider-residual COB executor
 * {@code @Service} classes (kept residual so jobs-impl does not compile against provider COB).
 */
public enum InlineJobType {
    LOAN_COB("LOAN_COB", "INLINE_LOAN_COB", "inlineLoanCOBExecutorServiceImpl"),
    WC_LOAN_COB("WC_LOAN_COB", "INLINE_WORKING_CAPITAL_LOAN_COB", "inlineWorkingCapitalLoanCOBExecutorServiceImpl");

    private final String jobName;
    private final String inlineJobName;
    private final String executorServiceBeanName;

    public static InlineJobType getInlineJobType(String jobName) {
        Optional<InlineJobType> optionalInlineJobType = Arrays.stream(InlineJobType.values())
                .filter(inlineCOBType -> jobName.equals(inlineCOBType.jobName)).findAny();
        return optionalInlineJobType
                .orElseThrow(() -> new IllegalArgumentException("Inline Job is not found by job name: " + jobName));
    }

    InlineJobType(final String jobName, final String inlineJobName, final String executorServiceBeanName) {
        this.jobName = jobName;
        this.inlineJobName = inlineJobName;
        this.executorServiceBeanName = executorServiceBeanName;
    }

    public String getInlineJobName() {
        return this.inlineJobName;
    }

    public String getExecutorServiceBeanName() {
        return this.executorServiceBeanName;
    }
}
