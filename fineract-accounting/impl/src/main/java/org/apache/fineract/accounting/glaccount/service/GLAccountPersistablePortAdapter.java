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
package org.apache.fineract.accounting.glaccount.service;

import org.apache.fineract.accounting.glaccount.domain.GLAccount;
import org.apache.fineract.accounting.glaccount.domain.GLAccountRepository;
import org.apache.fineract.accounting.moduleapi.GLAccountPersistablePort;
import org.springframework.stereotype.Service;

@Service
public class GLAccountPersistablePortAdapter implements GLAccountPersistablePort {

    private final GLAccountRepository glAccountRepository;

    public GLAccountPersistablePortAdapter(final GLAccountRepository glAccountRepository) {
        this.glAccountRepository = glAccountRepository;
    }

    @Override
    public Long id(final Object glAccount) {
        if (glAccount instanceof Long glAccountId) {
            return glAccountId;
        }
        if (glAccount == null) {
            return null;
        }
        return ((GLAccount) glAccount).getId();
    }

    @Override
    public Object persistableById(final Long glAccountId) {
        if (glAccountId == null) {
            return null;
        }
        return this.glAccountRepository.findById(glAccountId).orElse(null);
    }
}
