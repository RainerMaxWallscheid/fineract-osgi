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
package org.apache.fineract.portfolio.account.impl.osgi;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.portfolio.account.service.AccountAssociationsReadPlatformService;
import org.apache.fineract.portfolio.account.service.AccountTransferFundsWritePort;
import org.apache.fineract.portfolio.account.service.AccountTransfersCommandWritePort;
import org.apache.fineract.portfolio.account.service.AccountTransfersReadPlatformService;
import org.apache.fineract.portfolio.account.service.PortfolioAccountReadPlatformService;
import org.apache.fineract.portfolio.account.service.StandingInstructionHistoryReadService;
import org.apache.fineract.portfolio.account.service.StandingInstructionReadPlatformService;
import org.apache.fineract.portfolio.account.service.StandingInstructionWritePlatformService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Component;

/** Spring ↔ OSGi bridge for account-transfer / SI ports. */
@Component
public class AccountTransferOsgiServiceRegistrar implements InitializingBean, DisposableBean {

    private static final Logger LOG = LoggerFactory.getLogger(AccountTransferOsgiServiceRegistrar.class);

    private final ObjectProvider<AccountTransfersReadPlatformService> transfersRead;
    private final ObjectProvider<AccountTransfersCommandWritePort> transfersWrite;
    private final ObjectProvider<AccountTransferFundsWritePort> fundsWrite;
    private final ObjectProvider<PortfolioAccountReadPlatformService> portfolioRead;
    private final ObjectProvider<AccountAssociationsReadPlatformService> associationsRead;
    private final ObjectProvider<StandingInstructionReadPlatformService> siRead;
    private final ObjectProvider<StandingInstructionWritePlatformService> siWrite;
    private final ObjectProvider<StandingInstructionHistoryReadService> siHistory;
    private final List<Object> registrations = new ArrayList<>();

    public AccountTransferOsgiServiceRegistrar(final ObjectProvider<AccountTransfersReadPlatformService> transfersRead,
            final ObjectProvider<AccountTransfersCommandWritePort> transfersWrite,
            final ObjectProvider<AccountTransferFundsWritePort> fundsWrite,
            final ObjectProvider<PortfolioAccountReadPlatformService> portfolioRead,
            final ObjectProvider<AccountAssociationsReadPlatformService> associationsRead,
            final ObjectProvider<StandingInstructionReadPlatformService> siRead,
            final ObjectProvider<StandingInstructionWritePlatformService> siWrite,
            final ObjectProvider<StandingInstructionHistoryReadService> siHistory) {
        this.transfersRead = transfersRead;
        this.transfersWrite = transfersWrite;
        this.fundsWrite = fundsWrite;
        this.portfolioRead = portfolioRead;
        this.associationsRead = associationsRead;
        this.siRead = siRead;
        this.siWrite = siWrite;
        this.siHistory = siHistory;
    }

    @Override
    public void afterPropertiesSet() {
        try {
            final Class<?> frameworkUtil = Class.forName("org.osgi.framework.FrameworkUtil");
            final Method getBundle = frameworkUtil.getMethod("getBundle", Class.class);
            final Object bundle = getBundle.invoke(null, AccountTransferOsgiServiceRegistrar.class);
            if (bundle == null) {
                return;
            }
            final Object context = bundle.getClass().getMethod("getBundleContext").invoke(bundle);
            if (context == null) {
                return;
            }
            register(context, AccountTransfersReadPlatformService.class, transfersRead.getIfAvailable());
            register(context, AccountTransfersCommandWritePort.class, transfersWrite.getIfAvailable());
            register(context, AccountTransferFundsWritePort.class, fundsWrite.getIfAvailable());
            register(context, PortfolioAccountReadPlatformService.class, portfolioRead.getIfAvailable());
            register(context, AccountAssociationsReadPlatformService.class, associationsRead.getIfAvailable());
            register(context, StandingInstructionReadPlatformService.class, siRead.getIfAvailable());
            register(context, StandingInstructionWritePlatformService.class, siWrite.getIfAvailable());
            register(context, StandingInstructionHistoryReadService.class, siHistory.getIfAvailable());
            LOG.info("Registered {} account-transfer OSGi service(s)", registrations.size());
        } catch (final ClassNotFoundException ex) {
            LOG.debug("OSGi framework classes not present; Spring-only account-transfer wiring");
        } catch (final ReflectiveOperationException ex) {
            LOG.warn("Failed to register account-transfer OSGi services: {}", ex.toString());
        }
    }

    private <T> void register(final Object context, final Class<T> type, final T service) throws ReflectiveOperationException {
        if (service == null) {
            return;
        }
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-accounttransfer-impl");
        final Object registration = context.getClass().getMethod("registerService", Class.class, Object.class, Dictionary.class)
                .invoke(context, type, service, props);
        registrations.add(registration);
    }

    @Override
    public void destroy() {
        for (final Object registration : registrations) {
            try {
                registration.getClass().getMethod("unregister").invoke(registration);
            } catch (final ReflectiveOperationException | RuntimeException ignored) {
                // already unregistered
            }
        }
        registrations.clear();
    }
}
