package org.apache.fineract.portfolio.fund.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.portfolio.fund.service.FundReadPlatformService;
import org.apache.fineract.portfolio.fund.service.FundWritePlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class FundOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<FundReadPlatformService> r = mock(ObjectProvider.class);
        ObjectProvider<FundWritePlatformService> w = mock(ObjectProvider.class);
        when(r.getIfAvailable()).thenReturn(null);
        when(w.getIfAvailable()).thenReturn(null);
        var reg = new FundOsgiServiceRegistrar(r, w);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
