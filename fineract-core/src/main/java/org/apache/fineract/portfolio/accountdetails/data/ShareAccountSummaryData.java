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
package org.apache.fineract.portfolio.accountdetails.data;

import java.io.Serializable;
import org.apache.fineract.organisation.monetary.data.CurrencyData;
import org.apache.fineract.shares.shareaccounts.data.ShareAccountApplicationTimelineData;
import org.apache.fineract.shares.shareaccounts.data.ShareAccountStatusEnumData;

public class ShareAccountSummaryData implements Serializable {
    private final Long id;
    private final String accountNo;
    private final Long totalApprovedShares;
    private final Long totalPendingForApprovalShares;
    private final String externalId;
    private final Long productId;
    private final String productName;
    private final String shortProductName;
    private final ShareAccountStatusEnumData status;
    private final CurrencyData currency;
    private final ShareAccountApplicationTimelineData timeline;

    public ShareAccountSummaryData(final Long id, final String accountNo, final String externalId, final Long productId, final String productName, final String shortProductName, final ShareAccountStatusEnumData status, final CurrencyData currency, final Long approvedShares, final Long pendingForApprovalShares, final ShareAccountApplicationTimelineData timeline) {
        this.id = id;
        this.accountNo = accountNo;
        this.externalId = externalId;
        if (approvedShares == null) {
            this.totalApprovedShares = Long.valueOf(0);
        } else {
            this.totalApprovedShares = approvedShares;
        }
        if (pendingForApprovalShares == null) {
            this.totalPendingForApprovalShares = Long.valueOf(0);
        } else {
            this.totalPendingForApprovalShares = pendingForApprovalShares;
        }
        this.productId = productId;
        this.productName = productName;
        this.shortProductName = shortProductName;
        this.status = status;
        this.currency = currency;
        this.timeline = timeline;
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getAccountNo() {
        return this.accountNo;
    }

    @java.lang.SuppressWarnings("all")
        public Long getTotalApprovedShares() {
        return this.totalApprovedShares;
    }

    @java.lang.SuppressWarnings("all")
        public Long getTotalPendingForApprovalShares() {
        return this.totalPendingForApprovalShares;
    }

    @java.lang.SuppressWarnings("all")
        public String getExternalId() {
        return this.externalId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getProductId() {
        return this.productId;
    }

    @java.lang.SuppressWarnings("all")
        public String getProductName() {
        return this.productName;
    }

    @java.lang.SuppressWarnings("all")
        public String getShortProductName() {
        return this.shortProductName;
    }

    @java.lang.SuppressWarnings("all")
        public ShareAccountStatusEnumData getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public CurrencyData getCurrency() {
        return this.currency;
    }

    @java.lang.SuppressWarnings("all")
        public ShareAccountApplicationTimelineData getTimeline() {
        return this.timeline;
    }
}
