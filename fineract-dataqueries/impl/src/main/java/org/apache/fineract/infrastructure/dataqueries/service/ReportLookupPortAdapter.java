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
package org.apache.fineract.infrastructure.dataqueries.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import org.apache.fineract.infrastructure.dataqueries.domain.Report;
import org.apache.fineract.infrastructure.dataqueries.domain.ReportParameterUsage;
import org.apache.fineract.infrastructure.dataqueries.domain.ReportRepository;
import org.apache.fineract.infrastructure.dataqueries.exception.ReportNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class ReportLookupPortAdapter implements ReportLookupPort {

    private final ReportRepository reportRepository;

    public ReportLookupPortAdapter(final ReportRepository reportRepository) {
        this.reportRepository = reportRepository;
    }

    @Override
    public void assertExists(final Long reportId) {
        if (reportId == null || reportRepository.findById(reportId).isEmpty()) {
            throw new ReportNotFoundException(reportId);
        }
    }

    @Override
    public String findReportName(final Long reportId) {
        if (reportId == null) {
            return null;
        }
        return reportRepository.findById(reportId).map(Report::getReportName).orElse(null);
    }

    @Override
    public List<String> findParameterNames(final Long reportId) {
        final Report report = reportRepository.findById(reportId).orElseThrow(() -> new ReportNotFoundException(reportId));
        final Set<ReportParameterUsage> usages = report.getReportParameterUsages();
        final List<String> names = new ArrayList<>();
        if (usages != null) {
            for (final ReportParameterUsage usage : usages) {
                names.add(usage.getReportParameterName());
            }
        }
        return names;
    }
}
