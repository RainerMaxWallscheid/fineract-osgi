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
package org.apache.fineract.infrastructure.campaigns.sms.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.annotation.PostConstruct;
import java.io.IOException;
import java.security.InvalidParameterException;
import java.time.OffsetDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.apache.fineract.infrastructure.campaigns.sms.constants.SmsCampaignTriggerType;
import org.apache.fineract.infrastructure.campaigns.sms.domain.SmsCampaign;
import org.apache.fineract.infrastructure.campaigns.sms.domain.SmsCampaignRepository;
import org.apache.fineract.infrastructure.campaigns.sms.exception.SmsRuntimeException;
import org.apache.fineract.infrastructure.campaigns.sms.serialization.SmsCampaignValidator;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.event.business.moduleapi.SmsCampaignTriggerEventPort;
import org.apache.fineract.infrastructure.sms.scheduler.SmsMessageScheduledJobService;
import org.apache.fineract.infrastructure.sms.service.SmsMessagePort;
import org.apache.fineract.organisation.office.moduleapi.OfficePersistablePort;
import org.apache.fineract.portfolio.client.moduleapi.ClientActivePort;
import org.apache.fineract.portfolio.group.moduleapi.GroupActivePort;
import org.apache.fineract.portfolio.loanaccount.exception.InvalidLoanTypeException;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanExistencePort;
import org.apache.fineract.portfolio.savings.moduleapi.SavingsAccountExistencePort;
import org.springframework.stereotype.Service;

@Service
public class SmsCampaignDomainServiceImpl implements SmsCampaignDomainService {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(SmsCampaignDomainServiceImpl.class);
    private final SmsCampaignRepository smsCampaignRepository;
    private final SmsMessagePort smsMessagePort;
    private final OfficePersistablePort officePersistablePort;
    private final SmsCampaignWritePlatformService smsCampaignWritePlatformCommandHandler;
    private final GroupActivePort groupActivePort;
    private final SmsMessageScheduledJobService smsMessageScheduledJobService;
    private final SmsCampaignValidator smsCampaignValidator;
    private final SmsCampaignTriggerEventPort smsCampaignTriggerEventPort;
    private final SavingsAccountExistencePort savingsAccountExistencePort;
    private final LoanExistencePort loanExistencePort;
    private final ClientActivePort clientActivePort;

    @PostConstruct
    public void addListeners() {
        loanExistencePort.onApproved(this::notifyAcceptedLoanOwner);
        loanExistencePort.onRejected(this::notifyRejectedLoanOwner);
        loanExistencePort.onRepayment(this::sendSmsForLoanRepayment);
        smsCampaignTriggerEventPort.onClientActivated(client -> notifyClientActivated(this.clientActivePort.id(client)));
        smsCampaignTriggerEventPort.onClientRejected(client -> notifyClientRejected(this.clientActivePort.id(client)));
        smsCampaignTriggerEventPort.onSavingsActivated(this::notifySavingsAccountActivated);
        smsCampaignTriggerEventPort.onSavingsRejected(this::notifySavingsAccountRejected);
        smsCampaignTriggerEventPort.onSavingsDeposit(transaction -> sendSmsForSavingsTransaction(transaction, true));
        smsCampaignTriggerEventPort.onSavingsWithdrawal(transaction -> sendSmsForSavingsTransaction(transaction, false));
    }

    private void notifyRejectedLoanOwner(final Object leftoverLoan) {
        final var ref = this.loanExistencePort.campaignSource(leftoverLoan);
        List<SmsCampaign> smsCampaigns = retrieveSmsCampaigns("Loan Rejected");
        if (!smsCampaigns.isEmpty()) {
            for (SmsCampaign campaign : smsCampaigns) {
                if (campaign.isActive()) {
                    this.smsCampaignWritePlatformCommandHandler.insertDirectCampaignIntoSmsOutboundTable(ref.loanId(), ref.clientId(),
                            ref.groupId(), ref.groupLoan(), ref.invalidLoanType(), campaign);
                }
            }
        }
    }

    private void notifyAcceptedLoanOwner(final Object leftoverLoan) {
        final var ref = this.loanExistencePort.campaignSource(leftoverLoan);
        List<SmsCampaign> smsCampaigns = retrieveSmsCampaigns("Loan Approved");
        if (!smsCampaigns.isEmpty()) {
            for (SmsCampaign campaign : smsCampaigns) {
                this.smsCampaignWritePlatformCommandHandler.insertDirectCampaignIntoSmsOutboundTable(ref.loanId(), ref.clientId(),
                        ref.groupId(), ref.groupLoan(), ref.invalidLoanType(), campaign);
            }
        }
    }

    private void notifyClientActivated(final Long clientId) {
        List<SmsCampaign> smsCampaigns = retrieveSmsCampaigns("Client Activated");
        if (!smsCampaigns.isEmpty()) {
            for (SmsCampaign campaign : smsCampaigns) {
                this.smsCampaignWritePlatformCommandHandler.insertDirectCampaignIntoSmsOutboundTable(clientId, campaign);
            }
        }
    }

    private void notifyClientRejected(final Long clientId) {
        List<SmsCampaign> smsCampaigns = retrieveSmsCampaigns("Client Rejected");
        if (!smsCampaigns.isEmpty()) {
            for (SmsCampaign campaign : smsCampaigns) {
                this.smsCampaignWritePlatformCommandHandler.insertDirectCampaignIntoSmsOutboundTable(clientId, campaign);
            }
        }
    }

    private void notifySavingsAccountActivated(final Object leftover) {
        final var ref = this.savingsAccountExistencePort.campaignSource(leftover);
        List<SmsCampaign> smsCampaigns = retrieveSmsCampaigns("Savings Activated");
        if (!smsCampaigns.isEmpty()) {
            for (SmsCampaign campaign : smsCampaigns) {
                this.smsCampaignWritePlatformCommandHandler.insertDirectCampaignIntoSmsOutboundTable(ref.savingsAccountId(),
                        ref.clientId(), campaign);
            }
        }
    }

    private void notifySavingsAccountRejected(final Object leftover) {
        final var ref = this.savingsAccountExistencePort.campaignSource(leftover);
        List<SmsCampaign> smsCampaigns = retrieveSmsCampaigns("Savings Rejected");
        if (!smsCampaigns.isEmpty()) {
            for (SmsCampaign campaign : smsCampaigns) {
                this.smsCampaignWritePlatformCommandHandler.insertDirectCampaignIntoSmsOutboundTable(ref.savingsAccountId(),
                        ref.clientId(), campaign);
            }
        }
    }

    private void sendSmsForLoanRepayment(final Object leftoverTransaction) {
        List<SmsCampaign> smsCampaigns = retrieveSmsCampaigns("Loan Repayment");
        if (!smsCampaigns.isEmpty()) {
            for (SmsCampaign smsCampaign : smsCampaigns) {
                try {
                    final var view = this.loanExistencePort.repaymentSmsView(leftoverTransaction);
                    final Set<Long> groupClients = new HashSet<>();
                    if (view.invalidLoanType()) {
                        throw new InvalidLoanTypeException("Loan Type cannot be Invalid for the Triggered Sms Campaign");
                    }
                    if (view.groupLoan()) {
                        for (final Long memberId : this.groupActivePort.clientMemberIds(view.groupId())) {
                            this.clientActivePort.persistableById(memberId);
                            groupClients.add(memberId);
                        }
                    } else {
                        if (view.clientId() != null) {
                            this.clientActivePort.persistableById(view.clientId());
                            groupClients.add(view.clientId());
                        }
                    }
                    HashMap<String, String> campaignParams = new ObjectMapper().readValue(smsCampaign.getParamValue(), new TypeReference<>() {
                    });
                    if (!groupClients.isEmpty()) {
                        for (final Long clientId : groupClients) {
                            HashMap<String, Object> smsParams = processRepaymentDataForSms(view, clientId);
                            for (Map.Entry<String, String> entry : campaignParams.entrySet()) {
                                String value = entry.getValue();
                                String spvalue = null;
                                boolean spkeycheck = smsParams.containsKey(entry.getKey());
                                if (spkeycheck) {
                                    spvalue = smsParams.get(entry.getKey()).toString();
                                }
                                if (spkeycheck && !(value.equals("-1") || spvalue.equals(value))) {
                                    if (entry.getKey().equals("officeId")) {
                                        Long officeId = Long.valueOf(value);
                                        if (this.officePersistablePort.doesNotHaveAnOfficeInHierarchyWithId(officeId, this.clientActivePort.officeId(clientId))) {
                                            throw new SmsRuntimeException("error.msg.no.office", "Office not found for the id");
                                        }
                                    } else {
                                        throw new SmsRuntimeException("error.msg.no.id.attribute", "Office Id attribute is notfound");
                                    }
                                }
                            }
                            String message = this.smsCampaignWritePlatformCommandHandler.compileSmsTemplate(smsCampaign.getMessage(), smsCampaign.getCampaignName(), smsParams);
                            Object mobileNo = smsParams.get("mobileNo");
                            if (this.smsCampaignValidator.isValidNotificationOrSms(smsCampaign, mobileNo)) {
                                String mobileNumber = null;
                                if (mobileNo != null) {
                                    mobileNumber = mobileNo.toString();
                                }
                                final SmsMessagePort.OutboundView smsMessage = this.smsMessagePort.persistPending(new SmsMessagePort.PendingRequest(
                                        clientId, null, message, mobileNumber, smsCampaign.getId(), smsCampaign.isNotification()));
                                Map<SmsCampaign, Collection<SmsMessagePort.OutboundView>> smsDataMap = new HashMap<>();
                                smsDataMap.put(smsCampaign, Collections.singletonList(smsMessage));
                                this.smsMessageScheduledJobService.sendTriggeredMessages(smsDataMap);
                            }
                        }
                    }
                } catch (final IOException e) {
                    log.error("smsParams does not contain the key: ", e);
                } catch (final RuntimeException e) {
                    log.debug("Client Office Id and SMS Campaign Office id doesn\'t match ", e);
                }
            }
        }
    }

    private void sendSmsForSavingsTransaction(final Object leftoverTransaction, boolean isDeposit) {
        String campaignName = isDeposit ? "Savings Deposit" : "Savings Withdrawal";
        List<SmsCampaign> smsCampaigns = retrieveSmsCampaigns(campaignName);
        if (!smsCampaigns.isEmpty()) {
            for (SmsCampaign smsCampaign : smsCampaigns) {
                try {
                    final var view = this.savingsAccountExistencePort.transactionSmsView(leftoverTransaction);
                    final Long clientId = view.clientId();
                    if (clientId != null) {
                        this.clientActivePort.persistableById(clientId);
                    }
                    HashMap<String, String> campaignParams = new ObjectMapper().readValue(smsCampaign.getParamValue(), new TypeReference<>() {
                    });
                    HashMap<String, Object> smsParams = processSavingsTransactionDataForSms(view, clientId);
                    for (Map.Entry<String, String> entry : campaignParams.entrySet()) {
                        String value = entry.getValue();
                        String spvalue = null;
                        boolean spkeycheck = smsParams.containsKey(entry.getKey());
                        if (spkeycheck) {
                            spvalue = smsParams.get(entry.getKey()).toString();
                        }
                        if (spkeycheck && !(value.equals("-1") || spvalue.equals(value))) {
                            if (entry.getKey().equals("officeId")) {
                                Long officeId = Long.valueOf(value);
                                if (this.officePersistablePort.doesNotHaveAnOfficeInHierarchyWithId(officeId, this.clientActivePort.officeId(clientId))) {
                                    throw new SmsRuntimeException("error.msg.no.office", "Office not found for the id");
                                }
                            } else {
                                throw new SmsRuntimeException("error.msg.no.id.attribute", "Office Id attribute is notfound");
                            }
                        }
                    }
                    String message = this.smsCampaignWritePlatformCommandHandler.compileSmsTemplate(smsCampaign.getMessage(), smsCampaign.getCampaignName(), smsParams);
                    Object mobileNo = smsParams.get("mobileNo");
                    if (this.smsCampaignValidator.isValidNotificationOrSms(smsCampaign, mobileNo)) {
                        String mobileNumber = null;
                        if (mobileNo != null) {
                            mobileNumber = mobileNo.toString();
                        }
                        final SmsMessagePort.OutboundView smsMessage = this.smsMessagePort.persistPending(new SmsMessagePort.PendingRequest(
                                clientId, null, message, mobileNumber, smsCampaign.getId(), smsCampaign.isNotification()));
                        Map<SmsCampaign, Collection<SmsMessagePort.OutboundView>> smsDataMap = new HashMap<>();
                        smsDataMap.put(smsCampaign, Collections.singletonList(smsMessage));
                        this.smsMessageScheduledJobService.sendTriggeredMessages(smsDataMap);
                    }
                } catch (final IOException e) {
                    log.error("smsParams does not contain the key: ", e);
                } catch (final RuntimeException e) {
                    log.debug("Client Office Id and SMS Campaign Office id doesn\'t match ", e);
                }
            }
        }
    }

    private List<SmsCampaign> retrieveSmsCampaigns(String paramValue) {
        return smsCampaignRepository.findActiveSmsCampaigns("%" + paramValue + "%", SmsCampaignTriggerType.TRIGGERED.getValue());
    }

    private HashMap<String, Object> processRepaymentDataForSms(final LoanExistencePort.RepaymentSmsView view, final Long groupClientId) {
        HashMap<String, Object> smsParams = new HashMap<String, Object>();
        final Long clientId;
        if (view.groupLoan() && groupClientId != null) {
            clientId = groupClientId;
        } else if (view.individualLoan()) {
            clientId = view.clientId();
        } else {
            throw new InvalidParameterException("");
        }
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MMM:d:yyyy");
        smsParams.put("id", view.clientId());
        smsParams.put("firstname", this.clientActivePort.firstname(clientId));
        smsParams.put("middlename", this.clientActivePort.middlename(clientId));
        smsParams.put("lastname", this.clientActivePort.lastname(clientId));
        smsParams.put("FullName", this.clientActivePort.displayName(clientId));
        smsParams.put("mobileNo", this.clientActivePort.mobileNo(clientId));
        smsParams.put("LoanAmount", view.principal());
        smsParams.put("LoanOutstanding", view.outstanding());
        smsParams.put("loanId", view.loanId());
        smsParams.put("LoanAccountId", view.accountNumber());
        smsParams.put("officeId", this.clientActivePort.officeId(clientId));
        final Long staffId = this.clientActivePort.staffId(clientId);
        if (staffId != null) {
            smsParams.put("loanOfficerId", staffId);
        } else {
            smsParams.put("loanOfficerId", -1);
        }
        OffsetDateTime creationDate = view.createdDate() != null ? view.createdDate() : DateUtils.getAuditOffsetDateTime();
        smsParams.put("repaymentAmount", view.amount());
        smsParams.put("RepaymentDate", creationDate.toLocalDate().format(dateFormatter));
        smsParams.put("RepaymentTime", creationDate.toLocalTime().format(timeFormatter));
        if (view.receiptNumber() != null) {
            smsParams.put("receiptNumber", view.receiptNumber());
        } else {
            smsParams.put("receiptNumber", -1);
        }
        return smsParams;
    }

    private HashMap<String, Object> processSavingsTransactionDataForSms(final SavingsAccountExistencePort.TransactionSmsView view,
            final Long clientId) {
        // {{savingsId}} {{id}} {{firstname}} {{middlename}} {{lastname}}
        // {{FullName}} {{mobileNo}} {{savingsAccountId}} {{depositAmount}}
        // {{balance}}
        // transactionDate
        HashMap<String, Object> smsParams = new HashMap<>();
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MMM:d:yyyy");
        smsParams.put("clientId", clientId.longValue());
        smsParams.put("firstname", this.clientActivePort.firstname(clientId));
        smsParams.put("middlename", this.clientActivePort.middlename(clientId));
        smsParams.put("lastname", this.clientActivePort.lastname(clientId));
        smsParams.put("FullName", this.clientActivePort.displayName(clientId));
        smsParams.put("mobileNo", this.clientActivePort.mobileNo(clientId));
        smsParams.put("savingsId", view.savingsAccountId());
        smsParams.put("savingsAccountNo", view.accountNumber());
        smsParams.put("withdrawAmount", view.amount());
        smsParams.put("depositAmount", view.amount());
        smsParams.put("balance", view.balance());
        smsParams.put("officeId", this.clientActivePort.officeId(clientId));
        smsParams.put("transactionDate", view.transactionDate().format(dateFormatter));
        smsParams.put("savingsTransactionId", view.transactionId());
        final Long staffId = this.clientActivePort.staffId(clientId);
        if (staffId != null) {
            smsParams.put("loanOfficerId", staffId);
        } else {
            smsParams.put("loanOfficerId", -1);
        }
        if (view.receiptNumber() != null) {
            smsParams.put("receiptNumber", view.receiptNumber());
        } else {
            smsParams.put("receiptNumber", -1);
        }
        return smsParams;
    }

    @java.lang.SuppressWarnings("all")
        public SmsCampaignDomainServiceImpl(final SmsCampaignRepository smsCampaignRepository, final SmsMessagePort smsMessagePort, final OfficePersistablePort officePersistablePort, final SmsCampaignWritePlatformService smsCampaignWritePlatformCommandHandler, final GroupActivePort groupActivePort, final SmsMessageScheduledJobService smsMessageScheduledJobService, final SmsCampaignValidator smsCampaignValidator, final SmsCampaignTriggerEventPort smsCampaignTriggerEventPort, final SavingsAccountExistencePort savingsAccountExistencePort, final LoanExistencePort loanExistencePort, final ClientActivePort clientActivePort) {
        this.smsCampaignRepository = smsCampaignRepository;
        this.smsMessagePort = smsMessagePort;
        this.officePersistablePort = officePersistablePort;
        this.smsCampaignWritePlatformCommandHandler = smsCampaignWritePlatformCommandHandler;
        this.groupActivePort = groupActivePort;
        this.smsMessageScheduledJobService = smsMessageScheduledJobService;
        this.smsCampaignValidator = smsCampaignValidator;
        this.smsCampaignTriggerEventPort = smsCampaignTriggerEventPort;
        this.savingsAccountExistencePort = savingsAccountExistencePort;
        this.loanExistencePort = loanExistencePort;
        this.clientActivePort = clientActivePort;
    }
}
