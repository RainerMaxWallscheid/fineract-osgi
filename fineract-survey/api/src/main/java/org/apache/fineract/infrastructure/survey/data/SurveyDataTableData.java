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
package org.apache.fineract.infrastructure.survey.data;

import org.apache.fineract.infrastructure.dataqueries.data.DatatableData;

public final class SurveyDataTableData {
    @SuppressWarnings("unused")
    private DatatableData datatableData;
    @SuppressWarnings("unused")
    private boolean enabled;

    public static SurveyDataTableData create(final DatatableData datatableData, final boolean enabled) {
        return new SurveyDataTableData().setDatatableData(datatableData).setEnabled(enabled);
    }

    @java.lang.SuppressWarnings("all")
        public DatatableData getDatatableData() {
        return this.datatableData;
    }

    @java.lang.SuppressWarnings("all")
        public boolean isEnabled() {
        return this.enabled;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SurveyDataTableData setDatatableData(final DatatableData datatableData) {
        this.datatableData = datatableData;
        return this;
    }

    /**
     * @return {@code this}.
     */
    @java.lang.SuppressWarnings("all")
        public SurveyDataTableData setEnabled(final boolean enabled) {
        this.enabled = enabled;
        return this;
    }

    @java.lang.SuppressWarnings("all")
        public SurveyDataTableData() {
    }
}
