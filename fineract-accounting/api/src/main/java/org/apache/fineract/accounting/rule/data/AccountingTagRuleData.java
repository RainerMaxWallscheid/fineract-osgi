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
package org.apache.fineract.accounting.rule.data;

import org.apache.fineract.infrastructure.codes.data.CodeValueData;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;

public class AccountingTagRuleData {
    private Long id;
    private CodeValueData tag;
    private EnumOptionData transactionType;

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public CodeValueData getTag() {
        return this.tag;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getTransactionType() {
        return this.transactionType;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccountingTagRuleData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccountingTagRuleData setTag(final CodeValueData tag) {
        this.tag = tag;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public AccountingTagRuleData setTransactionType(final EnumOptionData transactionType) {
        this.transactionType = transactionType;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof AccountingTagRuleData)) return false;
        final AccountingTagRuleData other = (AccountingTagRuleData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$tag = this.getTag();
        final java.lang.Object other$tag = other.getTag();
        if (this$tag == null ? other$tag != null : !this$tag.equals(other$tag)) return false;
        final java.lang.Object this$transactionType = this.getTransactionType();
        final java.lang.Object other$transactionType = other.getTransactionType();
        if (this$transactionType == null ? other$transactionType != null : !this$transactionType.equals(other$transactionType)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof AccountingTagRuleData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $tag = this.getTag();
        result = result * PRIME + ($tag == null ? 43 : $tag.hashCode());
        final java.lang.Object $transactionType = this.getTransactionType();
        result = result * PRIME + ($transactionType == null ? 43 : $transactionType.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "AccountingTagRuleData(id=" + this.getId() + ", tag=" + this.getTag() + ", transactionType=" + this.getTransactionType() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public AccountingTagRuleData() {
    }
}
