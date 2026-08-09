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
package org.apache.fineract.infrastructure.springbatch;

import java.io.Serializable;
import org.apache.fineract.infrastructure.core.domain.FineractContext;
import org.springframework.batch.integration.partition.StepExecutionRequest;

public class ContextualMessage implements Serializable {
    private StepExecutionRequest stepExecutionRequest;
    private FineractContext context;

    @java.lang.SuppressWarnings("all")
        public ContextualMessage() {
    }

    @java.lang.SuppressWarnings("all")
        public StepExecutionRequest getStepExecutionRequest() {
        return this.stepExecutionRequest;
    }

    @java.lang.SuppressWarnings("all")
        public FineractContext getContext() {
        return this.context;
    }

    @java.lang.SuppressWarnings("all")
        public void setStepExecutionRequest(final StepExecutionRequest stepExecutionRequest) {
        this.stepExecutionRequest = stepExecutionRequest;
    }

    @java.lang.SuppressWarnings("all")
        public void setContext(final FineractContext context) {
        this.context = context;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ContextualMessage)) return false;
        final ContextualMessage other = (ContextualMessage) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$stepExecutionRequest = this.getStepExecutionRequest();
        final java.lang.Object other$stepExecutionRequest = other.getStepExecutionRequest();
        if (this$stepExecutionRequest == null ? other$stepExecutionRequest != null : !this$stepExecutionRequest.equals(other$stepExecutionRequest)) return false;
        final java.lang.Object this$context = this.getContext();
        final java.lang.Object other$context = other.getContext();
        if (this$context == null ? other$context != null : !this$context.equals(other$context)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ContextualMessage;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $stepExecutionRequest = this.getStepExecutionRequest();
        result = result * PRIME + ($stepExecutionRequest == null ? 43 : $stepExecutionRequest.hashCode());
        final java.lang.Object $context = this.getContext();
        result = result * PRIME + ($context == null ? 43 : $context.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ContextualMessage(stepExecutionRequest=" + this.getStepExecutionRequest() + ", context=" + this.getContext() + ")";
    }
}
