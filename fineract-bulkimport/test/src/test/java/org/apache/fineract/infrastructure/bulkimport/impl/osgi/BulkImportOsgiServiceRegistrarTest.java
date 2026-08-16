package org.apache.fineract.infrastructure.bulkimport.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.infrastructure.bulkimport.service.BulkImportWorkbookPopulatorService;
import org.apache.fineract.infrastructure.bulkimport.service.BulkImportWorkbookService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class BulkImportOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<BulkImportWorkbookService> w = mock(ObjectProvider.class);
        ObjectProvider<BulkImportWorkbookPopulatorService> p = mock(ObjectProvider.class);
        when(w.getIfAvailable()).thenReturn(null);
        when(p.getIfAvailable()).thenReturn(null);
        var reg = new BulkImportOsgiServiceRegistrar(w, p);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
