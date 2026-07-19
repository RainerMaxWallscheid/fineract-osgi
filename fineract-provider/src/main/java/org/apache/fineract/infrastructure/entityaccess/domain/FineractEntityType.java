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
package org.apache.fineract.infrastructure.entityaccess.domain;

public final class FineractEntityType {
    private String type;
    private String description;
    private String tableName;
    public static final FineractEntityType OFFICE = new FineractEntityType().setType("office").setDescription("Offices").setTableName("m_office");
    public static final FineractEntityType LOAN_PRODUCT = new FineractEntityType().setType("loan_product").setDescription("Loan Products").setTableName("m_product_loan");
    public static final FineractEntityType SAVINGS_PRODUCT = new FineractEntityType().setType("savings_product").setDescription("Savings Product").setTableName("m_savings_product");
    public static final FineractEntityType CHARGE = new FineractEntityType().setType("charge").setDescription("Fees/Charges").setTableName("m_charge");
    public static final FineractEntityType SHARE_PRODUCT = new FineractEntityType().setType("shares_product").setDescription("Shares Product").setTableName("m_share_product");

    public static FineractEntityType get(String type) {
        FineractEntityType retType = null;
        if (type.equals(OFFICE.type)) {
            retType = OFFICE;
        } else if (type.equals(LOAN_PRODUCT.type)) {
            retType = LOAN_PRODUCT;
        } else if (type.equals(SAVINGS_PRODUCT.type)) {
            retType = SAVINGS_PRODUCT;
        } else if (type.equals(CHARGE.type)) {
            retType = CHARGE;
        } else if (type.equals(SHARE_PRODUCT.type)) {
            retType = SHARE_PRODUCT;
        }
        return retType;
    }

    @java.lang.SuppressWarnings("all")
        public String getType() {
        return this.type;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public String getTableName() {
        return this.tableName;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public FineractEntityType setType(final String type) {
        this.type = type;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public FineractEntityType setDescription(final String description) {
        this.description = description;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public FineractEntityType setTableName(final String tableName) {
        this.tableName = tableName;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public FineractEntityType() {
    }
}
