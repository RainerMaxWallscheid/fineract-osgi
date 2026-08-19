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
package org.apache.fineract.adhocquery.impl.osgi;

import java.util.List;
import org.apache.fineract.adhocquery.data.AdHocData;
import org.apache.fineract.adhocquery.service.AdHocReadPlatformService;

/**
 * Empty ad-hoc query catalog for Equinox without Spring/JPA.
 * Published by {@code OSGI-INF/adhocquery.xml} (ADR-022 B6).
 */
public final class OsgiAdHocReadPlatformService implements AdHocReadPlatformService {

    @Override
    public List<AdHocData> retrieveAllAdHocQuery() {
        return List.of();
    }

    @Override
    public List<AdHocData> retrieveAllActiveAdHocQuery() {
        return List.of();
    }

    @Override
    public AdHocData retrieveOne(final Long adHocId) {
        return null;
    }

    @Override
    public AdHocData retrieveNewAdHocDetails() {
        return null;
    }
}
