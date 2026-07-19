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
package org.apache.fineract.cob.data;

public class BusinessStep {
    private String stepName;
    private Long order;

    @java.lang.SuppressWarnings("all")
        public BusinessStep() {
    }

    @java.lang.SuppressWarnings("all")
        public String getStepName() {
        return this.stepName;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOrder() {
        return this.order;
    }

    @java.lang.SuppressWarnings("all")
        public void setStepName(final String stepName) {
        this.stepName = stepName;
    }

    @java.lang.SuppressWarnings("all")
        public void setOrder(final Long order) {
        this.order = order;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof BusinessStep)) return false;
        final BusinessStep other = (BusinessStep) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$order = this.getOrder();
        final java.lang.Object other$order = other.getOrder();
        if (this$order == null ? other$order != null : !this$order.equals(other$order)) return false;
        final java.lang.Object this$stepName = this.getStepName();
        final java.lang.Object other$stepName = other.getStepName();
        if (this$stepName == null ? other$stepName != null : !this$stepName.equals(other$stepName)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof BusinessStep;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $order = this.getOrder();
        result = result * PRIME + ($order == null ? 43 : $order.hashCode());
        final java.lang.Object $stepName = this.getStepName();
        result = result * PRIME + ($stepName == null ? 43 : $stepName.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "BusinessStep(stepName=" + this.getStepName() + ", order=" + this.getOrder() + ")";
    }
}
