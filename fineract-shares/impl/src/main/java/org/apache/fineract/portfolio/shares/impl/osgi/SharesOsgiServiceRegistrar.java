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
package org.apache.fineract.portfolio.shares.impl.osgi;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.portfolio.accounts.service.AccountReadPlatformService;
import org.apache.fineract.portfolio.shareaccounts.service.PurchasedSharesReadPlatformService;
import org.apache.fineract.portfolio.shareaccounts.service.ShareAccountDividendReadPlatformService;
import org.apache.fineract.portfolio.shareaccounts.service.ShareAccountReadPlatformService;
import org.apache.fineract.portfolio.shareaccounts.service.ShareAccountSchedularService;
import org.apache.fineract.portfolio.shareaccounts.service.ShareAccountWritePlatformService;
import org.apache.fineract.portfolio.shareproducts.service.ShareProductDividendReadPlatformService;
import org.apache.fineract.portfolio.shareproducts.service.ShareProductDropdownReadPlatformService;
import org.apache.fineract.portfolio.shareproducts.service.ShareProductWritePlatformService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Component;

/** Spring ↔ OSGi bridge for share product/account ports. */
@Component
public class SharesOsgiServiceRegistrar implements InitializingBean, DisposableBean {

    private static final Logger LOG = LoggerFactory.getLogger(SharesOsgiServiceRegistrar.class);

    private final ObjectProvider<ShareAccountReadPlatformService> accountRead;
    private final ObjectProvider<ShareAccountWritePlatformService> accountWrite;
    private final ObjectProvider<ShareAccountSchedularService> accountSchedular;
    private final ObjectProvider<ShareAccountDividendReadPlatformService> accountDividendRead;
    private final ObjectProvider<PurchasedSharesReadPlatformService> purchasedRead;
    private final ObjectProvider<ShareProductWritePlatformService> productWrite;
    private final ObjectProvider<ShareProductDropdownReadPlatformService> productDropdown;
    private final ObjectProvider<ShareProductDividendReadPlatformService> productDividendRead;
    private final ObjectProvider<AccountReadPlatformService> accountsRead;
    private final List<Object> registrations = new ArrayList<>();

    public SharesOsgiServiceRegistrar(final ObjectProvider<ShareAccountReadPlatformService> accountRead,
            final ObjectProvider<ShareAccountWritePlatformService> accountWrite,
            final ObjectProvider<ShareAccountSchedularService> accountSchedular,
            final ObjectProvider<ShareAccountDividendReadPlatformService> accountDividendRead,
            final ObjectProvider<PurchasedSharesReadPlatformService> purchasedRead,
            final ObjectProvider<ShareProductWritePlatformService> productWrite,
            final ObjectProvider<ShareProductDropdownReadPlatformService> productDropdown,
            final ObjectProvider<ShareProductDividendReadPlatformService> productDividendRead,
            final ObjectProvider<AccountReadPlatformService> accountsRead) {
        this.accountRead = accountRead;
        this.accountWrite = accountWrite;
        this.accountSchedular = accountSchedular;
        this.accountDividendRead = accountDividendRead;
        this.purchasedRead = purchasedRead;
        this.productWrite = productWrite;
        this.productDropdown = productDropdown;
        this.productDividendRead = productDividendRead;
        this.accountsRead = accountsRead;
    }

    @Override
    public void afterPropertiesSet() {
        try {
            final Class<?> frameworkUtil = Class.forName("org.osgi.framework.FrameworkUtil");
            final Method getBundle = frameworkUtil.getMethod("getBundle", Class.class);
            final Object bundle = getBundle.invoke(null, SharesOsgiServiceRegistrar.class);
            if (bundle == null) {
                return;
            }
            final Object context = bundle.getClass().getMethod("getBundleContext").invoke(bundle);
            if (context == null) {
                return;
            }
            register(context, ShareAccountReadPlatformService.class, accountRead.getIfAvailable());
            register(context, ShareAccountWritePlatformService.class, accountWrite.getIfAvailable());
            register(context, ShareAccountSchedularService.class, accountSchedular.getIfAvailable());
            register(context, ShareAccountDividendReadPlatformService.class, accountDividendRead.getIfAvailable());
            register(context, PurchasedSharesReadPlatformService.class, purchasedRead.getIfAvailable());
            register(context, ShareProductWritePlatformService.class, productWrite.getIfAvailable());
            register(context, ShareProductDropdownReadPlatformService.class, productDropdown.getIfAvailable());
            register(context, ShareProductDividendReadPlatformService.class, productDividendRead.getIfAvailable());
            register(context, AccountReadPlatformService.class, accountsRead.getIfAvailable());
            LOG.info("Registered {} shares OSGi service(s)", registrations.size());
        } catch (final ClassNotFoundException ex) {
            LOG.debug("OSGi framework classes not present; Spring-only shares wiring");
        } catch (final ReflectiveOperationException ex) {
            LOG.warn("Failed to register shares OSGi services: {}", ex.toString());
        }
    }

    private <T> void register(final Object context, final Class<T> type, final T service) throws ReflectiveOperationException {
        if (service == null) {
            return;
        }
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-shares-impl");
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
