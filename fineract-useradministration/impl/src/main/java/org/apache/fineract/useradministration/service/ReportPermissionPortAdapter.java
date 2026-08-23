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

import org.apache.fineract.useradministration.domain.Permission;
import org.apache.fineract.useradministration.domain.PermissionRepository;
import org.apache.fineract.useradministration.exception.PermissionNotFoundException;
import org.apache.fineract.useradministration.moduleapi.ReportPermissionPort;
import org.springframework.stereotype.Service;

@Service
public class ReportPermissionPortAdapter implements ReportPermissionPort {

    private final PermissionRepository permissionRepository;

    public ReportPermissionPortAdapter(final PermissionRepository permissionRepository) {
        this.permissionRepository = permissionRepository;
    }

    @Override
    public void saveReadPermission(final String reportName) {
        this.permissionRepository.save(new Permission("report", reportName, "READ"));
    }

    @Override
    public void deleteReadPermission(final String reportName) {
        final String code = "READ_" + reportName;
        final Permission permission = this.permissionRepository.findOneByCode(code);
        if (permission == null) {
            throw new PermissionNotFoundException(code);
        }
        this.permissionRepository.delete(permission);
    }
}
