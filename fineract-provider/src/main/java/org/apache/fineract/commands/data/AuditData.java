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
package org.apache.fineract.commands.data;

import java.io.Serial;
import java.io.Serializable;
import java.time.ZonedDateTime;

/**
 * Immutable data object representing client data.
 */
public final class AuditData implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private final Long id;
    private final String actionName;
    private final String entityName;
    private final Long resourceId;
    private final Long subresourceId;
    private final String maker;
    private final ZonedDateTime madeOnDate;
    private final String checker;
    private final ZonedDateTime checkedOnDate;
    private final String processingResult;
    private String commandAsJson;
    private final String officeName;
    private final String groupLevelName;
    private final String groupName;
    private final String clientName;
    private final String loanAccountNo;
    private final String savingsAccountNo;
    private final Long clientId;
    private final Long loanId;
    private final String url;
    private final String ip;

    @java.lang.SuppressWarnings("all")
        public AuditData(final Long id, final String actionName, final String entityName, final Long resourceId, final Long subresourceId, final String maker, final ZonedDateTime madeOnDate, final String checker, final ZonedDateTime checkedOnDate, final String processingResult, final String commandAsJson, final String officeName, final String groupLevelName, final String groupName, final String clientName, final String loanAccountNo, final String savingsAccountNo, final Long clientId, final Long loanId, final String url, final String ip) {
        this.id = id;
        this.actionName = actionName;
        this.entityName = entityName;
        this.resourceId = resourceId;
        this.subresourceId = subresourceId;
        this.maker = maker;
        this.madeOnDate = madeOnDate;
        this.checker = checker;
        this.checkedOnDate = checkedOnDate;
        this.processingResult = processingResult;
        this.commandAsJson = commandAsJson;
        this.officeName = officeName;
        this.groupLevelName = groupLevelName;
        this.groupName = groupName;
        this.clientName = clientName;
        this.loanAccountNo = loanAccountNo;
        this.savingsAccountNo = savingsAccountNo;
        this.clientId = clientId;
        this.loanId = loanId;
        this.url = url;
        this.ip = ip;
    }

    @java.lang.SuppressWarnings("all")
        public Long getId() {
        return this.id;
    }

    @java.lang.SuppressWarnings("all")
        public String getActionName() {
        return this.actionName;
    }

    @java.lang.SuppressWarnings("all")
        public String getEntityName() {
        return this.entityName;
    }

    @java.lang.SuppressWarnings("all")
        public Long getResourceId() {
        return this.resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getSubresourceId() {
        return this.subresourceId;
    }

    @java.lang.SuppressWarnings("all")
        public String getMaker() {
        return this.maker;
    }

    @java.lang.SuppressWarnings("all")
        public ZonedDateTime getMadeOnDate() {
        return this.madeOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getChecker() {
        return this.checker;
    }

    @java.lang.SuppressWarnings("all")
        public ZonedDateTime getCheckedOnDate() {
        return this.checkedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getProcessingResult() {
        return this.processingResult;
    }

    @java.lang.SuppressWarnings("all")
        public String getCommandAsJson() {
        return this.commandAsJson;
    }

    @java.lang.SuppressWarnings("all")
        public String getOfficeName() {
        return this.officeName;
    }

    @java.lang.SuppressWarnings("all")
        public String getGroupLevelName() {
        return this.groupLevelName;
    }

    @java.lang.SuppressWarnings("all")
        public String getGroupName() {
        return this.groupName;
    }

    @java.lang.SuppressWarnings("all")
        public String getClientName() {
        return this.clientName;
    }

    @java.lang.SuppressWarnings("all")
        public String getLoanAccountNo() {
        return this.loanAccountNo;
    }

    @java.lang.SuppressWarnings("all")
        public String getSavingsAccountNo() {
        return this.savingsAccountNo;
    }

    @java.lang.SuppressWarnings("all")
        public Long getClientId() {
        return this.clientId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getLoanId() {
        return this.loanId;
    }

    @java.lang.SuppressWarnings("all")
        public String getUrl() {
        return this.url;
    }

    @java.lang.SuppressWarnings("all")
        public String getIp() {
        return this.ip;
    }

    @java.lang.SuppressWarnings("all")
        public void setCommandAsJson(final String commandAsJson) {
        this.commandAsJson = commandAsJson;
    }
}
