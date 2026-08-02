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
package org.apache.fineract.portfolio.delinquency.api.data;

import java.math.BigDecimal;
import org.apache.fineract.infrastructure.core.data.StringEnumOptionData;

public class DelinquencyMinimumPaymentPeriodAndRuleResponse {
    private Integer frequency;
    private StringEnumOptionData frequencyType;
    private BigDecimal minimumPayment;
    private StringEnumOptionData minimumPaymentType;

    @java.lang.Override
    @java.lang.SuppressWarnings("all")
        public java.lang.String toString() {
        return "DelinquencyMinimumPaymentPeriodAndRuleResponse(frequency=" + this.getFrequency() + ", frequencyType=" + this.getFrequencyType() + ", minimumPayment=" + this.getMinimumPayment() + ", minimumPaymentType=" + this.getMinimumPaymentType() + ")";
    }

    @java.lang.SuppressWarnings("all")
        public DelinquencyMinimumPaymentPeriodAndRuleResponse(final Integer frequency, final StringEnumOptionData frequencyType, final BigDecimal minimumPayment, final StringEnumOptionData minimumPaymentType) {
        this.frequency = frequency;
        this.frequencyType = frequencyType;
        this.minimumPayment = minimumPayment;
        this.minimumPaymentType = minimumPaymentType;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getFrequency() {
        return this.frequency;
    }

    @java.lang.SuppressWarnings("all")
        public StringEnumOptionData getFrequencyType() {
        return this.frequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getMinimumPayment() {
        return this.minimumPayment;
    }

    @java.lang.SuppressWarnings("all")
        public StringEnumOptionData getMinimumPaymentType() {
        return this.minimumPaymentType;
    }

    @java.lang.SuppressWarnings("all")
        public void setFrequency(final Integer frequency) {
        this.frequency = frequency;
    }

    @java.lang.SuppressWarnings("all")
        public void setFrequencyType(final StringEnumOptionData frequencyType) {
        this.frequencyType = frequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinimumPayment(final BigDecimal minimumPayment) {
        this.minimumPayment = minimumPayment;
    }

    @java.lang.SuppressWarnings("all")
        public void setMinimumPaymentType(final StringEnumOptionData minimumPaymentType) {
        this.minimumPaymentType = minimumPaymentType;
    }
}
