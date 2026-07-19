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
import org.apache.fineract.infrastructure.core.service.database.SqlOperator;

/**
 * Immutable data object representing datatable data.
 */
public final class ColumnFilterData implements Serializable {
    private String column;
    private List<FilterData> filters;

    public static ColumnFilterData eq(String column, String value) {
        return new ColumnFilterData(column, List.of(FilterData.eq(value)));
    }

    public static ColumnFilterData btw(String column, String value1, String value2) {
        return new ColumnFilterData(column, List.of(FilterData.btw(value1, value2)));
    }

    public static ColumnFilterData create(String column, SqlOperator op, String... values) {
        return new ColumnFilterData(column, List.of(FilterData.create(op, values)));
    }

    @java.lang.SuppressWarnings("all")
        public String getColumn() {
        return this.column;
    }

    @java.lang.SuppressWarnings("all")
        public List<FilterData> getFilters() {
        return this.filters;
    }

    @java.lang.SuppressWarnings("all")
        public void setColumn(final String column) {
        this.column = column;
    }

    @java.lang.SuppressWarnings("all")
        public void setFilters(final List<FilterData> filters) {
        this.filters = filters;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ColumnFilterData)) return false;
        final ColumnFilterData other = (ColumnFilterData) o;
        final java.lang.Object this$column = this.getColumn();
        final java.lang.Object other$column = other.getColumn();
        if (this$column == null ? other$column != null : !this$column.equals(other$column)) return false;
        final java.lang.Object this$filters = this.getFilters();
        final java.lang.Object other$filters = other.getFilters();
        if (this$filters == null ? other$filters != null : !this$filters.equals(other$filters)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $column = this.getColumn();
        result = result * PRIME + ($column == null ? 43 : $column.hashCode());
        final java.lang.Object $filters = this.getFilters();
        result = result * PRIME + ($filters == null ? 43 : $filters.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ColumnFilterData(column=" + this.getColumn() + ", filters=" + this.getFilters() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ColumnFilterData() {
    }

    @java.lang.SuppressWarnings("all")
        public ColumnFilterData(final String column, final List<FilterData> filters) {
        this.column = column;
        this.filters = filters;
    }
}
