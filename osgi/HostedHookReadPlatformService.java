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
import org.apache.fineract.infrastructure.hooks.data.HookData;
import org.apache.fineract.infrastructure.hooks.data.HookDetailsData;
import org.apache.fineract.infrastructure.hooks.data.HookTemplateData;
import org.apache.fineract.infrastructure.hooks.service.HookReadPlatformService;

/** Composition-root hosted hooks for the Equinox bridge smoke. */
final class HostedHookReadPlatformService implements HookReadPlatformService {

    static final long HOSTED_ID = 1L;

    private final HookData hosted = HookData.builder().id(HOSTED_ID).name("hosted").displayName("hosted").build();

    @Override
    public Collection<HookData> retrieveAllHooks() {
        return List.of(hosted);
    }

    @Override
    public HookData retrieveHook(final Long hookId) {
        return Long.valueOf(HOSTED_ID).equals(hookId) ? hosted : null;
    }

    @Override
    public HookDetailsData retrieveNewHookDetails(final String templateName) {
        return HookDetailsData.builder().templates(List.of(HookTemplateData.instance(HOSTED_ID, "hosted", List.of()))).build();
    }
}
