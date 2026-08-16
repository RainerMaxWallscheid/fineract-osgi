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
package org.apache.fineract.notification.data;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Set;

public class NotificationData implements Serializable {
    private static final long serialVersionUID = 1L;
    private Long id;
    private String objectType;
    private Long objectId;
    private String action;
    private Long actorId;
    private String content;
    private boolean isRead;
    private boolean isSystemGenerated;
    private String tenantIdentifier;
    private String createdAt;
    private Long officeId;
    private Set<Long> userIds;

    public NotificationData(final Long id, final String objectType, final Long objectId, final Long actorId, final String action, final String content, final boolean isSystemGenerated, final boolean isRead, final LocalDateTime createdAt) {
        this.id = id;
        this.objectType = objectType;
        this.objectId = objectId;
        this.actorId = actorId;
        this.action = action;
        this.content = content;
        this.isSystemGenerated = isSystemGenerated;
        this.isRead = isRead;
        this.createdAt = createdAt == null ? null : createdAt.toString();
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getObjectType() {
        return this.objectType;
    }

    @java.lang.SuppressWarnings("all")
        public Long getObjectId() {
        return this.objectId;
    }

    @java.lang.SuppressWarnings("all")
        public String getAction() {
        return this.action;
    }

    @java.lang.SuppressWarnings("all")
        public Long getActorId() {
        return this.actorId;
    }

    @java.lang.SuppressWarnings("all")
        public String getContent() {
        return this.content;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isRead() {
        return this.isRead;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isSystemGenerated() {
        return this.isSystemGenerated;
    }

    @java.lang.SuppressWarnings("all")
        public String getTenantIdentifier() {
        return this.tenantIdentifier;
    }

    @java.lang.SuppressWarnings("all")
        public String getCreatedAt() {
        return this.createdAt;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public Set<Long> getUserIds() {
        return this.userIds;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public NotificationData setId(final Long id) {
        this.id = id;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public NotificationData setObjectType(final String objectType) {
        this.objectType = objectType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public NotificationData setObjectId(final Long objectId) {
        this.objectId = objectId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public NotificationData setAction(final String action) {
        this.action = action;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public NotificationData setActorId(final Long actorId) {
        this.actorId = actorId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public NotificationData setContent(final String content) {
        this.content = content;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public NotificationData setRead(final boolean isRead) {
        this.isRead = isRead;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public NotificationData setSystemGenerated(final boolean isSystemGenerated) {
        this.isSystemGenerated = isSystemGenerated;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public NotificationData setTenantIdentifier(final String tenantIdentifier) {
        this.tenantIdentifier = tenantIdentifier;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public NotificationData setCreatedAt(final String createdAt) {
        this.createdAt = createdAt;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public NotificationData setOfficeId(final Long officeId) {
        this.officeId = officeId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public NotificationData setUserIds(final Set<Long> userIds) {
        this.userIds = userIds;
        return this;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof NotificationData)) return false;
        final NotificationData other = (NotificationData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        if (this.isRead() != other.isRead()) return false;
        if (this.isSystemGenerated() != other.isSystemGenerated()) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$objectId = this.getObjectId();
        final java.lang.Object other$objectId = other.getObjectId();
        if (this$objectId == null ? other$objectId != null : !this$objectId.equals(other$objectId)) return false;
        final java.lang.Object this$actorId = this.getActorId();
        final java.lang.Object other$actorId = other.getActorId();
        if (this$actorId == null ? other$actorId != null : !this$actorId.equals(other$actorId)) return false;
        final java.lang.Object this$officeId = this.getOfficeId();
        final java.lang.Object other$officeId = other.getOfficeId();
        if (this$officeId == null ? other$officeId != null : !this$officeId.equals(other$officeId)) return false;
        final java.lang.Object this$objectType = this.getObjectType();
        final java.lang.Object other$objectType = other.getObjectType();
        if (this$objectType == null ? other$objectType != null : !this$objectType.equals(other$objectType)) return false;
        final java.lang.Object this$action = this.getAction();
        final java.lang.Object other$action = other.getAction();
        if (this$action == null ? other$action != null : !this$action.equals(other$action)) return false;
        final java.lang.Object this$content = this.getContent();
        final java.lang.Object other$content = other.getContent();
        if (this$content == null ? other$content != null : !this$content.equals(other$content)) return false;
        final java.lang.Object this$tenantIdentifier = this.getTenantIdentifier();
        final java.lang.Object other$tenantIdentifier = other.getTenantIdentifier();
        if (this$tenantIdentifier == null ? other$tenantIdentifier != null : !this$tenantIdentifier.equals(other$tenantIdentifier)) return false;
        final java.lang.Object this$createdAt = this.getCreatedAt();
        final java.lang.Object other$createdAt = other.getCreatedAt();
        if (this$createdAt == null ? other$createdAt != null : !this$createdAt.equals(other$createdAt)) return false;
        final java.lang.Object this$userIds = this.getUserIds();
        final java.lang.Object other$userIds = other.getUserIds();
        if (this$userIds == null ? other$userIds != null : !this$userIds.equals(other$userIds)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof NotificationData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        result = result * PRIME + (this.isRead() ? 79 : 97);
        result = result * PRIME + (this.isSystemGenerated() ? 79 : 97);
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $objectId = this.getObjectId();
        result = result * PRIME + ($objectId == null ? 43 : $objectId.hashCode());
        final java.lang.Object $actorId = this.getActorId();
        result = result * PRIME + ($actorId == null ? 43 : $actorId.hashCode());
        final java.lang.Object $officeId = this.getOfficeId();
        result = result * PRIME + ($officeId == null ? 43 : $officeId.hashCode());
        final java.lang.Object $objectType = this.getObjectType();
        result = result * PRIME + ($objectType == null ? 43 : $objectType.hashCode());
        final java.lang.Object $action = this.getAction();
        result = result * PRIME + ($action == null ? 43 : $action.hashCode());
        final java.lang.Object $content = this.getContent();
        result = result * PRIME + ($content == null ? 43 : $content.hashCode());
        final java.lang.Object $tenantIdentifier = this.getTenantIdentifier();
        result = result * PRIME + ($tenantIdentifier == null ? 43 : $tenantIdentifier.hashCode());
        final java.lang.Object $createdAt = this.getCreatedAt();
        result = result * PRIME + ($createdAt == null ? 43 : $createdAt.hashCode());
        final java.lang.Object $userIds = this.getUserIds();
        result = result * PRIME + ($userIds == null ? 43 : $userIds.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "NotificationData(id=" + this.getId() + ", objectType=" + this.getObjectType() + ", objectId=" + this.getObjectId() + ", action=" + this.getAction() + ", actorId=" + this.getActorId() + ", content=" + this.getContent() + ", isRead=" + this.isRead() + ", isSystemGenerated=" + this.isSystemGenerated() + ", tenantIdentifier=" + this.getTenantIdentifier() + ", createdAt=" + this.getCreatedAt() + ", officeId=" + this.getOfficeId() + ", userIds=" + this.getUserIds() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public NotificationData() {
    }
}
