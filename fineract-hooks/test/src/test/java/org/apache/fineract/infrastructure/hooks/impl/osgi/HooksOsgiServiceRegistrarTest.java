package org.apache.fineract.infrastructure.hooks.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.infrastructure.hooks.service.HookReadPlatformService;
import org.apache.fineract.infrastructure.hooks.service.HookWritePlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class HooksOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<HookReadPlatformService> r = mock(ObjectProvider.class);
        ObjectProvider<HookWritePlatformService> w = mock(ObjectProvider.class);
        when(r.getIfAvailable()).thenReturn(null);
        when(w.getIfAvailable()).thenReturn(null);
        var reg = new HooksOsgiServiceRegistrar(r, w);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
