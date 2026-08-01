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
/**
 * Branch / teller Module API (OSGi contracts).
 *
 * <p>Public service interfaces live in {@code …teller.service}; pure DTOs in {@code …teller.data};
 * pure status / txn-type value types live in this package (no JPA entities on api).
 *
 * <p>OSGi registration (impl): {@code TellerManagementReadPlatformService},
 * {@code TellerWritePlatformService}.
 */
package org.apache.fineract.organisation.teller.moduleapi;
