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
package org.apache.fineract.infrastructure.openapi.impl.osgi;

import java.lang.reflect.Method;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Component;

/**
 * Spring ↔ OSGi bridge for openapi peel.
 * <p>
 * Reader/filter classes are pure utilities on the api jar (used by swagger-gradle-plugin
 * via fully-qualified class names). No application service ports are registered.
 */
@Component
public class OpenApiOsgiServiceRegistrar implements InitializingBean, DisposableBean {

    private static final Logger LOG = LoggerFactory.getLogger(OpenApiOsgiServiceRegistrar.class);

    @Override
    public void afterPropertiesSet() {
        try {
            final Class<?> frameworkUtil = Class.forName("org.osgi.framework.FrameworkUtil");
            final Method getBundle = frameworkUtil.getMethod("getBundle", Class.class);
            final Object bundle = getBundle.invoke(null, OpenApiOsgiServiceRegistrar.class);
            if (bundle == null) {
                return;
            }
            final Object context = bundle.getClass().getMethod("getBundleContext").invoke(bundle);
            if (context == null) {
                return;
            }
            LOG.info("OpenAPI OSGi bundle context present (no service ports to register)");
        } catch (final ClassNotFoundException ex) {
            LOG.debug("OSGi framework classes not present; Spring-only OpenAPI wiring");
        } catch (final ReflectiveOperationException ex) {
            LOG.warn("Failed to probe OpenAPI OSGi environment: {}", ex.toString());
        }
    }

    @Override
    public void destroy() {
        // no registrations
    }
}
