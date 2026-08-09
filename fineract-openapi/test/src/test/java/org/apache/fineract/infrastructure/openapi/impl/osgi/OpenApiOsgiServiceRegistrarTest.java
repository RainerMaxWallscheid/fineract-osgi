package org.apache.fineract.infrastructure.openapi.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

import org.junit.jupiter.api.Test;

class OpenApiOsgiServiceRegistrarTest {

    @Test
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        var reg = new OpenApiOsgiServiceRegistrar();
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
