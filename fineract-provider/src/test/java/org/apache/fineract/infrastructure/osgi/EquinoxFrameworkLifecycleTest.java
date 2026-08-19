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
package org.apache.fineract.infrastructure.osgi;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertTrue;
import java.util.Optional;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionData;
import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionPort;
import org.junit.jupiter.api.Test;
import org.osgi.framework.BundleContext;
import org.osgi.framework.Constants;
import org.osgi.framework.ServiceReference;

class EquinoxFrameworkLifecycleTest {

    @Test
    void registersWave1ChargePortAndUnbindsOnStop() {
        final ChargeDefinitionPort charge = new StubChargeDefinitionPort();
        final SpringOsgiPortBridge bridge = new SpringOsgiPortBridge(charge, null, null);
        final EquinoxFrameworkLifecycle lifecycle = new EquinoxFrameworkLifecycle(bridge);

        lifecycle.start();
        try {
            assertTrue(lifecycle.isRunning());
            final BundleContext ctx = lifecycle.getBundleContext();
            final ServiceReference<ChargeDefinitionPort> selected = ctx.getServiceReference(ChargeDefinitionPort.class);
            assertEquals(SpringOsgiPortBridge.PROVIDER, selected.getProperty("provider"));
            assertEquals(SpringOsgiPortBridge.RANKING, selected.getProperty(Constants.SERVICE_RANKING));
            assertSame(charge, ctx.getService(selected));
            ctx.ungetService(selected);
        } finally {
            lifecycle.stop();
        }
        assertFalse(lifecycle.isRunning());
    }

    private static final class StubChargeDefinitionPort implements ChargeDefinitionPort {

        @Override
        public boolean existsActiveCharge(final Long chargeId) {
            return false;
        }

        @Override
        public Optional<ChargeDefinitionData> findActiveCharge(final Long chargeId) {
            return Optional.empty();
        }

        @Override
        public Optional<ChargeDefinitionData> findCharge(final Long chargeId) {
            return Optional.empty();
        }

        @Override
        public ChargeDefinitionData getActiveCharge(final Long chargeId) {
            return null;
        }
    }
}
