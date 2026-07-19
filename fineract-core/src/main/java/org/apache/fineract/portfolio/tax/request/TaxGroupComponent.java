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
package org.apache.fineract.portfolio.tax.request;

import java.io.Serial;
import java.io.Serializable;

public class TaxGroupComponent implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;
    private Long taxComponentId;
    private String startDate;

    @java.lang.SuppressWarnings("all")
        public void setTaxComponentId(final Long taxComponentId) {
        this.taxComponentId = taxComponentId;
    }

    @java.lang.SuppressWarnings("all")
        public void setStartDate(final String startDate) {
        this.startDate = startDate;
    }

    @java.lang.SuppressWarnings("all")
        public Long getTaxComponentId() {
        return this.taxComponentId;
    }

    @java.lang.SuppressWarnings("all")
        public String getStartDate() {
        return this.startDate;
    }

    @java.lang.SuppressWarnings("all")
        public TaxGroupComponent() {
    }
}
