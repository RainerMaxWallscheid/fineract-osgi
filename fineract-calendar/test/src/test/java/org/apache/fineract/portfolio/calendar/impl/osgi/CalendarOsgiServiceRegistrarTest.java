package org.apache.fineract.portfolio.calendar.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.portfolio.calendar.service.CalendarDropdownReadPlatformService;
import org.apache.fineract.portfolio.calendar.service.CalendarReadPlatformService;
import org.apache.fineract.portfolio.calendar.service.CalendarWritePlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class CalendarOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<CalendarReadPlatformService> r = mock(ObjectProvider.class);
        ObjectProvider<CalendarWritePlatformService> w = mock(ObjectProvider.class);
        ObjectProvider<CalendarDropdownReadPlatformService> d = mock(ObjectProvider.class);
        when(r.getIfAvailable()).thenReturn(null);
        when(w.getIfAvailable()).thenReturn(null);
        when(d.getIfAvailable()).thenReturn(null);
        var reg = new CalendarOsgiServiceRegistrar(r, w, d);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
