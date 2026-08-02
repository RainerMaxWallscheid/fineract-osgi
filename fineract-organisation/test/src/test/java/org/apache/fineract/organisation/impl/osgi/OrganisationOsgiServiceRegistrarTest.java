package org.apache.fineract.organisation.impl.osgi;
import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import org.apache.fineract.organisation.office.service.OfficeReadPlatformService;
import org.apache.fineract.organisation.staff.service.StaffReadService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;
class OrganisationOsgiServiceRegistrarTest {
  @Test void afterPropertiesSet_withoutOsgi_doesNotThrow() {
    ObjectProvider<OfficeReadPlatformService> o = mock(ObjectProvider.class);
    ObjectProvider<StaffReadService> s = mock(ObjectProvider.class);
    when(o.getIfAvailable()).thenReturn(null); when(s.getIfAvailable()).thenReturn(null);
    var r = new OrganisationOsgiServiceRegistrar(o, s);
    assertDoesNotThrow(r::afterPropertiesSet); assertDoesNotThrow(r::destroy);
  }
}
