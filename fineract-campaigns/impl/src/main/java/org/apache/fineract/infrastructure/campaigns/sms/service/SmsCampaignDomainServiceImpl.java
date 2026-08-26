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
import org.apache.fineract.infrastructure.event.business.BusinessEventListener;
import org.apache.fineract.infrastructure.event.business.domain.loan.LoanApprovedBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.loan.LoanRejectedBusinessEvent;
import org.apache.fineract.infrastructure.event.business.domain.loan.transaction.LoanTransactionMakeRepaymentPostBusinessEvent;
import org.apache.fineract.infrastructure.event.business.moduleapi.SmsCampaignTriggerEventPort;
import org.apache.fineract.infrastructure.event.business.service.BusinessEventNotifierService;
import org.apache.fineract.infrastructure.sms.domain.SmsMessage;
import org.apache.fineract.infrastructure.sms.domain.SmsMessageRepository;
import org.apache.fineract.infrastructure.sms.scheduler.SmsMessageScheduledJobService;
import org.apache.fineract.organisation.office.domain.Office;
import org.apache.fineract.organisation.office.domain.OfficeRepository;
import org.apache.fineract.organisation.office.exception.OfficeNotFoundException;
import org.apache.fineract.portfolio.client.domain.Client;
import org.apache.fineract.portfolio.client.domain.ClientRepositoryWrapper;
import org.apache.fineract.portfolio.group.domain.Group;
import org.apache.fineract.portfolio.group.domain.GroupRepository;
import org.apache.fineract.portfolio.group.exception.GroupNotFoundException;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;
import org.apache.fineract.portfolio.loanaccount.domain.LoanTransaction;
import org.apache.fineract.portfolio.loanaccount.exception.InvalidLoanTypeException;
import org.apache.fineract.portfolio.savings.moduleapi.SavingsAccountExistencePort;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SmsCampaignDomainServiceImpl implements SmsCampaignDomainService {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(SmsCampaignDomainServiceImpl.class);
    private final SmsCampaignRepository smsCampaignRepository;
    private final SmsMessageRepository smsMessageRepository;
    private final OfficeRepository officeRepository;
    private final BusinessEventNotifierService businessEventNotifierService;
    private final SmsCampaignWritePlatformService smsCampaignWritePlatformCommandHandler;
    private final GroupRepository groupRepository;
    private final SmsMessageScheduledJobService smsMessageScheduledJobService;
    private final SmsCampaignValidator smsCampaignValidator;
    private final SmsCampaignTriggerEventPort smsCampaignTriggerEventPort;
    private final SavingsAccountExistencePort savingsAccountExistencePort;
    private ClientRepositoryWrapper clientRepositoryWrapper;

    @Autowired
    public void setClientRepositoryWrapper(final ClientRepositoryWrapper clientRepositoryWrapper) {
        this.clientRepositoryWrapper = clientRepositoryWrapper;
    }

    @PostConstruct
    public void addListeners() {
        businessEventNotifierService.addPostBusinessEventListener(LoanApprovedBusinessEvent.class, new SendSmsOnLoanApproved());
        businessEventNotifierService.addPostBusinessEventListener(LoanRejectedBusinessEvent.class, new SendSmsOnLoanRejected());
        businessEventNotifierService.addPostBusinessEventListener(LoanTransactionMakeRepaymentPostBusinessEvent.class, new SendSmsOnLoanRepayment());
        smsCampaignTriggerEventPort.onClientActivated(client -> notifyClientActivated((Client) client));
        smsCampaignTriggerEventPort.onClientRejected(client -> notifyClientRejected((Client) client));
        smsCampaignTriggerEventPort.onSavingsActivated(this::notifySavingsAccountActivated);
        smsCampaignTriggerEventPort.onSavingsRejected(this::notifySavingsAccountRejected);
        smsCampaignTriggerEventPort.onSavingsDeposit(transaction -> sendSmsForSavingsTransaction(transaction, true));
        smsCampaignTriggerEventPort.onSavingsWithdrawal(transaction -> sendSmsForSavingsTransaction(transaction, false));
    }

    private void notifyRejectedLoanOwner(Loan loan) {
        List<SmsCampaign> smsCampaigns = retrieveSmsCampaigns("Loan Rejected");
        if (!smsCampaigns.isEmpty()) {
            for (SmsCampaign campaign : smsCampaigns) {
                if (campaign.isActive()) {
                    SmsCampaignDomainServiceImpl.this.smsCampaignWritePlatformCommandHandler.insertDirectCampaignIntoSmsOutboundTable(loan, campaign);
                }
            }
        }
    }

    private void notifyAcceptedLoanOwner(Loan loan) {
        List<SmsCampaign> smsCampaigns = retrieveSmsCampaigns("Loan Approved");
        if (!smsCampaigns.isEmpty()) {
            for (SmsCampaign campaign : smsCampaigns) {
                this.smsCampaignWritePlatformCommandHandler.insertDirectCampaignIntoSmsOutboundTable(loan, campaign);
            }
        }
    }

    private void notifyClientActivated(final Client client) {
        List<SmsCampaign> smsCampaigns = retrieveSmsCampaigns("Client Activated");
        if (!smsCampaigns.isEmpty()) {
            for (SmsCampaign campaign : smsCampaigns) {
                this.smsCampaignWritePlatformCommandHandler.insertDirectCampaignIntoSmsOutboundTable(client, campaign);
            }
        }
    }

    private void notifyClientRejected(final Client client) {
        List<SmsCampaign> smsCampaigns = retrieveSmsCampaigns("Client Rejected");
        if (!smsCampaigns.isEmpty()) {
            for (SmsCampaign campaign : smsCampaigns) {
                this.smsCampaignWritePlatformCommandHandler.insertDirectCampaignIntoSmsOutboundTable(client, campaign);
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

    private void sendSmsForLoanRepayment(LoanTransaction loanTransaction) {
        List<SmsCampaign> smsCampaigns = retrieveSmsCampaigns("Loan Repayment");
        if (!smsCampaigns.isEmpty()) {
            for (SmsCampaign smsCampaign : smsCampaigns) {
                try {
                    Loan loan = loanTransaction.getLoan();
                    final Set<Client> groupClients = new HashSet<>();
                    if (loan.hasInvalidLoanType()) {
                        throw new InvalidLoanTypeException("Loan Type cannot be Invalid for the Triggered Sms Campaign");
                    }
                    if (loan.isGroupLoan()) {
                        Group group = this.groupRepository.findById(loan.getGroupId()).orElseThrow(() -> new GroupNotFoundException(loan.getGroupId()));
                        groupClients.addAll(group.getClientMembers());
                    } else {
                        if (loan.getClientId() != null) {
                            groupClients.add(this.clientRepositoryWrapper.findOneWithNotFoundDetection(loan.getClientId()));
                        }
                    }
                    HashMap<String, String> campaignParams = new ObjectMapper().readValue(smsCampaign.getParamValue(), new TypeReference<>() {
                    });
                    if (!groupClients.isEmpty()) {
                        for (Client client : groupClients) {
                            HashMap<String, Object> smsParams = processRepaymentDataForSms(loanTransaction, client);
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
                                        Office campaignOffice = this.officeRepository.findById(Long.valueOf(value)).orElseThrow(() -> new OfficeNotFoundException(officeId));
                                        if (campaignOffice.doesNotHaveAnOfficeInHierarchyWithId(client.getOffice().getId())) {
                                            throw new SmsRuntimeException("error.msg.no.office", "Office not found for the id");
                                        }
                                    } else {
                                        throw new SmsRuntimeException("error.msg.no.id.attribute", "Office Id attribute is notfound");
                                    }
                                }
                            }
                            String message = this.smsCampaignWritePlatformCommandHandler.compileSmsTemplate(smsCampaign.getMessage(), smsCampaign.getCampaignName(), smsParams);
                            Object mobileNo = smsParams.get("mobileNo");
                            if (this.smsCampaignValidator.isValidNotificationOrSms(client, smsCampaign, mobileNo)) {
                                String mobileNumber = null;
                                if (mobileNo != null) {
                                    mobileNumber = mobileNo.toString();
                                }
                                SmsMessage smsMessage = SmsMessage.pendingSms(null, null, client, null, message, mobileNumber, smsCampaign.getId(), smsCampaign.isNotification());
                                Map<SmsCampaign, Collection<SmsMessage>> smsDataMap = new HashMap<>();
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
                    final Client client = view.clientId() == null ? null
                            : this.clientRepositoryWrapper.findOneWithNotFoundDetection(view.clientId());
                    HashMap<String, String> campaignParams = new ObjectMapper().readValue(smsCampaign.getParamValue(), new TypeReference<>() {
                    });
                    HashMap<String, Object> smsParams = processSavingsTransactionDataForSms(view, client);
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
                                Office campaignOffice = this.officeRepository.findById(officeId).orElseThrow(() -> new OfficeNotFoundException(officeId));
                                if (campaignOffice.doesNotHaveAnOfficeInHierarchyWithId(client.getOffice().getId())) {
                                    throw new SmsRuntimeException("error.msg.no.office", "Office not found for the id");
                                }
                            } else {
                                throw new SmsRuntimeException("error.msg.no.id.attribute", "Office Id attribute is notfound");
                            }
                        }
                    }
                    String message = this.smsCampaignWritePlatformCommandHandler.compileSmsTemplate(smsCampaign.getMessage(), smsCampaign.getCampaignName(), smsParams);
                    Object mobileNo = smsParams.get("mobileNo");
                    if (this.smsCampaignValidator.isValidNotificationOrSms(client, smsCampaign, mobileNo)) {
                        String mobileNumber = null;
                        if (mobileNo != null) {
                            mobileNumber = mobileNo.toString();
                        }
                        SmsMessage smsMessage = SmsMessage.pendingSms(null, null, client, null, message, mobileNumber, smsCampaign.getId(), smsCampaign.isNotification());
                        this.smsMessageRepository.save(smsMessage);
                        Collection<SmsMessage> messages = new ArrayList<>();
                        messages.add(smsMessage);
                        Map<SmsCampaign, Collection<SmsMessage>> smsDataMap = new HashMap<>();
                        smsDataMap.put(smsCampaign, messages);
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

    private HashMap<String, Object> processRepaymentDataForSms(final LoanTransaction loanTransaction, Client groupClient) {
        HashMap<String, Object> smsParams = new HashMap<String, Object>();
        Loan loan = loanTransaction.getLoan();
        final Client client;
        if (loan.isGroupLoan() && groupClient != null) {
            client = groupClient;
        } else if (loan.isIndividualLoan()) {
            client = this.clientRepositoryWrapper.findOneWithNotFoundDetection(loan.getClientId());
        } else {
            throw new InvalidParameterException("");
        }
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MMM:d:yyyy");
        smsParams.put("id", loanTransaction.getLoan().getClientId());
        smsParams.put("firstname", client.getFirstname());
        smsParams.put("middlename", client.getMiddlename());
        smsParams.put("lastname", client.getLastname());
        smsParams.put("FullName", client.getDisplayName());
        smsParams.put("mobileNo", client.mobileNo());
        smsParams.put("LoanAmount", loan.getPrincipal());
        smsParams.put("LoanOutstanding", loanTransaction.getOutstandingLoanBalance());
        smsParams.put("loanId", loan.getId());
        smsParams.put("LoanAccountId", loan.getAccountNumber());
        smsParams.put("officeId", client.getOffice().getId());
        if (client.getStaff() != null) {
            smsParams.put("loanOfficerId", client.getStaff().getId());
        } else {
            smsParams.put("loanOfficerId", -1);
        }
        OffsetDateTime creationDate = loanTransaction.getCreatedDate().orElse(DateUtils.getAuditOffsetDateTime());
        smsParams.put("repaymentAmount", loanTransaction.getAmount(loan.getCurrency()));
        smsParams.put("RepaymentDate", creationDate.toLocalDate().format(dateFormatter));
        smsParams.put("RepaymentTime", creationDate.toLocalTime().format(timeFormatter));
        if (loanTransaction.getPaymentDetail() != null) {
            smsParams.put("receiptNumber", loanTransaction.getPaymentDetail().getReceiptNumber());
        } else {
            smsParams.put("receiptNumber", -1);
        }
        return smsParams;
    }

    private HashMap<String, Object> processSavingsTransactionDataForSms(final SavingsAccountExistencePort.TransactionSmsView view,
            Client client) {
        // {{savingsId}} {{id}} {{firstname}} {{middlename}} {{lastname}}
        // {{FullName}} {{mobileNo}} {{savingsAccountId}} {{depositAmount}}
        // {{balance}}
        // transactionDate
        HashMap<String, Object> smsParams = new HashMap<>();
        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("MMM:d:yyyy");
        smsParams.put("clientId", client.getId());
        smsParams.put("firstname", client.getFirstname());
        smsParams.put("middlename", client.getMiddlename());
        smsParams.put("lastname", client.getLastname());
        smsParams.put("FullName", client.getDisplayName());
        smsParams.put("mobileNo", client.mobileNo());
        smsParams.put("savingsId", view.savingsAccountId());
        smsParams.put("savingsAccountNo", view.accountNumber());
        smsParams.put("withdrawAmount", view.amount());
        smsParams.put("depositAmount", view.amount());
        smsParams.put("balance", view.balance());
        smsParams.put("officeId", client.getOffice().getId());
        smsParams.put("transactionDate", view.transactionDate().format(dateFormatter));
        smsParams.put("savingsTransactionId", view.transactionId());
        if (client.getStaff() != null) {
            smsParams.put("loanOfficerId", client.getStaff().getId());
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


    private final class SendSmsOnLoanApproved implements BusinessEventListener<LoanApprovedBusinessEvent> {
        @Override
        public void onBusinessEvent(LoanApprovedBusinessEvent event) {
            Loan loan = event.get();
            notifyAcceptedLoanOwner(loan);
        }
    }


    private final class SendSmsOnLoanRejected implements BusinessEventListener<LoanRejectedBusinessEvent> {
        @Override
        public void onBusinessEvent(LoanRejectedBusinessEvent event) {
            Loan loan = event.get();
            notifyRejectedLoanOwner(loan);
        }
    }


    private final class SendSmsOnLoanRepayment implements BusinessEventListener<LoanTransactionMakeRepaymentPostBusinessEvent> {
        @Override
        public void onBusinessEvent(LoanTransactionMakeRepaymentPostBusinessEvent event) {
            sendSmsForLoanRepayment(event.get());
        }
    }


    @java.lang.SuppressWarnings("all")
        public SmsCampaignDomainServiceImpl(final SmsCampaignRepository smsCampaignRepository, final SmsMessageRepository smsMessageRepository, final OfficeRepository officeRepository, final BusinessEventNotifierService businessEventNotifierService, final SmsCampaignWritePlatformService smsCampaignWritePlatformCommandHandler, final GroupRepository groupRepository, final SmsMessageScheduledJobService smsMessageScheduledJobService, final SmsCampaignValidator smsCampaignValidator, final SmsCampaignTriggerEventPort smsCampaignTriggerEventPort, final SavingsAccountExistencePort savingsAccountExistencePort) {
        this.smsCampaignRepository = smsCampaignRepository;
        this.smsMessageRepository = smsMessageRepository;
        this.officeRepository = officeRepository;
        this.businessEventNotifierService = businessEventNotifierService;
        this.smsCampaignWritePlatformCommandHandler = smsCampaignWritePlatformCommandHandler;
        this.groupRepository = groupRepository;
        this.smsMessageScheduledJobService = smsMessageScheduledJobService;
        this.smsCampaignValidator = smsCampaignValidator;
        this.smsCampaignTriggerEventPort = smsCampaignTriggerEventPort;
        this.savingsAccountExistencePort = savingsAccountExistencePort;
    }
}
