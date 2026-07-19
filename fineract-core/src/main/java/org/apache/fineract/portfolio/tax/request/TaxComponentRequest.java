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
package org.apache.fineract.portfolio.tax.request;

import com.fasterxml.jackson.annotation.JsonInclude;
import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class TaxComponentRequest implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private String name;
    private BigDecimal percentage;
    private Integer debitAccountType;
    private Long debitAccountId;
    private Integer creditAccountType;
    private Long creditAccountId;
    private String startDate;
    private String dateFormat;
    private String locale;

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setPercentage(final BigDecimal percentage) {
        this.percentage = percentage;
    }

    @java.lang.SuppressWarnings("all")
        public void setDebitAccountType(final Integer debitAccountType) {
        this.debitAccountType = debitAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public void setDebitAccountId(final Long debitAccountId) {
        this.debitAccountId = debitAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public void setCreditAccountType(final Integer creditAccountType) {
        this.creditAccountType = creditAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public void setCreditAccountId(final Long creditAccountId) {
        this.creditAccountId = creditAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public void setStartDate(final String startDate) {
        this.startDate = startDate;
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
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getPercentage() {
        return this.percentage;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getDebitAccountType() {
        return this.debitAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public Long getDebitAccountId() {
        return this.debitAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getCreditAccountType() {
        return this.creditAccountType;
    }

    @java.lang.SuppressWarnings("all")
        public Long getCreditAccountId() {
        return this.creditAccountId;
    }

    @java.lang.SuppressWarnings("all")
        public String getStartDate() {
        return this.startDate;
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
        public TaxComponentRequest() {
    }
}
