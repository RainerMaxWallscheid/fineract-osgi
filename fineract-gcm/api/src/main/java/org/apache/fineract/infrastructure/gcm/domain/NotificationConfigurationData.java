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

public class NotificationConfigurationData {
    private Long id;
    private String serverKey;
    private String gcmEndPoint;
    private String fcmEndPoint;

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getServerKey() {
        return this.serverKey;
    }

    @java.lang.SuppressWarnings("all")
        public String getGcmEndPoint() {
        return this.gcmEndPoint;
    }

    @java.lang.SuppressWarnings("all")
        public String getFcmEndPoint() {
        return this.fcmEndPoint;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public NotificationConfigurationData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public NotificationConfigurationData setServerKey(final String serverKey) {
        this.serverKey = serverKey;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public NotificationConfigurationData setGcmEndPoint(final String gcmEndPoint) {
        this.gcmEndPoint = gcmEndPoint;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public NotificationConfigurationData setFcmEndPoint(final String fcmEndPoint) {
        this.fcmEndPoint = fcmEndPoint;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof NotificationConfigurationData)) return false;
        final NotificationConfigurationData other = (NotificationConfigurationData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$serverKey = this.getServerKey();
        final java.lang.Object other$serverKey = other.getServerKey();
        if (this$serverKey == null ? other$serverKey != null : !this$serverKey.equals(other$serverKey)) return false;
        final java.lang.Object this$gcmEndPoint = this.getGcmEndPoint();
        final java.lang.Object other$gcmEndPoint = other.getGcmEndPoint();
        if (this$gcmEndPoint == null ? other$gcmEndPoint != null : !this$gcmEndPoint.equals(other$gcmEndPoint)) return false;
        final java.lang.Object this$fcmEndPoint = this.getFcmEndPoint();
        final java.lang.Object other$fcmEndPoint = other.getFcmEndPoint();
        if (this$fcmEndPoint == null ? other$fcmEndPoint != null : !this$fcmEndPoint.equals(other$fcmEndPoint)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof NotificationConfigurationData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $serverKey = this.getServerKey();
        result = result * PRIME + ($serverKey == null ? 43 : $serverKey.hashCode());
        final java.lang.Object $gcmEndPoint = this.getGcmEndPoint();
        result = result * PRIME + ($gcmEndPoint == null ? 43 : $gcmEndPoint.hashCode());
        final java.lang.Object $fcmEndPoint = this.getFcmEndPoint();
        result = result * PRIME + ($fcmEndPoint == null ? 43 : $fcmEndPoint.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "NotificationConfigurationData(id=" + this.getId() + ", serverKey=" + this.getServerKey() + ", gcmEndPoint=" + this.getGcmEndPoint() + ", fcmEndPoint=" + this.getFcmEndPoint() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public NotificationConfigurationData() {
    }
}
