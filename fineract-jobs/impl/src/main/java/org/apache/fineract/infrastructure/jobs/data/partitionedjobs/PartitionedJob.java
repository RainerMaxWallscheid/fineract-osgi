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
package org.apache.fineract.infrastructure.jobs.data.partitionedjobs;

public enum PartitionedJob {
    // Keep in sync with org.apache.fineract.cob.loan.LoanCOBConstant.LOAN_COB_PARTITIONER_STEP (provider residual).
    LOAN_COB("Loan COB partition - Step");
    private final String partitionerStepName;

    public static boolean existsByJobName(String jobName) {
        PartitionedJob partitionedJob = null;
        for (PartitionedJob job : values()) {
            if (jobName.equalsIgnoreCase(job.name())) {
                partitionedJob = job;
            }
        }
        return partitionedJob != null;
    }

    @java.lang.SuppressWarnings("all")
        private PartitionedJob(final String partitionerStepName) {
        this.partitionerStepName = partitionerStepName;
    }

    @java.lang.SuppressWarnings("all")
        public String getPartitionerStepName() {
        return this.partitionerStepName;
    }
}
