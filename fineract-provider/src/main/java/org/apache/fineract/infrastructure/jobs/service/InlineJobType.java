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
import org.apache.fineract.cob.service.InlineLoanCOBExecutorServiceImpl;
import org.apache.fineract.cob.service.InlineWorkingCapitalLoanCOBExecutorServiceImpl;

public enum InlineJobType {
    LOAN_COB("LOAN_COB", "INLINE_LOAN_COB", InlineLoanCOBExecutorServiceImpl.class), WC_LOAN_COB("WC_LOAN_COB", "INLINE_WORKING_CAPITAL_LOAN_COB", InlineWorkingCapitalLoanCOBExecutorServiceImpl.class);
    private final String jobName;
    private final String inlineJobName;
    private final Class<? extends InlineExecutorService> executorServiceClass;

    public static InlineJobType getInlineJobType(String jobName) {
        Optional<InlineJobType> optionalInlineJobType = Arrays.stream(InlineJobType.values()).filter(inlineCOBType -> jobName.equals(inlineCOBType.jobName)).findAny();
        return optionalInlineJobType.orElseThrow(() -> new IllegalArgumentException("Inline Job is not found by job name: " + jobName));
    }

    @java.lang.SuppressWarnings("all")
        private InlineJobType(final String jobName, final String inlineJobName, final Class<? extends InlineExecutorService> executorServiceClass) {
        this.jobName = jobName;
        this.inlineJobName = inlineJobName;
        this.executorServiceClass = executorServiceClass;
    }

    @java.lang.SuppressWarnings("all")
        public String getInlineJobName() {
        return this.inlineJobName;
    }

    @java.lang.SuppressWarnings("all")
        public Class<? extends InlineExecutorService> getExecutorServiceClass() {
        return this.executorServiceClass;
    }
}
