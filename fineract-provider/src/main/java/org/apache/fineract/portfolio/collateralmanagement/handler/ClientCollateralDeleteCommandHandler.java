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
package org.apache.fineract.portfolio.collateralmanagement.handler;

import io.github.resilience4j.retry.annotation.Retry;
import org.apache.fineract.command.core.Command;
import org.apache.fineract.command.core.CommandHandler;
import org.apache.fineract.portfolio.collateralmanagement.data.ClientCollateralDeleteRequest;
import org.apache.fineract.portfolio.collateralmanagement.data.ClientCollateralDeleteResponse;
import org.apache.fineract.portfolio.collateralmanagement.service.ClientCollateralManagementWriteService;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
public class ClientCollateralDeleteCommandHandler implements CommandHandler<ClientCollateralDeleteRequest, ClientCollateralDeleteResponse> {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(ClientCollateralDeleteCommandHandler.class);
    private final ClientCollateralManagementWriteService writeService;

    @Retry(name = "commandClientCollateralDelete", fallbackMethod = "fallback")
    @Override
    @Transactional
    public ClientCollateralDeleteResponse handle(Command<ClientCollateralDeleteRequest> command) {
        return writeService.deleteClientCollateralProduct(command.getPayload());
    }

    @Override
    public ClientCollateralDeleteResponse fallback(Command<ClientCollateralDeleteRequest> command, Throwable t) {
        return CommandHandler.super.fallback(command, t);
    }

    @java.lang.SuppressWarnings("all")
        public ClientCollateralDeleteCommandHandler(final ClientCollateralManagementWriteService writeService) {
        this.writeService = writeService;
    }
}
