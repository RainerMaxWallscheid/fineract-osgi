package org.apache.fineract.infrastructure.instancemode.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

import org.junit.jupiter.api.Test;

class InstanceModeOsgiServiceRegistrarTest {

    @Test
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        var reg = new InstanceModeOsgiServiceRegistrar();
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
