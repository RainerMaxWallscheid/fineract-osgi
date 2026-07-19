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

public class JobParameterDTO {
    private String parameterName;
    private String parameterValue;

    @java.lang.SuppressWarnings("all")
        public String getParameterName() {
        return this.parameterName;
    }

    @java.lang.SuppressWarnings("all")
        public String getParameterValue() {
        return this.parameterValue;
    }

    @java.lang.SuppressWarnings("all")
        public void setParameterName(final String parameterName) {
        this.parameterName = parameterName;
    }

    @java.lang.SuppressWarnings("all")
        public void setParameterValue(final String parameterValue) {
        this.parameterValue = parameterValue;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "JobParameterDTO(parameterName=" + this.getParameterName() + ", parameterValue=" + this.getParameterValue() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public JobParameterDTO(final String parameterName, final String parameterValue) {
        this.parameterName = parameterName;
        this.parameterValue = parameterValue;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof JobParameterDTO)) return false;
        final JobParameterDTO other = (JobParameterDTO) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$parameterName = this.getParameterName();
        final java.lang.Object other$parameterName = other.getParameterName();
        if (this$parameterName == null ? other$parameterName != null : !this$parameterName.equals(other$parameterName)) return false;
        final java.lang.Object this$parameterValue = this.getParameterValue();
        final java.lang.Object other$parameterValue = other.getParameterValue();
        if (this$parameterValue == null ? other$parameterValue != null : !this$parameterValue.equals(other$parameterValue)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof JobParameterDTO;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $parameterName = this.getParameterName();
        result = result * PRIME + ($parameterName == null ? 43 : $parameterName.hashCode());
        final java.lang.Object $parameterValue = this.getParameterValue();
        result = result * PRIME + ($parameterValue == null ? 43 : $parameterValue.hashCode());
        return result;
    }
}
