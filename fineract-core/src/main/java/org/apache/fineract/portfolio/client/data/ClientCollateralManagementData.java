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
package org.apache.fineract.portfolio.client.data;

import java.io.Serializable;
import java.math.BigDecimal;

public final class ClientCollateralManagementData implements Serializable {
    private final Long id;
    private final String name;
    private final BigDecimal quantity;
    private final BigDecimal pctToBase;
    private final BigDecimal unitPrice;
    private final BigDecimal total;
    private final BigDecimal totalCollateral;

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getQuantity() {
        return this.quantity;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPctToBase() {
        return this.pctToBase;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getUnitPrice() {
        return this.unitPrice;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotal() {
        return this.total;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getTotalCollateral() {
        return this.totalCollateral;
    }

    @java.lang.SuppressWarnings("all")
        public ClientCollateralManagementData(final Long id, final String name, final BigDecimal quantity, final BigDecimal pctToBase, final BigDecimal unitPrice, final BigDecimal total, final BigDecimal totalCollateral) {
        this.id = id;
        this.name = name;
        this.quantity = quantity;
        this.pctToBase = pctToBase;
        this.unitPrice = unitPrice;
        this.total = total;
        this.totalCollateral = totalCollateral;
    }
}
