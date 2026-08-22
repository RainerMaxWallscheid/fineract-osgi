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
 * Investor Module API package docs (ADR-021 / ADR-022).
 *
 * <p>Public contracts for foreign modules live primarily in sibling packages on
 * {@code fineract-investor-api}:
 * <ul>
 *   <li>{@code …investor.service} — pure ports (read/write owners, loan-product attributes, delayed settlement)</li>
 *   <li>{@code ExternalAssetOwnerTransferCobPort} — Object-typed COB execute for leftover {@code Loan} graphs</li>
 *   <li>{@code …investor.data} — pure DTOs and status enums</li>
 *   <li>{@code …investor.exception} — domain rule / not-found exceptions</li>
 * </ul>
 *
 * <p>Do not place JPA entities, Spring Data repositories or REST resources here.
 * Entity residual for composition-root journal wiring stays on investor-impl.
 *
 * @see docs/arc42/14_module_api_boundaries.md
 * @see docs/arc42/15_osgi_bundle_refactoring_fineract-investor.md
 */
package org.apache.fineract.investor.moduleapi;
