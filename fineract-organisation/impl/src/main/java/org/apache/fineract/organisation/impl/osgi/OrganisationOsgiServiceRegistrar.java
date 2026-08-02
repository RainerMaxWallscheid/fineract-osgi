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
package org.apache.fineract.organisation.impl.osgi;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.organisation.holiday.service.HolidayReadPlatformService;
import org.apache.fineract.organisation.office.service.OfficeReadPlatformService;
import org.apache.fineract.organisation.provisioning.service.ProvisioningCategoryReadPlatformService;
import org.apache.fineract.organisation.provisioning.service.ProvisioningCategoryWritePlatformService;
import org.apache.fineract.organisation.provisioning.service.ProvisioningCriteriaReadPlatformService;
import org.apache.fineract.organisation.provisioning.service.ProvisioningCriteriaWritePlatformService;
import org.apache.fineract.organisation.staff.service.StaffReadService;
import org.apache.fineract.organisation.workingdays.service.WorkingDaysReadPlatformService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Component;

/** Spring ↔ OSGi bridge for organisation read/write ports (office, staff, calendar, provisioning). */
@Component
public class OrganisationOsgiServiceRegistrar implements InitializingBean, DisposableBean {

    private static final Logger LOG = LoggerFactory.getLogger(OrganisationOsgiServiceRegistrar.class);

    private final ObjectProvider<OfficeReadPlatformService> officeRead;
    private final ObjectProvider<StaffReadService> staffRead;
    private final ObjectProvider<HolidayReadPlatformService> holidayRead;
    private final ObjectProvider<WorkingDaysReadPlatformService> workingDaysRead;
    private final ObjectProvider<ProvisioningCategoryReadPlatformService> categoryRead;
    private final ObjectProvider<ProvisioningCategoryWritePlatformService> categoryWrite;
    private final ObjectProvider<ProvisioningCriteriaReadPlatformService> criteriaRead;
    private final ObjectProvider<ProvisioningCriteriaWritePlatformService> criteriaWrite;
    private final List<Object> registrations = new ArrayList<>();

    public OrganisationOsgiServiceRegistrar(final ObjectProvider<OfficeReadPlatformService> officeRead,
            final ObjectProvider<StaffReadService> staffRead, final ObjectProvider<HolidayReadPlatformService> holidayRead,
            final ObjectProvider<WorkingDaysReadPlatformService> workingDaysRead,
            final ObjectProvider<ProvisioningCategoryReadPlatformService> categoryRead,
            final ObjectProvider<ProvisioningCategoryWritePlatformService> categoryWrite,
            final ObjectProvider<ProvisioningCriteriaReadPlatformService> criteriaRead,
            final ObjectProvider<ProvisioningCriteriaWritePlatformService> criteriaWrite) {
        this.officeRead = officeRead;
        this.staffRead = staffRead;
        this.holidayRead = holidayRead;
        this.workingDaysRead = workingDaysRead;
        this.categoryRead = categoryRead;
        this.categoryWrite = categoryWrite;
        this.criteriaRead = criteriaRead;
        this.criteriaWrite = criteriaWrite;
    }

    @Override
    public void afterPropertiesSet() {
        try {
            final Class<?> frameworkUtil = Class.forName("org.osgi.framework.FrameworkUtil");
            final Method getBundle = frameworkUtil.getMethod("getBundle", Class.class);
            final Object bundle = getBundle.invoke(null, OrganisationOsgiServiceRegistrar.class);
            if (bundle == null) {
                return;
            }
            final Object context = bundle.getClass().getMethod("getBundleContext").invoke(bundle);
            if (context == null) {
                return;
            }
            register(context, OfficeReadPlatformService.class, officeRead.getIfAvailable());
            register(context, StaffReadService.class, staffRead.getIfAvailable());
            register(context, HolidayReadPlatformService.class, holidayRead.getIfAvailable());
            register(context, WorkingDaysReadPlatformService.class, workingDaysRead.getIfAvailable());
            register(context, ProvisioningCategoryReadPlatformService.class, categoryRead.getIfAvailable());
            register(context, ProvisioningCategoryWritePlatformService.class, categoryWrite.getIfAvailable());
            register(context, ProvisioningCriteriaReadPlatformService.class, criteriaRead.getIfAvailable());
            register(context, ProvisioningCriteriaWritePlatformService.class, criteriaWrite.getIfAvailable());
            LOG.info("Registered {} organisation OSGi service(s)", registrations.size());
        } catch (final ClassNotFoundException ex) {
            LOG.debug("OSGi framework classes not present; Spring-only organisation wiring");
        } catch (final ReflectiveOperationException ex) {
            LOG.warn("Failed to register organisation OSGi services: {}", ex.toString());
        }
    }

    private <T> void register(final Object context, final Class<T> type, final T service) throws ReflectiveOperationException {
        if (service == null) {
            return;
        }
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-organisation-impl");
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
