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
package org.apache.fineract.portfolio.savings.data;

import java.io.Serializable;

/**
 * Immutable data object represent savings account sub-status enumerations.
 */
public class SavingsAccountSubStatusEnumData implements Serializable {
    private final Long id;
    private final String code;
    private final String value;
    private final boolean none;
    private final boolean inactive;
    private final boolean dormant;
    private final boolean escheat;
    private final boolean block;
    private final boolean blockCredit;
    private final boolean blockDebit;

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getCode() {
        return this.code;
    }

    @java.lang.SuppressWarnings("all")
        public String getValue() {
        return this.value;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isNone() {
        return this.none;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isInactive() {
        return this.inactive;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isDormant() {
        return this.dormant;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isEscheat() {
        return this.escheat;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isBlock() {
        return this.block;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isBlockCredit() {
        return this.blockCredit;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isBlockDebit() {
        return this.blockDebit;
    }

    @java.lang.SuppressWarnings("all")
        public SavingsAccountSubStatusEnumData(final Long id, final String code, final String value, final boolean none, final boolean inactive, final boolean dormant, final boolean escheat, final boolean block, final boolean blockCredit, final boolean blockDebit) {
        this.id = id;
        this.code = code;
        this.value = value;
        this.none = none;
        this.inactive = inactive;
        this.dormant = dormant;
        this.escheat = escheat;
        this.block = block;
        this.blockCredit = blockCredit;
        this.blockDebit = blockDebit;
    }
}
