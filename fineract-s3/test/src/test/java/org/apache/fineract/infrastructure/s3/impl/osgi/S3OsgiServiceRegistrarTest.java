package org.apache.fineract.infrastructure.s3.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.infrastructure.s3.S3ClientCustomizer;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class S3OsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<S3ClientCustomizer> p = mock(ObjectProvider.class);
        when(p.getIfAvailable()).thenReturn(null);
        var reg = new S3OsgiServiceRegistrar(p);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
