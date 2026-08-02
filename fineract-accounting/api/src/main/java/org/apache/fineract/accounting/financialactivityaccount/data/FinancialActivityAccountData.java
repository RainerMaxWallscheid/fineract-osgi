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

import java.util.List;
import java.util.Map;
import org.apache.fineract.accounting.glaccount.data.GLAccountData;

public class FinancialActivityAccountData {
    private final Long id;
    private final FinancialActivityData financialActivityData;
    private final GLAccountData glAccountData;
    private Map<String, List<GLAccountData>> glAccountOptions;
    private List<FinancialActivityData> financialActivityOptions;

    public FinancialActivityAccountData() {
        this.id = null;
        this.glAccountData = null;
        this.financialActivityData = null;
        this.glAccountOptions = null;
        this.financialActivityOptions = null;
    }

    @java.lang.SuppressWarnings("all")
        public FinancialActivityAccountData(final Long id, final FinancialActivityData financialActivityData, final GLAccountData glAccountData) {
        this.id = id;
        this.financialActivityData = financialActivityData;
        this.glAccountData = glAccountData;
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public FinancialActivityData getFinancialActivityData() {
        return this.financialActivityData;
    }

    @java.lang.SuppressWarnings("all")
        public GLAccountData getGlAccountData() {
        return this.glAccountData;
    }

    @java.lang.SuppressWarnings("all")
        public Map<String, List<GLAccountData>> getGlAccountOptions() {
        return this.glAccountOptions;
    }

    @java.lang.SuppressWarnings("all")
        public List<FinancialActivityData> getFinancialActivityOptions() {
        return this.financialActivityOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setGlAccountOptions(final Map<String, List<GLAccountData>> glAccountOptions) {
        this.glAccountOptions = glAccountOptions;
    }

    @java.lang.SuppressWarnings("all")
        public void setFinancialActivityOptions(final List<FinancialActivityData> financialActivityOptions) {
        this.financialActivityOptions = financialActivityOptions;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof FinancialActivityAccountData)) return false;
        final FinancialActivityAccountData other = (FinancialActivityAccountData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$financialActivityData = this.getFinancialActivityData();
        final java.lang.Object other$financialActivityData = other.getFinancialActivityData();
        if (this$financialActivityData == null ? other$financialActivityData != null : !this$financialActivityData.equals(other$financialActivityData)) return false;
        final java.lang.Object this$glAccountData = this.getGlAccountData();
        final java.lang.Object other$glAccountData = other.getGlAccountData();
        if (this$glAccountData == null ? other$glAccountData != null : !this$glAccountData.equals(other$glAccountData)) return false;
        final java.lang.Object this$glAccountOptions = this.getGlAccountOptions();
        final java.lang.Object other$glAccountOptions = other.getGlAccountOptions();
        if (this$glAccountOptions == null ? other$glAccountOptions != null : !this$glAccountOptions.equals(other$glAccountOptions)) return false;
        final java.lang.Object this$financialActivityOptions = this.getFinancialActivityOptions();
        final java.lang.Object other$financialActivityOptions = other.getFinancialActivityOptions();
        if (this$financialActivityOptions == null ? other$financialActivityOptions != null : !this$financialActivityOptions.equals(other$financialActivityOptions)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof FinancialActivityAccountData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $financialActivityData = this.getFinancialActivityData();
        result = result * PRIME + ($financialActivityData == null ? 43 : $financialActivityData.hashCode());
        final java.lang.Object $glAccountData = this.getGlAccountData();
        result = result * PRIME + ($glAccountData == null ? 43 : $glAccountData.hashCode());
        final java.lang.Object $glAccountOptions = this.getGlAccountOptions();
        result = result * PRIME + ($glAccountOptions == null ? 43 : $glAccountOptions.hashCode());
        final java.lang.Object $financialActivityOptions = this.getFinancialActivityOptions();
        result = result * PRIME + ($financialActivityOptions == null ? 43 : $financialActivityOptions.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "FinancialActivityAccountData(id=" + this.getId() + ", financialActivityData=" + this.getFinancialActivityData() + ", glAccountData=" + this.getGlAccountData() + ", glAccountOptions=" + this.getGlAccountOptions() + ", financialActivityOptions=" + this.getFinancialActivityOptions() + ")";
    }
}
