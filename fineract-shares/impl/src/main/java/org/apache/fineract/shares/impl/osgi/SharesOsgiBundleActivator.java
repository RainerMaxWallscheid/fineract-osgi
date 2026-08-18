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
package org.apache.fineract.shares.impl.osgi;

import java.util.Dictionary;
import java.util.Hashtable;
import org.apache.fineract.shares.shareproducts.service.ShareProductDropdownReadPlatformService;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceRegistration;

/**
 * Equinox start path for shares (ADR-022 B3). Registers
 * {@link ShareProductDropdownReadPlatformService} without a Spring/JPA context.
 * {@link SharesOsgiServiceRegistrar} remains the Spring Boot path.
 */
public class SharesOsgiBundleActivator implements BundleActivator {

    private ServiceRegistration<ShareProductDropdownReadPlatformService> registration;

    @Override
    public void start(final BundleContext context) {
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-shares-impl");
        registration = context.registerService(ShareProductDropdownReadPlatformService.class,
                new OsgiShareProductDropdownReadPlatformService(), props);
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
