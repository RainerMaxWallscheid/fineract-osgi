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
import java.util.List;

/**
 * Immutable data object representing datatable data.
 */
public final class DatatableSearchRequest implements Serializable {
    private List<ColumnFilter> columnFilters;
    private List<String> resultColumns;
    private String datatable;

    @java.lang.SuppressWarnings("all")
        public List<ColumnFilter> getColumnFilters() {
        return this.columnFilters;
    }

    @java.lang.SuppressWarnings("all")
        public List<String> getResultColumns() {
        return this.resultColumns;
    }

    @java.lang.SuppressWarnings("all")
        public String getDatatable() {
        return this.datatable;
    }

    @java.lang.SuppressWarnings("all")
        public void setColumnFilters(final List<ColumnFilter> columnFilters) {
        this.columnFilters = columnFilters;
    }

    @java.lang.SuppressWarnings("all")
        public void setResultColumns(final List<String> resultColumns) {
        this.resultColumns = resultColumns;
    }

    @java.lang.SuppressWarnings("all")
        public void setDatatable(final String datatable) {
        this.datatable = datatable;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof DatatableSearchRequest)) return false;
        final DatatableSearchRequest other = (DatatableSearchRequest) o;
        final java.lang.Object this$columnFilters = this.getColumnFilters();
        final java.lang.Object other$columnFilters = other.getColumnFilters();
        if (this$columnFilters == null ? other$columnFilters != null : !this$columnFilters.equals(other$columnFilters)) return false;
        final java.lang.Object this$resultColumns = this.getResultColumns();
        final java.lang.Object other$resultColumns = other.getResultColumns();
        if (this$resultColumns == null ? other$resultColumns != null : !this$resultColumns.equals(other$resultColumns)) return false;
        final java.lang.Object this$datatable = this.getDatatable();
        final java.lang.Object other$datatable = other.getDatatable();
        if (this$datatable == null ? other$datatable != null : !this$datatable.equals(other$datatable)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $columnFilters = this.getColumnFilters();
        result = result * PRIME + ($columnFilters == null ? 43 : $columnFilters.hashCode());
        final java.lang.Object $resultColumns = this.getResultColumns();
        result = result * PRIME + ($resultColumns == null ? 43 : $resultColumns.hashCode());
        final java.lang.Object $datatable = this.getDatatable();
        result = result * PRIME + ($datatable == null ? 43 : $datatable.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "DatatableSearchRequest(columnFilters=" + this.getColumnFilters() + ", resultColumns=" + this.getResultColumns() + ", datatable=" + this.getDatatable() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public DatatableSearchRequest() {
    }
}
