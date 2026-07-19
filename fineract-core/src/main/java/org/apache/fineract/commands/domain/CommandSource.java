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
package org.apache.fineract.commands.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import java.time.OffsetDateTime;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.data.CommandProcessingResult;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.infrastructure.core.domain.ExternalId;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.core.service.IpAddressUtils;
import org.apache.fineract.useradministration.domain.AppUser;

@Entity
@Table(name = "m_portfolio_command_source")
public class CommandSource extends AbstractPersistableCustom<Long> {
    @Column(name = "action_name", nullable = true, length = 100)
    private String actionName;
    @Column(name = "entity_name", nullable = true, length = 100)
    private String entityName;
    @Column(name = "office_id")
    private Long officeId;
    @Column(name = "group_id")
    private Long groupId;
    @Column(name = "client_id")
    private Long clientId;
    @Column(name = "loan_id")
    private Long loanId;
    @Column(name = "savings_account_id")
    private Long savingsId;
    @Column(name = "api_get_url", length = 100)
    private String resourceGetUrl;
    @Column(name = "resource_id")
    private Long resourceId;
    @Column(name = "subresource_id")
    private Long subResourceId;
    @Column(name = "command_as_json", length = 1000)
    private String commandAsJson;
    @ManyToOne
    @JoinColumn(name = "maker_id", nullable = false)
    private AppUser maker;
    /*
     * Deprecated: Columns and data left untouched to help migration.
     *
     * @Column(name = "made_on_date", nullable = false) private LocalDateTime madeOnDate;
     *
     * @Column(name = "checked_on_date", nullable = true) private LocalDateTime checkedOnDate;
     */
    @Column(name = "made_on_date_utc", nullable = false)
    private OffsetDateTime madeOnDate;
    @Column(name = "checked_on_date_utc")
    private OffsetDateTime checkedOnDate;
    @ManyToOne
    @JoinColumn(name = "checker_id", nullable = true)
    private AppUser checker;
    @Column(name = "status", nullable = false)
    private Integer status;
    @Column(name = "product_id")
    private Long productId;
    @Column(name = "transaction_id", length = 100)
    private String transactionId;
    @Column(name = "creditbureau_id")
    private Long creditBureauId;
    @Column(name = "organisation_creditbureau_id")
    private Long organisationCreditBureauId;
    @Column(name = "job_name")
    private String jobName;
    @Column(name = "idempotency_key", length = 50)
    private String idempotencyKey;
    @Column(name = "resource_external_id")
    private ExternalId resourceExternalId;
    @Column(name = "subresource_external_id")
    private ExternalId subResourceExternalId;
    @Column(name = "result")
    private String result;
    @Column(name = "result_status_code")
    private Integer resultStatusCode;
    @Column(name = "loan_external_id", length = 100)
    private ExternalId loanExternalId;
    @Column(name = "client_ip", nullable = true)
    private String clientIp;
    @Column(name = "is_sanitized", nullable = false)
    private boolean sanitized;

    public static CommandSource fullEntryFrom(final CommandWrapper wrapper, final JsonCommand command, final AppUser maker, String idempotencyKey, Integer status, boolean sanitized) {
        return  //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        CommandSource.builder().actionName(wrapper.actionName()).entityName(wrapper.entityName()).resourceGetUrl(wrapper.getHref()).resourceId(command.entityId()).subResourceId(command.subentityId()).commandAsJson(command.json()).maker(maker).madeOnDate(DateUtils.getAuditOffsetDateTime()).status(status).idempotencyKey(idempotencyKey).officeId(wrapper.getOfficeId()).groupId(command.getGroupId()).clientId(command.getClientId()).loanId(command.getLoanId()).savingsId(command.getSavingsId()).productId(command.getProductId()).transactionId(command.getTransactionId()).creditBureauId(command.getCreditBureauId()).organisationCreditBureauId(command.getOrganisationCreditBureauId()).clientIp(IpAddressUtils.getClientIp()).loanExternalId(command.getLoanExternalId()).sanitized(sanitized).build(); //
    }

    public String getPermissionCode() {
        return this.actionName + "_" + this.entityName;
    }

    @NotNull
    public CommandProcessingResultType getStatusEnum() {
        return CommandProcessingResultType.fromInt(status);
    }

    public void setStatus(@NotNull CommandProcessingResultType status) {
        this.status = status.getValue();
    }

    public void markAsAwaitingApproval() {
        setStatus(CommandProcessingResultType.AWAITING_APPROVAL);
    }

    public boolean isAwaitingApproval() {
        return getStatusEnum().isAwaitingApproval();
    }

    public boolean isProcessed() {
        return getStatusEnum().isProcessed();
    }

    public void markAsChecked(final AppUser checker) {
        this.checker = checker;
        this.checkedOnDate = DateUtils.getAuditOffsetDateTime();
        setStatus(CommandProcessingResultType.PROCESSED);
    }

    public boolean isChecked() {
        return checker != null && isProcessed();
    }

    public void markAsRejected(final AppUser checker) {
        this.checker = checker;
        this.checkedOnDate = DateUtils.getAuditOffsetDateTime();
        setStatus(CommandProcessingResultType.REJECTED);
    }

    public boolean isRejected() {
        return checker != null && isRejected();
    }

    public void updateForAudit(final CommandProcessingResult result) {
        this.officeId = result.getOfficeId();
        this.groupId = result.getGroupId();
        this.clientId = result.getClientId();
        this.loanId = result.getLoanId();
        this.savingsId = result.getSavingsId();
        this.productId = result.getProductId();
        this.transactionId = result.getTransactionId();
        this.resourceId = result.getResourceId();
        this.resourceExternalId = result.getResourceExternalId();
        this.subResourceId = result.getSubResourceId();
        this.subResourceExternalId = result.getSubResourceExternalId();
        this.loanExternalId = result.getLoanExternalId();
    }


    @java.lang.SuppressWarnings("all")
        public static class CommandSourceBuilder {
        @java.lang.SuppressWarnings("all")
                private String actionName;
        @java.lang.SuppressWarnings("all")
                private String entityName;
        @java.lang.SuppressWarnings("all")
                private Long officeId;
        @java.lang.SuppressWarnings("all")
                private Long groupId;
        @java.lang.SuppressWarnings("all")
                private Long clientId;
        @java.lang.SuppressWarnings("all")
                private Long loanId;
        @java.lang.SuppressWarnings("all")
                private Long savingsId;
        @java.lang.SuppressWarnings("all")
                private String resourceGetUrl;
        @java.lang.SuppressWarnings("all")
                private Long resourceId;
        @java.lang.SuppressWarnings("all")
                private Long subResourceId;
        @java.lang.SuppressWarnings("all")
                private String commandAsJson;
        @java.lang.SuppressWarnings("all")
                private AppUser maker;
        @java.lang.SuppressWarnings("all")
                private OffsetDateTime madeOnDate;
        @java.lang.SuppressWarnings("all")
                private OffsetDateTime checkedOnDate;
        @java.lang.SuppressWarnings("all")
                private AppUser checker;
        @java.lang.SuppressWarnings("all")
                private Integer status;
        @java.lang.SuppressWarnings("all")
                private Long productId;
        @java.lang.SuppressWarnings("all")
                private String transactionId;
        @java.lang.SuppressWarnings("all")
                private Long creditBureauId;
        @java.lang.SuppressWarnings("all")
                private Long organisationCreditBureauId;
        @java.lang.SuppressWarnings("all")
                private String jobName;
        @java.lang.SuppressWarnings("all")
                private String idempotencyKey;
        @java.lang.SuppressWarnings("all")
                private ExternalId resourceExternalId;
        @java.lang.SuppressWarnings("all")
                private ExternalId subResourceExternalId;
        @java.lang.SuppressWarnings("all")
                private String result;
        @java.lang.SuppressWarnings("all")
                private Integer resultStatusCode;
        @java.lang.SuppressWarnings("all")
                private ExternalId loanExternalId;
        @java.lang.SuppressWarnings("all")
                private String clientIp;
        @java.lang.SuppressWarnings("all")
                private boolean sanitized;

        @java.lang.SuppressWarnings("all")
                CommandSourceBuilder() {
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder actionName(final String actionName) {
            this.actionName = actionName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder entityName(final String entityName) {
            this.entityName = entityName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder officeId(final Long officeId) {
            this.officeId = officeId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder groupId(final Long groupId) {
            this.groupId = groupId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder clientId(final Long clientId) {
            this.clientId = clientId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder loanId(final Long loanId) {
            this.loanId = loanId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder savingsId(final Long savingsId) {
            this.savingsId = savingsId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder resourceGetUrl(final String resourceGetUrl) {
            this.resourceGetUrl = resourceGetUrl;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder resourceId(final Long resourceId) {
            this.resourceId = resourceId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder subResourceId(final Long subResourceId) {
            this.subResourceId = subResourceId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder commandAsJson(final String commandAsJson) {
            this.commandAsJson = commandAsJson;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder maker(final AppUser maker) {
            this.maker = maker;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder madeOnDate(final OffsetDateTime madeOnDate) {
            this.madeOnDate = madeOnDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder checkedOnDate(final OffsetDateTime checkedOnDate) {
            this.checkedOnDate = checkedOnDate;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder checker(final AppUser checker) {
            this.checker = checker;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder status(final Integer status) {
            this.status = status;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder productId(final Long productId) {
            this.productId = productId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder transactionId(final String transactionId) {
            this.transactionId = transactionId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder creditBureauId(final Long creditBureauId) {
            this.creditBureauId = creditBureauId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder organisationCreditBureauId(final Long organisationCreditBureauId) {
            this.organisationCreditBureauId = organisationCreditBureauId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder jobName(final String jobName) {
            this.jobName = jobName;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder idempotencyKey(final String idempotencyKey) {
            this.idempotencyKey = idempotencyKey;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder resourceExternalId(final ExternalId resourceExternalId) {
            this.resourceExternalId = resourceExternalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder subResourceExternalId(final ExternalId subResourceExternalId) {
            this.subResourceExternalId = subResourceExternalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder result(final String result) {
            this.result = result;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder resultStatusCode(final Integer resultStatusCode) {
            this.resultStatusCode = resultStatusCode;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder loanExternalId(final ExternalId loanExternalId) {
            this.loanExternalId = loanExternalId;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder clientIp(final String clientIp) {
            this.clientIp = clientIp;
            return this;
        }

        /**
         * @return {@code this}.
         */
        @java.lang.SuppressWarnings("all")
                public CommandSource.CommandSourceBuilder sanitized(final boolean sanitized) {
            this.sanitized = sanitized;
            return this;
        }

        @java.lang.SuppressWarnings("all")
                public CommandSource build() {
            return new CommandSource(this.actionName, this.entityName, this.officeId, this.groupId, this.clientId, this.loanId, this.savingsId, this.resourceGetUrl, this.resourceId, this.subResourceId, this.commandAsJson, this.maker, this.madeOnDate, this.checkedOnDate, this.checker, this.status, this.productId, this.transactionId, this.creditBureauId, this.organisationCreditBureauId, this.jobName, this.idempotencyKey, this.resourceExternalId, this.subResourceExternalId, this.result, this.resultStatusCode, this.loanExternalId, this.clientIp, this.sanitized);
        }

        @java.lang.Override
        @java.lang.SuppressWarnings("all")
                public java.lang.String toString() {
            return "CommandSource.CommandSourceBuilder(actionName=" + this.actionName + ", entityName=" + this.entityName + ", officeId=" + this.officeId + ", groupId=" + this.groupId + ", clientId=" + this.clientId + ", loanId=" + this.loanId + ", savingsId=" + this.savingsId + ", resourceGetUrl=" + this.resourceGetUrl + ", resourceId=" + this.resourceId + ", subResourceId=" + this.subResourceId + ", commandAsJson=" + this.commandAsJson + ", maker=" + this.maker + ", madeOnDate=" + this.madeOnDate + ", checkedOnDate=" + this.checkedOnDate + ", checker=" + this.checker + ", status=" + this.status + ", productId=" + this.productId + ", transactionId=" + this.transactionId + ", creditBureauId=" + this.creditBureauId + ", organisationCreditBureauId=" + this.organisationCreditBureauId + ", jobName=" + this.jobName + ", idempotencyKey=" + this.idempotencyKey + ", resourceExternalId=" + this.resourceExternalId + ", subResourceExternalId=" + this.subResourceExternalId + ", result=" + this.result + ", resultStatusCode=" + this.resultStatusCode + ", loanExternalId=" + this.loanExternalId + ", clientIp=" + this.clientIp + ", sanitized=" + this.sanitized + ")";
        }
    }

    @java.lang.SuppressWarnings("all")
        public static CommandSource.CommandSourceBuilder builder() {
        return new CommandSource.CommandSourceBuilder();
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
        public Long getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getGroupId() {
        return this.groupId;
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
        public Long getSavingsId() {
        return this.savingsId;
    }

    @java.lang.SuppressWarnings("all")
        public String getResourceGetUrl() {
        return this.resourceGetUrl;
    }

    @java.lang.SuppressWarnings("all")
        public Long getResourceId() {
        return this.resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getSubResourceId() {
        return this.subResourceId;
    }

    @java.lang.SuppressWarnings("all")
        public String getCommandAsJson() {
        return this.commandAsJson;
    }

    @java.lang.SuppressWarnings("all")
        public AppUser getMaker() {
        return this.maker;
    }

    @java.lang.SuppressWarnings("all")
        public OffsetDateTime getMadeOnDate() {
        return this.madeOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public OffsetDateTime getCheckedOnDate() {
        return this.checkedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public AppUser getChecker() {
        return this.checker;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getStatus() {
        return this.status;
    }

    @java.lang.SuppressWarnings("all")
        public Long getProductId() {
        return this.productId;
    }

    @java.lang.SuppressWarnings("all")
        public String getTransactionId() {
        return this.transactionId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCreditBureauId() {
        return this.creditBureauId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getOrganisationCreditBureauId() {
        return this.organisationCreditBureauId;
    }

    @java.lang.SuppressWarnings("all")
        public String getJobName() {
        return this.jobName;
    }

    @java.lang.SuppressWarnings("all")
        public String getIdempotencyKey() {
        return this.idempotencyKey;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getResourceExternalId() {
        return this.resourceExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getSubResourceExternalId() {
        return this.subResourceExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public String getResult() {
        return this.result;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getResultStatusCode() {
        return this.resultStatusCode;
    }

    @java.lang.SuppressWarnings("all")
        public ExternalId getLoanExternalId() {
        return this.loanExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public String getClientIp() {
        return this.clientIp;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isSanitized() {
        return this.sanitized;
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
        public void setOfficeId(final Long officeId) {
        this.officeId = officeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setGroupId(final Long groupId) {
        this.groupId = groupId;
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
        public void setSavingsId(final Long savingsId) {
        this.savingsId = savingsId;
    }

    @java.lang.SuppressWarnings("all")
        public void setResourceGetUrl(final String resourceGetUrl) {
        this.resourceGetUrl = resourceGetUrl;
    }

    @java.lang.SuppressWarnings("all")
        public void setResourceId(final Long resourceId) {
        this.resourceId = resourceId;
    }

    @java.lang.SuppressWarnings("all")
        public void setSubResourceId(final Long subResourceId) {
        this.subResourceId = subResourceId;
    }

    @java.lang.SuppressWarnings("all")
        public void setCommandAsJson(final String commandAsJson) {
        this.commandAsJson = commandAsJson;
    }

    @java.lang.SuppressWarnings("all")
        public void setMaker(final AppUser maker) {
        this.maker = maker;
    }

    @java.lang.SuppressWarnings("all")
        public void setMadeOnDate(final OffsetDateTime madeOnDate) {
        this.madeOnDate = madeOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setCheckedOnDate(final OffsetDateTime checkedOnDate) {
        this.checkedOnDate = checkedOnDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setChecker(final AppUser checker) {
        this.checker = checker;
    }

    @java.lang.SuppressWarnings("all")
        public void setProductId(final Long productId) {
        this.productId = productId;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransactionId(final String transactionId) {
        this.transactionId = transactionId;
    }

    @java.lang.SuppressWarnings("all")
        public void setCreditBureauId(final Long creditBureauId) {
        this.creditBureauId = creditBureauId;
    }

    @java.lang.SuppressWarnings("all")
        public void setOrganisationCreditBureauId(final Long organisationCreditBureauId) {
        this.organisationCreditBureauId = organisationCreditBureauId;
    }

    @java.lang.SuppressWarnings("all")
        public void setJobName(final String jobName) {
        this.jobName = jobName;
    }

    @java.lang.SuppressWarnings("all")
        public void setIdempotencyKey(final String idempotencyKey) {
        this.idempotencyKey = idempotencyKey;
    }

    @java.lang.SuppressWarnings("all")
        public void setResourceExternalId(final ExternalId resourceExternalId) {
        this.resourceExternalId = resourceExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setSubResourceExternalId(final ExternalId subResourceExternalId) {
        this.subResourceExternalId = subResourceExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setResult(final String result) {
        this.result = result;
    }

    @java.lang.SuppressWarnings("all")
        public void setResultStatusCode(final Integer resultStatusCode) {
        this.resultStatusCode = resultStatusCode;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanExternalId(final ExternalId loanExternalId) {
        this.loanExternalId = loanExternalId;
    }

    @java.lang.SuppressWarnings("all")
        public void setClientIp(final String clientIp) {
        this.clientIp = clientIp;
    }

    @java.lang.SuppressWarnings("all")
        public void setSanitized(final boolean sanitized) {
        this.sanitized = sanitized;
    }

    @java.lang.SuppressWarnings("all")
        public CommandSource() {
    }

    @java.lang.SuppressWarnings("all")
        public CommandSource(final String actionName, final String entityName, final Long officeId, final Long groupId, final Long clientId, final Long loanId, final Long savingsId, final String resourceGetUrl, final Long resourceId, final Long subResourceId, final String commandAsJson, final AppUser maker, final OffsetDateTime madeOnDate, final OffsetDateTime checkedOnDate, final AppUser checker, final Integer status, final Long productId, final String transactionId, final Long creditBureauId, final Long organisationCreditBureauId, final String jobName, final String idempotencyKey, final ExternalId resourceExternalId, final ExternalId subResourceExternalId, final String result, final Integer resultStatusCode, final ExternalId loanExternalId, final String clientIp, final boolean sanitized) {
        this.actionName = actionName;
        this.entityName = entityName;
        this.officeId = officeId;
        this.groupId = groupId;
        this.clientId = clientId;
        this.loanId = loanId;
        this.savingsId = savingsId;
        this.resourceGetUrl = resourceGetUrl;
        this.resourceId = resourceId;
        this.subResourceId = subResourceId;
        this.commandAsJson = commandAsJson;
        this.maker = maker;
        this.madeOnDate = madeOnDate;
        this.checkedOnDate = checkedOnDate;
        this.checker = checker;
        this.status = status;
        this.productId = productId;
        this.transactionId = transactionId;
        this.creditBureauId = creditBureauId;
        this.organisationCreditBureauId = organisationCreditBureauId;
        this.jobName = jobName;
        this.idempotencyKey = idempotencyKey;
        this.resourceExternalId = resourceExternalId;
        this.subResourceExternalId = subResourceExternalId;
        this.result = result;
        this.resultStatusCode = resultStatusCode;
        this.loanExternalId = loanExternalId;
        this.clientIp = clientIp;
        this.sanitized = sanitized;
    }
}
