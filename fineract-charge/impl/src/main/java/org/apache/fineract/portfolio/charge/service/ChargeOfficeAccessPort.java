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
package org.apache.fineract.portfolio.charge.service;

/**
 * Office-scoped product/charge access rules. Implemented in the composition root
 * (provider) so charge-impl does not depend on entity-access infrastructure types.
 */
public interface ChargeOfficeAccessPort {

    /**
     * When office-specific products are enabled, returns a SQL list of charge IDs
     * visible to the current user's office (suitable for {@code IN (...)}). Empty
     * string when unrestricted.
     */
    String chargeIdsInClauseForCurrentUserOfficeIfEnabled();

    /**
     * When configured, maps a newly created charge to the current user's office.
     */
    void restrictNewChargeToCurrentUserOfficeIfEnabled(Long chargeId);
}
