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
 * Module API (ADR-021) — the only package other Gradle modules should depend on
 * from this bounded context (Charge Catalog), aside from catalog {@code exception}.
 *
 * <p>Contents:
 * <ul>
 * <li>Ports / DTOs: {@link org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionPort},
 * {@link org.apache.fineract.portfolio.charge.moduleapi.ChargeDefinitionData}</li>
 * <li>Pure catalog enums and JPA converters: {@code ChargeAppliesTo}, {@code ChargeCalculationType},
 * {@code ChargePaymentMode}, …</li>
 * <li>Published read contract: {@link org.apache.fineract.portfolio.charge.moduleapi.ChargeReadPlatformService},
 * {@link org.apache.fineract.portfolio.charge.moduleapi.ChargeEnumerations}</li>
 * </ul>
 *
 * <p>{@code ChargeTimeType} lives in the same Java package name on {@code fineract-core}
 * (shared-kernel placement until rates/tax-style catalog consolidation).
 *
 * <p>Do not place JPA entities, Spring Data repositories or REST resources here.
 *
 * @see docs/arc42/14_module_api_boundaries.md
 * @see docs/arc42/15_osgi_bundle_refactoring_fineract-charge.md
 */
package org.apache.fineract.portfolio.charge.moduleapi;
