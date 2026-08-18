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

import java.util.List;
import org.apache.fineract.cob.data.JobBusinessStepConfigData;
import org.apache.fineract.cob.data.JobBusinessStepDetail;
import org.apache.fineract.cob.service.ConfigJobParameterService;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.data.CommandProcessingResult;

/** Composition-root hosted COB job names for the Equinox bridge smoke. */
final class HostedConfigJobParameterService implements ConfigJobParameterService {

    static final String HOSTED_JOB = "hosted";

    @Override
    public JobBusinessStepConfigData getBusinessStepConfigByJobName(final String jobName) {
        final JobBusinessStepConfigData data = new JobBusinessStepConfigData();
        data.setJobName(jobName);
        data.setBusinessSteps(List.of());
        return data;
    }

    @Override
    public CommandProcessingResult updateStepConfigByJobName(final JsonCommand command, final String jobName) {
        return CommandProcessingResult.resourceResult(1L);
    }

    @Override
    public JobBusinessStepDetail getAvailableBusinessStepsByJobName(final String jobName) {
        final JobBusinessStepDetail data = new JobBusinessStepDetail();
        data.setJobName(jobName);
        data.setAvailableBusinessSteps(List.of());
        return data;
    }

    @Override
    public List<String> getAllConfiguredJobNames() {
        return List.of(HOSTED_JOB);
    }
}
