package org.apache.fineract.infrastructure.survey.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.infrastructure.survey.service.PovertyLineService;
import org.apache.fineract.infrastructure.survey.service.ReadLikelihoodService;
import org.apache.fineract.infrastructure.survey.service.ReadSurveyService;
import org.apache.fineract.infrastructure.survey.service.WriteLikelihoodService;
import org.apache.fineract.infrastructure.survey.service.WriteSurveyService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class SurveyOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<ReadSurveyService> rs = mock(ObjectProvider.class);
        ObjectProvider<WriteSurveyService> ws = mock(ObjectProvider.class);
        ObjectProvider<ReadLikelihoodService> rl = mock(ObjectProvider.class);
        ObjectProvider<WriteLikelihoodService> wl = mock(ObjectProvider.class);
        ObjectProvider<PovertyLineService> pl = mock(ObjectProvider.class);
        when(rs.getIfAvailable()).thenReturn(null);
        when(ws.getIfAvailable()).thenReturn(null);
        when(rl.getIfAvailable()).thenReturn(null);
        when(wl.getIfAvailable()).thenReturn(null);
        when(pl.getIfAvailable()).thenReturn(null);
        var reg = new SurveyOsgiServiceRegistrar(rs, ws, rl, wl, pl);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
