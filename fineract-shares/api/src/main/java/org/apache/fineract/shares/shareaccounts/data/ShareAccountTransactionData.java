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
package org.apache.fineract.shares.shareaccounts.data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import org.apache.fineract.infrastructure.core.data.EnumOptionData;
import org.apache.fineract.infrastructure.core.jersey.serializer.legacy.JsonLocalDateArrayFormat;

@JsonLocalDateArrayFormat
public class ShareAccountTransactionData implements Serializable {
    private final Long id;
    private final Long accountId;
    private final LocalDate purchasedDate;
    private final Long numberOfShares;
    private final BigDecimal purchasedPrice;
    private final EnumOptionData status;
    private final EnumOptionData type;
    private final BigDecimal amount;
    private final BigDecimal chargeAmount;
    private final BigDecimal amountPaid;

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getAccountId() {
        return this.accountId;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDate getPurchasedDate() {
        return this.purchasedDate;
    }

    @java.lang.SuppressWarnings("all")
        public Long getNumberOfShares() {
        return this.numberOfShares;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPurchasedPrice() {
        return this.purchasedPrice;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public EnumOptionData getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmount() {
        return this.amount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getChargeAmount() {
        return this.chargeAmount;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getAmountPaid() {
        return this.amountPaid;
    }

    @java.lang.SuppressWarnings("all")
        public ShareAccountTransactionData(final Long id, final Long accountId, final LocalDate purchasedDate, final Long numberOfShares, final BigDecimal purchasedPrice, final EnumOptionData status, final EnumOptionData type, final BigDecimal amount, final BigDecimal chargeAmount, final BigDecimal amountPaid) {
        this.id = id;
        this.accountId = accountId;
        this.purchasedDate = purchasedDate;
        this.numberOfShares = numberOfShares;
        this.purchasedPrice = purchasedPrice;
        this.status = status;
        this.type = type;
        this.amount = amount;
        this.chargeAmount = chargeAmount;
        this.amountPaid = amountPaid;
    }
}
