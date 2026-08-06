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
package org.apache.fineract.notification.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;

@Entity
@Table(name = "notification_generator")
public class Notification extends AbstractPersistableCustom<Long> {
    @Column(name = "object_type")
    private String objectType;
    @Column(name = "object_identifier")
    private Long objectIdentifier;
    @Column(name = "action")
    private String action;
    @Column(name = "actor")
    private Long actorId;
    @Column(name = "is_system_generated")
    private boolean isSystemGenerated;
    @Column(name = "notification_content")
    private String notificationContent;
    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @java.lang.SuppressWarnings("all")
        public String getObjectType() {
        return this.objectType;
    }

    @java.lang.SuppressWarnings("all")
        public Long getObjectIdentifier() {
        return this.objectIdentifier;
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
        public boolean isSystemGenerated() {
        return this.isSystemGenerated;
    }

    @java.lang.SuppressWarnings("all")
        public String getNotificationContent() {
        return this.notificationContent;
    }

    @java.lang.SuppressWarnings("all")
        public LocalDateTime getCreatedAt() {
        return this.createdAt;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Notification setObjectType(final String objectType) {
        this.objectType = objectType;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Notification setObjectIdentifier(final Long objectIdentifier) {
        this.objectIdentifier = objectIdentifier;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Notification setAction(final String action) {
        this.action = action;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Notification setActorId(final Long actorId) {
        this.actorId = actorId;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Notification setSystemGenerated(final boolean isSystemGenerated) {
        this.isSystemGenerated = isSystemGenerated;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Notification setNotificationContent(final String notificationContent) {
        this.notificationContent = notificationContent;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public Notification setCreatedAt(final LocalDateTime createdAt) {
        this.createdAt = createdAt;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public Notification() {
    }
}
