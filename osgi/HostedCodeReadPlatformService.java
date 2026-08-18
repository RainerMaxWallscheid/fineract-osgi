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
import org.apache.fineract.infrastructure.codes.data.CodeData;
import org.apache.fineract.infrastructure.codes.service.CodeReadPlatformService;

/** Composition-root hosted code catalog for the Equinox bridge smoke. */
final class HostedCodeReadPlatformService implements CodeReadPlatformService {

    static final long HOSTED_ID = 1L;
    static final String HOSTED_NAME = "hosted";

    private final CodeData hosted = CodeData.instance(HOSTED_ID, HOSTED_NAME, false);

    @Override
    public Collection<CodeData> retrieveAllCodes() {
        return List.of(hosted);
    }

    @Override
    public CodeData retrieveCode(final Long codeId) {
        return Long.valueOf(HOSTED_ID).equals(codeId) ? hosted : null;
    }

    @Override
    public CodeData retrieveCode(final String codeName) {
        return HOSTED_NAME.equals(codeName) ? hosted : null;
    }
}
