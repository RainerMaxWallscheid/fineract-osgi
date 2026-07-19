@WorkingCapital
@WorkingCapitalLoanChargeAdjustmentFeature
Feature: WorkingCapitalLoanChargeAdjustmentFeature

  @TestRailId:C85221
  Scenario: Verify Working Capital fee charge adjustment - UC1: full fee charge adjustment is processed successfully
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260110" due date and 100.0 transaction amount
    Then Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 100.0      | 100.0           | 0.0      | 0.0            | 0.0                 | 0.0          |
    When Admin makes a charge adjustment for the last added charge with 100.0 amount on working capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type             | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement     | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260110 | Charge Adjustment | 100.0            | 0.0              | 100.0             | 0.0                   | false    |
    And Working Capital Loan has charges with the following data:
      | Charge Name              | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee | 20260110 | 100.0  | EUR      | false     | Specified due date | Flat                    | Regular             |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 100.0      | 0.0             | 100.0    | 0.0            | 0.0                 | 0.0          |

  @TestRailId:C85222
  Scenario: Verify Working Capital penalty charge adjustment - UC2: full penalty charge adjustment is processed successfully
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_PENALTY" specified due date charge to working capital loan with "20260110" due date and 50.0 transaction amount
    Then Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 0.0        | 0.0             | 0.0      | 50.0           | 50.0                | 0.0          |
    When Admin makes a charge adjustment for the last added charge with 50.0 amount on working capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260110 | Charge Adjustment | 50.0              | 0.0              | 0.0               | 50.0                  | false    |
    And Working Capital Loan has charges with the following data:
      | Charge Name                  | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Penalty | 20260110 | 50.0   | EUR      | true      | Specified due date | Flat                    | Regular             |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 0.0        | 0.0             | 0.0      | 50.0           | 0.0                 | 50.0         |

  @TestRailId:C85223
  Scenario: Verify Working Capital charge adjustment - UC3: partial fee charge adjustment leaves correct outstanding
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260110" due date and 100.0 transaction amount
    When Admin makes a charge adjustment for the last added charge with 40.0 amount on working capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260110 | Charge Adjustment | 40.0              | 0.0              | 40.0              | 0.0                   | false    |
    And Working Capital Loan has charges with the following data:
      | Charge Name              | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee | 20260110 | 100.0  | EUR      | false     | Specified due date | Flat                    | Regular             |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 100.0      | 60.0            | 40.0     | 0.0            | 0.0                 | 0.0          |

  @TestRailId:C85224
  Scenario: Verify Working Capital charge adjustment - UC4: partial penalty charge adjustment leaves correct outstanding
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_PENALTY" specified due date charge to working capital loan with "20260110" due date and 60.0 transaction amount
    When Admin makes a charge adjustment for the last added charge with 25.0 amount on working capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260110 | Charge Adjustment | 25.0              | 0.0              | 0.0               | 25.0                  | false    |
    And Working Capital Loan has charges with the following data:
      | Charge Name                  | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Penalty | 20260110 | 60.0   | EUR      | true      | Specified due date | Flat                    | Regular             |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 0.0        | 0.0             | 0.0      | 60.0           | 35.0                | 25.0         |

  @TestRailId:C85225
  Scenario: Verify Working Capital charge adjustment - UC5: two partial adjustments sum to full charge amount
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260110" due date and 100.0 transaction amount
    When Admin makes a charge adjustment for the last added charge with 60.0 amount on working capital loan
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 100.0      | 40.0            | 60.0     | 0.0            | 0.0                 | 0.0          |
    When Admin makes a charge adjustment for the last added charge with 40.0 amount on working capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260110 | Charge Adjustment | 60.0              | 0.0              | 60.0              | 0.0                   | false    |
      | 20260110 | Charge Adjustment | 40.0              | 0.0              | 40.0              | 0.0                   | false    |
    And Working Capital Loan has charges with the following data:
      | Charge Name              | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee | 20260110 | 100.0  | EUR      | false     | Specified due date | Flat                    | Regular             |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 100.0      | 0.0             | 100.0    | 0.0            | 0.0                 | 0.0          |

  @TestRailId:C85226
  Scenario: Verify Working Capital charge adjustment - UC6: two partial adjustments on different days sum to full charge amount
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260110" due date and 100.0 transaction amount
    When Admin sets the business date to "20260111"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin makes a charge adjustment for the last added charge with 60.0 amount on working capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260111 | Charge Adjustment | 60.0              | 0.0              | 60.0              | 0.0                   | false    |
    And Working Capital Loan has charges with the following data:
      | Charge Name              | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee | 20260110 | 100.0  | EUR      | false     | Specified due date | Flat                    | Regular             |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 100.0      | 40.0            | 60.0     | 0.0            | 0.0                 | 0.0          |
    When Admin sets the business date to "20260112"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin makes a charge adjustment for the last added charge with 40.0 amount on working capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260111 | Charge Adjustment | 60.0              | 0.0              | 60.0              | 0.0                   | false    |
      | 20260112 | Charge Adjustment | 40.0              | 0.0              | 40.0              | 0.0                   | false    |
    And Working Capital Loan has charges with the following data:
      | Charge Name              | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee | 20260110 | 100.0  | EUR      | false     | Specified due date | Flat                    | Regular             |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 100.0      | 0.0             | 100.0    | 0.0            | 0.0                 | 0.0          |

  @TestRailId:C85227
  Scenario: Verify Working Capital charge adjustment - UC7: fee and penalty charges adjusted independently
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct                    | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP_DUE_FEE_PENALTY_PRINCIPAL | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260110" due date and 80.0 transaction amount
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_PENALTY" specified due date charge to working capital loan with "20260110" due date and 30.0 transaction amount
    When Admin makes a charge adjustment for the last added fee charge with 80.0 amount on working capital loan
    And Admin makes a charge adjustment for the last added penalty charge with 30.0 amount on working capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260110 | Charge Adjustment | 80.0              | 0.0              | 80.0              | 0.0                   | false    |
      | 20260110 | Charge Adjustment | 30.0              | 0.0              | 0.0               | 30.0                  | false    |
    And Working Capital Loan has charges with the following data:
      | Charge Name                  | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee     | 20260110 | 80.0   | EUR      | false     | Specified due date | Flat                    | Regular             |
      | Working Capital Loan Penalty | 20260110 | 30.0   | EUR      | true      | Specified due date | Flat                    | Regular             |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 80.0       | 0.0             | 80.0     | 30.0           | 0.0                 | 30.0         |

  @TestRailId:C85228
  Scenario: Verify Working Capital charge adjustment - UC8: fee and penalty charges adjusted independently on different days
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct                    | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP_DUE_FEE_PENALTY_PRINCIPAL | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260110" due date and 80.0 transaction amount
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_PENALTY" specified due date charge to working capital loan with "20260110" due date and 30.0 transaction amount
    When Admin sets the business date to "20260111"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin makes a charge adjustment for the last added fee charge with 80.0 amount on working capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260111 | Charge Adjustment | 80.0              | 0.0              | 80.0              | 0.0                   | false    |
    And Working Capital Loan has charges with the following data:
      | Charge Name                  | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee     | 20260110 | 80.0   | EUR      | false     | Specified due date | Flat                    | Regular             |
      | Working Capital Loan Penalty | 20260110 | 30.0   | EUR      | true      | Specified due date | Flat                    | Regular             |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 80.0       | 0.0             | 80.0     | 30.0           | 30.0                | 0.0          |
    When Admin sets the business date to "20260112"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin makes a charge adjustment for the last added penalty charge with 30.0 amount on working capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260111 | Charge Adjustment | 80.0              | 0.0              | 80.0              | 0.0                   | false    |
      | 20260112 | Charge Adjustment | 30.0              | 0.0              | 0.0               | 30.0                  | false    |
    And Working Capital Loan has charges with the following data:
      | Charge Name                  | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee     | 20260110 | 80.0   | EUR      | false     | Specified due date | Flat                    | Regular             |
      | Working Capital Loan Penalty | 20260110 | 30.0   | EUR      | true      | Specified due date | Flat                    | Regular             |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 80.0       | 0.0             | 80.0     | 30.0           | 0.0                 | 30.0         |

  @TestRailId:C85229
  Scenario: Verify Working Capital charge adjustment - UC9: adjustment amount exceeding charge amount results an error (Negative)
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260110" due date and 100.0 transaction amount
    Then Making a charge adjustment with 101.0 amount on working capital loan results an error with the following data:
      | httpCode | errorMessage                                                                   |
      | 403      | Transaction amount cannot be higher than the charge amount           |

  @TestRailId:C85230
  Scenario: Verify Working Capital charge adjustment - UC10: second adjustment exceeding remaining available amount results an error (Negative)
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260110" due date and 100.0 transaction amount
    When Admin makes a charge adjustment for the last added charge with 90.0 amount on working capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260110 | Charge Adjustment | 90.0              | 0.0              | 90.0              | 0.0                   | false    |
    And Working Capital Loan has charges with the following data:
      | Charge Name              | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee | 20260110 | 100.0  | EUR      | false     | Specified due date | Flat                    | Regular             |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 100.0      | 10.0            | 90.0     | 0.0            | 0.0                 | 0.0          |
    Then Making a charge adjustment with 11.0 amount on working capital loan results an error with the following data:
      | httpCode | errorMessage                                                                              |
      | 403      | Transaction amount cannot be higher than the available charge amount for adjustment       |

  @TestRailId:C85231
  Scenario: Verify Working Capital charge adjustment - UC11: reversal of charge adjustment restores balances
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260110" due date and 100.0 transaction amount
    When Admin makes a charge adjustment for the last added charge with 100.0 amount on working capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260110 | Charge Adjustment | 100.0             | 0.0              | 100.0             | 0.0                   | false    |
    And Working Capital Loan has charges with the following data:
      | Charge Name              | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee | 20260110 | 100.0  | EUR      | false     | Specified due date | Flat                    | Regular             |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 100.0      | 0.0             | 100.0    | 0.0            | 0.0                 | 0.0          |
    When Admin reverts the last charge adjustment on working capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260110 | Charge Adjustment | 100.0             | 0.0              | 100.0             | 0.0                   | true     |
    And Working Capital Loan has charges with the following data:
      | Charge Name              | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee | 20260110 | 100.0  | EUR      | false     | Specified due date | Flat                    | Regular             |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 100.0      | 100.0           | 0.0      | 0.0            | 0.0                 | 0.0          |

  @TestRailId:C85232
  Scenario: Verify Working Capital charge adjustment - UC12: reversal of already reversed adjustment results an error (Negative)
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260110" due date and 100.0 transaction amount
    When Admin makes a charge adjustment for the last added charge with 100.0 amount on working capital loan
    And Admin reverts the last charge adjustment on working capital loan
    Then Reverting an already reversed charge adjustment on working capital loan results an error with the following data:
      | httpCode | errorMessage                                               |
      | 400      | Failed data validation due to: transaction.already.undone |

  @TestRailId:C85545
  Scenario: Verify Working Capital charge adjustment undo - UC1: undo of charge adjustment on active loan restores fee balances
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260110" due date and 100.0 transaction amount
    When Admin makes a charge adjustment for the last added charge with 100.0 amount on working capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260110 | Charge Adjustment | 100.0             | 0.0              | 100.0             | 0.0                   | false    |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 100.0      | 0.0             | 100.0    | 0.0            | 0.0                 | 0.0          |
    When Admin sets the business date to "20260115"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin reverts the last charge adjustment on working capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260110 | Charge Adjustment | 100.0             | 0.0              | 100.0             | 0.0                   | true     |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 100.0      | 100.0           | 0.0      | 0.0            | 0.0                 | 0.0          |
    And Working Capital loan balance payload contains the following fields:
      | field                | value  |
      | principalOutstanding | 9000.0 |
    Then Working Capital loan status will be "ACTIVE"
    #    --- Close loan ---
    When Admin closes the Working Capital loan with a full repayment on "20260115"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85546
  Scenario: Verify Working Capital charge adjustment undo - UC2: undo of charge adjustment on closed loan - loan remains closed
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260131" due date and 100.0 transaction amount
    When Admin sets the business date to "20260102"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Customer makes repayment on "20260102" with 9000.0 transaction amount on Working Capital loan
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"
    When Admin makes a charge adjustment for the last added charge with 40.0 amount on working capital loan
    Then Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 100.0      | 60.0            | 40.0     | 0.0            | 0.0                 | 0.0          |
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"
    When Admin sets the business date to "20260103"
    And Admin reverts the last charge adjustment on working capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260102 | Repayment         | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260102 | Charge Adjustment | 40.0              | 0.0              | 40.0              | 0.0                   | true     |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 100.0      | 100.0           | 0.0      | 0.0            | 0.0                 | 0.0          |
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85547
  Scenario: Verify Working Capital charge adjustment undo - UC3: undo of charge adjustment on active loan recalculates delinquency schedule
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260131"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan delinquency range schedule has the following data:
      | periodNumber | fromDate   | toDate     | expectedAmount | paidAmount | outstandingAmount | minPaymentCriteriaMet | delinquentAmount | delinquentDays |
      | 1            | 2026-01-01 | 2026-01-30 | 270.0          | 0.0        | 270.0             | false                 | 270.0            | 1              |
      | 2            | 2026-01-31 | 2026-03-01 | 270.0          | 0.0        | 270.0             | null                  | null             | null           |
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260131" due date and 270.0 transaction amount
    When Admin sets the business date to "20260201"
    And Admin makes a charge adjustment for the last added charge with 270.0 amount on working capital loan
    Then Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 270.0      | 0.0             | 270.0    | 0.0            | 0.0                 | 0.0          |
    And Working Capital loan delinquency range schedule has the following data:
      | periodNumber | fromDate   | toDate     | expectedAmount | paidAmount | outstandingAmount | minPaymentCriteriaMet | delinquentAmount | delinquentDays |
      | 1            | 2026-01-01 | 2026-01-30 | 270.0          | 270.0      | 0.0               | true                  | 0.0              | 0              |
      | 2            | 2026-01-31 | 2026-03-01 | 270.0          | 0.0        | 270.0             | null                  | null             | null           |
    When Admin reverts the last charge adjustment on working capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260201 | Charge Adjustment | 270.0            | 0.0              | 270.0             | 0.0                   | true     |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 270.0      | 270.0           | 0.0      | 0.0            | 0.0                 | 0.0          |
    And Working Capital loan delinquency range schedule has the following data:
      | periodNumber | fromDate   | toDate     | expectedAmount | paidAmount | outstandingAmount | minPaymentCriteriaMet | delinquentAmount | delinquentDays |
      | 1            | 2026-01-01 | 2026-01-30 | 270.0          | 0.0        | 270.0             | false                 | 270.0            | 2              |
      | 2            | 2026-01-31 | 2026-03-01 | 270.0          | 0.0        | 270.0             | null                  | null             | null           |
    Then Working Capital loan status will be "ACTIVE"
    #    --- Close loan ---
    When Admin closes the Working Capital loan with a full repayment on "20260201"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85548
  Scenario: Verify Working Capital charge adjustment undo - UC4: undo of repayment on closed loan reopens loan to ACTIVE
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Customer makes repayment on "20260110" with 9000.0 transaction amount on Working Capital loan
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"
    When Admin sets the business date to "20260115"
    And Customer undo "1"th "REPAYMENT" transaction made on "20260110" on Working Capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type         | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260110 | Repayment    | 9000.0            | 9000.0           | 0.0               | 0.0                   | true     |
    And Working Capital loan balance payload contains the following fields:
      | field                | value  |
      | principalOutstanding | 9000.0 |
    Then Working Capital loan status will be "ACTIVE"
    #    --- Close loan ---
    When Admin closes the Working Capital loan with a full repayment on "20260115"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C85549
  Scenario: Verify Working Capital charge adjustment undo - UC5: undo of charge adjustment with principal portion (via reprocessing) reopens closed loan to ACTIVE
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct               | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP_DUE_FEE_PENALTY_PRINCIPAL | 20260101 | 20260101     | 9000            | 100000       | 18                | 0        |
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260110" due date and 500.0 transaction amount
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin makes a charge adjustment for the last added charge with 500.0 amount on working capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260110 | Charge Adjustment | 500.0             | 0.0              | 500.0             | 0.0                   | false    |
    When Admin sets the business date to "20260120"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Customer makes repayment on "20260110" with 500.0 transaction amount on Working Capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260110 | Charge Adjustment | 500.0             | 0.0              | 500.0             | 0.0                   | false    |
      | 20260110 | Repayment         | 500.0             | 500.0            | 0.0               | 0.0                   | false    |
    And Customer makes repayment on "20260120" with 8500.0 transaction amount on Working Capital loan
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"
    When Admin sets the business date to "20260125"
    And Admin reverts the last charge adjustment on working capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260110 | Charge Adjustment | 500.0             | 0.0              | 500.0             | 0.0                   | true     |
      | 20260110 | Repayment         | 500.0             | 0.0              | 500.0             | 0.0                   | false    |
      | 20260120 | Repayment         | 8500.0            | 8500.0           | 0.0               | 0.0                   | false    |
    And Working Capital loan balance payload contains the following fields:
      | field                | value  |
      | principalOutstanding | 500.0  |
    Then Working Capital loan status will be "ACTIVE"
#    --- Close loan ---
    When Admin closes the Working Capital loan with a full repayment on "20260125"
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"
