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
package org.apache.fineract.portfolio.workingcapitalloannearbreach.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;
import org.apache.fineract.portfolio.workingcapitalloan.domain.WorkingCapitalLoanPeriodFrequencyType;

@Entity
@Table(name = "m_wc_near_breach")
public class WorkingCapitalNearBreach extends AbstractPersistableCustom<Long> {
    @Column(name = "near_breach_name", nullable = false, length = 100)
    private String name;
    @Column(name = "near_breach_frequency", nullable = false)
    private Integer frequency;
    @Enumerated(EnumType.STRING)
    @Column(name = "near_breach_frequency_type", nullable = false, length = 50)
    private WorkingCapitalLoanPeriodFrequencyType frequencyType;
    @Column(name = "near_breach_threshold", nullable = false, scale = 6, precision = 19)
    private BigDecimal threshold;

    @java.lang.SuppressWarnings("all")
        public String getName() {
        return this.name;
    }

    @java.lang.SuppressWarnings("all")
        public Integer getFrequency() {
        return this.frequency;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalLoanPeriodFrequencyType getFrequencyType() {
        return this.frequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public BigDecimal getThreshold() {
        return this.threshold;
    }

    @java.lang.SuppressWarnings("all")
        public void setName(final String name) {
        this.name = name;
    }

    @java.lang.SuppressWarnings("all")
        public void setFrequency(final Integer frequency) {
        this.frequency = frequency;
    }

    @java.lang.SuppressWarnings("all")
        public void setFrequencyType(final WorkingCapitalLoanPeriodFrequencyType frequencyType) {
        this.frequencyType = frequencyType;
    }

    @java.lang.SuppressWarnings("all")
        public void setThreshold(final BigDecimal threshold) {
        this.threshold = threshold;
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalNearBreach() {
    }

    @java.lang.SuppressWarnings("all")
        public WorkingCapitalNearBreach(final String name, final Integer frequency, final WorkingCapitalLoanPeriodFrequencyType frequencyType, final BigDecimal threshold) {
        this.name = name;
        this.frequency = frequency;
        this.frequencyType = frequencyType;
        this.threshold = threshold;
    }
}
