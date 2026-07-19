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
package org.apache.fineract.infrastructure.dataqueries.data;

public final class ReportParameterJoinData {
    private final Long reportId;
    private final String reportName;
    private final String reportType;
    private final String reportSubType;
    private final String reportCategory;
    private final String description;
    private final String reportSql;
    private final Boolean coreReport;
    private final Boolean useReport;
    private final Long reportParameterId;
    private final Long parameterId;
    private final String reportParameterName;
    private final String parameterName;

    @java.lang.SuppressWarnings("all")
        public Long getReportId() {
        return this.reportId;
    }

    @java.lang.SuppressWarnings("all")
        public String getReportName() {
        return this.reportName;
    }

    @java.lang.SuppressWarnings("all")
        public String getReportType() {
        return this.reportType;
    }

    @java.lang.SuppressWarnings("all")
        public String getReportSubType() {
        return this.reportSubType;
    }

    @java.lang.SuppressWarnings("all")
        public String getReportCategory() {
        return this.reportCategory;
    }

    @java.lang.SuppressWarnings("all")
        public String getDescription() {
        return this.description;
    }

    @java.lang.SuppressWarnings("all")
        public String getReportSql() {
        return this.reportSql;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getCoreReport() {
        return this.coreReport;
    }

    @java.lang.SuppressWarnings("all")
        public Boolean getUseReport() {
        return this.useReport;
    }

    @java.lang.SuppressWarnings("all")
        public Long getReportParameterId() {
        return this.reportParameterId;
    }

    @java.lang.SuppressWarnings("all")
        public Long getParameterId() {
        return this.parameterId;
    }

    @java.lang.SuppressWarnings("all")
        public String getReportParameterName() {
        return this.reportParameterName;
    }

    @java.lang.SuppressWarnings("all")
        public String getParameterName() {
        return this.parameterName;
    }

    @java.lang.SuppressWarnings("all")
        public ReportParameterJoinData(final Long reportId, final String reportName, final String reportType, final String reportSubType, final String reportCategory, final String description, final String reportSql, final Boolean coreReport, final Boolean useReport, final Long reportParameterId, final Long parameterId, final String reportParameterName, final String parameterName) {
        this.reportId = reportId;
        this.reportName = reportName;
        this.reportType = reportType;
        this.reportSubType = reportSubType;
        this.reportCategory = reportCategory;
        this.description = description;
        this.reportSql = reportSql;
        this.coreReport = coreReport;
        this.useReport = useReport;
        this.reportParameterId = reportParameterId;
        this.parameterId = parameterId;
        this.reportParameterName = reportParameterName;
        this.parameterName = parameterName;
    }
}
