package org.apache.fineract.infrastructure.gcm.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.infrastructure.gcm.service.NotificationConfigurationReadService;
import org.apache.fineract.infrastructure.gcm.service.NotificationSenderService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class GcmOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<NotificationConfigurationReadService> c = mock(ObjectProvider.class);
        ObjectProvider<NotificationSenderService> s = mock(ObjectProvider.class);
        when(c.getIfAvailable()).thenReturn(null);
        when(s.getIfAvailable()).thenReturn(null);
        var reg = new GcmOsgiServiceRegistrar(c, s);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
