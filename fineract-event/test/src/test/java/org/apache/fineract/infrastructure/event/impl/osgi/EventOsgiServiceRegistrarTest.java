package org.apache.fineract.infrastructure.event.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.infrastructure.event.business.moduleapi.PortfolioNotificationEventPort;
import org.apache.fineract.infrastructure.event.business.moduleapi.SmsCampaignTriggerEventPort;
import org.apache.fineract.infrastructure.event.external.producer.ExternalEventProducer;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class EventOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<ExternalEventProducer> p = mock(ObjectProvider.class);
        ObjectProvider<PortfolioNotificationEventPort> notifications = mock(ObjectProvider.class);
        ObjectProvider<SmsCampaignTriggerEventPort> smsCampaigns = mock(ObjectProvider.class);
        when(p.getIfAvailable()).thenReturn(null);
        when(notifications.getIfAvailable()).thenReturn(null);
        when(smsCampaigns.getIfAvailable()).thenReturn(null);
        var reg = new EventOsgiServiceRegistrar(p, notifications, smsCampaigns);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
