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
 * Module API (ADR-021 / ADR-022) for content storage.
 *
 * <p>Primary OSGi ports:
 * <ul>
 *   <li>{@link org.apache.fineract.infrastructure.contentstore.service.ContentStoreService} — FS vs S3</li>
 *   <li>{@link ContentStreamPort} — async stream piping for bulk import / processors</li>
 * </ul>
 * Prefer these over adapter-specific or Spring utility types in document-impl.
 *
 * @see docs/arc42/15_osgi_bundle_refactoring_fineract-document.md
 */
package org.apache.fineract.infrastructure.contentstore.moduleapi;
