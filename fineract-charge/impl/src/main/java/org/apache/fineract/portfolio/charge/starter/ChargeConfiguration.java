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
package org.apache.fineract.portfolio.charge.starter;

import org.apache.fineract.accounting.glaccount.domain.GLAccountRepositoryWrapper;
import org.apache.fineract.infrastructure.configuration.domain.ConfigurationDomainService;
import org.apache.fineract.infrastructure.security.service.PlatformSecurityContext;
import org.apache.fineract.organisation.monetary.service.CurrencyReadPlatformService;
import org.apache.fineract.portfolio.charge.domain.ChargeRepository;
import org.apache.fineract.portfolio.charge.serialization.ChargeDefinitionCommandFromApiJsonDeserializer;
import org.apache.fineract.portfolio.charge.service.ChargeAccountingDropdownPort;
import org.apache.fineract.portfolio.charge.service.ChargeDropdownReadPlatformService;
import org.apache.fineract.portfolio.charge.service.ChargeDropdownReadPlatformServiceImpl;
import org.apache.fineract.portfolio.charge.service.ChargeOfficeAccessPort;
import org.apache.fineract.portfolio.charge.service.ChargeReadPlatformService;
import org.apache.fineract.portfolio.charge.service.ChargeReadPlatformServiceImpl;
import org.apache.fineract.portfolio.charge.service.ChargeWritePlatformService;
import org.apache.fineract.portfolio.charge.service.ChargeWritePlatformServiceJpaRepositoryImpl;
import org.apache.fineract.portfolio.paymenttype.domain.PaymentTypeRepository;
import org.apache.fineract.portfolio.tax.domain.TaxGroupRepositoryWrapper;
import org.apache.fineract.portfolio.tax.service.TaxReadPlatformService;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;

/**
 * Spring wiring for charge catalog services. Also scans the OSGi registrar package so
 * {@link org.apache.fineract.portfolio.charge.impl.osgi.ChargeOsgiServiceRegistrar} is active
 * when this configuration is imported without a broad package scan.
 */
@Configuration
@ComponentScan("org.apache.fineract.portfolio.charge.impl.osgi")
public class ChargeConfiguration {

    @Bean
    @ConditionalOnMissingBean(ChargeDropdownReadPlatformService.class)
    public ChargeDropdownReadPlatformService chargeDropdownReadPlatformService() {
        return new ChargeDropdownReadPlatformServiceImpl();
    }

    @Bean
    @ConditionalOnMissingBean(ChargeReadPlatformService.class)
    public ChargeReadPlatformService chargeReadPlatformService(CurrencyReadPlatformService currencyReadPlatformService,
            ChargeDropdownReadPlatformService chargeDropdownReadPlatformService, JdbcTemplate jdbcTemplate,
            ChargeOfficeAccessPort chargeOfficeAccessPort, ChargeAccountingDropdownPort chargeAccountingDropdownPort,
            TaxReadPlatformService taxReadPlatformService, ConfigurationDomainService configurationDomainService,
            NamedParameterJdbcTemplate namedParameterJdbcTemplate) {
        return new ChargeReadPlatformServiceImpl(currencyReadPlatformService, chargeDropdownReadPlatformService, jdbcTemplate,
                chargeOfficeAccessPort, chargeAccountingDropdownPort, taxReadPlatformService, configurationDomainService,
                namedParameterJdbcTemplate);
    }

    @Bean
    @ConditionalOnMissingBean(ChargeWritePlatformService.class)
    public ChargeWritePlatformService chargeWritePlatformService(PlatformSecurityContext context,
            ChargeDefinitionCommandFromApiJsonDeserializer fromApiJsonDeserializer, ChargeRepository chargeRepository,
            JdbcTemplate jdbcTemplate, ChargeOfficeAccessPort chargeOfficeAccessPort, GLAccountRepositoryWrapper glAccountRepository,
            TaxGroupRepositoryWrapper taxGroupRepository, PaymentTypeRepository paymentTypeRepository) {
        return new ChargeWritePlatformServiceJpaRepositoryImpl(context, fromApiJsonDeserializer, chargeRepository, jdbcTemplate,
                chargeOfficeAccessPort, glAccountRepository, taxGroupRepository, paymentTypeRepository);
    }
}
