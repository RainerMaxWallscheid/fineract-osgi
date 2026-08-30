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
package org.apache.fineract.cob.api;

import java.time.LocalDate;

public class LockRequest {
    private String error;
    private LocalDate cobBusinessDate;
    private Boolean nullCobBusinessDate;

    @java.lang.SuppressWarnings("all")
        public LockRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public String getError() {
        return this.error;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getCobBusinessDate() {
        return this.cobBusinessDate;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getNullCobBusinessDate() {
        return this.nullCobBusinessDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setError(final String error) {
        this.error = error;
    }

    @java.lang.SuppressWarnings("all")
        public void setCobBusinessDate(final LocalDate cobBusinessDate) {
        this.cobBusinessDate = cobBusinessDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setNullCobBusinessDate(final Boolean nullCobBusinessDate) {
        this.nullCobBusinessDate = nullCobBusinessDate;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof LockRequest)) return false;
        final LockRequest other = (LockRequest) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$nullCobBusinessDate = this.getNullCobBusinessDate();
        final java.lang.Object other$nullCobBusinessDate = other.getNullCobBusinessDate();
        if (this$nullCobBusinessDate == null ? other$nullCobBusinessDate != null : !this$nullCobBusinessDate.equals(other$nullCobBusinessDate)) return false;
        final java.lang.Object this$error = this.getError();
        final java.lang.Object other$error = other.getError();
        if (this$error == null ? other$error != null : !this$error.equals(other$error)) return false;
        final java.lang.Object this$cobBusinessDate = this.getCobBusinessDate();
        final java.lang.Object other$cobBusinessDate = other.getCobBusinessDate();
        if (this$cobBusinessDate == null ? other$cobBusinessDate != null : !this$cobBusinessDate.equals(other$cobBusinessDate)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof LockRequest;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $nullCobBusinessDate = this.getNullCobBusinessDate();
        result = result * PRIME + ($nullCobBusinessDate == null ? 43 : $nullCobBusinessDate.hashCode());
        final java.lang.Object $error = this.getError();
        result = result * PRIME + ($error == null ? 43 : $error.hashCode());
        final java.lang.Object $cobBusinessDate = this.getCobBusinessDate();
        result = result * PRIME + ($cobBusinessDate == null ? 43 : $cobBusinessDate.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "LockRequest(error=" + this.getError() + ", cobBusinessDate=" + this.getCobBusinessDate() + ", nullCobBusinessDate=" + this.getNullCobBusinessDate() + ")";
    }
}
