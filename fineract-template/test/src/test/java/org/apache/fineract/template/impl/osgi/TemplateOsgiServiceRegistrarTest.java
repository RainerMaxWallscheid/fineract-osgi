package org.apache.fineract.template.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.template.service.TemplateDomainService;
import org.apache.fineract.template.service.TemplateMergeService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class TemplateOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<TemplateDomainService> d = mock(ObjectProvider.class);
        ObjectProvider<TemplateMergeService> m = mock(ObjectProvider.class);
        when(d.getIfAvailable()).thenReturn(null);
        when(m.getIfAvailable()).thenReturn(null);
        var r = new TemplateOsgiServiceRegistrar(d, m);
        assertDoesNotThrow(r::afterPropertiesSet);
        assertDoesNotThrow(r::destroy);
    }
}
