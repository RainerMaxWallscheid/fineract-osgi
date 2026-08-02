package org.apache.fineract.organisation.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.organisation.holiday.service.HolidayReadPlatformService;
import org.apache.fineract.organisation.office.service.OfficeReadPlatformService;
import org.apache.fineract.organisation.provisioning.service.ProvisioningCategoryReadPlatformService;
import org.apache.fineract.organisation.provisioning.service.ProvisioningCategoryWritePlatformService;
import org.apache.fineract.organisation.provisioning.service.ProvisioningCriteriaReadPlatformService;
import org.apache.fineract.organisation.provisioning.service.ProvisioningCriteriaWritePlatformService;
import org.apache.fineract.organisation.staff.service.StaffReadService;
import org.apache.fineract.organisation.workingdays.service.WorkingDaysReadPlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class OrganisationOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<OfficeReadPlatformService> o = mock(ObjectProvider.class);
        ObjectProvider<StaffReadService> s = mock(ObjectProvider.class);
        ObjectProvider<HolidayReadPlatformService> h = mock(ObjectProvider.class);
        ObjectProvider<WorkingDaysReadPlatformService> w = mock(ObjectProvider.class);
        ObjectProvider<ProvisioningCategoryReadPlatformService> cr = mock(ObjectProvider.class);
        ObjectProvider<ProvisioningCategoryWritePlatformService> cw = mock(ObjectProvider.class);
        ObjectProvider<ProvisioningCriteriaReadPlatformService> pr = mock(ObjectProvider.class);
        ObjectProvider<ProvisioningCriteriaWritePlatformService> pw = mock(ObjectProvider.class);
        when(o.getIfAvailable()).thenReturn(null);
        when(s.getIfAvailable()).thenReturn(null);
        when(h.getIfAvailable()).thenReturn(null);
        when(w.getIfAvailable()).thenReturn(null);
        when(cr.getIfAvailable()).thenReturn(null);
        when(cw.getIfAvailable()).thenReturn(null);
        when(pr.getIfAvailable()).thenReturn(null);
        when(pw.getIfAvailable()).thenReturn(null);
        var r = new OrganisationOsgiServiceRegistrar(o, s, h, w, cr, cw, pr, pw);
        assertDoesNotThrow(r::afterPropertiesSet);
        assertDoesNotThrow(r::destroy);
    }
}
