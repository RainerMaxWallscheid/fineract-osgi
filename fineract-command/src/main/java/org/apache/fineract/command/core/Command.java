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
package org.apache.fineract.command.core;

import java.io.Serial;
import java.io.Serializable;
import java.time.Instant;

public class Command<T> implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long commandId;
    private String idempotencyKey;
    private String ipAddress;
    private Instant createdAt;
    private Instant updatedAt;
    private Instant executedAt;
    private Instant approvedAt;
    private Instant rejectedAt;
    private String initiatedByUsername;
    private String executedByUsername;
    private String approvedByUsername;
    private String rejectedByUsername;
    private String error;
    private T payload;

    @java.lang.SuppressWarnings("all")
        public Command() {
    }

    @java.lang.SuppressWarnings("all")
        public Long getCommandId() {
        return this.commandId;
    }

    @java.lang.SuppressWarnings("all")
        public String getIdempotencyKey() {
        return this.idempotencyKey;
    }

    @java.lang.SuppressWarnings("all")
        public String getIpAddress() {
        return this.ipAddress;
    }

    @java.lang.SuppressWarnings("all")
        public Instant getCreatedAt() {
        return this.createdAt;
    }

    @java.lang.SuppressWarnings("all")
        public Instant getUpdatedAt() {
        return this.updatedAt;
    }

    @java.lang.SuppressWarnings("all")
        public Instant getExecutedAt() {
        return this.executedAt;
    }

    @java.lang.SuppressWarnings("all")
        public Instant getApprovedAt() {
        return this.approvedAt;
    }

    @java.lang.SuppressWarnings("all")
        public Instant getRejectedAt() {
        return this.rejectedAt;
    }

    @java.lang.SuppressWarnings("all")
        public String getInitiatedByUsername() {
        return this.initiatedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getExecutedByUsername() {
        return this.executedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getApprovedByUsername() {
        return this.approvedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getRejectedByUsername() {
        return this.rejectedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public String getError() {
        return this.error;
    }

    @java.lang.SuppressWarnings("all")
        public T getPayload() {
        return this.payload;
    }

    @java.lang.SuppressWarnings("all")
        public void setCommandId(final Long commandId) {
        this.commandId = commandId;
    }

    @java.lang.SuppressWarnings("all")
        public void setIdempotencyKey(final String idempotencyKey) {
        this.idempotencyKey = idempotencyKey;
    }

    @java.lang.SuppressWarnings("all")
        public void setIpAddress(final String ipAddress) {
        this.ipAddress = ipAddress;
    }

    @java.lang.SuppressWarnings("all")
        public void setCreatedAt(final Instant createdAt) {
        this.createdAt = createdAt;
    }

    @java.lang.SuppressWarnings("all")
        public void setUpdatedAt(final Instant updatedAt) {
        this.updatedAt = updatedAt;
    }

    @java.lang.SuppressWarnings("all")
        public void setExecutedAt(final Instant executedAt) {
        this.executedAt = executedAt;
    }

    @java.lang.SuppressWarnings("all")
        public void setApprovedAt(final Instant approvedAt) {
        this.approvedAt = approvedAt;
    }

    @java.lang.SuppressWarnings("all")
        public void setRejectedAt(final Instant rejectedAt) {
        this.rejectedAt = rejectedAt;
    }

    @java.lang.SuppressWarnings("all")
        public void setInitiatedByUsername(final String initiatedByUsername) {
        this.initiatedByUsername = initiatedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public void setExecutedByUsername(final String executedByUsername) {
        this.executedByUsername = executedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public void setApprovedByUsername(final String approvedByUsername) {
        this.approvedByUsername = approvedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public void setRejectedByUsername(final String rejectedByUsername) {
        this.rejectedByUsername = rejectedByUsername;
    }

    @java.lang.SuppressWarnings("all")
        public void setError(final String error) {
        this.error = error;
    }

    @java.lang.SuppressWarnings("all")
        public void setPayload(final T payload) {
        this.payload = payload;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof Command)) return false;
        final Command<?> other = (Command<?>) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$commandId = this.getCommandId();
        final java.lang.Object other$commandId = other.getCommandId();
        if (this$commandId == null ? other$commandId != null : !this$commandId.equals(other$commandId)) return false;
        final java.lang.Object this$idempotencyKey = this.getIdempotencyKey();
        final java.lang.Object other$idempotencyKey = other.getIdempotencyKey();
        if (this$idempotencyKey == null ? other$idempotencyKey != null : !this$idempotencyKey.equals(other$idempotencyKey)) return false;
        final java.lang.Object this$ipAddress = this.getIpAddress();
        final java.lang.Object other$ipAddress = other.getIpAddress();
        if (this$ipAddress == null ? other$ipAddress != null : !this$ipAddress.equals(other$ipAddress)) return false;
        final java.lang.Object this$createdAt = this.getCreatedAt();
        final java.lang.Object other$createdAt = other.getCreatedAt();
        if (this$createdAt == null ? other$createdAt != null : !this$createdAt.equals(other$createdAt)) return false;
        final java.lang.Object this$updatedAt = this.getUpdatedAt();
        final java.lang.Object other$updatedAt = other.getUpdatedAt();
        if (this$updatedAt == null ? other$updatedAt != null : !this$updatedAt.equals(other$updatedAt)) return false;
        final java.lang.Object this$executedAt = this.getExecutedAt();
        final java.lang.Object other$executedAt = other.getExecutedAt();
        if (this$executedAt == null ? other$executedAt != null : !this$executedAt.equals(other$executedAt)) return false;
        final java.lang.Object this$approvedAt = this.getApprovedAt();
        final java.lang.Object other$approvedAt = other.getApprovedAt();
        if (this$approvedAt == null ? other$approvedAt != null : !this$approvedAt.equals(other$approvedAt)) return false;
        final java.lang.Object this$rejectedAt = this.getRejectedAt();
        final java.lang.Object other$rejectedAt = other.getRejectedAt();
        if (this$rejectedAt == null ? other$rejectedAt != null : !this$rejectedAt.equals(other$rejectedAt)) return false;
        final java.lang.Object this$initiatedByUsername = this.getInitiatedByUsername();
        final java.lang.Object other$initiatedByUsername = other.getInitiatedByUsername();
        if (this$initiatedByUsername == null ? other$initiatedByUsername != null : !this$initiatedByUsername.equals(other$initiatedByUsername)) return false;
        final java.lang.Object this$executedByUsername = this.getExecutedByUsername();
        final java.lang.Object other$executedByUsername = other.getExecutedByUsername();
        if (this$executedByUsername == null ? other$executedByUsername != null : !this$executedByUsername.equals(other$executedByUsername)) return false;
        final java.lang.Object this$approvedByUsername = this.getApprovedByUsername();
        final java.lang.Object other$approvedByUsername = other.getApprovedByUsername();
        if (this$approvedByUsername == null ? other$approvedByUsername != null : !this$approvedByUsername.equals(other$approvedByUsername)) return false;
        final java.lang.Object this$rejectedByUsername = this.getRejectedByUsername();
        final java.lang.Object other$rejectedByUsername = other.getRejectedByUsername();
        if (this$rejectedByUsername == null ? other$rejectedByUsername != null : !this$rejectedByUsername.equals(other$rejectedByUsername)) return false;
        final java.lang.Object this$error = this.getError();
        final java.lang.Object other$error = other.getError();
        if (this$error == null ? other$error != null : !this$error.equals(other$error)) return false;
        final java.lang.Object this$payload = this.getPayload();
        final java.lang.Object other$payload = other.getPayload();
        if (this$payload == null ? other$payload != null : !this$payload.equals(other$payload)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof Command;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $commandId = this.getCommandId();
        result = result * PRIME + ($commandId == null ? 43 : $commandId.hashCode());
        final java.lang.Object $idempotencyKey = this.getIdempotencyKey();
        result = result * PRIME + ($idempotencyKey == null ? 43 : $idempotencyKey.hashCode());
        final java.lang.Object $ipAddress = this.getIpAddress();
        result = result * PRIME + ($ipAddress == null ? 43 : $ipAddress.hashCode());
        final java.lang.Object $createdAt = this.getCreatedAt();
        result = result * PRIME + ($createdAt == null ? 43 : $createdAt.hashCode());
        final java.lang.Object $updatedAt = this.getUpdatedAt();
        result = result * PRIME + ($updatedAt == null ? 43 : $updatedAt.hashCode());
        final java.lang.Object $executedAt = this.getExecutedAt();
        result = result * PRIME + ($executedAt == null ? 43 : $executedAt.hashCode());
        final java.lang.Object $approvedAt = this.getApprovedAt();
        result = result * PRIME + ($approvedAt == null ? 43 : $approvedAt.hashCode());
        final java.lang.Object $rejectedAt = this.getRejectedAt();
        result = result * PRIME + ($rejectedAt == null ? 43 : $rejectedAt.hashCode());
        final java.lang.Object $initiatedByUsername = this.getInitiatedByUsername();
        result = result * PRIME + ($initiatedByUsername == null ? 43 : $initiatedByUsername.hashCode());
        final java.lang.Object $executedByUsername = this.getExecutedByUsername();
        result = result * PRIME + ($executedByUsername == null ? 43 : $executedByUsername.hashCode());
        final java.lang.Object $approvedByUsername = this.getApprovedByUsername();
        result = result * PRIME + ($approvedByUsername == null ? 43 : $approvedByUsername.hashCode());
        final java.lang.Object $rejectedByUsername = this.getRejectedByUsername();
        result = result * PRIME + ($rejectedByUsername == null ? 43 : $rejectedByUsername.hashCode());
        final java.lang.Object $error = this.getError();
        result = result * PRIME + ($error == null ? 43 : $error.hashCode());
        final java.lang.Object $payload = this.getPayload();
        result = result * PRIME + ($payload == null ? 43 : $payload.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "Command(commandId=" + this.getCommandId() + ", idempotencyKey=" + this.getIdempotencyKey() + ", ipAddress=" + this.getIpAddress() + ", createdAt=" + this.getCreatedAt() + ", updatedAt=" + this.getUpdatedAt() + ", executedAt=" + this.getExecutedAt() + ", approvedAt=" + this.getApprovedAt() + ", rejectedAt=" + this.getRejectedAt() + ", initiatedByUsername=" + this.getInitiatedByUsername() + ", executedByUsername=" + this.getExecutedByUsername() + ", approvedByUsername=" + this.getApprovedByUsername() + ", rejectedByUsername=" + this.getRejectedByUsername() + ", error=" + this.getError() + ", payload=" + this.getPayload() + ")";
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String commandId = "commandId";
        public static final java.lang.String idempotencyKey = "idempotencyKey";
        public static final java.lang.String ipAddress = "ipAddress";
        public static final java.lang.String createdAt = "createdAt";
        public static final java.lang.String updatedAt = "updatedAt";
        public static final java.lang.String executedAt = "executedAt";
        public static final java.lang.String approvedAt = "approvedAt";
        public static final java.lang.String rejectedAt = "rejectedAt";
        public static final java.lang.String initiatedByUsername = "initiatedByUsername";
        public static final java.lang.String executedByUsername = "executedByUsername";
        public static final java.lang.String approvedByUsername = "approvedByUsername";
        public static final java.lang.String rejectedByUsername = "rejectedByUsername";
        public static final java.lang.String error = "error";
        public static final java.lang.String payload = "payload";
    }
}
