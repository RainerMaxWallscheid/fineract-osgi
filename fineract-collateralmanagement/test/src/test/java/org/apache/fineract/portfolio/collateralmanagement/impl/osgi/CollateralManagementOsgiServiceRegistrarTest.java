package org.apache.fineract.portfolio.collateralmanagement.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.portfolio.collateralmanagement.service.ClientCollateralManagementReadService;
import org.apache.fineract.portfolio.collateralmanagement.service.ClientCollateralManagementWriteService;
import org.apache.fineract.portfolio.collateralmanagement.service.CollateralManagementReadService;
import org.apache.fineract.portfolio.collateralmanagement.service.CollateralManagementWriteService;
import org.apache.fineract.portfolio.collateralmanagement.service.LoanCollateralManagementReadService;
import org.apache.fineract.portfolio.collateralmanagement.service.LoanCollateralManagementWriteService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class CollateralManagementOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<CollateralManagementReadService> pr = mock(ObjectProvider.class);
        ObjectProvider<CollateralManagementWriteService> pw = mock(ObjectProvider.class);
        ObjectProvider<ClientCollateralManagementReadService> cr = mock(ObjectProvider.class);
        ObjectProvider<ClientCollateralManagementWriteService> cw = mock(ObjectProvider.class);
        ObjectProvider<LoanCollateralManagementReadService> lr = mock(ObjectProvider.class);
        ObjectProvider<LoanCollateralManagementWriteService> lw = mock(ObjectProvider.class);
        when(pr.getIfAvailable()).thenReturn(null);
        when(pw.getIfAvailable()).thenReturn(null);
        when(cr.getIfAvailable()).thenReturn(null);
        when(cw.getIfAvailable()).thenReturn(null);
        when(lr.getIfAvailable()).thenReturn(null);
        when(lw.getIfAvailable()).thenReturn(null);
        var reg = new CollateralManagementOsgiServiceRegistrar(pr, pw, cr, cw, lr, lw);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
