package org.apache.fineract.infrastructure.instancemode.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.infrastructure.instancemode.moduleapi.InstanceModePort;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class InstanceModeOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<InstanceModePort> p = mock(ObjectProvider.class);
        when(p.getIfAvailable()).thenReturn(null);
        var reg = new InstanceModeOsgiServiceRegistrar(p);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
