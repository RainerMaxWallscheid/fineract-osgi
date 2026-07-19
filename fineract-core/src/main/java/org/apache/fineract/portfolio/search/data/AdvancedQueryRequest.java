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
package org.apache.fineract.portfolio.search.data;

import java.io.Serializable;
import java.util.List;

/**
 * Immutable data object representing datatable data.
 */
public final class AdvancedQueryRequest implements Serializable {
    private AdvancedQueryData baseQuery;
    private List<TableQueryData> datatableQueries;

    public boolean hasFilter() {
        return (baseQuery != null && baseQuery.hasFilter()) || (datatableQueries != null && datatableQueries.stream().anyMatch(TableQueryData::hasFilter));
    }

    public boolean hasResultColumn() {
        return (baseQuery != null && baseQuery.hasResultColumn()) || (datatableQueries != null && datatableQueries.stream().anyMatch(TableQueryData::hasResultColumn));
    }

    @java.lang.SuppressWarnings("all")
        public AdvancedQueryData getBaseQuery() {
        return this.baseQuery;
    }

    @java.lang.SuppressWarnings("all")
        public List<TableQueryData> getDatatableQueries() {
        return this.datatableQueries;
    }

    @java.lang.SuppressWarnings("all")
        public void setBaseQuery(final AdvancedQueryData baseQuery) {
        this.baseQuery = baseQuery;
    }

    @java.lang.SuppressWarnings("all")
        public void setDatatableQueries(final List<TableQueryData> datatableQueries) {
        this.datatableQueries = datatableQueries;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof AdvancedQueryRequest)) return false;
        final AdvancedQueryRequest other = (AdvancedQueryRequest) o;
        final java.lang.Object this$baseQuery = this.getBaseQuery();
        final java.lang.Object other$baseQuery = other.getBaseQuery();
        if (this$baseQuery == null ? other$baseQuery != null : !this$baseQuery.equals(other$baseQuery)) return false;
        final java.lang.Object this$datatableQueries = this.getDatatableQueries();
        final java.lang.Object other$datatableQueries = other.getDatatableQueries();
        if (this$datatableQueries == null ? other$datatableQueries != null : !this$datatableQueries.equals(other$datatableQueries)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $baseQuery = this.getBaseQuery();
        result = result * PRIME + ($baseQuery == null ? 43 : $baseQuery.hashCode());
        final java.lang.Object $datatableQueries = this.getDatatableQueries();
        result = result * PRIME + ($datatableQueries == null ? 43 : $datatableQueries.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "AdvancedQueryRequest(baseQuery=" + this.getBaseQuery() + ", datatableQueries=" + this.getDatatableQueries() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public AdvancedQueryRequest() {
    }
}
