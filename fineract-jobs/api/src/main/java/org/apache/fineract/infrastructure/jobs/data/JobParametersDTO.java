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
package org.apache.fineract.infrastructure.jobs.data;

import java.util.Set;

public class JobParametersDTO {
    private Set<JobParameterDTO> jobParameters;

    @java.lang.SuppressWarnings("all")
        public Set<JobParameterDTO> getJobParameters() {
        return this.jobParameters;
    }

    @java.lang.SuppressWarnings("all")
        public void setJobParameters(final Set<JobParameterDTO> jobParameters) {
        this.jobParameters = jobParameters;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "JobParametersDTO(jobParameters=" + this.getJobParameters() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public JobParametersDTO(final Set<JobParameterDTO> jobParameters) {
        this.jobParameters = jobParameters;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof JobParametersDTO)) return false;
        final JobParametersDTO other = (JobParametersDTO) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$jobParameters = this.getJobParameters();
        final java.lang.Object other$jobParameters = other.getJobParameters();
        if (this$jobParameters == null ? other$jobParameters != null : !this$jobParameters.equals(other$jobParameters)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof JobParametersDTO;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $jobParameters = this.getJobParameters();
        result = result * PRIME + ($jobParameters == null ? 43 : $jobParameters.hashCode());
        return result;
    }
}
