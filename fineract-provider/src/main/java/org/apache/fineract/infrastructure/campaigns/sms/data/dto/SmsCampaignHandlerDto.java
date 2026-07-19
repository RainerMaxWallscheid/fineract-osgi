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

import com.fasterxml.jackson.annotation.JsonInclude;
import java.io.Serial;
import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class SmsCampaignHandlerDto implements Serializable {
    public static final String ACTIVATE_COMMAND = "activate";
    public static final String CLOSE_COMMAND = "close";
    public static final String REACTIVATE_COMMAND = "reactivate";
    @Serial
    private static final long serialVersionUID = 1L;
    private String locale;
    private String dateFormat;
    private String activationDate;
    private String closureDate;

    @java.lang.SuppressWarnings("all")
        public String getLocale() {
        return this.locale;
    }

    @java.lang.SuppressWarnings("all")
        public String getDateFormat() {
        return this.dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public String getActivationDate() {
        return this.activationDate;
    }

    @java.lang.SuppressWarnings("all")
        public String getClosureDate() {
        return this.closureDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setLocale(final String locale) {
        this.locale = locale;
    }

    @java.lang.SuppressWarnings("all")
        public void setDateFormat(final String dateFormat) {
        this.dateFormat = dateFormat;
    }

    @java.lang.SuppressWarnings("all")
        public void setActivationDate(final String activationDate) {
        this.activationDate = activationDate;
    }

    @java.lang.SuppressWarnings("all")
        public void setClosureDate(final String closureDate) {
        this.closureDate = closureDate;
    }

    @java.lang.SuppressWarnings("all")
        public SmsCampaignHandlerDto() {
    }

    @java.lang.SuppressWarnings("all")
        public SmsCampaignHandlerDto(final String locale, final String dateFormat, final String activationDate, final String closureDate) {
        this.locale = locale;
        this.dateFormat = dateFormat;
        this.activationDate = activationDate;
        this.closureDate = closureDate;
    }
}
