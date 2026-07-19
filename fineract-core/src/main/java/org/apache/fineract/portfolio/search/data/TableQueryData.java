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

/**
 * Immutable data object representing datatable data.
 */
public final class TableQueryData implements Serializable {
    private String table;
    private AdvancedQueryData query;

    public boolean hasFilter() {
        return query != null && query.hasFilter();
    }

    public boolean hasResultColumn() {
        return query != null && query.hasResultColumn();
    }

    @java.lang.SuppressWarnings("all")
        public String getTable() {
        return this.table;
    }

    @java.lang.SuppressWarnings("all")
        public AdvancedQueryData getQuery() {
        return this.query;
    }

    @java.lang.SuppressWarnings("all")
        public void setTable(final String table) {
        this.table = table;
    }

    @java.lang.SuppressWarnings("all")
        public void setQuery(final AdvancedQueryData query) {
        this.query = query;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof TableQueryData)) return false;
        final TableQueryData other = (TableQueryData) o;
        final java.lang.Object this$table = this.getTable();
        final java.lang.Object other$table = other.getTable();
        if (this$table == null ? other$table != null : !this$table.equals(other$table)) return false;
        final java.lang.Object this$query = this.getQuery();
        final java.lang.Object other$query = other.getQuery();
        if (this$query == null ? other$query != null : !this$query.equals(other$query)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $table = this.getTable();
        result = result * PRIME + ($table == null ? 43 : $table.hashCode());
        final java.lang.Object $query = this.getQuery();
        result = result * PRIME + ($query == null ? 43 : $query.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "TableQueryData(table=" + this.getTable() + ", query=" + this.getQuery() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public TableQueryData() {
    }
}
