package org.apache.fineract.infrastructure.configuration.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.infrastructure.configuration.domain.ConfigurationDomainService;
import org.apache.fineract.infrastructure.configuration.service.ConfigurationReadPlatformService;
import org.apache.fineract.infrastructure.configuration.service.ExternalServiceWritePlatformService;
import org.apache.fineract.infrastructure.configuration.service.ExternalServicesPropertiesReadPlatformService;
import org.apache.fineract.infrastructure.configuration.service.ExternalServicesReadPlatformService;
import org.apache.fineract.infrastructure.configuration.service.GlobalConfigurationWritePlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class ConfigurationOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<ConfigurationDomainService> domain = mock(ObjectProvider.class);
        ObjectProvider<ConfigurationReadPlatformService> read = mock(ObjectProvider.class);
        ObjectProvider<GlobalConfigurationWritePlatformService> globalWrite = mock(ObjectProvider.class);
        ObjectProvider<ExternalServicesPropertiesReadPlatformService> externalPropsRead = mock(ObjectProvider.class);
        ObjectProvider<ExternalServicesReadPlatformService> externalRead = mock(ObjectProvider.class);
        ObjectProvider<ExternalServiceWritePlatformService> externalWrite = mock(ObjectProvider.class);
        when(domain.getIfAvailable()).thenReturn(null);
        when(read.getIfAvailable()).thenReturn(null);
        when(globalWrite.getIfAvailable()).thenReturn(null);
        when(externalPropsRead.getIfAvailable()).thenReturn(null);
        when(externalRead.getIfAvailable()).thenReturn(null);
        when(externalWrite.getIfAvailable()).thenReturn(null);
        var reg = new ConfigurationOsgiServiceRegistrar(domain, read, globalWrite, externalPropsRead, externalRead, externalWrite);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
