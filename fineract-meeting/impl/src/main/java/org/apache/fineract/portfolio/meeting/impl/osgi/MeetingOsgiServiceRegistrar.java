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
package org.apache.fineract.portfolio.meeting.impl.osgi;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.portfolio.meeting.service.MeetingAttendanceDropdownReadService;
import org.apache.fineract.portfolio.meeting.service.MeetingAttendanceReadService;
import org.apache.fineract.portfolio.meeting.service.MeetingAttendanceWriteService;
import org.apache.fineract.portfolio.meeting.service.MeetingReadService;
import org.apache.fineract.portfolio.meeting.service.MeetingWriteService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Component;

/** Spring ↔ OSGi bridge for meeting ports. */
@Component
public class MeetingOsgiServiceRegistrar implements InitializingBean, DisposableBean {

    private static final Logger LOG = LoggerFactory.getLogger(MeetingOsgiServiceRegistrar.class);

    private final ObjectProvider<MeetingReadService> read;
    private final ObjectProvider<MeetingWriteService> write;
    private final ObjectProvider<MeetingAttendanceReadService> attendanceRead;
    private final ObjectProvider<MeetingAttendanceWriteService> attendanceWrite;
    private final ObjectProvider<MeetingAttendanceDropdownReadService> attendanceDropdown;
    private final List<Object> registrations = new ArrayList<>();

    public MeetingOsgiServiceRegistrar(final ObjectProvider<MeetingReadService> read, final ObjectProvider<MeetingWriteService> write,
            final ObjectProvider<MeetingAttendanceReadService> attendanceRead,
            final ObjectProvider<MeetingAttendanceWriteService> attendanceWrite,
            final ObjectProvider<MeetingAttendanceDropdownReadService> attendanceDropdown) {
        this.read = read;
        this.write = write;
        this.attendanceRead = attendanceRead;
        this.attendanceWrite = attendanceWrite;
        this.attendanceDropdown = attendanceDropdown;
    }

    @Override
    public void afterPropertiesSet() {
        try {
            final Class<?> frameworkUtil = Class.forName("org.osgi.framework.FrameworkUtil");
            final Method getBundle = frameworkUtil.getMethod("getBundle", Class.class);
            final Object bundle = getBundle.invoke(null, MeetingOsgiServiceRegistrar.class);
            if (bundle == null) {
                return;
            }
            final Object context = bundle.getClass().getMethod("getBundleContext").invoke(bundle);
            if (context == null) {
                return;
            }
            register(context, MeetingReadService.class, read.getIfAvailable());
            register(context, MeetingWriteService.class, write.getIfAvailable());
            register(context, MeetingAttendanceReadService.class, attendanceRead.getIfAvailable());
            register(context, MeetingAttendanceWriteService.class, attendanceWrite.getIfAvailable());
            register(context, MeetingAttendanceDropdownReadService.class, attendanceDropdown.getIfAvailable());
            LOG.info("Registered {} meeting OSGi service(s)", registrations.size());
        } catch (final ClassNotFoundException ex) {
            LOG.debug("OSGi framework classes not present; Spring-only meeting wiring");
        } catch (final ReflectiveOperationException ex) {
            LOG.warn("Failed to register meeting OSGi services: {}", ex.toString());
        }
    }

    private <T> void register(final Object context, final Class<T> type, final T service) throws ReflectiveOperationException {
        if (service == null) {
            return;
        }
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-meeting-impl");
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
