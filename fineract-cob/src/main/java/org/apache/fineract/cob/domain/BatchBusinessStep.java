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
package org.apache.fineract.cob.domain;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import org.apache.fineract.infrastructure.core.domain.AbstractPersistableCustom;

@Entity
@Table(name = "m_batch_business_steps")
public class BatchBusinessStep extends AbstractPersistableCustom<Long> {
    @Column(name = "job_name", nullable = false)
    private String jobName;
    @Column(name = "step_name", nullable = false)
    private String stepName;
    @Column(name = "step_order", nullable = false)
    private Long stepOrder;

    @java.lang.SuppressWarnings("all")
        public BatchBusinessStep() {
    }

    @java.lang.SuppressWarnings("all")
        public String getJobName() {
        return this.jobName;
    }

    @java.lang.SuppressWarnings("all")
        public String getStepName() {
        return this.stepName;
    }

    @java.lang.SuppressWarnings("all")
        public Long getStepOrder() {
        return this.stepOrder;
    }

    @java.lang.SuppressWarnings("all")
        public void setJobName(final String jobName) {
        this.jobName = jobName;
    }

    @java.lang.SuppressWarnings("all")
        public void setStepName(final String stepName) {
        this.stepName = stepName;
    }

    @java.lang.SuppressWarnings("all")
        public void setStepOrder(final Long stepOrder) {
        this.stepOrder = stepOrder;
    }
}
