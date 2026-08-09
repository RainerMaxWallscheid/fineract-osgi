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
package org.apache.fineract.infrastructure.campaigns.sms.data.dto;

import java.io.Serial;
import java.io.Serializable;

public class SmsCampaignParamReq implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Integer officeId;
    private Integer loanOfficerId;
    private Integer transactionId;
    private String reportName;

    @java.lang.SuppressWarnings("all")
        public Integer getOfficeId() {
        return this.officeId;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getLoanOfficerId() {
        return this.loanOfficerId;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getTransactionId() {
        return this.transactionId;
    }

    @java.lang.SuppressWarnings("all")
        public String getReportName() {
        return this.reportName;
    }

    @java.lang.SuppressWarnings("all")
        public void setOfficeId(final Integer officeId) {
        this.officeId = officeId;
    }

    @java.lang.SuppressWarnings("all")
        public void setLoanOfficerId(final Integer loanOfficerId) {
        this.loanOfficerId = loanOfficerId;
    }

    @java.lang.SuppressWarnings("all")
        public void setTransactionId(final Integer transactionId) {
        this.transactionId = transactionId;
    }

    @java.lang.SuppressWarnings("all")
        public void setReportName(final String reportName) {
        this.reportName = reportName;
    }

    @java.lang.SuppressWarnings("all")
        public SmsCampaignParamReq() {
    }
}
