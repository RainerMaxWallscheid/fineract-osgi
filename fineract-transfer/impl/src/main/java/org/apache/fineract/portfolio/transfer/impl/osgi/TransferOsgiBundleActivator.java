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
package org.apache.fineract.portfolio.transfer.impl.osgi;

import java.util.Dictionary;
import java.util.Hashtable;
import org.apache.fineract.portfolio.transfer.service.TransferWritePlatformService;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceRegistration;

/**
 * Equinox start path for transfer (ADR-022 B3). Registers
 * {@link TransferWritePlatformService} without a Spring/JPA context.
 * {@link TransferOsgiServiceRegistrar} remains the Spring Boot path.
 */
public class TransferOsgiBundleActivator implements BundleActivator {

    private ServiceRegistration<TransferWritePlatformService> registration;

    @Override
    public void start(final BundleContext context) {
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-transfer-impl");
        registration = context.registerService(TransferWritePlatformService.class, new OsgiTransferWritePlatformService(), props);
    }

    @Override
    public void stop(final BundleContext context) {
        if (registration != null) {
            try {
                registration.unregister();
            } catch (final IllegalStateException ignored) {
                // already unregistered
            }
            registration = null;
        }
    }
}
