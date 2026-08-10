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
package org.apache.fineract.accounting.journalentry.data;

import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.Map;
import org.apache.fineract.accounting.glaccount.domain.GLAccount;

public class GLAccountBalanceHolder {
    private final Map<Long, GLAccount> glAccountMap = new LinkedHashMap<>();
    private final Map<Long, BigDecimal> debitBalances = new LinkedHashMap<>();
    private final Map<Long, BigDecimal> creditBalances = new LinkedHashMap<>();

    public void addToCredit(@NotNull GLAccount creditAccount, @NotNull BigDecimal amount) {
        addToProperBalance(creditBalances, creditAccount, amount);
    }

    public void addToDebit(@NotNull GLAccount debitAccount, @NotNull BigDecimal amount) {
        addToProperBalance(debitBalances, debitAccount, amount);
    }

    private void addToProperBalance(@NotNull Map<Long, BigDecimal> balanceMap, @NotNull @NotNull GLAccount account, @NotNull BigDecimal amount) {
        glAccountMap.putIfAbsent(account.getId(), account);
        if (balanceMap.containsKey(account.getId())) {
            BigDecimal totalAmount = balanceMap.get(account.getId()).add(amount);
            balanceMap.put(account.getId(), totalAmount);
        } else {
            balanceMap.put(account.getId(), amount);
        }
    }

    @java.lang.SuppressWarnings("all")
        public GLAccountBalanceHolder() {
    }

    @java.lang.SuppressWarnings("all")
        public Map<Long, GLAccount> getGlAccountMap() {
        return this.glAccountMap;
    }

    @java.lang.SuppressWarnings("all")
        public Map<Long, BigDecimal> getDebitBalances() {
        return this.debitBalances;
    }

    @java.lang.SuppressWarnings("all")
        public Map<Long, BigDecimal> getCreditBalances() {
        return this.creditBalances;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof GLAccountBalanceHolder)) return false;
        final GLAccountBalanceHolder other = (GLAccountBalanceHolder) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$glAccountMap = this.getGlAccountMap();
        final java.lang.Object other$glAccountMap = other.getGlAccountMap();
        if (this$glAccountMap == null ? other$glAccountMap != null : !this$glAccountMap.equals(other$glAccountMap)) return false;
        final java.lang.Object this$debitBalances = this.getDebitBalances();
        final java.lang.Object other$debitBalances = other.getDebitBalances();
        if (this$debitBalances == null ? other$debitBalances != null : !this$debitBalances.equals(other$debitBalances)) return false;
        final java.lang.Object this$creditBalances = this.getCreditBalances();
        final java.lang.Object other$creditBalances = other.getCreditBalances();
        if (this$creditBalances == null ? other$creditBalances != null : !this$creditBalances.equals(other$creditBalances)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof GLAccountBalanceHolder;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $glAccountMap = this.getGlAccountMap();
        result = result * PRIME + ($glAccountMap == null ? 43 : $glAccountMap.hashCode());
        final java.lang.Object $debitBalances = this.getDebitBalances();
        result = result * PRIME + ($debitBalances == null ? 43 : $debitBalances.hashCode());
        final java.lang.Object $creditBalances = this.getCreditBalances();
        result = result * PRIME + ($creditBalances == null ? 43 : $creditBalances.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "GLAccountBalanceHolder(glAccountMap=" + this.getGlAccountMap() + ", debitBalances=" + this.getDebitBalances() + ", creditBalances=" + this.getCreditBalances() + ")";
    }
}
