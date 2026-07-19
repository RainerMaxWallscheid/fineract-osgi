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

import io.swagger.v3.oas.annotations.media.Schema;
import java.io.Serial;
import java.io.Serializable;

public class ClientIdentifierRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @Schema(example = "1")
    public Long documentTypeId;
    @Schema(example = "KA-54677")
    public String documentKey;
    @Schema(example = "Document has been verified")
    public String description;
    @Schema(example = "Active")
    public String status;

    @java.lang.SuppressWarnings("all")
        public Long getDocumentTypeId() {
        return this.documentTypeId;
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
        public void setDocumentTypeId(final Long documentTypeId) {
        this.documentTypeId = documentTypeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setDocumentKey(final String documentKey) {
        this.documentKey = documentKey;
    }

    @java.lang.SuppressWarnings("all")
        public void setDescription(final String description) {
        this.description = description;
    }

    @java.lang.SuppressWarnings("all")
        public void setStatus(final String status) {
        this.status = status;
    }

    @java.lang.SuppressWarnings("all")
        public ClientIdentifierRequest() {
    }

    @java.lang.SuppressWarnings("all")
        public ClientIdentifierRequest(final Long documentTypeId, final String documentKey, final String description, final String status) {
        this.documentTypeId = documentTypeId;
        this.documentKey = documentKey;
        this.description = description;
        this.status = status;
    }
}
