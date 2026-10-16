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

import java.util.List;

/**
 * Positional JDBC for bundle code. The only implementation uses the connection already bound to the
 * current transaction, so these calls see the same uncommitted rows as the JPA session and commit or
 * roll back with it. Not an OSGi service.
 */
public interface JdbcDatabase {

    <T> List<T> query(String sql, JdbcRowMapper<T> rowMapper, Object... args);

    <T> T queryForObject(String sql, Class<T> requiredType, Object... args);

    <T> T queryForObject(String sql, JdbcRowMapper<T> rowMapper, Object... args);

    <T> List<T> queryForList(String sql, Class<T> elementType, Object... args);

    int update(String sql, Object... args);

    <T> Page<T> fetchPage(String sql, JdbcRowMapper<T> rowMapper, Object... args);

    Page<Long> fetchPage(String sql, Class<Long> type);
}
