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
package org.apache.fineract.infrastructure.bulkimport.impl.osgi;

import org.osgi.framework.BundleActivator;
import org.osgi.framework.BundleContext;

/**
 * Equinox start path for bulkimport (ADR-022 B3). No api port is registered:
 * workbook/populator/handler signatures load jersey multipart, jakarta.ws.rs, or
 * Apache POI, none of which have a staged Equinox BSN.
 * {@link BulkImportOsgiServiceRegistrar} remains the Spring Boot path.
 */
public class BulkImportOsgiBundleActivator implements BundleActivator {

    @Override
    public void start(final BundleContext context) {
        // no Equinox-safe api port
    }

    @Override
    public void stop(final BundleContext context) {
        // no registrations
    }
}
