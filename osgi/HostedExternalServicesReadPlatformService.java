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

import org.apache.fineract.infrastructure.configuration.data.ExternalServicesData;
import org.apache.fineract.infrastructure.configuration.service.ExternalServicesReadPlatformService;

/** Composition-root hosted external-services catalog for the Equinox bridge smoke. */
final class HostedExternalServicesReadPlatformService implements ExternalServicesReadPlatformService {

    static final long HOSTED_ID = 1L;
    static final String HOSTED_NAME = "hosted";

    @Override
    public ExternalServicesData getExternalServiceDetailsByServiceName(final String serviceName) {
        if (HOSTED_NAME.equals(serviceName)) {
            return new ExternalServicesData().setId(HOSTED_ID).setName(HOSTED_NAME);
        }
        return null;
    }
}
