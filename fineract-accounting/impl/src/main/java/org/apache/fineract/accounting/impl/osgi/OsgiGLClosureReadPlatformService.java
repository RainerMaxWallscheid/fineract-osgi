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
package org.apache.fineract.accounting.impl.osgi;

import java.util.List;
import org.apache.fineract.accounting.closure.data.GLClosureData;
import org.apache.fineract.accounting.closure.exception.GLClosureNotFoundException;
import org.apache.fineract.accounting.closure.service.GLClosureReadPlatformService;

/**
 * Empty GL-closure catalog for Equinox without Spring/JPA. Same outcome as a
 * repository that finds no closures.
 */
final class OsgiGLClosureReadPlatformService implements GLClosureReadPlatformService {

    @Override
    public List<GLClosureData> retrieveAllGLClosures(final Long officeId) {
        return List.of();
    }

    @Override
    public GLClosureData retrieveGLClosureById(final long glClosureId) {
        throw new GLClosureNotFoundException(glClosureId);
    }
}
