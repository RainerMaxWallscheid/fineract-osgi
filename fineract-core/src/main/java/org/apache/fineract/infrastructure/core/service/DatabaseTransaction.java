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
package org.apache.fineract.infrastructure.core.service;

/**
 * Transaction boundary for bundle code. The only implementation uses the JPA transaction manager, so
 * {@link JdbcDatabase} and the JPA session share its connection and commit or roll back together.
 * Not an OSGi service.
 *
 * <p>
 * {@link #call} and {@link #callReadOnly} join the current transaction or start one. {@link #callNew} suspends the
 * current transaction and commits or rolls back on its own. An unchecked exception from the work rolls back the
 * boundary that caught it.
 */
public interface DatabaseTransaction {

    <T> T call(DatabaseWork<T> work);

    /**
     * Same participation as {@link #call}, but a transaction started here is read-only.
     */
    <T> T callReadOnly(DatabaseWork<T> work);

    <T> T callNew(DatabaseWork<T> work);
}
