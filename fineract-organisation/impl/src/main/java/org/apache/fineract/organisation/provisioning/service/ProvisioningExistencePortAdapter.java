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
package org.apache.fineract.organisation.provisioning.service;

import org.apache.fineract.organisation.provisioning.domain.ProvisioningCategoryRepository;
import org.apache.fineract.organisation.provisioning.domain.ProvisioningCriteriaRepository;
import org.apache.fineract.organisation.provisioning.moduleapi.ProvisioningExistencePort;
import org.springframework.stereotype.Service;

@Service
public class ProvisioningExistencePortAdapter implements ProvisioningExistencePort {

    private final ProvisioningCategoryRepository provisioningCategoryRepository;
    private final ProvisioningCriteriaRepository provisioningCriteriaRepository;

    public ProvisioningExistencePortAdapter(final ProvisioningCategoryRepository provisioningCategoryRepository,
            final ProvisioningCriteriaRepository provisioningCriteriaRepository) {
        this.provisioningCategoryRepository = provisioningCategoryRepository;
        this.provisioningCriteriaRepository = provisioningCriteriaRepository;
    }

    @Override
    public boolean categoryExistsById(final Long categoryId) {
        return categoryId != null && provisioningCategoryRepository.existsById(categoryId);
    }

    @Override
    public boolean hasAnyCriteria() {
        return provisioningCriteriaRepository.count() > 0;
    }
}
