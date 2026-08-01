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
package org.apache.fineract.portfolio.tax.moduleapi;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Collection;
import java.util.Objects;

/**
 * One component's share of a tax calculation for a base amount (pure data, no JPA).
 */
public final class TaxComponentShareData implements Serializable {

    private static final long serialVersionUID = 1L;

    private final Long taxComponentId;
    private final String name;
    private final BigDecimal amount;
    private final Long creditAccountId;
    private final Long debitAccountId;

    public TaxComponentShareData(final Long taxComponentId, final String name, final BigDecimal amount, final Long creditAccountId,
            final Long debitAccountId) {
        this.taxComponentId = taxComponentId;
        this.name = name;
        this.amount = amount;
        this.creditAccountId = creditAccountId;
        this.debitAccountId = debitAccountId;
    }

    public Long getTaxComponentId() {
        return this.taxComponentId;
    }

    public String getName() {
        return this.name;
    }

    public BigDecimal getAmount() {
        return this.amount;
    }

    public Long getCreditAccountId() {
        return this.creditAccountId;
    }

    public Long getDebitAccountId() {
        return this.debitAccountId;
    }

    public static BigDecimal totalAmount(final Collection<TaxComponentShareData> shares) {
        BigDecimal total = BigDecimal.ZERO;
        if (shares != null) {
            for (final TaxComponentShareData share : shares) {
                if (share != null && share.getAmount() != null) {
                    total = total.add(share.getAmount());
                }
            }
        }
        return total;
    }

    @Override
    public boolean equals(final Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof TaxComponentShareData)) {
            return false;
        }
        final TaxComponentShareData that = (TaxComponentShareData) o;
        return Objects.equals(this.taxComponentId, that.taxComponentId) && Objects.equals(this.amount, that.amount);
    }

    @Override
    public int hashCode() {
        return Objects.hash(this.taxComponentId, this.amount);
    }
}
