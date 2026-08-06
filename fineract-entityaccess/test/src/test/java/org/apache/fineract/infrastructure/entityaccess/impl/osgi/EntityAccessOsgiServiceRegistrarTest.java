package org.apache.fineract.infrastructure.entityaccess.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.infrastructure.entityaccess.service.FineractEntityAccessReadService;
import org.apache.fineract.infrastructure.entityaccess.service.FineractEntityAccessWriteService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class EntityAccessOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<FineractEntityAccessReadService> r = mock(ObjectProvider.class);
        ObjectProvider<FineractEntityAccessWriteService> w = mock(ObjectProvider.class);
        when(r.getIfAvailable()).thenReturn(null);
        when(w.getIfAvailable()).thenReturn(null);
        var reg = new EntityAccessOsgiServiceRegistrar(r, w);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
