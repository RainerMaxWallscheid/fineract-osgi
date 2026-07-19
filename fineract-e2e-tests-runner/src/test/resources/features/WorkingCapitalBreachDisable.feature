@WorkingCapital
@WorkingCapitalBreachDisableFeature
Feature: Working Capital Breach Disable

  @TestRailId:C85463
  Scenario: Verify Working Capital breach enable/disable - UC1: Disable stops breach evaluation and enable re-triggers a recompute as of the enable date
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260228"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin initiate a Working Capital loan breach disable with startDate "20260228"
    Then Working Capital loan breach disable action has the following data:
      | action  | startDate  | endDate |
      | DISABLE | 2026-02-28 |         |
    When Admin sets the business date to "20260301"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | numberOfDays | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-02-28 | 59           | 110.70           | 110.70            | null       | null   |
      | 2            | 2026-03-01 | 2026-04-30 | 61           | 110.70           | 110.70            | null       | null   |
    When Admin sets the business date to "20260315"
    And Admin initiate a Working Capital loan breach enable with startDate "20260315"
    Then Working Capital loan breach disable action has the following data:
      | action  | startDate  | endDate    |
      | DISABLE | 2026-02-28 | 2026-03-14 |
      | ENABLE  | 2026-03-15 |            |
    And Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | numberOfDays | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-02-28 | 59           | 110.70           | 110.70            | null       | true   |
      | 2            | 2026-03-01 | 2026-04-30 | 61           | 110.70           | 110.70            | null       | null   |
    When Admin closes the Working Capital loan with a full repayment on "20260315"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85464
  Scenario: Verify Working Capital breach enable/disable - UC2: Breach disable is allowed only once until it is reversed (Negative)
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260115"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin initiate a Working Capital loan breach disable with startDate "20260115"
    Then Initiating a Working Capital loan breach disable with startDate "20260115" results an error with the following data:
      | httpCode | message                                                |
      | 400      | Failed data validation due to: breach.already.disabled |
    When Admin closes the Working Capital loan with a full repayment on "20260115"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85465
  Scenario: Verify Working Capital breach enable/disable - UC3: Breach enable is rejected when there is no active disable (Negative)
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260115"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Initiating a Working Capital loan breach enable with startDate "20260115" results an error with the following data:
      | httpCode | message                                                           |
      | 400      | Failed data validation due to: no.active.breach.disable.to.enable |
    When Admin closes the Working Capital loan with a full repayment on "20260115"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85466
  Scenario: Verify Working Capital breach enable/disable - UC4: Breach disable and enable are rejected when backdated or given an end date (Negative)
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260115"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Initiating a Working Capital loan breach disable with startDate "20260110" results an error with the following data:
      | httpCode | message                                                      |
      | 400      | Failed data validation due to: must.be.current.business.date |
    And Initiating a Working Capital loan breach enable with startDate "20260110" results an error with the following data:
      | httpCode | message                                                      |
      | 400      | Failed data validation due to: must.be.current.business.date |
    And Initiating a Working Capital loan breach disable with startDate "20260115" and endDate "20260120" results an error with the following data:
      | httpCode | message                                                                   |
      | 400      | Failed data validation due to: must.not.be.provided.for.disable.or.enable |
    When Admin closes the Working Capital loan with a full repayment on "20260115"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85467
  Scenario: Verify Working Capital breach enable/disable - UC5: While disabled the pause and reschedule breach actions are not allowed (Negative)
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260115"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin initiate a Working Capital loan breach disable with startDate "20260115"
    Then Initiating a Working Capital loan breach pause with startDate "20260116" and endDate "20260120" results an error with the following data:
      | httpCode | message                                           |
      | 400      | Failed data validation due to: breach.is.disabled |
    And Initiating a Working Capital loan breach reschedule with minimumPayment "50" "FLAT" results an error with the following data:
      | httpCode | message                                           |
      | 400      | Failed data validation due to: breach.is.disabled |
    When Admin closes the Working Capital loan with a full repayment on "20260115"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85468
  Scenario: Verify Working Capital breach enable/disable - UC6: While disabled the near breach reschedule action is not allowed (Negative)
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a Working Capital Loan Product with breach and near breach config and overrides enabled:
      | breachFrequency | breachFrequencyType | breachAmountCalculationType | breachAmount | nearBreachFrequency | nearBreachFrequencyType | nearBreachThreshold | delinquencyGraceDays |
      | 9               | DAYS                | FLAT                        | 90           | 3                   | DAYS                    | 33.33               |                      |
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260115"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin initiate a Working Capital loan breach disable with startDate "20260115"
    Then Admin creates a near breach reschedule action with threshold "50" frequency 3 frequencyType "DAYS" expecting error:
      | httpCode | errorMessage                                      |
      | 400      | Failed data validation due to: breach.is.disabled |
    When Admin closes the Working Capital loan with a full repayment on "20260115"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85469
  Scenario: Verify Working Capital breach enable/disable - UC7: While disabled the reset breach action is not allowed (Negative)
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260115"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin initiate a Working Capital loan breach disable with startDate "20260115"
    Then Admin fails to create WC breach reset action with the following data:
      | httpCode | errorMessage                                      |
      | 400      | Failed data validation due to: breach.is.disabled |
    When Admin closes the Working Capital loan with a full repayment on "20260115"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85470
  Scenario: Verify Working Capital breach enable/disable - UC8: Resume of a pause made before disable is not allowed while breach is disabled (Negative)
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260115"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin initiate a Working Capital loan breach pause with startDate "20260115" and endDate "20260120"
    And Admin initiate a Working Capital loan breach disable with startDate "20260115"
    Then Initiating a Working Capital loan breach resume with startDate "20260115" results an error with the following data:
      | httpCode | message                                           |
      | 400      | Failed data validation due to: breach.is.disabled |
    When Admin closes the Working Capital loan with a full repayment on "20260115"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85471
  Scenario: Verify Working Capital breach enable/disable - UC9: Undo reset is allowed while breach is disabled
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260115"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin creates WC breach reset action
    And Admin initiate a Working Capital loan breach disable with startDate "20260115"
    And Admin creates WC breach undo reset action
    Then WC loan breach actions have the following data:
      | action     | startDate       |
      | RESET      | 20260115 |
      | DISABLE    | 20260115 |
      | UNDO_RESET | 20260115 |
    And Working Capital loan breach disable action has the following data:
      | action  | startDate  | endDate |
      | DISABLE | 2026-01-15 |         |
    When Admin closes the Working Capital loan with a full repayment on "20260115"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85472
  Scenario: Verify Working Capital breach enable/disable - UC10: Repayment during disable does not touch the breach schedule and is applied by enable
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260115"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin initiate a Working Capital loan breach disable with startDate "20260115"
    And Admin sets the business date to "20260120"
    And Customer makes repayment on "20260120" with 110.7 transaction amount on Working Capital loan
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-02-28 | 110.70           | 110.70            | null       | null   |
    When Admin sets the business date to "20260315"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin initiate a Working Capital loan breach enable with startDate "20260315"
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-02-28 | 110.70           | 0                 | null       | false  |
      | 2            | 2026-03-01 | 2026-04-30 | 110.70           | 110.70            | null       | null   |
    When Admin closes the Working Capital loan with a full repayment on "20260315"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85473
  Scenario: Verify Working Capital breach enable/disable - UC11: Repayment undo during disable does not touch the breach schedule and the reversal is honoured by enable
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260115"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin initiate a Working Capital loan breach disable with startDate "20260115"
    And Admin sets the business date to "20260120"
    And Customer makes repayment on "20260120" with 110.7 transaction amount on Working Capital loan
    And Admin sets the business date to "20260315"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Customer undo "1"th "REPAYMENT" transaction made on "20260120" on Working Capital loan
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-02-28 | 110.70           | 110.70            | null       | null   |
      | 2            | 2026-03-01 | 2026-04-30 | 110.70           | 110.70            | null       | null   |
    When Admin initiate a Working Capital loan breach enable with startDate "20260315"
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-02-28 | 110.70           | 110.70            | null       | true   |
      | 2            | 2026-03-01 | 2026-04-30 | 110.70           | 110.70            | null       | null   |
    When Admin closes the Working Capital loan with a full repayment on "20260315"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85474
  Scenario: Verify Working Capital breach enable/disable - UC12: Disable suppresses near breach evaluation
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a Working Capital Loan Product with breach and near breach config and overrides enabled:
      | breachFrequency | breachFrequencyType | breachAmountCalculationType | breachAmount | nearBreachFrequency | nearBreachFrequencyType | nearBreachThreshold | delinquencyGraceDays |
      | 3               | MONTHS              | FLAT                        | 900          | 60                  | DAYS                    | 33.33               |                      |
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260201"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin initiate a Working Capital loan breach disable with startDate "20260201"
    And Admin sets the business date to "20260303"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-03-31 | 900.00           | 900.00            | null       | null   |
    When Admin closes the Working Capital loan with a full repayment on "20260303"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85475
  Scenario: Verify Working Capital breach enable/disable - UC13: Enable resumes near breach evaluation on the next COB
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a Working Capital Loan Product with breach and near breach config and overrides enabled:
      | breachFrequency | breachFrequencyType | breachAmountCalculationType | breachAmount | nearBreachFrequency | nearBreachFrequencyType | nearBreachThreshold | delinquencyGraceDays |
      | 3               | MONTHS              | FLAT                        | 900          | 60                  | DAYS                    | 33.33               |                      |
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260201"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin initiate a Working Capital loan breach disable with startDate "20260201"
    And Admin sets the business date to "20260302"
    And Admin initiate a Working Capital loan breach enable with startDate "20260302"
    And Admin sets the business date to "20260303"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-03-31 | 900.00           | 900.00            | true       | null   |
    When Admin closes the Working Capital loan with a full repayment on "20260303"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85476
  Scenario: Verify Working Capital breach enable/disable - UC14: A loan can be disabled again after a previous disable was enabled
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin initiate a Working Capital loan breach disable with startDate "20260110"
    And Admin sets the business date to "20260120"
    And Admin initiate a Working Capital loan breach enable with startDate "20260120"
    And Admin initiate a Working Capital loan breach disable with startDate "20260120"
    Then Working Capital loan breach disable action has the following data:
      | action  | startDate  | endDate    |
      | DISABLE | 2026-01-10 | 2026-01-19 |
      | ENABLE  | 2026-01-20 |            |
      | DISABLE | 2026-01-20 |            |
    When Admin closes the Working Capital loan with a full repayment on "20260120"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85477
  Scenario: Verify Working Capital breach enable/disable - UC15: Breach disable is rejected for a loan without breach configuration (Negative)
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Initiating a Working Capital loan breach disable with startDate "20260101" results an error with the following data:
      | httpCode | message                                                |
      | 400      | Failed data validation due to: no.breach.configuration |
    When Admin closes the Working Capital loan with a full repayment on "20260101"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85478
  Scenario: Verify Working Capital breach enable/disable - UC16: Breach disable is rejected for a not yet active loan (Negative)
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    Then Initiating a Working Capital loan breach disable with startDate "20260101" results an error with the following data:
      | httpCode | message                                           |
      | 400      | Failed data validation due to: loan.is.not.active |

  @TestRailId:C85479
  Scenario: Verify Working Capital breach enable/disable - UC17: Breach disable can be applied and retrieved by loan external id
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260115"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin initiate a Working Capital loan breach disable by external ID with startDate "20260115"
    Then Working Capital loan breach disable action by external ID has the following data:
      | action  | startDate  | endDate |
      | DISABLE | 2026-01-15 |         |
    When Admin closes the Working Capital loan with a full repayment on "20260115"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85480
  Scenario: Verify Working Capital breach enable/disable - UC18: Breach disable requires the CREATE_WC_BREACH_DISABLE permission (Negative)
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260115"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin creates new user with "NO_CREATE_WC_BREACH_DISABLE_USER" username, "NO_CREATE_WC_BREACH_DISABLE_ROLE" role name and given permissions:
      | REPAYMENT_LOAN |
    Then Created user with no CREATE_WC_BREACH_DISABLE permission gets an error when initiate a Working Capital loan breach disable with startDate "20260115"
    When Admin closes the Working Capital loan with a full repayment on "20260115"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85481
  Scenario: Verify Working Capital breach enable/disable - UC19: COB breach evaluation is skipped during disable window and correctly runs after enable
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260228"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin initiate a Working Capital loan breach disable with startDate "20260228"
    And Admin sets the business date to "20260301"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-02-28 | 110.70           | 110.70            | null       | null   |
      | 2            | 2026-03-01 | 2026-04-30 | 110.70           | 110.70            | null       | null   |
    When Admin initiate a Working Capital loan breach enable with startDate "20260301"
    And Admin sets the business date to "20260302"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-02-28 | 110.70           | 110.70            | null       | true   |
      | 2            | 2026-03-01 | 2026-04-30 | 110.70           | 110.70            | null       | null   |
    When Admin closes the Working Capital loan with a full repayment on "20260302"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85482
  Scenario: Verify Working Capital breach enable/disable - UC20: Disable and enable history is maintained correctly across two full disable-enable cycles
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin initiate a Working Capital loan breach disable with startDate "20260110"
    And Admin sets the business date to "20260120"
    And Admin initiate a Working Capital loan breach enable with startDate "20260120"
    And Admin sets the business date to "20260125"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin initiate a Working Capital loan breach disable with startDate "20260125"
    And Admin sets the business date to "20260131"
    And Admin initiate a Working Capital loan breach enable with startDate "20260131"
    Then Working Capital loan breach disable action has the following data:
      | action  | startDate  | endDate    |
      | DISABLE | 2026-01-10 | 2026-01-19 |
      | ENABLE  | 2026-01-20 |            |
      | DISABLE | 2026-01-25 | 2026-01-30 |
      | ENABLE  | 2026-01-31 |            |
    When Admin closes the Working Capital loan with a full repayment on "20260131"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85483
  Scenario: Verify Working Capital breach enable/disable - UC21: Enable after an active reset re-evaluates breach using the reset boundary
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Customer makes repayment on "20260110" with 110.7 transaction amount on Working Capital loan
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-02-28 | 110.70           | 0                 | null       | false  |
    When Admin sets the business date to "20260115"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin creates WC breach reset action
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-02-28 | 110.70           | 0                 | null       | false  |
    When Admin sets the business date to "20260120"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin initiate a Working Capital loan breach disable with startDate "20260120"
    And Admin sets the business date to "20260301"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin initiate a Working Capital loan breach enable with startDate "20260301"
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-02-28 | 110.70           | 0                 | null       | false  |
      | 2            | 2026-03-01 | 2026-04-30 | 110.70           | 110.70            | null       | null   |
    When Admin closes the Working Capital loan with a full repayment on "20260301"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85484
  Scenario: Verify Working Capital breach enable/disable - UC22: Breach enable on the same business day as disable is accepted
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260115"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin initiate a Working Capital loan breach disable with startDate "20260115"
    And Admin initiate a Working Capital loan breach enable with startDate "20260115"
    Then Working Capital loan breach disable action has the following data:
      | action  | startDate  | endDate    |
      | DISABLE | 2026-01-15 | 2026-01-14 |
      | ENABLE  | 2026-01-15 |            |
    When Admin closes the Working Capital loan with a full repayment on "20260115"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85485
  Scenario: Verify Working Capital breach enable/disable - UC23: Breach action history retrieval requires READ_WC_BREACH_ACTION permission (Negative)
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a new Working Capital Loan Product with breachId and overrides enabled
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260115"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin initiate a Working Capital loan breach disable with startDate "20260115"
    And Admin creates new user with "NO_READ_WC_BREACH_ACTION_USER" username, "NO_READ_WC_BREACH_ACTION_ROLE" role name and given permissions:
      | REPAYMENT_LOAN |
    Then Created user with no READ_WC_BREACH_ACTION permission gets an error when retrieving Working Capital loan breach actions
    When Admin closes the Working Capital loan with a full repayment on "20260115"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85486
  Scenario: Verify Working Capital breach enable/disable - UC24: Near breach flag set before disable is preserved during disable window and not altered until enable
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a Working Capital Loan Product with breach and near breach config and overrides enabled:
      | breachFrequency | breachFrequencyType | breachAmountCalculationType | breachAmount | nearBreachFrequency | nearBreachFrequencyType | nearBreachThreshold | delinquencyGraceDays |
      | 3               | MONTHS              | FLAT                        | 900          | 60                  | DAYS                    | 33.33               |                      |
    And Admin creates a working capital loan using created product with the following data:
      | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin sets the business date to "20260303"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-03-31 | 900.00           | 900.00            | true       | null   |
    When Admin sets the business date to "20260304"
    And Admin initiate a Working Capital loan breach disable with startDate "20260304"
    And Admin sets the business date to "20260315"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-03-31 | 900.00           | 900.00            | true       | null   |
    When Admin sets the business date to "20260325"
    And Admin initiate a Working Capital loan breach enable with startDate "20260325"
    And Admin sets the business date to "20260326"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan breach schedule has the following data:
      | periodNumber | fromDate   | toDate     | minPaymentAmount | outstandingAmount | nearBreach | breach |
      | 1            | 2026-01-01 | 2026-03-31 | 900.00           | 900.00            | true       | null   |
    When Admin closes the Working Capital loan with a full repayment on "20260326"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"
