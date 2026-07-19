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
package org.apache.fineract.portfolio.client.data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Collection;
import org.apache.fineract.infrastructure.codes.data.CodeValueData;

/**
 * Immutable data object represent client identity data.
 */
public class ClientIdentifierData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private final Long id;
    private final Long clientId;
    private final CodeValueData documentType;
    private final String documentKey;
    private final String description;
    private final String status;
    @SuppressWarnings("unused")
    private final Collection<CodeValueData> allowedDocumentTypes;

    public static ClientIdentifierData singleItem(final Long id, final Long clientId, final CodeValueData documentType, final String documentKey, final String status, final String description) {
        return new ClientIdentifierData(id, clientId, documentType, documentKey, description, status, null);
    }

    public static ClientIdentifierData template(final Collection<CodeValueData> codeValues) {
        return new ClientIdentifierData(null, null, null, null, null, null, codeValues);
    }

    public static ClientIdentifierData template(final ClientIdentifierData data, final Collection<CodeValueData> codeValues) {
        return new ClientIdentifierData(data.id, data.clientId, data.documentType, data.documentKey, data.description, data.status, codeValues);
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientId() {
        return this.clientId;
    }

    @java.lang.SuppressWarnings("all")
        public CodeValueData getDocumentType() {
        return this.documentType;
    }

    @java.lang.SuppressWarnings("all")
        public String getDocumentKey() {
        return this.documentKey;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public String getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public Collection<CodeValueData> getAllowedDocumentTypes() {
        return this.allowedDocumentTypes;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public boolean equals(final java.lang.Object o) {
        if (o == this) return true;
        if (!(o instanceof ClientIdentifierData)) return false;
        final ClientIdentifierData other = (ClientIdentifierData) o;
        if (!other.canEqual((java.lang.Object) this)) return false;
        final java.lang.Object this$id = this.getId();
        final java.lang.Object other$id = other.getId();
        if (this$id == null ? other$id != null : !this$id.equals(other$id)) return false;
        final java.lang.Object this$clientId = this.getClientId();
        final java.lang.Object other$clientId = other.getClientId();
        if (this$clientId == null ? other$clientId != null : !this$clientId.equals(other$clientId)) return false;
        final java.lang.Object this$documentType = this.getDocumentType();
        final java.lang.Object other$documentType = other.getDocumentType();
        if (this$documentType == null ? other$documentType != null : !this$documentType.equals(other$documentType)) return false;
        final java.lang.Object this$documentKey = this.getDocumentKey();
        final java.lang.Object other$documentKey = other.getDocumentKey();
        if (this$documentKey == null ? other$documentKey != null : !this$documentKey.equals(other$documentKey)) return false;
        final java.lang.Object this$description = this.getDescription();
        final java.lang.Object other$description = other.getDescription();
        if (this$description == null ? other$description != null : !this$description.equals(other$description)) return false;
        final java.lang.Object this$status = this.getStatus();
        final java.lang.Object other$status = other.getStatus();
        if (this$status == null ? other$status != null : !this$status.equals(other$status)) return false;
        final java.lang.Object this$allowedDocumentTypes = this.getAllowedDocumentTypes();
        final java.lang.Object other$allowedDocumentTypes = other.getAllowedDocumentTypes();
        if (this$allowedDocumentTypes == null ? other$allowedDocumentTypes != null : !this$allowedDocumentTypes.equals(other$allowedDocumentTypes)) return false;
        return true;
    }

    @java.lang.SuppressWarnings("all")
        protected boolean canEqual(final java.lang.Object other) {
        return other instanceof ClientIdentifierData;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public int hashCode() {
        final int PRIME = 59;
        int result = 1;
        final java.lang.Object $id = this.getId();
        result = result * PRIME + ($id == null ? 43 : $id.hashCode());
        final java.lang.Object $clientId = this.getClientId();
        result = result * PRIME + ($clientId == null ? 43 : $clientId.hashCode());
        final java.lang.Object $documentType = this.getDocumentType();
        result = result * PRIME + ($documentType == null ? 43 : $documentType.hashCode());
        final java.lang.Object $documentKey = this.getDocumentKey();
        result = result * PRIME + ($documentKey == null ? 43 : $documentKey.hashCode());
        final java.lang.Object $description = this.getDescription();
        result = result * PRIME + ($description == null ? 43 : $description.hashCode());
        final java.lang.Object $status = this.getStatus();
        result = result * PRIME + ($status == null ? 43 : $status.hashCode());
        final java.lang.Object $allowedDocumentTypes = this.getAllowedDocumentTypes();
        result = result * PRIME + ($allowedDocumentTypes == null ? 43 : $allowedDocumentTypes.hashCode());
        return result;
    }

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "ClientIdentifierData(id=" + this.getId() + ", clientId=" + this.getClientId() + ", documentType=" + this.getDocumentType() + ", documentKey=" + this.getDocumentKey() + ", description=" + this.getDescription() + ", status=" + this.getStatus() + ", allowedDocumentTypes=" + this.getAllowedDocumentTypes() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public ClientIdentifierData(final Long id, final Long clientId, final CodeValueData documentType, final String documentKey, final String description, final String status, final Collection<CodeValueData> allowedDocumentTypes) {
        this.id = id;
        this.clientId = clientId;
        this.documentType = documentType;
        this.documentKey = documentKey;
        this.description = description;
        this.status = status;
        this.allowedDocumentTypes = allowedDocumentTypes;
    }
}
