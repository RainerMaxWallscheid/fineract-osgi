package org.apache.fineract.infrastructure.s3.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import java.util.List;
import org.apache.fineract.infrastructure.s3.S3ClientCustomizer;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;
import software.amazon.awssdk.services.s3.S3Client;

class S3OsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<S3Client> c = mock(ObjectProvider.class);
        ObjectProvider<List<S3ClientCustomizer>> customizers = mock(ObjectProvider.class);
        when(c.getIfAvailable()).thenReturn(null);
        when(customizers.getIfAvailable()).thenReturn(null);
        var reg = new S3OsgiServiceRegistrar(c, customizers);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
