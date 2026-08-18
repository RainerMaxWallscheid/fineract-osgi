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
import org.apache.fineract.portfolio.address.data.FieldConfigurationData;
import org.apache.fineract.portfolio.address.service.FieldConfigurationReadPlatformService;

/** Composition-root hosted address field configuration for the Equinox bridge smoke. */
final class HostedFieldConfigurationReadPlatformService implements FieldConfigurationReadPlatformService {

    static final long HOSTED_ID = 1L;

    private final FieldConfigurationData hosted = new FieldConfigurationData(HOSTED_ID, "hosted", "hosted", "hosted", true, false, "hosted");

    @Override
    public List<FieldConfigurationData> retrieveFieldConfiguration(final String entity) {
        return List.of(hosted);
    }

    @Override
    public List<FieldConfigurationData> retrieveFieldConfigurationList(final String entity) {
        return List.of(hosted);
    }
}
