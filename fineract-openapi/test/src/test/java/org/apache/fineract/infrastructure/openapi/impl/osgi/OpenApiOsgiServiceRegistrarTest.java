package org.apache.fineract.infrastructure.openapi.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.infrastructure.openapi.moduleapi.OpenApiPort;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class OpenApiOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<OpenApiPort> p = mock(ObjectProvider.class);
        when(p.getIfAvailable()).thenReturn(null);
        var reg = new OpenApiOsgiServiceRegistrar(p);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
