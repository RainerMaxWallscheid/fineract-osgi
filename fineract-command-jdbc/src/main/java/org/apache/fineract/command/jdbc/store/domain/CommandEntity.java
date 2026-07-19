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
package org.apache.fineract.command.jdbc.store.domain;

import com.fasterxml.jackson.databind.JsonNode;
import java.io.Serial;
import java.io.Serializable;
import java.time.Instant;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

@Table("m_command")
public class CommandEntity implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Id
    @Column("id")
    private Long id;
    @Column("created_at")
    private Instant createdAt;
    @Column("updated_at")
    private Instant updatedAt;
    @Column("executed_at")
    private Instant executedAt;
    @Column("approved_at")
    private Instant approvedAt;
    @Column("rejected_at")
    private Instant rejectedAt;
    @Column("initiated_by_username")
    private String initiatedByUsername;
    @Column("executed_by_username")
    private String executedByUsername;
    @Column("approved_by_username")
    private String approvedByUsername;
    @Column("rejected_by_username")
    private String rejectedByUsername;
    @Column("idempotency_key")
    private String idempotencyKey;
    @Column("state")
    private org.apache.fineract.command.core.CommandState state;
    @Column("error")
    private String error;
    @Column("ip_address")
    private String ipAddress;
    @Column("request")
    private JsonNode request;
    @Column("response")
    private JsonNode response;

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
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
        public String getIdempotencyKey() {
        return this.idempotencyKey;
    }

    @java.lang.SuppressWarnings("all")
        public org.apache.fineract.command.core.CommandState getState() {
        return this.state;
    }

    @java.lang.SuppressWarnings("all")
        public String getError() {
        return this.error;
    }

    @java.lang.SuppressWarnings("all")
        public String getIpAddress() {
        return this.ipAddress;
    }

    @java.lang.SuppressWarnings("all")
        public JsonNode getRequest() {
        return this.request;
    }

    @java.lang.SuppressWarnings("all")
        public JsonNode getResponse() {
        return this.response;
    }

    @java.lang.SuppressWarnings("all")
        public void setId(final Long id) {
        this.id = id;
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
        public void setIdempotencyKey(final String idempotencyKey) {
        this.idempotencyKey = idempotencyKey;
    }

    @java.lang.SuppressWarnings("all")
        public void setState(final org.apache.fineract.command.core.CommandState state) {
        this.state = state;
    }

    @java.lang.SuppressWarnings("all")
        public void setError(final String error) {
        this.error = error;
    }

    @java.lang.SuppressWarnings("all")
        public void setIpAddress(final String ipAddress) {
        this.ipAddress = ipAddress;
    }

    @java.lang.SuppressWarnings("all")
        public void setRequest(final JsonNode request) {
        this.request = request;
    }

    @java.lang.SuppressWarnings("all")
        public void setResponse(final JsonNode response) {
        this.response = response;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "CommandEntity(id=" + this.getId() + ", createdAt=" + this.getCreatedAt() + ", updatedAt=" + this.getUpdatedAt() + ", executedAt=" + this.getExecutedAt() + ", approvedAt=" + this.getApprovedAt() + ", rejectedAt=" + this.getRejectedAt() + ", initiatedByUsername=" + this.getInitiatedByUsername() + ", executedByUsername=" + this.getExecutedByUsername() + ", approvedByUsername=" + this.getApprovedByUsername() + ", rejectedByUsername=" + this.getRejectedByUsername() + ", idempotencyKey=" + this.getIdempotencyKey() + ", state=" + this.getState() + ", error=" + this.getError() + ", ipAddress=" + this.getIpAddress() + ", request=" + this.getRequest() + ", response=" + this.getResponse() + ")";
    }


    @java.lang.SuppressWarnings("all")
        public static final class Fields {
        public static final java.lang.String id = "id";
        public static final java.lang.String createdAt = "createdAt";
        public static final java.lang.String updatedAt = "updatedAt";
        public static final java.lang.String executedAt = "executedAt";
        public static final java.lang.String approvedAt = "approvedAt";
        public static final java.lang.String rejectedAt = "rejectedAt";
        public static final java.lang.String initiatedByUsername = "initiatedByUsername";
        public static final java.lang.String executedByUsername = "executedByUsername";
        public static final java.lang.String approvedByUsername = "approvedByUsername";
        public static final java.lang.String rejectedByUsername = "rejectedByUsername";
        public static final java.lang.String idempotencyKey = "idempotencyKey";
        public static final java.lang.String state = "state";
        public static final java.lang.String error = "error";
        public static final java.lang.String ipAddress = "ipAddress";
        public static final java.lang.String request = "request";
        public static final java.lang.String response = "response";
    }
}
