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
package org.apache.fineract.portfolio.delinquency.validator;

import static org.apache.fineract.portfolio.delinquency.domain.DelinquencyAction.PAUSE;
import static org.apache.fineract.portfolio.delinquency.domain.DelinquencyAction.RESUME;
import static org.apache.fineract.portfolio.delinquency.validator.DelinquencyActionParameters.ACTION;
import static org.apache.fineract.portfolio.delinquency.validator.DelinquencyActionParameters.DATE_FORMAT;
import static org.apache.fineract.portfolio.delinquency.validator.DelinquencyActionParameters.END_DATE;
import static org.apache.fineract.portfolio.delinquency.validator.DelinquencyActionParameters.LOCALE;
import static org.apache.fineract.portfolio.delinquency.validator.DelinquencyActionParameters.START_DATE;
import static org.junit.jupiter.api.Assertions.assertThrows;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonParser;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import org.apache.fineract.infrastructure.core.api.JsonCommand;
import org.apache.fineract.infrastructure.core.exception.PlatformApiDataValidationException;
import org.apache.fineract.infrastructure.core.serialization.FromJsonHelper;
import org.apache.fineract.portfolio.delinquency.domain.DelinquencyAction;
import org.apache.fineract.portfolio.delinquency.domain.LoanDelinquencyAction;
import org.apache.fineract.portfolio.delinquency.helper.DelinquencyEffectivePauseHelper;
import org.apache.fineract.portfolio.loanaccount.domain.Loan;
import org.apache.fineract.portfolio.loanaccount.domain.LoanStatus;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.function.Executable;
import org.mockito.Mockito;
import org.springframework.lang.NonNull;
import org.springframework.lang.Nullable;

class DelinquencyActionParseAndValidatorTest {

    private final FromJsonHelper fromJsonHelper = new FromJsonHelper();
    private final DelinquencyEffectivePauseHelper delinquencyEffectivePauseHelper = Mockito.mock(DelinquencyEffectivePauseHelper.class);
    private final DelinquencyActionParseAndValidator underTest = new DelinquencyActionParseAndValidator(fromJsonHelper,
            delinquencyEffectivePauseHelper);
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyyMMdd", Locale.US);

    @Test
    public void testParseAndValidationIsOKForPause() throws JsonProcessingException {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.ACTIVE);
        Mockito.when(loan.getDisbursementDate()).thenReturn(localDate("20220907"));

        JsonCommand command = delinquencyAction("pause", "20220909", "20220919");

        LoanDelinquencyAction parsedDelinquencyAction = underTest.validateAndParseUpdate(command, loan, List.of(),
                localDate("20220909"));
        Assertions.assertEquals(PAUSE, parsedDelinquencyAction.getAction());
        Assertions.assertEquals(localDate("20220909"), parsedDelinquencyAction.getStartDate());
        Assertions.assertEquals(localDate("20220919"), parsedDelinquencyAction.getEndDate());
    }

    @Test
    public void testParseAndValidationIsOKForResume() throws JsonProcessingException {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.ACTIVE);

        JsonCommand command = delinquencyAction("resume", "20220909", null);
        List<LoanDelinquencyAction> existing = List.of(loanDelinquencyAction(PAUSE, "20220905", "20220915"));
        List<LoanDelinquencyActionData> effectiveList = List.of(loanDelinquencyActionData(existing.get(0)));
        Mockito.when(delinquencyEffectivePauseHelper.calculateEffectiveDelinquencyList(existing)).thenReturn(effectiveList);

        LoanDelinquencyAction parsedDelinquencyAction = underTest.validateAndParseUpdate(command, loan, existing,
                localDate("20220909"));
        Assertions.assertEquals(RESUME, parsedDelinquencyAction.getAction());
        Assertions.assertEquals(localDate("20220909"), parsedDelinquencyAction.getStartDate());
        Assertions.assertNull(parsedDelinquencyAction.getEndDate());
    }

    @Test
    public void testPauseBothStartAndEndDateIsOverlappingWithAnActivePause() throws JsonProcessingException {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.ACTIVE);
        Mockito.when(loan.getDisbursementDate()).thenReturn(localDate("20220907"));

        List<LoanDelinquencyAction> existing = List.of(loanDelinquencyAction(PAUSE, "20220914", "20220922"));
        JsonCommand command = delinquencyAction("pause", "20220909", "20220915");
        List<LoanDelinquencyActionData> effectiveList = List.of(loanDelinquencyActionData(existing.get(0)));
        Mockito.when(delinquencyEffectivePauseHelper.calculateEffectiveDelinquencyList(existing)).thenReturn(effectiveList);

        assertPlatformValidationException("Delinquency pause period cannot overlap with another pause period",
                "validation.msg.loanDelinquencyAction.overlapping",
                () -> underTest.validateAndParseUpdate(command, loan, existing, localDate("20220909")));
    }

    @Test
    public void testPauseStartIsOverlappingWithAnActivePause() throws JsonProcessingException {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.ACTIVE);
        Mockito.when(loan.getDisbursementDate()).thenReturn(localDate("20220911"));

        List<LoanDelinquencyAction> existing = List.of(loanDelinquencyAction(PAUSE, "20220914", "20220922"));
        JsonCommand command = delinquencyAction("pause", "20220915", "20220923");
        List<LoanDelinquencyActionData> effectiveList = List.of(loanDelinquencyActionData(existing.get(0)));
        Mockito.when(delinquencyEffectivePauseHelper.calculateEffectiveDelinquencyList(existing)).thenReturn(effectiveList);

        assertPlatformValidationException("Delinquency pause period cannot overlap with another pause period",
                "validation.msg.loanDelinquencyAction.overlapping",
                () -> underTest.validateAndParseUpdate(command, loan, existing, localDate("20220909")));
    }

    @Test
    public void testNewPauseEndIsOverlappingWithExistingPause() throws JsonProcessingException {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.ACTIVE);
        Mockito.when(loan.getDisbursementDate()).thenReturn(localDate("20220911"));
        List<LoanDelinquencyAction> existing = List.of(loanDelinquencyAction(PAUSE, "20220915", "20220922"));
        JsonCommand command = delinquencyAction("pause", "20220913", "20220920");
        List<LoanDelinquencyActionData> effectiveList = List.of(loanDelinquencyActionData(existing.get(0)));
        Mockito.when(delinquencyEffectivePauseHelper.calculateEffectiveDelinquencyList(existing)).thenReturn(effectiveList);

        assertPlatformValidationException("Delinquency pause period cannot overlap with another pause period",
                "validation.msg.loanDelinquencyAction.overlapping",
                () -> underTest.validateAndParseUpdate(command, loan, existing, localDate("20220909")));
    }

    @Test
    public void testNewPauseIsOverlappingWithExistingPauseBecauseSameDates() throws JsonProcessingException {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.ACTIVE);
        Mockito.when(loan.getDisbursementDate()).thenReturn(localDate("20220911"));

        List<LoanDelinquencyAction> existing = List.of(loanDelinquencyAction(PAUSE, "20220915", "20220922"));
        JsonCommand command = delinquencyAction("pause", "20220915", "20220922");
        List<LoanDelinquencyActionData> effectiveList = List.of(loanDelinquencyActionData(existing.get(0)));
        Mockito.when(delinquencyEffectivePauseHelper.calculateEffectiveDelinquencyList(existing)).thenReturn(effectiveList);

        assertPlatformValidationException("Delinquency pause period cannot overlap with another pause period",
                "validation.msg.loanDelinquencyAction.overlapping",
                () -> underTest.validateAndParseUpdate(command, loan, existing, localDate("20220909")));
    }

    @Test
    public void testNewPauseIsNotOverlappingBecauseThereWasAResume() throws JsonProcessingException {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.ACTIVE);
        Mockito.when(loan.getDisbursementDate()).thenReturn(localDate("20220911"));

        JsonCommand command = delinquencyAction("pause", "20220918", "20220920");

        List<LoanDelinquencyAction> existing = List.of(loanDelinquencyAction(PAUSE, "20220915", "20220922"), //
                loanDelinquencyAction(RESUME, "20220917") //
        );

        LoanDelinquencyAction parsedDelinquencyAction = underTest.validateAndParseUpdate(command, loan, existing,
                localDate("20220918"));
        Assertions.assertEquals(PAUSE, parsedDelinquencyAction.getAction());
        Assertions.assertEquals(localDate("20220918"), parsedDelinquencyAction.getStartDate());
        Assertions.assertEquals(localDate("20220920"), parsedDelinquencyAction.getEndDate());
    }

    @Test
    public void testResumeIsNotOverlappingWithAnActivePause() throws JsonProcessingException {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.ACTIVE);

        List<LoanDelinquencyAction> existing = List.of(loanDelinquencyAction(PAUSE, "20220905", "20220908"));
        JsonCommand command = delinquencyAction("resume", "20220909", null);

        assertPlatformValidationException("Resume Delinquency Action can only be created during an active pause",
                "validation.msg.loanDelinquencyAction.resume.should.be.on.pause",
                () -> underTest.validateAndParseUpdate(command, loan, existing, localDate("20220909")));
    }

    @Test
    public void testValidationErrorWhenDelinquencyActionIsMissing() throws JsonProcessingException {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.APPROVED);

        JsonCommand command = delinquencyAction(null, "20220909", "20220919");

        assertPlatformValidationException("Delinquency Action must not be null or empty",
                "validation.msg.loanDelinquencyAction.action.cannot.be.blank",
                () -> underTest.validateAndParseUpdate(command, loan, List.of(), localDate("20220909")));
    }

    @Test
    public void testValidationErrorWhenLoanIsNotActive() throws JsonProcessingException {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.APPROVED);

        JsonCommand command = delinquencyAction("pause", "20220909", "20220919");

        assertPlatformValidationException("Delinquency actions can be created only for active loans.",
                "validation.msg.loanDelinquencyAction.invalid.loan.state",
                () -> underTest.validateAndParseUpdate(command, loan, List.of(), localDate("20220909")));
    }

    @Test
    public void testValidationErrorResumeShouldHaveNoEndDate() throws JsonProcessingException {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.ACTIVE);

        JsonCommand command = delinquencyAction("resume", "20220909", "20220919");

        assertPlatformValidationException("Resume Delinquency action can not have end date",
                "validation.msg.loanDelinquencyAction.endDate.resume.should.have.no.end.date",
                () -> underTest.validateAndParseUpdate(command, loan, List.of(), localDate("20220909")));
    }

    @Test
    public void testValidationErrorResumeInvalidStartDate() throws JsonProcessingException {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.ACTIVE);

        JsonCommand command = delinquencyAction("resume", "20220909", "20220919");

        assertPlatformValidationException("Start date of the Resume Delinquency action must be the current business date",
                "validation.msg.loanDelinquencyAction.startDate.resume.invalid.start.date",
                () -> underTest.validateAndParseUpdate(command, loan, List.of(), localDate("20220910")));
    }

    @Test
    public void testValidationErrorResumeOnExistingResumeDate() throws JsonProcessingException {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.ACTIVE);

        JsonCommand command = delinquencyAction("resume", "20220909", null);
        List<LoanDelinquencyAction> existing = List.of(loanDelinquencyAction(PAUSE, "20220905", "20220915"));
        List<LoanDelinquencyActionData> effectiveList = List.of(loanDelinquencyActionData(existing.get(0)));
        Mockito.when(delinquencyEffectivePauseHelper.calculateEffectiveDelinquencyList(existing)).thenReturn(effectiveList);

        LoanDelinquencyAction parsedDelinquencyAction = underTest.validateAndParseUpdate(command, loan, existing,
                localDate("20220909"));
        Assertions.assertEquals(RESUME, parsedDelinquencyAction.getAction());
        Assertions.assertEquals(localDate("20220909"), parsedDelinquencyAction.getStartDate());
        Assertions.assertNull(parsedDelinquencyAction.getEndDate());

        List<LoanDelinquencyAction> existing2 = List.of(loanDelinquencyAction(PAUSE, "20220905", "20220915"),
                loanDelinquencyAction(RESUME, "20220909", null));

        JsonCommand command2 = delinquencyAction("resume", "20220909", null);

        assertPlatformValidationException("There is an existing Resume Delinquency Action on this date",
                "validation.msg.loanDelinquencyAction.resume.should.be.unique",
                () -> underTest.validateAndParseUpdate(command2, loan, existing2, localDate("20220909")));
    }

    @Test
    public void testValidationErrorPausePeriodShouldBeAtLeastOneDay() throws JsonProcessingException {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.ACTIVE);

        JsonCommand command = delinquencyAction("pause", "20220910", "20220910");

        assertPlatformValidationException("Delinquency pause period must be at least one day",
                "validation.msg.loanDelinquencyAction.pause.period.must.be.at.least.one.day",
                () -> underTest.validateAndParseUpdate(command, loan, List.of(), localDate("20220909")));
    }

    @Test
    public void testValidationErrorPausePeriodMustNotBeBeforeDisbursement() throws JsonProcessingException {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.ACTIVE);
        Mockito.when(loan.getDisbursementDate()).thenReturn(localDate("20220911"));

        JsonCommand command = delinquencyAction("pause", "20220908", "20220909");

        assertPlatformValidationException("Start date of pause period must be after first disbursal date",
                "validation.msg.loanDelinquencyAction.startDate.before.disbursement",
                () -> underTest.validateAndParseUpdate(command, loan, List.of(), localDate("20220909")));
    }

    @Test
    public void testStartDateOrEndDateIsMissingForPause() {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.ACTIVE);

        assertPlatformValidationException("The parameter `startDate` is mandatory.",
                "validation.msg.loanDelinquencyAction.startDate.cannot.be.blank",
                () -> underTest.validateAndParseUpdate(delinquencyAction("pause", null, "20220909"), loan, List.of(),
                        localDate("20220909")));

        assertPlatformValidationException("The parameter `endDate` is mandatory.",
                "validation.msg.loanDelinquencyAction.endDate.cannot.be.blank",
                () -> underTest.validateAndParseUpdate(delinquencyAction("pause", "20220909", null), loan, List.of(),
                        localDate("20220909")));
    }

    @Test
    public void testStartDateIsMissingForResume() {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.ACTIVE);

        assertPlatformValidationException("The parameter `startDate` is mandatory.",
                "validation.msg.loanDelinquencyAction.startDate.cannot.be.blank", () -> underTest
                        .validateAndParseUpdate(delinquencyAction("resume", null, null), loan, List.of(), localDate("20220909")));
    }

    @Test
    public void testNewPausePeriodStartingOnExistingEndDate() throws JsonProcessingException {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.ACTIVE);
        Mockito.when(loan.getDisbursementDate()).thenReturn(localDate("20220911"));

        JsonCommand command = delinquencyAction("pause", "20220918", "20220920");

        List<LoanDelinquencyAction> existing = List.of(loanDelinquencyAction(PAUSE, "20220915", "20220918"));

        LoanDelinquencyAction parsedDelinquencyAction = underTest.validateAndParseUpdate(command, loan, existing,
                localDate("20220918"));
        Assertions.assertEquals(PAUSE, parsedDelinquencyAction.getAction());
        Assertions.assertEquals(localDate("20220918"), parsedDelinquencyAction.getStartDate());
        Assertions.assertEquals(localDate("20220920"), parsedDelinquencyAction.getEndDate());
    }

    @Test
    public void testNewPauseEndingOnExistingStartDate() throws JsonProcessingException {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.ACTIVE);
        Mockito.when(loan.getDisbursementDate()).thenReturn(localDate("20220911"));

        JsonCommand command = delinquencyAction("pause", "20220918", "20220920");

        List<LoanDelinquencyAction> existing = List.of(loanDelinquencyAction(PAUSE, "20220920", "20220925"));

        LoanDelinquencyAction parsedDelinquencyAction = underTest.validateAndParseUpdate(command, loan, existing,
                localDate("20220918"));
        Assertions.assertEquals(PAUSE, parsedDelinquencyAction.getAction());
        Assertions.assertEquals(localDate("20220918"), parsedDelinquencyAction.getStartDate());
        Assertions.assertEquals(localDate("20220920"), parsedDelinquencyAction.getEndDate());
    }

    @Test
    public void testNewPausePeriodStartingOnExistingEffectiveEndDate() throws JsonProcessingException {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.ACTIVE);
        Mockito.when(loan.getDisbursementDate()).thenReturn(localDate("20220911"));

        JsonCommand command = delinquencyAction("pause", "20220918", "20220920");

        List<LoanDelinquencyAction> existing = List.of(//
                loanDelinquencyAction(PAUSE, "20220915", "20220920"), //
                loanDelinquencyAction(RESUME, "20220918") //
        );

        LoanDelinquencyAction parsedDelinquencyAction = underTest.validateAndParseUpdate(command, loan, existing,
                localDate("20220918"));
        Assertions.assertEquals(PAUSE, parsedDelinquencyAction.getAction());
        Assertions.assertEquals(localDate("20220918"), parsedDelinquencyAction.getStartDate());
        Assertions.assertEquals(localDate("20220920"), parsedDelinquencyAction.getEndDate());
    }

    @Test
    public void testParseAndValidationIsOKForBackdatedPause() throws JsonProcessingException {
        Loan loan = Mockito.mock(Loan.class);
        Mockito.when(loan.getStatus()).thenReturn(LoanStatus.ACTIVE);
        Mockito.when(loan.getDisbursementDate()).thenReturn(localDate("20220907"));

        JsonCommand command = delinquencyAction("pause", "20220908", "20220919");

        LoanDelinquencyAction parsedDelinquencyAction = underTest.validateAndParseUpdate(command, loan, List.of(),
                localDate("20220909"));
        Assertions.assertEquals(PAUSE, parsedDelinquencyAction.getAction());
        Assertions.assertEquals(localDate("20220908"), parsedDelinquencyAction.getStartDate());
        Assertions.assertEquals(localDate("20220919"), parsedDelinquencyAction.getEndDate());
    }

    @NonNull
    private JsonCommand delinquencyAction(@Nullable String action, @Nullable String startDate, @Nullable String endDate)
            throws JsonProcessingException {
        Map<String, Object> map = new HashMap<>();
        Optional.ofNullable(action).ifPresent(a -> map.put(ACTION, a));
        map.put(DATE_FORMAT, "yyyyMMdd");
        map.put(LOCALE, "en");
        Optional.ofNullable(startDate).ifPresent(sd -> map.put(START_DATE, sd));
        Optional.ofNullable(endDate).ifPresent(ed -> map.put(END_DATE, ed));
        return createJsonCommand(map);
    }

    private LocalDate localDate(String date) {
        return LocalDate.parse(date, DATE_TIME_FORMATTER);
    }

    @NonNull
    private JsonCommand createJsonCommand(Map<String, Object> jsonMap) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        String json = objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(jsonMap);
        return new JsonCommand(null, JsonParser.parseString(json));
    }

    private void assertPlatformValidationException(String message, String code, Executable executable) {
        PlatformApiDataValidationException validationException = assertThrows(PlatformApiDataValidationException.class, executable);
        assertPlatformException(message, code, validationException);
    }

    private void assertPlatformException(String expectedMessage, String expectedCode,
            PlatformApiDataValidationException platformApiDataValidationException) {
        Assertions.assertEquals(expectedMessage, platformApiDataValidationException.getErrors().get(0).getDefaultUserMessage());
        Assertions.assertEquals(expectedCode, platformApiDataValidationException.getErrors().get(0).getUserMessageGlobalisationCode());
    }

    private LoanDelinquencyAction loanDelinquencyAction(DelinquencyAction action, String startTime, String endTime) {
        return new LoanDelinquencyAction(null, action, localDate(startTime), Objects.isNull(endTime) ? null : localDate(endTime));
    }

    private LoanDelinquencyActionData loanDelinquencyActionData(LoanDelinquencyAction loanDelinquencyAction) {
        return new LoanDelinquencyActionData(loanDelinquencyAction);
    }

    private LoanDelinquencyAction loanDelinquencyAction(DelinquencyAction action, String startTime) {
        return new LoanDelinquencyAction(null, action, localDate(startTime), null);
    }

}
