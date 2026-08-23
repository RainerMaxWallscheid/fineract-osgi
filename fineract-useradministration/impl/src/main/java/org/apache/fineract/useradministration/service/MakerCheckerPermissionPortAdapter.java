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
package org.apache.fineract.useradministration.service;

import org.apache.commons.lang3.StringUtils;
import org.apache.fineract.useradministration.domain.Permission;
import org.apache.fineract.useradministration.domain.PermissionRepository;
import org.apache.fineract.useradministration.exception.PermissionNotFoundException;
import org.apache.fineract.useradministration.moduleapi.MakerCheckerPermissionPort;
import org.springframework.stereotype.Service;

@Service
public class MakerCheckerPermissionPortAdapter implements MakerCheckerPermissionPort {

    private final PermissionRepository permissionRepository;

    public MakerCheckerPermissionPortAdapter(final PermissionRepository permissionRepository) {
        this.permissionRepository = permissionRepository;
    }

    @Override
    public boolean hasMakerCheckerEnabled(final String permissionCode) {
        if (StringUtils.isBlank(permissionCode)) {
            throw new PermissionNotFoundException(permissionCode);
        }
        final Permission thisTask = this.permissionRepository.findOneByCode(permissionCode);
        if (thisTask == null) {
            throw new PermissionNotFoundException(permissionCode);
        }
        return thisTask.hasMakerCheckerEnabled();
    }
}
