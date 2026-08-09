package org.apache.fineract.infrastructure.campaigns.impl.osgi;

import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

import org.apache.fineract.infrastructure.campaigns.email.service.EmailCampaignReadPlatformService;
import org.apache.fineract.infrastructure.campaigns.email.service.EmailCampaignWritePlatformService;
import org.apache.fineract.infrastructure.campaigns.email.service.EmailConfigurationReadPlatformService;
import org.apache.fineract.infrastructure.campaigns.email.service.EmailConfigurationWritePlatformService;
import org.apache.fineract.infrastructure.campaigns.email.service.EmailReadPlatformService;
import org.apache.fineract.infrastructure.campaigns.email.service.EmailWritePlatformService;
import org.apache.fineract.infrastructure.campaigns.sms.service.SmsCampaignDropdownReadPlatformService;
import org.apache.fineract.infrastructure.campaigns.sms.service.SmsCampaignReadPlatformService;
import org.apache.fineract.infrastructure.campaigns.sms.service.SmsCampaignWritePlatformService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.ObjectProvider;

class CampaignsOsgiServiceRegistrarTest {

    @Test
    @SuppressWarnings("unchecked")
    void afterPropertiesSet_withoutOsgi_doesNotThrow() {
        ObjectProvider<SmsCampaignReadPlatformService> smsRead = mock(ObjectProvider.class);
        ObjectProvider<SmsCampaignWritePlatformService> smsWrite = mock(ObjectProvider.class);
        ObjectProvider<SmsCampaignDropdownReadPlatformService> smsDropdown = mock(ObjectProvider.class);
        ObjectProvider<EmailCampaignReadPlatformService> emailCampaignRead = mock(ObjectProvider.class);
        ObjectProvider<EmailCampaignWritePlatformService> emailCampaignWrite = mock(ObjectProvider.class);
        ObjectProvider<EmailReadPlatformService> emailRead = mock(ObjectProvider.class);
        ObjectProvider<EmailWritePlatformService> emailWrite = mock(ObjectProvider.class);
        ObjectProvider<EmailConfigurationReadPlatformService> emailConfigRead = mock(ObjectProvider.class);
        ObjectProvider<EmailConfigurationWritePlatformService> emailConfigWrite = mock(ObjectProvider.class);
        when(smsRead.getIfAvailable()).thenReturn(null);
        when(smsWrite.getIfAvailable()).thenReturn(null);
        when(smsDropdown.getIfAvailable()).thenReturn(null);
        when(emailCampaignRead.getIfAvailable()).thenReturn(null);
        when(emailCampaignWrite.getIfAvailable()).thenReturn(null);
        when(emailRead.getIfAvailable()).thenReturn(null);
        when(emailWrite.getIfAvailable()).thenReturn(null);
        when(emailConfigRead.getIfAvailable()).thenReturn(null);
        when(emailConfigWrite.getIfAvailable()).thenReturn(null);
        var reg = new CampaignsOsgiServiceRegistrar(smsRead, smsWrite, smsDropdown, emailCampaignRead, emailCampaignWrite, emailRead,
                emailWrite, emailConfigRead, emailConfigWrite);
        assertDoesNotThrow(reg::afterPropertiesSet);
        assertDoesNotThrow(reg::destroy);
    }
}
