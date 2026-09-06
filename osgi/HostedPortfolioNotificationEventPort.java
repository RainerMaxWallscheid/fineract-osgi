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
import org.apache.fineract.infrastructure.event.business.moduleapi.PortfolioNotificationEventPort;

/** Composition-root hosted notification events for the Equinox bridge smoke. */
final class HostedPortfolioNotificationEventPort implements PortfolioNotificationEventPort {

    static final String HOSTED = "hosted";

    static final Notification HOSTED_NOTIFICATION = new Notification(HOSTED, HOSTED, 1L, HOSTED, HOSTED, 1L);

    @Override
    public void onNotifications(final Consumer<Notification> handler) {
        handler.accept(HOSTED_NOTIFICATION);
    }
}
