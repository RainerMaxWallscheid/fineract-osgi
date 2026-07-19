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
package org.apache.fineract.commands.data.request;

import jakarta.ws.rs.QueryParam;
import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.LocalTime;
import org.apache.fineract.infrastructure.core.service.DateUtils;

public class AuditRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    @QueryParam("actionName")
    private String actionName;
    @QueryParam("entityName")
    private String entityName;
    @QueryParam("resourceId")
    private Long resourceId;
    @QueryParam("makerId")
    private Long makerId;
    @QueryParam("makerDateTimeFrom")
    private String makerDateTimeFrom;
    @QueryParam("makerDateTimeTo")
    private String makerDateTimeTo;
    @QueryParam("checkerId")
    private Long checkerId;
    @QueryParam("checkerDateTimeFrom")
    private String checkerDateTimeFrom;
    @QueryParam("checkerDateTimeTo")
    private String checkerDateTimeTo;
    @QueryParam("status")
    private String status;
    @QueryParam("clientId")
    private Long clientId;
    @QueryParam("loanId")
    private Long loanId;
    @QueryParam("officeId")
    private Long officeId;
    @QueryParam("groupId")
    private Long groupId;
    @QueryParam("savingsAccountId")
    private Long savingsAccountId;
    @QueryParam("processingResult")
    private String processingResult;
    @QueryParam("dateFormat")
    private String dateFormat;
    @QueryParam("locale")
    private String locale;

    public LocalDateTime getMakerDateTimeFrom() {
        return DateUtils.convertDateTimeStringToLocalDateTime(makerDateTimeFrom, dateFormat, locale, LocalTime.MIN);
    }

    public LocalDateTime getMakerDateTimeTo() {
        return DateUtils.convertDateTimeStringToLocalDateTime(makerDateTimeTo, dateFormat, locale, LocalTime.MAX);
    }

    public LocalDateTime getCheckerDateTimeFrom() {
        return DateUtils.convertDateTimeStringToLocalDateTime(checkerDateTimeFrom, dateFormat, locale, LocalTime.MIN);
    }

    public LocalDateTime getCheckerDateTimeTo() {
        return DateUtils.convertDateTimeStringToLocalDateTime(checkerDateTimeTo, dateFormat, locale, LocalTime.MAX);
    }

    @java.lang.SuppressWarnings("all")
        public void setActionName(final String actionName) {
        this.actionName = actionName;
    }

    @java.lang.SuppressWarnings("all")
        public void setEntityName(final String entityName) {
        this.entityName = entityName;
    }

    @java.lang.SuppressWarnings("all")
        public void setResourceId(final Long resourceId) {
        this.resourceId = resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public void setMakerId(final Long makerId) {
        this.makerId = makerId;
    }

    @java.lang.SuppressWarnings("all")
        public void setMakerDateTimeFrom(final String makerDateTimeFrom) {
        this.makerDateTimeFrom = makerDateTimeFrom;
    }

    @java.lang.SuppressWarnings("all")
        public void setMakerDateTimeTo(final String makerDateTimeTo) {
        this.makerDateTimeTo = makerDateTimeTo;
    }

    @java.lang.SuppressWarnings("all")
        public void setCheckerId(final Long checkerId) {
        this.checkerId = checkerId;
    }

    @java.lang.SuppressWarnings("all")
        public void setCheckerDateTimeFrom(final String checkerDateTimeFrom) {
        this.checkerDateTimeFrom = checkerDateTimeFrom;
    }

    @java.lang.SuppressWarnings("all")
        public void setCheckerDateTimeTo(final String checkerDateTimeTo) {
        this.checkerDateTimeTo = checkerDateTimeTo;
    }

    @java.lang.SuppressWarnings("all")
        public void setStatus(final String status) {
        this.status = status;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientId(final Long clientId) {
        this.clientId = clientId;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanId(final Long loanId) {
        this.loanId = loanId;
    }

    @java.lang.SuppressWarnings("all")
        public void setOfficeId(final Long officeId) {
        this.officeId = officeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setGroupId(final Long groupId) {
        this.groupId = groupId;
    }

    @java.lang.SuppressWarnings("all")
        public void setSavingsAccountId(final Long savingsAccountId) {
        this.savingsAccountId = savingsAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public void setProcessingResult(final String processingResult) {
        this.processingResult = processingResult;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
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
        public Long getMakerId() {
        return this.makerId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCheckerId() {
        return this.checkerId;
    }

    @java.lang.SuppressWarnings("all")
        public String getStatus() {
        return this.status;
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
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getGroupId() {
        return this.groupId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getSavingsAccountId() {
        return this.savingsAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public String getProcessingResult() {
        return this.processingResult;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public AuditRequest() {
    }
}
