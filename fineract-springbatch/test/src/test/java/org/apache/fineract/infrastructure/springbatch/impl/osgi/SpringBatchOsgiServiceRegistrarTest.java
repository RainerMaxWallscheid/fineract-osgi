package org.apache.fineract.infrastructure.springbatch.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.infrastructure.springbatch.PropertyService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class SpringBatchOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<PropertyService> p = mock(ObjectProvider.class);
        when(p.getIfAvailable()).thenReturn(null);
        var reg = new SpringBatchOsgiServiceRegistrar(p);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
