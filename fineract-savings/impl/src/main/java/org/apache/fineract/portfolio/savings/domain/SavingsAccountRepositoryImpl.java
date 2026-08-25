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
package org.apache.fineract.portfolio.savings.domain;

import jakarta.persistence.EntityManager;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.apache.fineract.portfolio.savings.data.SavingsAccrualData;

public class SavingsAccountRepositoryImpl implements SavingsAccountRepositoryCustom {

    private static final int INTEREST_RECEIVABLE_FINANCIAL_ACCOUNT_TYPE = 18;

    private final EntityManager entityManager;

    public SavingsAccountRepositoryImpl(final EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<SavingsAccrualData> findAccrualData(final LocalDate tillDate, final Long savingsId, final Integer status,
            final Integer accountingRule) {
        final java.sql.Date till = tillDate == null ? null : java.sql.Date.valueOf(tillDate);
        List<Object[]> rows = entityManager.createNativeQuery(
                "SELECT savings.id, savings.account_no, savings.accrued_till_date,"
                        + " CASE WHEN apm.financial_account_type = " + INTEREST_RECEIVABLE_FINANCIAL_ACCOUNT_TYPE
                        + " THEN 1 ELSE 0 END, msp.allow_overdraft, savings.deposit_type_enum"
                        + " FROM m_savings_account savings"
                        + " LEFT JOIN m_savings_product msp ON msp.id = savings.product_id"
                        + " LEFT JOIN acc_product_mapping apm ON apm.product_id = msp.id AND (apm.financial_account_type = "
                        + INTEREST_RECEIVABLE_FINANCIAL_ACCOUNT_TYPE + " OR apm.financial_account_type IS NULL)"
                        + " WHERE savings.status_enum = ?"
                        + " AND (savings.nominal_annual_interest_rate IS NOT NULL AND savings.nominal_annual_interest_rate > 0)"
                        + " AND msp.accounting_type = ?"
                        + " AND (savings.closedon_date <= ? OR savings.closedon_date IS NULL)"
                        + " AND (savings.accrued_till_date <= ? OR savings.accrued_till_date IS NULL)"
                        + " ORDER BY savings.id")
                .setParameter(1, status).setParameter(2, accountingRule).setParameter(3, till).setParameter(4, till).getResultList();
        List<SavingsAccrualData> result = new ArrayList<>(rows.size());
        for (Object[] row : rows) {
            result.add(new SavingsAccrualData(toLong(row[0]), (String) row[1], toLocalDate(row[2]), toBoolean(row[3]), toBoolean(row[4]),
                    toInteger(row[5])));
        }
        return result;
    }

    private static Long toLong(final Object value) {
        if (value == null) {
            return null;
        }
        if (value instanceof Number number) {
            return number.longValue();
        }
        throw new IllegalStateException("Unexpected id type: " + value.getClass().getName());
    }

    private static Integer toInteger(final Object value) {
        if (value == null) {
            return null;
        }
        if (value instanceof Number number) {
            return number.intValue();
        }
        throw new IllegalStateException("Unexpected integer type: " + value.getClass().getName());
    }

    private static Boolean toBoolean(final Object value) {
        if (value == null) {
            return Boolean.FALSE;
        }
        if (value instanceof Boolean bool) {
            return bool;
        }
        if (value instanceof Number number) {
            return number.intValue() != 0;
        }
        throw new IllegalStateException("Unexpected boolean type: " + value.getClass().getName());
    }

    private static LocalDate toLocalDate(final Object value) {
        if (value == null) {
            return null;
        }
        if (value instanceof LocalDate localDate) {
            return localDate;
        }
        if (value instanceof java.sql.Date sqlDate) {
            return sqlDate.toLocalDate();
        }
        if (value instanceof Timestamp timestamp) {
            return timestamp.toLocalDateTime().toLocalDate();
        }
        if (value instanceof Date date) {
            return date.toInstant().atZone(ZoneOffset.UTC).toLocalDate();
        }
        throw new IllegalStateException("Unexpected date type: " + value.getClass().getName());
    }
}
