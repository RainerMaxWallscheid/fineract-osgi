/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements. See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership. The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package org.apache.fineract.infrastructure.campaigns.sms.service;

import org.apache.fineract.organisation.staff.domain.Staff;

/**
 * Narrow campaigns/sms port for 2FA OTP delivery.
 * <p>
 * Breaks the security-impl ↔ sms-impl cycle: security uses this api port; campaigns-impl implements it using
 * SmsMessage + triggered gateway send.
 */
public interface TwoFactorSmsDeliveryPort {

    /**
     * Persist a pending OTP SMS and trigger immediate delivery via the configured provider.
     */
    void deliverOtpSms(Staff staff, String mobileNo, String messageText, long smsProviderId);
}
