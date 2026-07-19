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

import java.time.LocalDate;

public class IsCatchUpRunningDTO {
    private boolean isCatchUpRunning;
    private LocalDate processingDate;

    @java.lang.SuppressWarnings("all")
        public boolean isCatchUpRunning() {
        return this.isCatchUpRunning;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getProcessingDate() {
        return this.processingDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setCatchUpRunning(final boolean isCatchUpRunning) {
        this.isCatchUpRunning = isCatchUpRunning;
    }

    @java.lang.SuppressWarnings("all")
        public void setProcessingDate(final LocalDate processingDate) {
        this.processingDate = processingDate;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof IsCatchUpRunningDTO)) return false;
        final IsCatchUpRunningDTO other = (IsCatchUpRunningDTO) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.isCatchUpRunning() != other.isCatchUpRunning()) return false;
        final java.lang.Object this$processingDate = this.getProcessingDate();
        final java.lang.Object other$processingDate = other.getProcessingDate();
        if (this$processingDate == null ? other$processingDate != null : !this$processingDate.equals(other$processingDate)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof IsCatchUpRunningDTO;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isCatchUpRunning() ? 79 : 97);
        final java.lang.Object $processingDate = this.getProcessingDate();
        result = result * PRIME + ($processingDate == null ? 43 : $processingDate.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "IsCatchUpRunningDTO(isCatchUpRunning=" + this.isCatchUpRunning() + ", processingDate=" + this.getProcessingDate() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public IsCatchUpRunningDTO(final boolean isCatchUpRunning, final LocalDate processingDate) {
        this.isCatchUpRunning = isCatchUpRunning;
        this.processingDate = processingDate;
    }
}
