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

/**
 * Immutable data object representing datatable data.
 */
public final class ColumnFilter implements Serializable {
    private String columnName;
    private String columnValue;
    private String columnOperation;

    @java.lang.SuppressWarnings("all")
        public String getColumnName() {
        return this.columnName;
    }

    @java.lang.SuppressWarnings("all")
        public String getColumnValue() {
        return this.columnValue;
    }

    @java.lang.SuppressWarnings("all")
        public String getColumnOperation() {
        return this.columnOperation;
    }

    @java.lang.SuppressWarnings("all")
        public void setColumnName(final String columnName) {
        this.columnName = columnName;
    }

    @java.lang.SuppressWarnings("all")
        public void setColumnValue(final String columnValue) {
        this.columnValue = columnValue;
    }

    @java.lang.SuppressWarnings("all")
        public void setColumnOperation(final String columnOperation) {
        this.columnOperation = columnOperation;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ColumnFilter)) return false;
        final ColumnFilter other = (ColumnFilter) o;
        final java.lang.Object this$columnName = this.getColumnName();
        final java.lang.Object other$columnName = other.getColumnName();
        if (this$columnName == null ? other$columnName != null : !this$columnName.equals(other$columnName)) return false;
        final java.lang.Object this$columnValue = this.getColumnValue();
        final java.lang.Object other$columnValue = other.getColumnValue();
        if (this$columnValue == null ? other$columnValue != null : !this$columnValue.equals(other$columnValue)) return false;
        final java.lang.Object this$columnOperation = this.getColumnOperation();
        final java.lang.Object other$columnOperation = other.getColumnOperation();
        if (this$columnOperation == null ? other$columnOperation != null : !this$columnOperation.equals(other$columnOperation)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $columnName = this.getColumnName();
        result = result * PRIME + ($columnName == null ? 43 : $columnName.hashCode());
        final java.lang.Object $columnValue = this.getColumnValue();
        result = result * PRIME + ($columnValue == null ? 43 : $columnValue.hashCode());
        final java.lang.Object $columnOperation = this.getColumnOperation();
        result = result * PRIME + ($columnOperation == null ? 43 : $columnOperation.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ColumnFilter(columnName=" + this.getColumnName() + ", columnValue=" + this.getColumnValue() + ", columnOperation=" + this.getColumnOperation() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ColumnFilter() {
    }
}
