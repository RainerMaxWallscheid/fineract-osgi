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

import java.util.function.Consumer;
import org.apache.fineract.infrastructure.event.business.moduleapi.SmsCampaignTriggerEventPort;

/** Composition-root hosted SMS-campaign triggers for the Equinox bridge smoke. */
final class HostedSmsCampaignTriggerEventPort implements SmsCampaignTriggerEventPort {

    static final String HOSTED = "hosted";

    @Override
    public void onClientActivated(final Consumer<Object> handler) {
        handler.accept(HOSTED);
    }

    @Override
    public void onClientRejected(final Consumer<Object> handler) {
        handler.accept(HOSTED);
    }

    @Override
    public void onSavingsActivated(final Consumer<Object> handler) {
        handler.accept(HOSTED);
    }

    @Override
    public void onSavingsRejected(final Consumer<Object> handler) {
        handler.accept(HOSTED);
    }

    @Override
    public void onSavingsDeposit(final Consumer<Object> handler) {
        handler.accept(HOSTED);
    }

    @Override
    public void onSavingsWithdrawal(final Consumer<Object> handler) {
        handler.accept(HOSTED);
    }
}
