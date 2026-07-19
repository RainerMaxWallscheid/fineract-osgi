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
package org.apache.fineract.portfolio.tax.data;

import java.math.BigDecimal;

public class TaxDetailsData {
    private TaxComponentData taxComponent;
    private BigDecimal amount;

    @java.lang.SuppressWarnings("all")
        public TaxComponentData getTaxComponent() {
        return this.taxComponent;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public TaxDetailsData(final TaxComponentData taxComponent, final BigDecimal amount) {
        this.taxComponent = taxComponent;
        this.amount = amount;
    }

    @java.lang.SuppressWarnings("all")
        public TaxDetailsData() {
    }

    @java.lang.SuppressWarnings("all")
        public void setAmount(final BigDecimal amount) {
        this.amount = amount;
    }
}
