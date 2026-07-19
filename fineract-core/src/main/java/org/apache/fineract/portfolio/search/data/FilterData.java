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

import static org.apache.fineract.infrastructure.core.service.database.SqlOperator.BTW;
import static org.apache.fineract.infrastructure.core.service.database.SqlOperator.EQ;
import java.io.Serializable;
import java.util.List;
import org.apache.fineract.infrastructure.core.service.database.SqlOperator;

/**
 * Immutable data object representing datatable data.
 */
public final class FilterData implements Serializable {
    private SqlOperator operator;
    private List<String> values;

    static FilterData eq(String value) {
        return new FilterData(EQ, List.of(value));
    }

    static FilterData btw(String value1, String value2) {
        return new FilterData(BTW, List.of(value1, value2));
    }

    static FilterData create(SqlOperator op, String... values) {
        return new FilterData(op, List.of(values));
    }

    @java.lang.SuppressWarnings("all")
        public SqlOperator getOperator() {
        return this.operator;
    }

    @java.lang.SuppressWarnings("all")
        public List<String> getValues() {
        return this.values;
    }

    @java.lang.SuppressWarnings("all")
        public void setOperator(final SqlOperator operator) {
        this.operator = operator;
    }

    @java.lang.SuppressWarnings("all")
        public void setValues(final List<String> values) {
        this.values = values;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof FilterData)) return false;
        final FilterData other = (FilterData) o;
        final java.lang.Object this$operator = this.getOperator();
        final java.lang.Object other$operator = other.getOperator();
        if (this$operator == null ? other$operator != null : !this$operator.equals(other$operator)) return false;
        final java.lang.Object this$values = this.getValues();
        final java.lang.Object other$values = other.getValues();
        if (this$values == null ? other$values != null : !this$values.equals(other$values)) return false;
        return true;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $operator = this.getOperator();
        result = result * PRIME + ($operator == null ? 43 : $operator.hashCode());
        final java.lang.Object $values = this.getValues();
        result = result * PRIME + ($values == null ? 43 : $values.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "FilterData(operator=" + this.getOperator() + ", values=" + this.getValues() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public FilterData() {
    }

    @java.lang.SuppressWarnings("all")
        public FilterData(final SqlOperator operator, final List<String> values) {
        this.operator = operator;
        this.values = values;
    }
}
