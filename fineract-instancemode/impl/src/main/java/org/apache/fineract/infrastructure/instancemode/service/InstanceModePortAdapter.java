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
package org.apache.fineract.infrastructure.instancemode.service;

import org.apache.fineract.infrastructure.core.config.FineractProperties;
import org.apache.fineract.infrastructure.instancemode.moduleapi.InstanceModePort;
import org.springframework.stereotype.Service;

@Service
public class InstanceModePortAdapter implements InstanceModePort {

    private final FineractProperties fineractProperties;

    public InstanceModePortAdapter(final FineractProperties fineractProperties) {
        this.fineractProperties = fineractProperties;
    }

    @Override
    public void changeMode(final boolean readEnabled, final boolean writeEnabled, final boolean batchWorkerEnabled,
            final boolean batchManagerEnabled) {
        fineractProperties.getMode().setReadEnabled(readEnabled);
        fineractProperties.getMode().setWriteEnabled(writeEnabled);
        fineractProperties.getMode().setBatchWorkerEnabled(batchWorkerEnabled);
        fineractProperties.getMode().setBatchManagerEnabled(batchManagerEnabled);
    }
}
