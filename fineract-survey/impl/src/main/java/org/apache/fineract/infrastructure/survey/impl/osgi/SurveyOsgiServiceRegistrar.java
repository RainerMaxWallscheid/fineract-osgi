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
package org.apache.fineract.infrastructure.survey.impl.osgi;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import org.apache.fineract.infrastructure.survey.service.PovertyLineService;
import org.apache.fineract.infrastructure.survey.service.ReadLikelihoodService;
import org.apache.fineract.infrastructure.survey.service.ReadSurveyService;
import org.apache.fineract.infrastructure.survey.service.WriteLikelihoodService;
import org.apache.fineract.infrastructure.survey.service.WriteSurveyService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Component;

/** Spring ↔ OSGi bridge for survey (PPI) ports. */
@Component
public class SurveyOsgiServiceRegistrar implements InitializingBean, DisposableBean {

    private static final Logger LOG = LoggerFactory.getLogger(SurveyOsgiServiceRegistrar.class);

    private final ObjectProvider<ReadSurveyService> readSurvey;
    private final ObjectProvider<WriteSurveyService> writeSurvey;
    private final ObjectProvider<ReadLikelihoodService> readLikelihood;
    private final ObjectProvider<WriteLikelihoodService> writeLikelihood;
    private final ObjectProvider<PovertyLineService> povertyLine;
    private final List<Object> registrations = new ArrayList<>();

    public SurveyOsgiServiceRegistrar(final ObjectProvider<ReadSurveyService> readSurvey,
            final ObjectProvider<WriteSurveyService> writeSurvey, final ObjectProvider<ReadLikelihoodService> readLikelihood,
            final ObjectProvider<WriteLikelihoodService> writeLikelihood, final ObjectProvider<PovertyLineService> povertyLine) {
        this.readSurvey = readSurvey;
        this.writeSurvey = writeSurvey;
        this.readLikelihood = readLikelihood;
        this.writeLikelihood = writeLikelihood;
        this.povertyLine = povertyLine;
    }

    @Override
    public void afterPropertiesSet() {
        try {
            final Class<?> frameworkUtil = Class.forName("org.osgi.framework.FrameworkUtil");
            final Method getBundle = frameworkUtil.getMethod("getBundle", Class.class);
            final Object bundle = getBundle.invoke(null, SurveyOsgiServiceRegistrar.class);
            if (bundle == null) {
                return;
            }
            final Object context = bundle.getClass().getMethod("getBundleContext").invoke(bundle);
            if (context == null) {
                return;
            }
            register(context, ReadSurveyService.class, readSurvey.getIfAvailable());
            register(context, WriteSurveyService.class, writeSurvey.getIfAvailable());
            register(context, ReadLikelihoodService.class, readLikelihood.getIfAvailable());
            register(context, WriteLikelihoodService.class, writeLikelihood.getIfAvailable());
            register(context, PovertyLineService.class, povertyLine.getIfAvailable());
            LOG.info("Registered {} survey OSGi service(s)", registrations.size());
        } catch (final ClassNotFoundException ex) {
            LOG.debug("OSGi framework classes not present; Spring-only survey wiring");
        } catch (final ReflectiveOperationException ex) {
            LOG.warn("Failed to register survey OSGi services: {}", ex.toString());
        }
    }

    private <T> void register(final Object context, final Class<T> type, final T service) throws ReflectiveOperationException {
        if (service == null) {
            return;
        }
        final Dictionary<String, Object> props = new Hashtable<>();
        props.put("provider", "fineract-survey-impl");
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
