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

import java.util.Collection;
import java.util.List;
import org.apache.fineract.spm.data.ScorecardData;
import org.apache.fineract.spm.service.ScorecardReadPlatformService;

/** Composition-root hosted scorecards for the Equinox bridge smoke. */
final class HostedScorecardReadPlatformService implements ScorecardReadPlatformService {

    static final long HOSTED_ID = 1L;

    private final ScorecardData hosted = ScorecardData.instance(HOSTED_ID, HOSTED_ID, "hosted", HOSTED_ID, "hosted", HOSTED_ID);

    @Override
    public Collection<ScorecardData> retrieveScorecardByClient(final Long clientId) {
        return Long.valueOf(HOSTED_ID).equals(clientId) ? List.of(hosted) : List.of();
    }

    @Override
    public Collection<ScorecardData> retrieveScorecardBySurveyAndClient(final Long surveyId, final Long clientId) {
        return retrieveScorecardByClient(clientId);
    }

    @Override
    public Collection<ScorecardData> retrieveScorecardBySurvey(final Long surveyId) {
        return Long.valueOf(HOSTED_ID).equals(surveyId) ? List.of(hosted) : List.of();
    }
}
