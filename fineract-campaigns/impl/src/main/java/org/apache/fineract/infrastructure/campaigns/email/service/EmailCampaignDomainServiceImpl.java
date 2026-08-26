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
package org.apache.fineract.infrastructure.campaigns.email.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.annotation.PostConstruct;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import org.apache.fineract.infrastructure.campaigns.email.domain.EmailCampaign;
import org.apache.fineract.infrastructure.campaigns.email.domain.EmailCampaignRepository;
import org.apache.fineract.infrastructure.campaigns.sms.constants.SmsCampaignTriggerType;
import org.apache.fineract.portfolio.loanaccount.moduleapi.LoanExistencePort;
import org.springframework.stereotype.Service;

@Service
public class EmailCampaignDomainServiceImpl implements EmailCampaignDomainService {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(EmailCampaignDomainServiceImpl.class);
    private final LoanExistencePort loanExistencePort;
    private final EmailCampaignWritePlatformService emailCampaignWritePlatformService;
    private final EmailCampaignRepository emailCampaignRepository;

    @PostConstruct
    public void addListeners() {
        loanExistencePort.onApproved(loan -> notifyLoanOwner(loan, "Loan Approved"));
        loanExistencePort.onRejected(loan -> notifyLoanOwner(loan, "Loan Rejected"));
        loanExistencePort.onRepayment(transaction -> notifyLoanOwnerRepayment(transaction, "Loan Repayment"));
    }

    private void notifyLoanOwnerRepayment(final Object leftoverTransaction, final String paramValue) {
        try {
            final var view = this.loanExistencePort.repaymentSmsView(leftoverTransaction);
            List<EmailCampaign> campaigns = this.retrieveEmailCampaigns(paramValue);
            for (EmailCampaign emailCampaign : campaigns) {
                HashMap<String, String> campaignParams = new ObjectMapper().readValue(emailCampaign.getParamValue(),
                        new TypeReference<HashMap<String, String>>() {});
                campaignParams.put("loanId", view.loanId().toString());
                campaignParams.put("loanTransactionId", view.loanTransactionId().toString());
                this.emailCampaignWritePlatformService.insertDirectCampaignIntoEmailOutboundTable(view.clientId(), emailCampaign,
                        campaignParams);
            }
        } catch (IOException e) {
            log.error("Exception when trying to send triggered email: {}", e.getMessage());
        }
    }

    private void notifyLoanOwner(final Object leftoverLoan, final String paramValue) {
        try {
            final var ref = this.loanExistencePort.campaignSource(leftoverLoan);
            List<EmailCampaign> campaigns = this.retrieveEmailCampaigns(paramValue);
            for (EmailCampaign emailCampaign : campaigns) {
                HashMap<String, String> campaignParams = new ObjectMapper().readValue(emailCampaign.getParamValue(),
                        new TypeReference<HashMap<String, String>>() {});
                campaignParams.put("loanId", ref.loanId().toString());
                this.emailCampaignWritePlatformService.insertDirectCampaignIntoEmailOutboundTable(ref.clientId(), emailCampaign,
                        campaignParams);
            }
        } catch (IOException e) {
            log.error("Exception when trying to send triggered email: {}", e.getMessage());
        }
    }

    private List<EmailCampaign> retrieveEmailCampaigns(String paramValue) {
        return emailCampaignRepository.findActiveEmailCampaigns("%" + paramValue + "%", SmsCampaignTriggerType.TRIGGERED.getValue());
    }

    @java.lang.SuppressWarnings("all")
        public EmailCampaignDomainServiceImpl(final LoanExistencePort loanExistencePort, final EmailCampaignWritePlatformService emailCampaignWritePlatformService, final EmailCampaignRepository emailCampaignRepository) {
        this.loanExistencePort = loanExistencePort;
        this.emailCampaignWritePlatformService = emailCampaignWritePlatformService;
        this.emailCampaignRepository = emailCampaignRepository;
    }
}
