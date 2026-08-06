package org.apache.fineract.portfolio.meeting.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.portfolio.meeting.service.MeetingAttendanceDropdownReadService;
import org.apache.fineract.portfolio.meeting.service.MeetingAttendanceReadService;
import org.apache.fineract.portfolio.meeting.service.MeetingAttendanceWriteService;
import org.apache.fineract.portfolio.meeting.service.MeetingReadService;
import org.apache.fineract.portfolio.meeting.service.MeetingWriteService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class MeetingOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<MeetingReadService> r = mock(ObjectProvider.class);
        ObjectProvider<MeetingWriteService> w = mock(ObjectProvider.class);
        ObjectProvider<MeetingAttendanceReadService> ar = mock(ObjectProvider.class);
        ObjectProvider<MeetingAttendanceWriteService> aw = mock(ObjectProvider.class);
        ObjectProvider<MeetingAttendanceDropdownReadService> ad = mock(ObjectProvider.class);
        when(r.getIfAvailable()).thenReturn(null);
        when(w.getIfAvailable()).thenReturn(null);
        when(ar.getIfAvailable()).thenReturn(null);
        when(aw.getIfAvailable()).thenReturn(null);
        when(ad.getIfAvailable()).thenReturn(null);
        var reg = new MeetingOsgiServiceRegistrar(r, w, ar, aw, ad);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
