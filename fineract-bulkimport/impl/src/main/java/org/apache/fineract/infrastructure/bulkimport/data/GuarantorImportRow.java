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
package org.apache.fineract.infrastructure.bulkimport.data;

import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * JSON payload for guarantor bulk import (same field names as leftover
 * {@code GuarantorData} import instance).
 */
public class GuarantorImportRow {

    private Integer guarantorTypeId;
    private Integer clientRelationshipTypeId;
    private Long entityId;
    private String firstname;
    private String lastname;
    private String addressLine1;
    private String addressLine2;
    private String city;
    private LocalDate dob;
    private String zip;
    private Integer savingsId;
    private BigDecimal amount;
    private transient Integer rowIndex;
    private transient Long accountId;
    private String locale;
    private String dateFormat;
    private boolean status;

    public Long getAccountId() {
        return this.accountId;
    }

    public Integer getRowIndex() {
        return this.rowIndex;
    }

    public static GuarantorImportRow of(final Integer guarantorTypeId, final Integer clientRelationshipTypeId, final Long entityId,
            final String firstname, final String lastname, final String addressLine1, final String addressLine2, final String city,
            final LocalDate dob, final String zip, final Integer savingsId, final BigDecimal amount, final Integer rowIndex,
            final Long accountId, final String locale, final String dateFormat) {
        final GuarantorImportRow row = new GuarantorImportRow();
        row.guarantorTypeId = guarantorTypeId;
        row.clientRelationshipTypeId = clientRelationshipTypeId;
        row.entityId = entityId;
        row.firstname = firstname;
        row.lastname = lastname;
        row.addressLine1 = addressLine1;
        row.addressLine2 = addressLine2;
        row.city = city;
        row.dob = dob;
        row.zip = zip;
        row.savingsId = savingsId;
        row.amount = amount;
        row.rowIndex = rowIndex;
        row.accountId = accountId;
        row.locale = locale;
        row.dateFormat = dateFormat;
        row.status = false;
        return row;
    }
}
