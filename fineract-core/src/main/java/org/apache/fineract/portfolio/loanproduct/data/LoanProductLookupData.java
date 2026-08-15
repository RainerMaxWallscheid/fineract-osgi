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
package org.apache.fineract.portfolio.loanproduct.data;

import java.io.Serial;
import java.io.Serializable;
import org.apache.fineract.organisation.monetary.data.CurrencyData;

/**
 * Thin loan-product identity for cross-module reads (search/collection sheet) without loan-impl LoanProductData.
 */
public final class LoanProductLookupData implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    private final Long id;
    private final String name;
    private final Boolean multiDisburseLoan;
    private final CurrencyData currency;

    private LoanProductLookupData(final Long id, final String name, final Boolean multiDisburseLoan, final CurrencyData currency) {
        this.id = id;
        this.name = name;
        this.multiDisburseLoan = multiDisburseLoan;
        this.currency = currency;
    }

    public static LoanProductLookupData lookup(final Long id, final String name, final Boolean multiDisburseLoan) {
        return new LoanProductLookupData(id, name, multiDisburseLoan, null);
    }

    public static LoanProductLookupData lookupWithCurrency(final Long id, final String name, final CurrencyData currency) {
        return new LoanProductLookupData(id, name, null, currency);
    }

    public Long getId() {
        return this.id;
    }

    public String getName() {
        return this.name;
    }

    public Boolean isMultiDisburseLoan() {
        return this.multiDisburseLoan;
    }

    public CurrencyData getCurrency() {
        return this.currency;
    }
}
