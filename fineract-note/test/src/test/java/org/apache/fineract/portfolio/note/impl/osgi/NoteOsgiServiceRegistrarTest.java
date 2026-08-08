package org.apache.fineract.portfolio.note.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.portfolio.note.service.NoteReadPlatformService;
import org.apache.fineract.portfolio.note.service.NoteWritePlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class NoteOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<NoteReadPlatformService> r = mock(ObjectProvider.class);
        ObjectProvider<NoteWritePlatformService> w = mock(ObjectProvider.class);
        when(r.getIfAvailable()).thenReturn(null);
        when(w.getIfAvailable()).thenReturn(null);
        var reg = new NoteOsgiServiceRegistrar(r, w);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
