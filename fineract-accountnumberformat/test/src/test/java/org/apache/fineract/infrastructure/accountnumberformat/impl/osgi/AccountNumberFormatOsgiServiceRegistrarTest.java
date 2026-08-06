package org.apache.fineract.infrastructure.accountnumberformat.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.infrastructure.accountnumberformat.service.AccountNumberFormatReadPlatformService;
import org.apache.fineract.infrastructure.accountnumberformat.service.AccountNumberFormatWritePlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class AccountNumberFormatOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<AccountNumberFormatReadPlatformService> r = mock(ObjectProvider.class);
        ObjectProvider<AccountNumberFormatWritePlatformService> w = mock(ObjectProvider.class);
        when(r.getIfAvailable()).thenReturn(null);
        when(w.getIfAvailable()).thenReturn(null);
        var reg = new AccountNumberFormatOsgiServiceRegistrar(r, w);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
