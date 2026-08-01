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
 * Module API (ADR-021 / ADR-022) — the only package other Gradle modules should depend on
 * from the tax bounded context for catalog lookup (alongside service interfaces / exceptions).
 *
 * <p>Put port interfaces and stable definition DTOs here.
 * Do not place JPA entities, Spring Data repositories or REST resources in this package.
 *
 * <p>Consumers that still need {@code TaxGroup}/{@code TaxComponent} entities (charge, loan, savings)
 * temporarily depend on tax-impl until Step 8 retargets associations to catalog ids + this port.
 *
 * @see docs/arc42/14_module_api_boundaries.md
 * @see docs/arc42/15_osgi_bundle_refactoring_fineract-tax.md
 */
package org.apache.fineract.portfolio.tax.moduleapi;
