package org.apache.fineract.notification.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.notification.eventandlistener.NotificationEventPublisher;
import org.apache.fineract.notification.service.NotificationReadPlatformService;
import org.apache.fineract.notification.service.NotificationWritePlatformService;
import org.apache.fineract.notification.service.UserNotificationService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class NotificationOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<UserNotificationService> u = mock(ObjectProvider.class);
        ObjectProvider<NotificationReadPlatformService> r = mock(ObjectProvider.class);
        ObjectProvider<NotificationWritePlatformService> w = mock(ObjectProvider.class);
        ObjectProvider<NotificationEventPublisher> p = mock(ObjectProvider.class);
        when(u.getIfAvailable()).thenReturn(null);
        when(r.getIfAvailable()).thenReturn(null);
        when(w.getIfAvailable()).thenReturn(null);
        when(p.getIfAvailable()).thenReturn(null);
        var reg = new NotificationOsgiServiceRegistrar(u, r, w, p);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
