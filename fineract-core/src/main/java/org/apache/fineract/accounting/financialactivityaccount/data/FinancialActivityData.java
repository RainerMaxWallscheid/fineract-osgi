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
package org.apache.fineract.accounting.financialactivityaccount.data;

import org.apache.fineract.accounting.glaccount.domain.GLAccountType;

public class FinancialActivityData {
    private final Integer id;
    private final String name;
    private final GLAccountType mappedGLAccountType;

    @java.lang.SuppressWarnings("all")
        public FinancialActivityData(final Integer id, final String name, final GLAccountType mappedGLAccountType) {
        this.id = id;
        this.name = name;
        this.mappedGLAccountType = mappedGLAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public GLAccountType getMappedGLAccountType() {
        return this.mappedGLAccountType;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof FinancialActivityData)) return false;
        final FinancialActivityData other = (FinancialActivityData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$name = this.getName();
        final java.lang.Object other$name = other.getName();
        if (this$name == null ? other$name != null : !this$name.equals(other$name)) return false;
        final java.lang.Object this$mappedGLAccountType = this.getMappedGLAccountType();
        final java.lang.Object other$mappedGLAccountType = other.getMappedGLAccountType();
        if (this$mappedGLAccountType == null ? other$mappedGLAccountType != null : !this$mappedGLAccountType.equals(other$mappedGLAccountType)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof FinancialActivityData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $name = this.getName();
        result = result * PRIME + ($name == null ? 43 : $name.hashCode());
        final java.lang.Object $mappedGLAccountType = this.getMappedGLAccountType();
        result = result * PRIME + ($mappedGLAccountType == null ? 43 : $mappedGLAccountType.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "FinancialActivityData(id=" + this.getId() + ", name=" + this.getName() + ", mappedGLAccountType=" + this.getMappedGLAccountType() + ")";
    }
}
