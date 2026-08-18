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
import org.apache.fineract.adhocquery.data.AdHocData;
import org.apache.fineract.adhocquery.service.AdHocReadPlatformService;

/** Composition-root hosted ad-hoc query catalog for the Equinox bridge smoke. */
final class HostedAdHocReadPlatformService implements AdHocReadPlatformService {

    static final long HOSTED_ID = 1L;

    private final AdHocData hosted = new AdHocData().setId(HOSTED_ID).setName("hosted").setQuery("hosted").setActive(true);

    @Override
    public List<AdHocData> retrieveAllAdHocQuery() {
        return List.of(hosted);
    }

    @Override
    public List<AdHocData> retrieveAllActiveAdHocQuery() {
        return List.of(hosted);
    }

    @Override
    public AdHocData retrieveOne(final Long adHocId) {
        return Long.valueOf(HOSTED_ID).equals(adHocId) ? hosted : null;
    }

    @Override
    public AdHocData retrieveNewAdHocDetails() {
        return hosted;
    }
}
