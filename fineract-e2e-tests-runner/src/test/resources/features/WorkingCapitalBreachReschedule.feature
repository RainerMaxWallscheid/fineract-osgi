@WorkingCapital
@WorkingCapitalBreachRescheduleActionFeature @WCCOBFeature
Feature: Working Capital Breach Reschedule Action

  @TestRailId:C85272
  Scenario: Verify breach reschedule - UC1: changes minimumPayment only
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | WCLP_BREACH | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin sets the business date to "20260601"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | numberOfDays | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-02-28 | 59           | 110.70           | 110.70            | null       | true   |
      | 2            | 2026-03-01 | 2026-04-30 | 61           | 110.70           | 110.70            | null       | true   |
      | 3            | 2026-05-01 | 2026-06-30 | 61           | 110.70           | 110.70            | null       | null   |
    When Admin creates WC breach reschedule action with the following parameters:
      | minimumPayment | minimumPaymentType |
      | 1              | PERCENTAGE         |
    When Admin sets the business date to "20260815"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | numberOfDays | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-02-28 | 59           | 110.70           | 110.70            | null       | true   |
      | 2            | 2026-03-01 | 2026-04-30 | 61           | 110.70           | 110.70            | null       | true   |
      | 3            | 2026-05-01 | 2026-06-30 | 61           | 90               | 90                | null       | true   |
      | 4            | 2026-07-01 | 2026-08-31 | 62           | 90               | 90                | null       | null   |
    Then Admin closes the Working Capital loan with a full repayment on "20260815"

  @TestRailId:C85273
  Scenario: Verify breach reschedule - UC2: changes frequency only
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | WCLP_BREACH | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin sets the business date to "20260601"
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin creates WC breach reschedule action with the following parameters:
      | frequency | frequencyType |
      | 30        | DAYS          |
    When Admin sets the business date to "20260815"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | numberOfDays | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-02-28 | 59           | 110.70           | 110.70            | null       | true   |
      | 2            | 2026-03-01 | 2026-04-30 | 61           | 110.70           | 110.70            | null       | true   |
      | 3            | 2026-05-01 | 2026-06-30 | 61           | 110.70           | 110.70            | null       | true   |
      | 4            | 2026-07-01 | 2026-07-30 | 30           | 110.70           | 110.70            | null       | true   |
      | 5            | 2026-07-31 | 2026-08-29 | 30           | 110.70           | 110.70            | null       | null   |
    Then Admin closes the Working Capital loan with a full repayment on "20260815"

  @TestRailId:C85274
  Scenario: Verify breach reschedule - UC3: changes minimumPayment and frequency
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | WCLP_BREACH | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin sets the business date to "20260601"
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin creates WC breach reschedule action with the following parameters:
      | minimumPayment | minimumPaymentType | frequency | frequencyType |
      | 1              | PERCENTAGE         | 30        | DAYS          |
    When Admin sets the business date to "20260815"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | numberOfDays | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-02-28 | 59           | 110.70           | 110.70            | null       | true   |
      | 2            | 2026-03-01 | 2026-04-30 | 61           | 110.70           | 110.70            | null       | true   |
      | 3            | 2026-05-01 | 2026-06-30 | 61           | 90               | 90                | null       | true   |
      | 4            | 2026-07-01 | 2026-07-30 | 30           | 90               | 90                | null       | true   |
      | 5            | 2026-07-31 | 2026-08-29 | 30           | 90               | 90                | null       | null   |
    Then Admin closes the Working Capital loan with a full repayment on "20260815"

  @TestRailId:C85275
  Scenario: Verify breach reschedule - UC4: latest reschedule action wins
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | WCLP_BREACH | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin sets the business date to "20260601"
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin creates WC breach reschedule action with the following parameters:
      | minimumPayment | minimumPaymentType | frequency | frequencyType |
      | 2              | PERCENTAGE         | 30        | DAYS          |
    When Admin creates WC breach reschedule action with the following parameters:
      | minimumPayment | minimumPaymentType | frequency | frequencyType |
      | 1              | PERCENTAGE         | 30        | DAYS          |
    When Admin sets the business date to "20260815"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | numberOfDays | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-02-28 | 59           | 110.70           | 110.70            | null       | true   |
      | 2            | 2026-03-01 | 2026-04-30 | 61           | 110.70           | 110.70            | null       | true   |
      | 3            | 2026-05-01 | 2026-06-30 | 61           | 90               | 90                | null       | true   |
      | 4            | 2026-07-01 | 2026-07-30 | 30           | 90               | 90                | null       | true   |
      | 5            | 2026-07-31 | 2026-08-29 | 30           | 90               | 90                | null       | null   |
    Then Admin closes the Working Capital loan with a full repayment on "20260815"

  @TestRailId:C85276
  Scenario: Verify breach reschedule - UC5: multiple reschedules on the same date are stored in history
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | WCLP_BREACH | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin sets the business date to "20260601"
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin creates WC breach reschedule action with the following parameters:
      | minimumPayment | minimumPaymentType | frequency | frequencyType |
      | 2              | PERCENTAGE         | 2         | MONTHS        |
    When Admin creates WC breach reschedule action with the following parameters:
      | minimumPayment | minimumPaymentType | frequency | frequencyType |
      | 1              | PERCENTAGE         | 2         | MONTHS        |
    When Admin creates WC breach reschedule action with the following parameters:
      | minimumPayment | minimumPaymentType | frequency | frequencyType |
      | 1.5            | PERCENTAGE         | 2         | MONTHS        |
    And WC loan breach actions have the following data:
      | action     | startDate    | minimumPayment | minimumPaymentType | frequency | frequencyType |
      | RESCHEDULE | 20260601 | 2              | PERCENTAGE         | 2         | MONTHS        |
      | RESCHEDULE | 20260601 | 1              | PERCENTAGE         | 2         | MONTHS        |
      | RESCHEDULE | 20260601 | 1.5            | PERCENTAGE         | 2         | MONTHS        |
    Then Admin closes the Working Capital loan with a full repayment on "20260601"

  @TestRailId:C85277
  Scenario: Verify breach reschedule - UC6: fails when no change parameters are provided (Negative)
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | WCLP_BREACH | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Admin fails to create WC breach reschedule action with no parameters with error containing "reschedule.no.change.parameters"
    Then Admin closes the Working Capital loan with a full repayment on "20260101"

  @TestRailId:C85278
  Scenario: Verify breach reschedule - UC7: fails with negative minimumPayment (Negative)
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | WCLP_BREACH | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Admin fails to create WC breach reschedule action with minimumPayment -1 PERCENTAGE and frequency 30 DAYS with error containing "minimumPayment"
    Then Admin closes the Working Capital loan with a full repayment on "20260101"

  @TestRailId:C85279
  Scenario: Verify breach reschedule - UC8: payment-only reschedule after frequency reschedule inherits the previously rescheduled frequency
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | WCLP_BREACH | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin sets the business date to "20260601"
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin creates WC breach reschedule action with the following parameters:
      | frequency | frequencyType |
      | 30        | DAYS          |
    When Admin creates WC breach reschedule action with the following parameters:
      | minimumPayment | minimumPaymentType |
      | 1              | PERCENTAGE         |
    When Admin sets the business date to "20260815"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | numberOfDays | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-02-28 | 59           | 110.70           | 110.70            | null       | true   |
      | 2            | 2026-03-01 | 2026-04-30 | 61           | 110.70           | 110.70            | null       | true   |
      | 3            | 2026-05-01 | 2026-06-30 | 61           | 90               | 90                | null       | true   |
      | 4            | 2026-07-01 | 2026-07-30 | 30           | 90               | 90                | null       | true   |
      | 5            | 2026-07-31 | 2026-08-29 | 30           | 90               | 90                | null       | null   |
    Then Admin closes the Working Capital loan with a full repayment on "20260815"

  @TestRailId:C85280
  Scenario: Verify breach reschedule - UC9: updates current period after partial repayment and replays payments
    When Admin sets the business date to "20190101"
    And Admin creates a client with random data
    And Admin creates a Working Capital Loan Product with custom breach config and overrides enabled:
      | breachFrequency | breachFrequencyType | breachAmountCalculationType | breachAmount | delinquencyGraceDays |
      | 90              | DAYS                | PERCENTAGE                  | 9            | 3                    |
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | WCLP_BREACH | 20190101 | 20190101          | 9000            | 100000             | 18                | 1000     |
    And Admin successfully approves the working capital loan on "20190101" with "9000" amount and expected disbursement date on "20190101"
    And Admin successfully disburse the Working Capital loan on "20190101" with "9000" EUR transaction amount and "1000" discount amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin sets the business date to "20190305"
    And Customer makes repayment on "20190305" with 450.0 transaction amount on Working Capital loan
    When Admin sets the business date to "20190310"
    And Admin creates WC breach reschedule action with the following parameters:
      | minimumPayment | minimumPaymentType |
      | 5              | PERCENTAGE         |
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | numberOfDays | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2019-01-01 | 2019-03-31 | 90           | 500.00           | 50.00             | null       | null   |
    Then Admin closes the Working Capital loan with a full repayment on "20190310"

  @TestRailId:C85281
  Scenario: Verify breach reschedule - UC10: preserves already evaluated periods
    When Admin sets the business date to "20190101"
    And Admin creates a client with random data
    And Admin creates a Working Capital Loan Product with custom breach config and overrides enabled:
      | breachFrequency | breachFrequencyType | breachAmountCalculationType | breachAmount | delinquencyGraceDays |
      | 90              | DAYS                | PERCENTAGE                  | 10           | 3                    |
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | WCLP_BREACH | 20190101 | 20190101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20190101" with "9000" amount and expected disbursement date on "20190101"
    And Admin successfully disburse the Working Capital loan on "20190101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin sets the business date to "20190305"
    And Customer makes repayment on "20190305" with 450.0 transaction amount on Working Capital loan
    When Admin sets the business date to "20190406"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | numberOfDays | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2019-01-01 | 2019-03-31 | 90           | 900.00           | 450.00            | null       | true   |
      | 2            | 2019-04-01 | 2019-06-29 | 90           | 900.00           | 900.00            | null       | null   |
    When Admin sets the business date to "20190410"
    And Admin creates WC breach reschedule action with the following parameters:
      | minimumPayment | minimumPaymentType |
      | 5              | PERCENTAGE         |
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | numberOfDays | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2019-01-01 | 2019-03-31 | 90           | 900.00           | 450.00            | null       | true   |
      | 2            | 2019-04-01 | 2019-06-29 | 90           | 450.00           | 450.00            | null       | null   |
    Then Admin closes the Working Capital loan with a full repayment on "20190410"

  @TestRailId:C85282
  Scenario: Verify breach reschedule - UC11: changes frequency from 90 days to 30 days for current and future periods
    When Admin sets the business date to "20190101"
    And Admin creates a client with random data
    And Admin creates a Working Capital Loan Product with custom breach config and overrides enabled:
      | breachFrequency | breachFrequencyType | breachAmountCalculationType | breachAmount | delinquencyGraceDays |
      | 90              | DAYS                | PERCENTAGE                  | 9            | 3                    |
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | WCLP_BREACH | 20190101 | 20190101          | 9000            | 100000             | 18                | 1000     |
    And Admin successfully approves the working capital loan on "20190101" with "9000" amount and expected disbursement date on "20190101"
    And Admin successfully disburse the Working Capital loan on "20190101" with "9000" EUR transaction amount and "1000" discount amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin sets the business date to "20190310"
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | numberOfDays | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2019-01-01 | 2019-03-31 | 90           | 900.00           | 900.00            | null       | null   |
    And Admin creates WC breach reschedule action with the following parameters:
      | frequency | frequencyType |
      | 30        | DAYS          |
    When Admin sets the business date to "20190404"
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin sets the business date to "20190615"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | numberOfDays | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2019-01-01 | 2019-03-31 | 90           | 900.00           | 900.00            | null       | true   |
      | 2            | 2019-04-01 | 2019-04-30 | 30           | 900.00           | 900.00            | null       | true   |
      | 3            | 2019-05-01 | 2019-05-30 | 30           | 900.00           | 900.00            | null       | true   |
      | 4            | 2019-05-31 | 2019-06-29 | 30           | 900.00           | 900.00            | null       | null   |
    Then Admin closes the Working Capital loan with a full repayment on "20190615"

  @TestRailId:C85283
  Scenario: Verify breach reschedule - UC12: changes minimum payment and frequency together
    When Admin sets the business date to "20190101"
    And Admin creates a client with random data
    And Admin creates a Working Capital Loan Product with custom breach config and overrides enabled:
      | breachFrequency | breachFrequencyType | breachAmountCalculationType | breachAmount | delinquencyGraceDays |
      | 90              | DAYS                | PERCENTAGE                  | 9            | 3                    |
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | WCLP_BREACH | 20190101 | 20190101          | 9000            | 100000             | 18                | 1000     |
    And Admin successfully approves the working capital loan on "20190101" with "9000" amount and expected disbursement date on "20190101"
    And Admin successfully disburse the Working Capital loan on "20190101" with "9000" EUR transaction amount and "1000" discount amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin sets the business date to "20190310"
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | numberOfDays | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2019-01-01 | 2019-03-31 | 90           | 900.00           | 900.00            | null       | null   |
    And Admin creates WC breach reschedule action with the following parameters:
      | minimumPayment | minimumPaymentType | frequency | frequencyType |
      | 5              | PERCENTAGE         | 30        | DAYS          |
    When Admin sets the business date to "20190404"
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin sets the business date to "20190615"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | numberOfDays | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2019-01-01 | 2019-03-31 | 90           | 500.00           | 500.00            | null       | true   |
      | 2            | 2019-04-01 | 2019-04-30 | 30           | 500.00           | 500.00            | null       | true   |
      | 3            | 2019-05-01 | 2019-05-30 | 30           | 500.00           | 500.00            | null       | true   |
      | 4            | 2019-05-31 | 2019-06-29 | 30           | 500.00           | 500.00            | null       | null   |
    Then Admin closes the Working Capital loan with a full repayment on "20190615"

  @TestRailId:C85588
  Scenario: Verify breach reschedule inherits each partial group from the latest action that set it
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | WCLP_BREACH | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin sets the business date to "20260601"
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin creates WC breach reschedule action with the following parameters:
      | minimumPayment | minimumPaymentType |
      | 1              | PERCENTAGE         |
    When Admin creates WC breach reschedule action with the following parameters:
      | frequency | frequencyType |
      | 30        | DAYS          |
    Then WC loan breach actions have the following data:
      | action     | startDate    | minimumPayment | minimumPaymentType | frequency | frequencyType |
      | RESCHEDULE | 20260601 | 1              | PERCENTAGE         |           |               |
      | RESCHEDULE | 20260601 |                |                    | 30        | DAYS          |
    When Admin sets the business date to "20260815"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | numberOfDays | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-02-28 | 59           | 110.70           | 110.70            | null       | true   |
      | 2            | 2026-03-01 | 2026-04-30 | 61           | 110.70           | 110.70            | null       | true   |
      | 3            | 2026-05-01 | 2026-06-30 | 61           | 90               | 90                | null       | true   |
      | 4            | 2026-07-01 | 2026-07-30 | 30           | 90               | 90                | null       | true   |
      | 5            | 2026-07-31 | 2026-08-29 | 30           | 90               | 90                | null       | null   |
    Then Admin closes the Working Capital loan with a full repayment on "20260815"
