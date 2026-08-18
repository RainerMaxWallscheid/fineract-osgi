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
import java.util.Set;
import org.apache.fineract.portfolio.loanorigination.data.LoanOriginatorData;
import org.apache.fineract.portfolio.loanorigination.data.LoanOriginatorTemplateData;
import org.apache.fineract.portfolio.loanorigination.exception.LoanOriginatorNotFoundException;
import org.apache.fineract.portfolio.loanorigination.service.LoanOriginatorReadPlatformService;

/**
 * Composition-root hosted originator catalog for the Equinox bridge smoke.
 * Not JPA — {@code LoanOriginatorReadPlatformServiceImpl} stays on the Boot classpath.
 */
final class HostedLoanOriginatorReadPlatformService implements LoanOriginatorReadPlatformService {

    static final long HOSTED_ID = 1L;
    static final String HOSTED_EXTERNAL_ID = "hosted";

    private final LoanOriginatorData hosted = LoanOriginatorData.builder().id(HOSTED_ID).externalId(HOSTED_EXTERNAL_ID).name("hosted")
            .status("ACTIVE").build();

    @Override
    public List<LoanOriginatorData> retrieveAll() {
        return List.of(hosted);
    }

    @Override
    public LoanOriginatorData retrieveById(final Long id) {
        if (Long.valueOf(HOSTED_ID).equals(id)) {
            return hosted;
        }
        throw new LoanOriginatorNotFoundException(id);
    }

    @Override
    public LoanOriginatorData retrieveByExternalId(final String externalId) {
        if (HOSTED_EXTERNAL_ID.equals(externalId)) {
            return hosted;
        }
        throw new LoanOriginatorNotFoundException(externalId);
    }

    @Override
    public Long resolveIdByExternalId(final String externalId) {
        if (HOSTED_EXTERNAL_ID.equals(externalId)) {
            return HOSTED_ID;
        }
        throw new LoanOriginatorNotFoundException(externalId);
    }

    @Override
    public List<LoanOriginatorData> retrieveByLoanId(final Long loanId) {
        if (Long.valueOf(HOSTED_ID).equals(loanId)) {
            return List.of(hosted);
        }
        return List.of();
    }

    @Override
    public LoanOriginatorTemplateData retrieveTemplate() {
        return new LoanOriginatorTemplateData(null, Set.of(), List.of(), List.of());
    }
}
