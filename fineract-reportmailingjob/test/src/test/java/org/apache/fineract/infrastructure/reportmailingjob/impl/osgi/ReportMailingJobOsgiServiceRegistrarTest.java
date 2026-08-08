package org.apache.fineract.infrastructure.reportmailingjob.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.infrastructure.reportmailingjob.service.ReportMailingJobConfigurationReadPlatformService;
import org.apache.fineract.infrastructure.reportmailingjob.service.ReportMailingJobEmailService;
import org.apache.fineract.infrastructure.reportmailingjob.service.ReportMailingJobReadPlatformService;
import org.apache.fineract.infrastructure.reportmailingjob.service.ReportMailingJobRunHistoryReadPlatformService;
import org.apache.fineract.infrastructure.reportmailingjob.service.ReportMailingJobWritePlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class ReportMailingJobOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<ReportMailingJobReadPlatformService> r = mock(ObjectProvider.class);
        ObjectProvider<ReportMailingJobWritePlatformService> w = mock(ObjectProvider.class);
        ObjectProvider<ReportMailingJobRunHistoryReadPlatformService> h = mock(ObjectProvider.class);
        ObjectProvider<ReportMailingJobConfigurationReadPlatformService> c = mock(ObjectProvider.class);
        ObjectProvider<ReportMailingJobEmailService> e = mock(ObjectProvider.class);
        when(r.getIfAvailable()).thenReturn(null);
        when(w.getIfAvailable()).thenReturn(null);
        when(h.getIfAvailable()).thenReturn(null);
        when(c.getIfAvailable()).thenReturn(null);
        when(e.getIfAvailable()).thenReturn(null);
        var reg = new ReportMailingJobOsgiServiceRegistrar(r, w, h, c, e);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
