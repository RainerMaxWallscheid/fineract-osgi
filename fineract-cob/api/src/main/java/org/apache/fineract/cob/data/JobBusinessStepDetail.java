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

public class JobBusinessStepDetail {
    private String jobName;
    private List<BusinessStepDetail> availableBusinessSteps;

    @java.lang.SuppressWarnings("all")
        public JobBusinessStepDetail() {
    }

    @java.lang.SuppressWarnings("all")
        public String getJobName() {
        return this.jobName;
    }

    @java.lang.SuppressWarnings("all")
        public List<BusinessStepDetail> getAvailableBusinessSteps() {
        return this.availableBusinessSteps;
    }

    @java.lang.SuppressWarnings("all")
        public void setJobName(final String jobName) {
        this.jobName = jobName;
    }

    @java.lang.SuppressWarnings("all")
        public void setAvailableBusinessSteps(final List<BusinessStepDetail> availableBusinessSteps) {
        this.availableBusinessSteps = availableBusinessSteps;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof JobBusinessStepDetail)) return false;
        final JobBusinessStepDetail other = (JobBusinessStepDetail) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$jobName = this.getJobName();
        final java.lang.Object other$jobName = other.getJobName();
        if (this$jobName == null ? other$jobName != null : !this$jobName.equals(other$jobName)) return false;
        final java.lang.Object this$availableBusinessSteps = this.getAvailableBusinessSteps();
        final java.lang.Object other$availableBusinessSteps = other.getAvailableBusinessSteps();
        if (this$availableBusinessSteps == null ? other$availableBusinessSteps != null : !this$availableBusinessSteps.equals(other$availableBusinessSteps)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof JobBusinessStepDetail;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $jobName = this.getJobName();
        result = result * PRIME + ($jobName == null ? 43 : $jobName.hashCode());
        final java.lang.Object $availableBusinessSteps = this.getAvailableBusinessSteps();
        result = result * PRIME + ($availableBusinessSteps == null ? 43 : $availableBusinessSteps.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "JobBusinessStepDetail(jobName=" + this.getJobName() + ", availableBusinessSteps=" + this.getAvailableBusinessSteps() + ")";
    }
}
