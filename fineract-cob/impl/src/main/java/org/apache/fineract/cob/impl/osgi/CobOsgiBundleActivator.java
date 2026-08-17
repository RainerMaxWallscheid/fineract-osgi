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
package org.apache.fineract.cob.impl.osgi;

import java.util.Dictionary;
import java.util.Hashtable;
import org.apache.fineract.cob.service.ConfigJobParameterService;
import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;
import org.osgi.framework.ServiceRegistration;

/**
 * Equinox start path for cob (ADR-022 B3). Registers
 * {@link ConfigJobParameterService} without a Spring/JPA context.
 * {@link CobOsgiServiceRegistrar} remains the Spring Boot path.
 */
public class CobOsgiBundleActivator implements BundleActivator {

    private ServiceRegistration<ConfigJobParameterService> registration;

    @Override
    public void start(final BundleContext context) {
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-cob-impl");
        registration = context.registerService(ConfigJobParameterService.class, new OsgiConfigJobParameterService(), props);
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
