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
package org.apache.fineract.infrastructure.core.config;

import java.util.List;
import org.apache.fineract.infrastructure.core.exception.JdbcAccessException;
import org.apache.fineract.infrastructure.core.exception.JdbcEmptyResultException;
import org.apache.fineract.infrastructure.core.service.JdbcDatabase;
import org.apache.fineract.infrastructure.core.service.JdbcRowMapper;
import org.apache.fineract.infrastructure.core.service.Page;
import org.apache.fineract.infrastructure.core.service.PaginationHelper;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

/**
 * The only {@link JdbcDatabase}. {@link JdbcTemplate} participates in the transaction-bound connection.
 */
public class SpringJdbcDatabase implements JdbcDatabase {

    private final JdbcTemplate jdbcTemplate;
    private final PaginationHelper paginationHelper;

    public SpringJdbcDatabase(JdbcTemplate jdbcTemplate, PaginationHelper paginationHelper) {
        this.jdbcTemplate = jdbcTemplate;
        this.paginationHelper = paginationHelper;
    }

    @Override
    public <T> List<T> query(String sql, JdbcRowMapper<T> rowMapper, Object... args) {
        return call(() -> jdbcTemplate.query(sql, springMapper(rowMapper), argsOrEmpty(args)));
    }

    @Override
    public <T> T queryForObject(String sql, Class<T> requiredType, Object... args) {
        return call(() -> jdbcTemplate.queryForObject(sql, requiredType, argsOrEmpty(args)));
    }

    @Override
    public <T> T queryForObject(String sql, JdbcRowMapper<T> rowMapper, Object... args) {
        return call(() -> jdbcTemplate.queryForObject(sql, springMapper(rowMapper), argsOrEmpty(args)));
    }

    @Override
    public <T> List<T> queryForList(String sql, Class<T> elementType, Object... args) {
        return call(() -> jdbcTemplate.queryForList(sql, elementType, argsOrEmpty(args)));
    }

    @Override
    public int update(String sql, Object... args) {
        return call(() -> jdbcTemplate.update(sql, argsOrEmpty(args)));
    }

    @Override
    public <T> Page<T> fetchPage(String sql, JdbcRowMapper<T> rowMapper, Object... args) {
        return call(() -> paginationHelper.fetchPage(jdbcTemplate, sql, argsOrEmpty(args), springMapper(rowMapper)));
    }

    @Override
    public Page<Long> fetchPage(String sql, Class<Long> type) {
        return call(() -> paginationHelper.fetchPage(jdbcTemplate, sql, type));
    }

    private static Object[] argsOrEmpty(Object... args) {
        return args == null ? new Object[0] : args;
    }

    private static <T> RowMapper<T> springMapper(JdbcRowMapper<T> rowMapper) {
        return rowMapper::mapRow;
    }

    private static <T> T call(JdbcCall<T> jdbcCall) {
        try {
            return jdbcCall.run();
        } catch (EmptyResultDataAccessException ex) {
            throw new JdbcEmptyResultException("Query returned no row", ex);
        } catch (DataAccessException ex) {
            throw new JdbcAccessException(ex.getMessage() == null ? "JDBC call failed" : ex.getMessage(), ex);
        }
    }

    @FunctionalInterface
    private interface JdbcCall<T> {

        T run();
    }
}
