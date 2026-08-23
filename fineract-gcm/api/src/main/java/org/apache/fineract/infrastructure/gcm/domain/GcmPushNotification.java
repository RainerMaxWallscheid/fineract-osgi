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
package org.apache.fineract.infrastructure.gcm.domain;

import java.time.LocalDateTime;

/**
 * Push payload for {@code NotificationSenderService} (no leftover SmsMessage).
 */
public class GcmPushNotification {

    private final Long clientId;
    private final String message;
    private Boolean sent;
    private LocalDateTime deliveredOnDate;

    public GcmPushNotification(final Long clientId, final String message) {
        this.clientId = clientId;
        this.message = message;
    }

    public Long getClientId() {
        return this.clientId;
    }

    public String getMessage() {
        return this.message;
    }

    public boolean isSent() {
        return Boolean.TRUE.equals(this.sent);
    }

    public boolean isFailed() {
        return Boolean.FALSE.equals(this.sent);
    }

    public LocalDateTime getDeliveredOnDate() {
        return this.deliveredOnDate;
    }

    public void markSent(final LocalDateTime deliveredOnDate) {
        this.sent = true;
        this.deliveredOnDate = deliveredOnDate;
    }

    public void markFailed() {
        this.sent = false;
        this.deliveredOnDate = null;
    }
}
