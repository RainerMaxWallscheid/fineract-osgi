package org.apache.fineract.infrastructure.jobs.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.infrastructure.jobs.service.SchedulerJobRunnerReadService;
import org.apache.fineract.infrastructure.jobs.service.StuckJobExecutorService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class JobsOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<SchedulerJobRunnerReadService> r = mock(ObjectProvider.class);
        ObjectProvider<StuckJobExecutorService> s = mock(ObjectProvider.class);
        when(r.getIfAvailable()).thenReturn(null);
        when(s.getIfAvailable()).thenReturn(null);
        var reg = new JobsOsgiServiceRegistrar(r, s);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
