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

import java.util.List;

public class JobBusinessStepConfigData {
    private String jobName;
    private List<BusinessStep> businessSteps;

    @java.lang.SuppressWarnings("all")
        public JobBusinessStepConfigData() {
    }

    @java.lang.SuppressWarnings("all")
        public String getJobName() {
        return this.jobName;
    }

    @java.lang.SuppressWarnings("all")
        public List<BusinessStep> getBusinessSteps() {
        return this.businessSteps;
    }

    @java.lang.SuppressWarnings("all")
        public void setJobName(final String jobName) {
        this.jobName = jobName;
    }

    @java.lang.SuppressWarnings("all")
        public void setBusinessSteps(final List<BusinessStep> businessSteps) {
        this.businessSteps = businessSteps;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof JobBusinessStepConfigData)) return false;
        final JobBusinessStepConfigData other = (JobBusinessStepConfigData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$jobName = this.getJobName();
        final java.lang.Object other$jobName = other.getJobName();
        if (this$jobName == null ? other$jobName != null : !this$jobName.equals(other$jobName)) return false;
        final java.lang.Object this$businessSteps = this.getBusinessSteps();
        final java.lang.Object other$businessSteps = other.getBusinessSteps();
        if (this$businessSteps == null ? other$businessSteps != null : !this$businessSteps.equals(other$businessSteps)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof JobBusinessStepConfigData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $jobName = this.getJobName();
        result = result * PRIME + ($jobName == null ? 43 : $jobName.hashCode());
        final java.lang.Object $businessSteps = this.getBusinessSteps();
        result = result * PRIME + ($businessSteps == null ? 43 : $businessSteps.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "JobBusinessStepConfigData(jobName=" + this.getJobName() + ", businessSteps=" + this.getBusinessSteps() + ")";
    }
}
