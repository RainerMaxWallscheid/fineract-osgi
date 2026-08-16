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
package org.apache.fineract.portfolio.floatingrates.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.portfolio.floatingrates.moduleapi.FloatingRatePort;
import org.apache.fineract.portfolio.rate.service.RateReadService;
import org.apache.fineract.portfolio.rate.service.RateWriteService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class RatesOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<FloatingRatePort> floating = mock(ObjectProvider.class);
        ObjectProvider<RateReadService> read = mock(ObjectProvider.class);
        ObjectProvider<RateWriteService> write = mock(ObjectProvider.class);
        when(floating.getIfAvailable()).thenReturn(null);
        when(read.getIfAvailable()).thenReturn(null);
        when(write.getIfAvailable()).thenReturn(null);
        var reg = new RatesOsgiServiceRegistrar(floating, read, write);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
