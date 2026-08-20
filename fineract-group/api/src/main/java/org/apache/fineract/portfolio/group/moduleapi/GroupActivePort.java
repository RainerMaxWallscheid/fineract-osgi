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
package org.apache.fineract.portfolio.group.moduleapi;

import java.time.LocalDate;

/**
 * ID-only group activity check (ADR-021). Foreign BCs must not depend on
 * leftover {@code Group} graphs for {@code checkClientOrGroupActive}.
 */
public interface GroupActivePort {

    boolean isActive(Long groupId);

    boolean isCenter(Long groupId);

    boolean isActivatedAfter(Long groupId, LocalDate date);

    LocalDate activationDate(Long groupId);

    Long officeId(Long groupId);

    /**
     * Persistable office for the group (Object-typed, ADR-021).
     */
    Object office(Long groupId);

    boolean hasClientAsMember(Long groupId, Long clientId);

    /**
     * Group id from a persistable group instance (Object-typed, ADR-021).
     */
    Long id(Object group);
}
