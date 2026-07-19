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
package org.apache.fineract.infrastructure.dataqueries.data;

import java.io.Serializable;

public class ReportExportType implements Serializable {
    private final String key;
    private final String queryParameter;

    @java.lang.SuppressWarnings("all")
        public String getKey() {
        return this.key;
    }

    @java.lang.SuppressWarnings("all")
        public String getQueryParameter() {
        return this.queryParameter;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ReportExportType)) return false;
        final ReportExportType other = (ReportExportType) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$key = this.getKey();
        final java.lang.Object other$key = other.getKey();
        if (this$key == null ? other$key != null : !this$key.equals(other$key)) return false;
        final java.lang.Object this$queryParameter = this.getQueryParameter();
        final java.lang.Object other$queryParameter = other.getQueryParameter();
        if (this$queryParameter == null ? other$queryParameter != null : !this$queryParameter.equals(other$queryParameter)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ReportExportType;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $key = this.getKey();
        result = result * PRIME + ($key == null ? 43 : $key.hashCode());
        final java.lang.Object $queryParameter = this.getQueryParameter();
        result = result * PRIME + ($queryParameter == null ? 43 : $queryParameter.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ReportExportType(key=" + this.getKey() + ", queryParameter=" + this.getQueryParameter() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ReportExportType(final String key, final String queryParameter) {
        this.key = key;
        this.queryParameter = queryParameter;
    }
}
