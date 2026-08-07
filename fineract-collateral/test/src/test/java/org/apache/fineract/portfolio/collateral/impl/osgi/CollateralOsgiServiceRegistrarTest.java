package org.apache.fineract.portfolio.collateral.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.portfolio.collateral.service.CollateralReadPlatformService;
import org.apache.fineract.portfolio.collateral.service.CollateralWritePlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class CollateralOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<CollateralReadPlatformService> r = mock(ObjectProvider.class);
        ObjectProvider<CollateralWritePlatformService> w = mock(ObjectProvider.class);
        when(r.getIfAvailable()).thenReturn(null);
        when(w.getIfAvailable()).thenReturn(null);
        var reg = new CollateralOsgiServiceRegistrar(r, w);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
