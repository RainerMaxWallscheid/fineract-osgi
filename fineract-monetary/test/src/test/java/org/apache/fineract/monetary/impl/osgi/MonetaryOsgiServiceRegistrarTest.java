package org.apache.fineract.monetary.impl.osgi;
import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import org.apache.fineract.organisation.monetary.service.CurrencyReadPlatformService;
import org.apache.fineract.organisation.monetary.service.CurrencyWritePlatformService;
import org.apache.fineract.organisation.monetary.service.OrganisationCurrencyReadPlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;
class MonetaryOsgiServiceRegistrarTest {
  @Test void afterPropertiesSet_withoutOsgi_doesNotThrow() {
    ObjectProvider<CurrencyReadPlatformService> a = mock(ObjectProvider.class);
    ObjectProvider<CurrencyWritePlatformService> b = mock(ObjectProvider.class);
    ObjectProvider<OrganisationCurrencyReadPlatformService> c = mock(ObjectProvider.class);
    when(a.getIfAvailable()).thenReturn(null); when(b.getIfAvailable()).thenReturn(null); when(c.getIfAvailable()).thenReturn(null);
    var r = new MonetaryOsgiServiceRegistrar(a, b, c);
    assertDoesNotThrow(r::afterPropertiesSet); assertDoesNotThrow(r::destroy);
  }
}
