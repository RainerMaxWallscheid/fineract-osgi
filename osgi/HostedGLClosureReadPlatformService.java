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

import java.time.LocalDate;
import java.util.List;
import org.apache.fineract.accounting.closure.data.GLClosureData;
import org.apache.fineract.accounting.closure.exception.GLClosureNotFoundException;
import org.apache.fineract.accounting.closure.service.GLClosureReadPlatformService;

/** Composition-root hosted GL-closure catalog for the Equinox bridge smoke. */
final class HostedGLClosureReadPlatformService implements GLClosureReadPlatformService {

    static final long HOSTED_ID = 1L;

    private final GLClosureData hosted = new GLClosureData(HOSTED_ID, HOSTED_ID, "hosted", LocalDate.of(2020, 1, 1), false, null, null,
            HOSTED_ID, "hosted", HOSTED_ID, "hosted", "hosted");

    @Override
    public List<GLClosureData> retrieveAllGLClosures(final Long officeId) {
        return List.of(hosted);
    }

    @Override
    public GLClosureData retrieveGLClosureById(final long glClosureId) {
        if (HOSTED_ID == glClosureId) {
            return hosted;
        }
        throw new GLClosureNotFoundException(glClosureId);
    }
}
