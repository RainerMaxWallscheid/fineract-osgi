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
package org.apache.fineract.accounting.producttoaccountmapping.data;

import java.io.Serializable;
import org.apache.fineract.accounting.glaccount.data.GLAccountData;
import org.apache.fineract.infrastructure.codes.data.CodeValueData;

public class AdvancedMappingToExpenseAccountData implements Serializable {
    private static final long serialVersionUID = 1L;
    private CodeValueData reasonCodeValue;
    private GLAccountData expenseAccount;

    @java.lang.SuppressWarnings("all")
        public CodeValueData getReasonCodeValue() {
        return this.reasonCodeValue;
    }

    @java.lang.SuppressWarnings("all")
        public GLAccountData getExpenseAccount() {
        return this.expenseAccount;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AdvancedMappingToExpenseAccountData setReasonCodeValue(final CodeValueData reasonCodeValue) {
        this.reasonCodeValue = reasonCodeValue;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AdvancedMappingToExpenseAccountData setExpenseAccount(final GLAccountData expenseAccount) {
        this.expenseAccount = expenseAccount;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof AdvancedMappingToExpenseAccountData)) return false;
        final AdvancedMappingToExpenseAccountData other = (AdvancedMappingToExpenseAccountData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$reasonCodeValue = this.getReasonCodeValue();
        final java.lang.Object other$reasonCodeValue = other.getReasonCodeValue();
        if (this$reasonCodeValue == null ? other$reasonCodeValue != null : !this$reasonCodeValue.equals(other$reasonCodeValue)) return false;
        final java.lang.Object this$expenseAccount = this.getExpenseAccount();
        final java.lang.Object other$expenseAccount = other.getExpenseAccount();
        if (this$expenseAccount == null ? other$expenseAccount != null : !this$expenseAccount.equals(other$expenseAccount)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof AdvancedMappingToExpenseAccountData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $reasonCodeValue = this.getReasonCodeValue();
        result = result * PRIME + ($reasonCodeValue == null ? 43 : $reasonCodeValue.hashCode());
        final java.lang.Object $expenseAccount = this.getExpenseAccount();
        result = result * PRIME + ($expenseAccount == null ? 43 : $expenseAccount.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "AdvancedMappingToExpenseAccountData(reasonCodeValue=" + this.getReasonCodeValue() + ", expenseAccount=" + this.getExpenseAccount() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public AdvancedMappingToExpenseAccountData() {
    }
}
