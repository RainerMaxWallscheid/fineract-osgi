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
package org.apache.fineract.infrastructure.core;

import org.apache.fineract.infrastructure.core.config.FineractProperties;
import org.apache.fineract.infrastructure.core.config.FineractProperties.FineractModeProperties;

/**
 * Shared {@link FineractProperties} for cucumber stepdefs that previously Autowired the composition-root test harness.
 * Instance-type and Liquibase scenarios mutate the same mode flags.
 */
final class CucumberFineractProperties {

    static final FineractProperties INSTANCE = createDefault();

    private CucumberFineractProperties() {}

    private static FineractProperties createDefault() {
        FineractProperties properties = new FineractProperties();
        FineractModeProperties mode = new FineractModeProperties();
        mode.setReadEnabled(true);
        mode.setWriteEnabled(true);
        mode.setBatchWorkerEnabled(true);
        mode.setBatchManagerEnabled(true);
        properties.setMode(mode);

        // Tenant store details are only logged during upgrade; keep them non-null.
        FineractProperties.FineractTenantProperties tenant = new FineractProperties.FineractTenantProperties();
        tenant.setHost("localhost");
        tenant.setPort(3306);
        properties.setTenant(tenant);

        // Matches application-test.properties tenant-upgrade executor defaults.
        FineractProperties.FineractTaskExecutor taskExecutor = new FineractProperties.FineractTaskExecutor();
        taskExecutor.setTenantUpgradeTaskExecutorCorePoolSize(1);
        taskExecutor.setTenantUpgradeTaskExecutorMaxPoolSize(1);
        taskExecutor.setTenantUpgradeTaskExecutorQueueCapacity(100);
        properties.setTaskExecutor(taskExecutor);
        return properties;
    }
}
