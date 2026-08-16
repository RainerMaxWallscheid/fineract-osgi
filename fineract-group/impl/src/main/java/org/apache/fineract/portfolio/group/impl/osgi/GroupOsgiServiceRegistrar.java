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
package org.apache.fineract.portfolio.group.impl.osgi;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.portfolio.group.service.CenterReadPlatformService;
import org.apache.fineract.portfolio.group.service.GroupLevelReadPlatformService;
import org.apache.fineract.portfolio.group.service.GroupReadPlatformService;
import org.apache.fineract.portfolio.group.service.GroupRolesReadPlatformService;
import org.apache.fineract.portfolio.group.service.GroupRolesWritePlatformService;
import org.apache.fineract.portfolio.group.service.GroupingTypesWritePlatformService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Component;

/** Spring ↔ OSGi bridge for group/center ports. */
@Component
public class GroupOsgiServiceRegistrar implements InitializingBean, DisposableBean {

    private static final Logger LOG = LoggerFactory.getLogger(GroupOsgiServiceRegistrar.class);

    private final ObjectProvider<GroupReadPlatformService> groupRead;
    private final ObjectProvider<CenterReadPlatformService> centerRead;
    private final ObjectProvider<GroupLevelReadPlatformService> levelRead;
    private final ObjectProvider<GroupRolesReadPlatformService> rolesRead;
    private final ObjectProvider<GroupRolesWritePlatformService> rolesWrite;
    private final ObjectProvider<GroupingTypesWritePlatformService> groupingWrite;
    private final List<Object> registrations = new ArrayList<>();

    public GroupOsgiServiceRegistrar(final ObjectProvider<GroupReadPlatformService> groupRead,
            final ObjectProvider<CenterReadPlatformService> centerRead,
            final ObjectProvider<GroupLevelReadPlatformService> levelRead,
            final ObjectProvider<GroupRolesReadPlatformService> rolesRead,
            final ObjectProvider<GroupRolesWritePlatformService> rolesWrite,
            final ObjectProvider<GroupingTypesWritePlatformService> groupingWrite) {
        this.groupRead = groupRead;
        this.centerRead = centerRead;
        this.levelRead = levelRead;
        this.rolesRead = rolesRead;
        this.rolesWrite = rolesWrite;
        this.groupingWrite = groupingWrite;
    }

    @Override
    public void afterPropertiesSet() {
        try {
            final Class<?> frameworkUtil = Class.forName("org.osgi.framework.FrameworkUtil");
            final Method getBundle = frameworkUtil.getMethod("getBundle", Class.class);
            final Object bundle = getBundle.invoke(null, GroupOsgiServiceRegistrar.class);
            if (bundle == null) {
                return;
            }
            final Object context = bundle.getClass().getMethod("getBundleContext").invoke(bundle);
            if (context == null) {
                return;
            }
            register(context, GroupReadPlatformService.class, groupRead.getIfAvailable());
            register(context, CenterReadPlatformService.class, centerRead.getIfAvailable());
            register(context, GroupLevelReadPlatformService.class, levelRead.getIfAvailable());
            register(context, GroupRolesReadPlatformService.class, rolesRead.getIfAvailable());
            register(context, GroupRolesWritePlatformService.class, rolesWrite.getIfAvailable());
            register(context, GroupingTypesWritePlatformService.class, groupingWrite.getIfAvailable());
            LOG.info("Registered {} group OSGi service(s)", registrations.size());
        } catch (final ClassNotFoundException ex) {
            LOG.debug("OSGi framework classes not present; Spring-only group wiring");
        } catch (final ReflectiveOperationException ex) {
            LOG.warn("Failed to register group OSGi services: {}", ex.toString());
        }
    }

    private <T> void register(final Object context, final Class<T> type, final T service) throws ReflectiveOperationException {
        if (service == null) {
            return;
        }
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-group-impl");
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
