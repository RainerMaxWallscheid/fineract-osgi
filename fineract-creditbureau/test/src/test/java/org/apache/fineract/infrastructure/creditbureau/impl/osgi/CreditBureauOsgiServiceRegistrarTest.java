package org.apache.fineract.infrastructure.creditbureau.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.infrastructure.creditbureau.service.CreditBureauLoanProductMappingReadPlatformService;
import org.apache.fineract.infrastructure.creditbureau.service.CreditBureauReadPlatformService;
import org.apache.fineract.infrastructure.creditbureau.service.CreditReportReadPlatformService;
import org.apache.fineract.infrastructure.creditbureau.service.OrganisationCreditBureauReadPlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class CreditBureauOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<CreditBureauReadPlatformService> r = mock(ObjectProvider.class);
        ObjectProvider<CreditBureauLoanProductMappingReadPlatformService> m = mock(ObjectProvider.class);
        ObjectProvider<OrganisationCreditBureauReadPlatformService> o = mock(ObjectProvider.class);
        ObjectProvider<CreditReportReadPlatformService> rep = mock(ObjectProvider.class);
        when(r.getIfAvailable()).thenReturn(null);
        when(m.getIfAvailable()).thenReturn(null);
        when(o.getIfAvailable()).thenReturn(null);
        when(rep.getIfAvailable()).thenReturn(null);
        var reg = new CreditBureauOsgiServiceRegistrar(r, m, o, rep);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
