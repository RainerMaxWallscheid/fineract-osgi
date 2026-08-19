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

import org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionPort;
import org.apache.fineract.portfolio.floatingrates.moduleapi.FloatingRatePort;
import org.apache.fineract.portfolio.tax.moduleapi.TaxCatalogPort;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Boot composition-root Equinox embed (ADR-022 B3). Off unless
 * {@code fineract.osgi.enabled=true}.
 */
@Configuration
@ConditionalOnProperty(name = "fineract.osgi.enabled", havingValue = "true")
public class EquinoxOsgiConfiguration {

    @Bean
    public SpringOsgiPortBridge springOsgiPortBridge(final ObjectProvider<ChargeDefinitionPort> charge,
            final ObjectProvider<FloatingRatePort> rates, final ObjectProvider<TaxCatalogPort> tax) {
        return new SpringOsgiPortBridge(charge.getIfAvailable(), rates.getIfAvailable(), tax.getIfAvailable());
    }

    @Bean
    public EquinoxFrameworkLifecycle equinoxFrameworkLifecycle(final SpringOsgiPortBridge bridge) {
        return new EquinoxFrameworkLifecycle(bridge);
    }
}
