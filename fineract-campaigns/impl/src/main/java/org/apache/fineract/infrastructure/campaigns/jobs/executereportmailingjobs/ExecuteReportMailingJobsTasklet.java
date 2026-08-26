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
package org.apache.fineract.infrastructure.campaigns.jobs.executereportmailingjobs;

import jakarta.ws.rs.core.MultivaluedMap;
import jakarta.ws.rs.core.Response;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.LocalDateTime;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import org.apache.fineract.infrastructure.core.config.FineractProperties;
import org.apache.fineract.infrastructure.core.service.DateUtils;
import org.apache.fineract.infrastructure.dataqueries.domain.Report;
import org.apache.fineract.infrastructure.dataqueries.domain.ReportRepositoryWrapper;
import org.apache.fineract.infrastructure.dataqueries.service.ReadReportingService;
import org.apache.fineract.infrastructure.report.provider.ReportingProcessServiceProvider;
import org.apache.fineract.infrastructure.report.service.ReportingProcessService;
import org.apache.fineract.infrastructure.reportmailingjob.data.DueReportMailingJob;
import org.apache.fineract.infrastructure.reportmailingjob.data.ReportMailingJobEmailAttachmentFileFormat;
import org.apache.fineract.infrastructure.reportmailingjob.data.ReportMailingJobEmailData;
import org.apache.fineract.infrastructure.reportmailingjob.data.ReportMailingJobStretchyReportParamDateOption;
import org.apache.fineract.infrastructure.reportmailingjob.service.ReportMailingJobEmailService;
import org.apache.fineract.infrastructure.reportmailingjob.service.ReportMailingJobRunPort;
import org.apache.fineract.infrastructure.reportmailingjob.util.ReportMailingJobDateUtil;
import org.apache.fineract.infrastructure.reportmailingjob.validation.ReportMailingJobValidator;
import org.glassfish.jersey.internal.util.collection.MultivaluedStringMap;
import org.springframework.batch.core.StepContribution;
import org.springframework.batch.core.scope.context.ChunkContext;
import org.springframework.batch.core.step.tasklet.Tasklet;
import org.springframework.batch.repeat.RepeatStatus;

public class ExecuteReportMailingJobsTasklet implements Tasklet {
    @java.lang.SuppressWarnings("all")
        private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(ExecuteReportMailingJobsTasklet.class);
    private final ReportMailingJobRunPort reportMailingJobRunPort;
    private final ReportMailingJobValidator reportMailingJobValidator;
    private final ReadReportingService readReportingService;
    private final ReportRepositoryWrapper reportRepositoryWrapper;
    private final ReportingProcessServiceProvider reportingProcessServiceProvider;
    private final ReportMailingJobEmailService reportMailingJobEmailService;
    private final FineractProperties fineractProperties;

    @Override
    public RepeatStatus execute(StepContribution contribution, ChunkContext chunkContext) throws Exception {
        for (DueReportMailingJob reportMailingJob : reportMailingJobRunPort.findDueJobs()) {
            final LocalDateTime jobStart = DateUtils.getLocalDateTimeOfTenant();
            final ReportMailingJobEmailAttachmentFileFormat emailAttachmentFileFormat = ReportMailingJobEmailAttachmentFileFormat
                    .newInstance(reportMailingJob.emailAttachmentFileFormat());
            if (emailAttachmentFileFormat != null && emailAttachmentFileFormat != ReportMailingJobEmailAttachmentFileFormat.INVALID) {
                final Long stretchyReportId = reportMailingJob.stretchyReportId();
                final Report stretchyReport = stretchyReportId == null ? null
                        : reportRepositoryWrapper.findOneThrowExceptionIfNotFound(stretchyReportId);
                final String reportName = (stretchyReport != null) ? stretchyReport.getReportName() : null;
                final StringBuilder errorLog = new StringBuilder();
                final Map<String, String> validateStretchyReportParamMap = reportMailingJobValidator
                        .validateStretchyReportParamMap(reportMailingJob.stretchyReportParamMap());
                MultivaluedMap<String, String> reportParams = new MultivaluedStringMap();
                if (validateStretchyReportParamMap != null) {
                    for (Map.Entry<String, String> validateStretchyReportParamMapEntry : validateStretchyReportParamMap.entrySet()) {
                        String key = validateStretchyReportParamMapEntry.getKey();
                        String value = validateStretchyReportParamMapEntry.getValue();
                        if (key != null && key.toLowerCase(Locale.ROOT).contains("date")) {
                            ReportMailingJobStretchyReportParamDateOption reportMailingJobStretchyReportParamDateOption = ReportMailingJobStretchyReportParamDateOption
                                    .newInstance(value);
                            if (reportMailingJobStretchyReportParamDateOption != ReportMailingJobStretchyReportParamDateOption.INVALID) {
                                value = ReportMailingJobDateUtil.getDateAsString(reportMailingJobStretchyReportParamDateOption);
                            }
                        }
                        reportParams.add(key, value);
                    }
                }
                generateReportOutputStream(reportMailingJob, emailAttachmentFileFormat, reportParams, reportName, errorLog);
                reportMailingJobRunPort.recordRun(reportMailingJob.id(), jobStart, errorLog.length() == 0, errorLog.toString());
            }
        }
        return RepeatStatus.FINISHED;
    }

    private void generateReportOutputStream(final DueReportMailingJob reportMailingJob, final ReportMailingJobEmailAttachmentFileFormat emailAttachmentFileFormat, final MultivaluedMap<String, String> reportParams, final String reportName, final StringBuilder errorLog) {
        try {
            final String reportType = readReportingService.getReportType(reportName, false);
            final ReportingProcessService reportingProcessService = reportingProcessServiceProvider.findReportingProcessService(reportType);
            if (reportingProcessService != null) {
                final Response processReport = reportingProcessService.processRequest(reportName, reportParams);
                final Object responseObject = (processReport != null) ? processReport.getEntity() : null;
                if (responseObject != null && responseObject.getClass().equals(ByteArrayOutputStream.class)) {
                    final ByteArrayOutputStream byteArrayOutputStream = (ByteArrayOutputStream) responseObject;
                    final Path fileLocation = Path.of(fineractProperties.getContent().getFilesystem().getRootFolder());
                    final Path fileNameWithoutExtension = fileLocation.resolve(reportName);
                    if (!Files.isDirectory(fileLocation)) {
                        Files.createDirectories(fileLocation);
                    }
                    if (byteArrayOutputStream.size() == 0) {
                        errorLog.append("Report processing failed, empty output stream created");
                    } else if ((errorLog != null && errorLog.length() == 0) && (byteArrayOutputStream.size() > 0)) {
                        final Path fileName = fileNameWithoutExtension.resolveSibling(reportName + "." + emailAttachmentFileFormat.getValue());
                        sendReportFileToEmailRecipients(reportMailingJob, fileName, byteArrayOutputStream, errorLog);
                    }
                } else {
                    errorLog.append("Response object entity is not equal to ByteArrayOutputStream ---------- ");
                }
            } else {
                errorLog.append(ReportingProcessServiceProvider.SERVICE_MISSING).append(reportType);
            }
        } catch (Exception e) {
            errorLog.append("The ReportMailingJobWritePlatformServiceImpl.generateReportOutputStream method threw an Exception: ").append(e).append(" ---------- ");
        }
    }

    private void sendReportFileToEmailRecipients(final DueReportMailingJob reportMailingJob, final Path fileName, final ByteArrayOutputStream byteArrayOutputStream, final StringBuilder errorLog) {
        final Set<String> emailRecipients = this.reportMailingJobValidator.validateEmailRecipients(reportMailingJob.emailRecipients());
        try {
            final Path parent = fileName.getParent();
            if (parent != null) {
                Files.createDirectories(parent);
            }
            final File file = fileName.toFile();
            try (var outputStream = Files.newOutputStream(fileName)) {
                byteArrayOutputStream.writeTo(outputStream);
            }
            for (String emailRecipient : emailRecipients) {
                final ReportMailingJobEmailData reportMailingJobEmailData = new ReportMailingJobEmailData().setTo(emailRecipient).setText(reportMailingJob.emailMessage()).setSubject(reportMailingJob.emailSubject()).setAttachment(file);
                reportMailingJobEmailService.sendEmailWithAttachment(reportMailingJobEmailData);
            }
        } catch (IOException e) {
            errorLog.append("The ReportMailingJobWritePlatformServiceImpl.sendReportFileToEmailRecipients method threw an IOException " + "exception: ").append(e).append(" ---------- ");
        }
    }

    @java.lang.SuppressWarnings("all")
        public ExecuteReportMailingJobsTasklet(final ReportMailingJobRunPort reportMailingJobRunPort, final ReportMailingJobValidator reportMailingJobValidator, final ReadReportingService readReportingService, final ReportRepositoryWrapper reportRepositoryWrapper, final ReportingProcessServiceProvider reportingProcessServiceProvider, final ReportMailingJobEmailService reportMailingJobEmailService, final FineractProperties fineractProperties) {
        this.reportMailingJobRunPort = reportMailingJobRunPort;
        this.reportMailingJobValidator = reportMailingJobValidator;
        this.readReportingService = readReportingService;
        this.reportRepositoryWrapper = reportRepositoryWrapper;
        this.reportingProcessServiceProvider = reportingProcessServiceProvider;
        this.reportMailingJobEmailService = reportMailingJobEmailService;
        this.fineractProperties = fineractProperties;
    }
}
