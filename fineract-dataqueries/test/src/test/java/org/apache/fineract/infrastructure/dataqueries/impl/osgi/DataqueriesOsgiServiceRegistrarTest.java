package org.apache.fineract.infrastructure.dataqueries.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.infrastructure.dataqueries.service.DatatableReadService;
import org.apache.fineract.infrastructure.dataqueries.service.DatatableWriteService;
import org.apache.fineract.infrastructure.dataqueries.service.EntityDatatableChecksWritePlatformService;
import org.apache.fineract.infrastructure.dataqueries.service.GenericDataService;
import org.apache.fineract.infrastructure.dataqueries.service.ReadReportingService;
import org.apache.fineract.infrastructure.dataqueries.service.ReportWritePlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class DataqueriesOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<ReadReportingService> r = mock(ObjectProvider.class);
        ObjectProvider<ReportWritePlatformService> w = mock(ObjectProvider.class);
        ObjectProvider<DatatableReadService> dr = mock(ObjectProvider.class);
        ObjectProvider<DatatableWriteService> dw = mock(ObjectProvider.class);
        ObjectProvider<GenericDataService> g = mock(ObjectProvider.class);
        ObjectProvider<EntityDatatableChecksWritePlatformService> ew = mock(ObjectProvider.class);
        when(r.getIfAvailable()).thenReturn(null);
        when(w.getIfAvailable()).thenReturn(null);
        when(dr.getIfAvailable()).thenReturn(null);
        when(dw.getIfAvailable()).thenReturn(null);
        when(g.getIfAvailable()).thenReturn(null);
        when(ew.getIfAvailable()).thenReturn(null);
        var reg = new DataqueriesOsgiServiceRegistrar(r, w, dr, dw, g, ew);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
