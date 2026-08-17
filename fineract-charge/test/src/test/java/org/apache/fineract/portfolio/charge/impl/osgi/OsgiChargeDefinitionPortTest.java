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
package org.apache.fineract.portfolio.charge.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import org.apache.fineract.portfolio.charge.exception.ChargeNotFoundException;
import org.junit.jupiter.api.Test;

class OsgiChargeDefinitionPortTest {

    private final OsgiChargeDefinitionPort port = new OsgiChargeDefinitionPort();

    @Test
    void emptyCatalogHasNoActiveCharges() {
        assertFalse(port.existsActiveCharge(1L));
        assertTrue(port.findActiveCharge(1L).isEmpty());
        assertTrue(port.findCharge(1L).isEmpty());
    }

    @Test
    void getActiveChargeThrowsNotFound() {
        assertThrows(ChargeNotFoundException.class, () -> port.getActiveCharge(1L));
    }
}
