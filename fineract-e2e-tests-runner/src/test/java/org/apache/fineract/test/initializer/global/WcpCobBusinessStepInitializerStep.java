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
package org.apache.fineract.test.initializer.global;

import org.apache.fineract.client.feign.util.CallFailedRuntimeException;
import org.apache.fineract.client.models.JobBusinessStepConfigData;
import org.apache.fineract.test.helper.WorkFlowJobHelper;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

@Component
@Order(Ordered.HIGHEST_PRECEDENCE)
public class WcpCobBusinessStepInitializerStep implements FineractGlobalInitializerStep {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(WcpCobBusinessStepInitializerStep.class);
    private static final String WCP_COB_JOB_NAME = "WORKING_CAPITAL_LOAN_CLOSE_OF_BUSINESS";
    private final WorkFlowJobHelper workFlowJobHelper;

    @Override
    public void initialize() throws Exception {
        try {
            JobBusinessStepConfigData response = workFlowJobHelper.getConfiguredWorkflowSteps(WCP_COB_JOB_NAME);
            log.debug("WCP COB configured business steps: {}", response.getBusinessSteps());
        } catch (CallFailedRuntimeException e) {
            log.warn("WCP COB business steps retrieval failed (expected if WCP COB not deployed): {}", e.getMessage());
            log.debug("Full stack trace:", e);
        }
    }

    @java.lang.SuppressWarnings("all")
        public WcpCobBusinessStepInitializerStep(final WorkFlowJobHelper workFlowJobHelper) {
        this.workFlowJobHelper = workFlowJobHelper;
    }
}
