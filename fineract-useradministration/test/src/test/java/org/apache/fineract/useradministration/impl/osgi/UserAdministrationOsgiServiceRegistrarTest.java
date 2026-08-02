package org.apache.fineract.useradministration.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.useradministration.service.AppUserReadPlatformService;
import org.apache.fineract.useradministration.service.AppUserWritePlatformService;
import org.apache.fineract.useradministration.service.PermissionReadPlatformService;
import org.apache.fineract.useradministration.service.RoleReadPlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class UserAdministrationOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<AppUserReadPlatformService> ur = mock(ObjectProvider.class);
        ObjectProvider<AppUserWritePlatformService> uw = mock(ObjectProvider.class);
        ObjectProvider<RoleReadPlatformService> rr = mock(ObjectProvider.class);
        ObjectProvider<PermissionReadPlatformService> pr = mock(ObjectProvider.class);
        when(ur.getIfAvailable()).thenReturn(null);
        when(uw.getIfAvailable()).thenReturn(null);
        when(rr.getIfAvailable()).thenReturn(null);
        when(pr.getIfAvailable()).thenReturn(null);
        var r = new UserAdministrationOsgiServiceRegistrar(ur, uw, rr, pr);
        assertDoesNotThrow(r::afterPropertiesSet);
        assertDoesNotThrow(r::destroy);
    }
}
