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
package org.apache.fineract.infrastructure.event.impl.osgi;

import java.util.function.Consumer;
import org.apache.fineract.infrastructure.event.business.moduleapi.SmsCampaignTriggerEventPort;

/**
 * Empty SMS-campaign trigger port for Equinox without Spring/JPA.
 * Published by {@code OSGI-INF/event-sms-campaign.xml} (ADR-022 B6).
 */
public final class OsgiSmsCampaignTriggerEventPort implements SmsCampaignTriggerEventPort {

    @Override
    public void onClientActivated(final Consumer<Object> handler) {
        // empty catalog: no listeners
    }

    @Override
    public void onClientRejected(final Consumer<Object> handler) {
        // empty catalog: no listeners
    }

    @Override
    public void onSavingsActivated(final Consumer<Object> handler) {
        // empty catalog: no listeners
    }

    @Override
    public void onSavingsRejected(final Consumer<Object> handler) {
        // empty catalog: no listeners
    }

    @Override
    public void onSavingsDeposit(final Consumer<Object> handler) {
        // empty catalog: no listeners
    }

    @Override
    public void onSavingsWithdrawal(final Consumer<Object> handler) {
        // empty catalog: no listeners
    }
}
