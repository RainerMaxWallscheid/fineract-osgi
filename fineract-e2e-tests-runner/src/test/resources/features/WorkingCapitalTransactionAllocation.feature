@WorkingCapital
@WorkingCapitalTransactionAllocationFeature
Feature: Working Capital Transaction Allocation

  @TestRailId:C85412
  Scenario: Verify Working Capital Repayment transaction with fee and penalty added with DUE_FEE_PENALTY_PRINCIPAL allocation - UC1
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct                    | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP_DUE_FEE_PENALTY_PRINCIPAL | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260112" due date and 15.0 transaction amount
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_PENALTY" specified due date charge to working capital loan with "20260112" due date and 25.0 transaction amount
    Then Working Capital Loan has charges with the following data:
      | Charge Name                  | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee     | 20260112 | 15.0   | EUR      | false     | Specified due date | Flat                    | Regular             |
      | Working Capital Loan Penalty | 20260112 | 25.0   | EUR      | true      | Specified due date | Flat                    | Regular             |
    When Admin sets the business date to "20260112"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Customer makes repayment on "20260112" with 270.0 transaction amount on Working Capital loan
    And Working capital loan account has the correct data:
      | principal | totalPaidPrincipal | totalPaymentVolume | realizedIncome | unrealizedIncome | overpaymentAmount |
      | 9000.0    | 230.0              | 100000.0           | 0.0            | 0.0              | 0.0               |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 15.0       | 0.0             | 15.0     | 25.0           | 0.0                 | 25.0         |
    And Working Capital Loan has transactions:
      | transactionDate | type         | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260112 | Repayment    | 270.0             | 230.0            | 15.0              | 25.0                  | false    |

  @TestRailId:C85413
  Scenario: Verify Working Capital Repayment transaction with fee and penalty added with DUE_PENALTY_FEE_PRINCIPAL allocation - UC2
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct                | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP_ADVANCED_ACCOUNTING | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260112" due date and 15.0 transaction amount
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_PENALTY" specified due date charge to working capital loan with "20260112" due date and 25.0 transaction amount
    Then Working Capital Loan has charges with the following data:
      | Charge Name                  | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee     | 20260112 | 15.0   | EUR      | false     | Specified due date | Flat                    | Regular             |
      | Working Capital Loan Penalty | 20260112 | 25.0   | EUR      | true      | Specified due date | Flat                    | Regular             |
    When Admin sets the business date to "20260112"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Customer makes repayment on "20260112" with 270.0 transaction amount on Working Capital loan
    And Working capital loan account has the correct data:
      | principal | totalPaidPrincipal | totalPaymentVolume | realizedIncome | unrealizedIncome | overpaymentAmount |
      | 9000.0    | 230.0              | 100000.0           | 0.0            | 0.0              | 0.0               |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 15.0       | 0.0             | 15.0     | 25.0           | 0.0                 | 25.0         |
    And Working Capital Loan has transactions:
      | transactionDate | type         | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260112 | Repayment    | 270.0             | 230.0            | 15.0              | 25.0                  | false    |

  @TestRailId:C85414
  Scenario: Verify Working Capital Repayment transaction with fee and penalty added with DUE_PRINCIPAL_FEE_PENALTY allocation - UC3
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct                    | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP_DUE_PRINCIPAL_FEE_PENALTY | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260112" due date and 15.0 transaction amount
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_PENALTY" specified due date charge to working capital loan with "20260112" due date and 25.0 transaction amount
    Then Working Capital Loan has charges with the following data:
      | Charge Name                  | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee     | 20260112 | 15.0   | EUR      | false     | Specified due date | Flat                    | Regular             |
      | Working Capital Loan Penalty | 20260112 | 25.0   | EUR      | true      | Specified due date | Flat                    | Regular             |
    When Admin sets the business date to "20260112"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Customer makes repayment on "20260112" with 270.0 transaction amount on Working Capital loan
    And Working capital loan account has the correct data:
      | principal | totalPaidPrincipal | totalPaymentVolume | realizedIncome | unrealizedIncome | overpaymentAmount |
      | 9000.0    | 270.0              | 100000.0           | 0.0            | 0.0              | 0.0               |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 15.0       | 15.0            | 0.0      | 25.0           | 25.0                | 0.0          |
    And Working Capital Loan has transactions:
      | transactionDate | type         | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260112 | Repayment    | 270.0             | 270.0            | 0.0               | 0.0                   | false    |

  @TestRailId:C85415
  Scenario: Verify Working Capital Repayment transaction with fee and penalty added with DUE_FEE_PRINCIPAL_PENALTY allocation - UC4
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct                    | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP_DUE_FEE_PRINCIPAL_PENALTY | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260112" due date and 15.0 transaction amount
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_PENALTY" specified due date charge to working capital loan with "20260112" due date and 25.0 transaction amount
    Then Working Capital Loan has charges with the following data:
      | Charge Name                  | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee     | 20260112 | 15.0   | EUR      | false     | Specified due date | Flat                    | Regular             |
      | Working Capital Loan Penalty | 20260112 | 25.0   | EUR      | true      | Specified due date | Flat                    | Regular             |
    When Admin sets the business date to "20260112"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Customer makes repayment on "20260112" with 270.0 transaction amount on Working Capital loan
    And Working capital loan account has the correct data:
      | principal | totalPaidPrincipal | totalPaymentVolume | realizedIncome | unrealizedIncome | overpaymentAmount |
      | 9000.0    | 255.0              | 100000.0           | 0.0            | 0.0              | 0.0               |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 15.0       | 0.0             | 15.0     | 25.0           | 25.0                | 0.0          |
    And Working Capital Loan has transactions:
      | transactionDate | type         | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260112 | Repayment    | 270.0             | 255.0            | 15.0              | 0.0                   | false    |

  @TestRailId:C85416
  Scenario: Verify Working Capital Repayment transaction with fee and penalty added with IN_ADVANCE_PENALTY_FEE_PRINCIPAL allocation - UC5
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct                           | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP_IN_ADVANCE_PENALTY_FEE_PRINCIPAL | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260112" due date and 15.0 transaction amount
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_PENALTY" specified due date charge to working capital loan with "20260112" due date and 25.0 transaction amount
    Then Working Capital Loan has charges with the following data:
      | Charge Name                  | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee     | 20260112 | 15.0   | EUR      | false     | Specified due date | Flat                    | Regular             |
      | Working Capital Loan Penalty | 20260112 | 25.0   | EUR      | true      | Specified due date | Flat                    | Regular             |
    And Customer makes repayment on "20260110" with 270.0 transaction amount on Working Capital loan
    And Working capital loan account has the correct data:
      | principal | totalPaidPrincipal | totalPaymentVolume | realizedIncome | unrealizedIncome | overpaymentAmount |
      | 9000.0    | 230.0              | 100000.0           | 0.0            | 0.0              | 0.0               |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 15.0       | 0.0             | 15.0     | 25.0           | 0.0                 | 25.0         |
    And Working Capital Loan has transactions:
      | transactionDate | type         | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260110 | Repayment    | 270.0             | 230.0            | 15.0              | 25.0                  | false    |

  @TestRailId:C85417
  Scenario: Verify Working Capital Repayment transaction that closes loan with fee and penalty added with DUE_PRINCIPAL_FEE_PENALTY allocation - UC6
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct                    | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP_DUE_PRINCIPAL_FEE_PENALTY | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260112" due date and 15.0 transaction amount
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_PENALTY" specified due date charge to working capital loan with "20260112" due date and 25.0 transaction amount
    Then Working Capital Loan has charges with the following data:
      | Charge Name                  | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee     | 20260112 | 15.0   | EUR      | false     | Specified due date | Flat                    | Regular             |
      | Working Capital Loan Penalty | 20260112 | 25.0   | EUR      | true      | Specified due date | Flat                    | Regular             |
    When Admin sets the business date to "20260112"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Customer makes repayment on "20260112" with 9040.0 transaction amount on Working Capital loan
    And Working capital loan account has the correct data:
      | principal | totalPaidPrincipal | totalPaymentVolume | realizedIncome | unrealizedIncome | overpaymentAmount |
      | 9000.0    | 9000.0             | 100000.0           | 0.0            | 0.0              | 0.0               |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 15.0       | 0.0             | 15.0     | 25.0           | 0.0                 | 25.0         |
    And Working Capital Loan has transactions:
      | transactionDate | type         | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260112 | Repayment    | 9040.0            | 9000.0           | 15.0              | 25.0                  | false    |

  @TestRailId:C85418
  Scenario: Verify Working Capital Repayment transaction that overpays loon with following CBR trn and with fee and penalty added with DUE_PRINCIPAL_FEE_PENALTY allocation - UC7
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct              | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP_ADVANCED_ACCOUNTING | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260112" due date and 15.0 transaction amount
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_PENALTY" specified due date charge to working capital loan with "20260112" due date and 25.0 transaction amount
    Then Working Capital Loan has charges with the following data:
      | Charge Name                  | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee     | 20260112 | 15.0   | EUR      | false     | Specified due date | Flat                    | Regular             |
      | Working Capital Loan Penalty | 20260112 | 25.0   | EUR      | true      | Specified due date | Flat                    | Regular             |
    When Admin sets the business date to "20260112"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Customer makes repayment on "20260112" with 9200.0 transaction amount on Working Capital loan
    And Working capital loan account has the correct data:
      | principal | totalPaidPrincipal | totalPaymentVolume | realizedIncome | unrealizedIncome | overpaymentAmount |
      | 9000.0    | 9000.0             | 100000.0           | 0.0            | 0.0              | 160.0             |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 15.0       | 0.0             | 15.0     | 25.0           | 0.0                 | 25.0          |
    And Working Capital Loan has transactions:
      | transactionDate | type         | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260112 | Repayment    | 9200.0            | 9000.0           | 15.0              | 25.0                  | false    |
# --- make CBR trn to refund overpaid amount --- #
    And Customer makes credit balance refund on "20260112" with 160.0 transaction amount on Working Capital loan
    And Working capital loan account has the correct data:
      | principal | totalPaidPrincipal | totalPaymentVolume | realizedIncome | unrealizedIncome | overpaymentAmount |
      | 9000.0    | 9000.0             | 100000.0           | 0.0            | 0.0              | 0.0               |
    And Working Capital Loan has transactions:
      | transactionDate | type                  | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement          | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260112 | Repayment             | 9200.0            | 9000.0           | 15.0              | 25.0                  | false    |
      | 20260112 | Credit Balance Refund | 160.0             | 160.0            | 0.0               | 0.0                   | false    |

  @TestRailId:C85419
  Scenario: Verify Working Capital Repayment transaction allocation with charges has been reprocessed successfully after additional backdated repayment - UC8
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct                    | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP_DUE_FEE_PENALTY_PRINCIPAL | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260110" due date and 100.0 transaction amount
    Then Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 100.0      | 100.0           | 0.0      | 0.0            | 0.0                 | 0.0          |
    When Admin sets the business date to "20260120"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Customer makes repayment on "20260120" with 100.0 transaction amount on Working Capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260120 | Repayment         | 100.0             | 0.0              | 100.0             | 0.0                   | false    |
    And Working Capital Loan has charges with the following data:
      | Charge Name              | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee | 20260110 | 100.0  | EUR      | false     | Specified due date | Flat                    | Regular             |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 100.0      | 0.0             | 100.0    | 0.0            | 0.0                 | 0.0          |
# --- backdated repayment on Jan, 10, 20206 --- #
    And Customer makes repayment on "20260110" with 100.0 transaction amount on Working Capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260110 | Repayment         | 100.0             | 0.0              | 100.0             | 0.0                   | false    |
      | 20260120 | Repayment         | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
    And Working Capital Loan has charges with the following data:
      | Charge Name              | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee | 20260110 | 100.0  | EUR      | false     | Specified due date | Flat                    | Regular             |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 100.0      | 0.0             | 100.0    | 0.0            | 0.0                 | 0.0          |

  @TestRailId:C85420
  Scenario: Verify Working Capital fee charge adjustment transaction allocation with full fee charge adjustment is processed successfully - UC9
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct              | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP_ADVANCED_ACCOUNTING | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260110" due date and 100.0 transaction amount
    Then Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 100.0      | 100.0           | 0.0      | 0.0            | 0.0                 | 0.0          |
    When Admin sets the business date to "20260111"
    And Admin runs inline COB job for Working Capital Loan by loanId
    When Admin makes a charge adjustment for the last added charge with 70.0 amount on working capital loan
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260111 | Charge Adjustment | 70.0              | 0.0              | 70.0              | 0.0                   | false    |
    And Working Capital Loan has charges with the following data:
      | Charge Name              | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee | 20260110 | 100.0  | EUR      | false     | Specified due date | Flat                    | Regular             |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 100.0      | 30.0            | 70.0     | 0.0            | 0.0                 | 0.0          |

  @TestRailId:C85421
  Scenario: Verify Working Capital Repayment transaction with charge within amortization schedule with DUE_PENALTY_FEE_PRINCIPAL allocation - UC10
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct               | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP_ADVANCED_ACCOUNTING | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_PENALTY" specified due date charge to working capital loan with "20260110" due date and 35.0 transaction amount
    Then Working Capital Loan has charges with the following data:
      | Charge Name                  | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Penalty | 20260110 | 35.0   | EUR      | true      | Specified due date | Flat                    | Regular             |
    Then Working Capital Loan has transactions:
      | transactionDate | type              | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement      | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
    And Customer makes repayment on "20260110" with 270.0 transaction amount on Working Capital loan
    And Working capital loan account has the correct data:
      | principal | totalPaidPrincipal | totalPaymentVolume | realizedIncome | unrealizedIncome | overpaymentAmount |
      | 9000.0    | 235.0              | 100000.0           | 0.0            | 0.0              | 0.0               |
    And Working Capital Loan has transactions:
      | transactionDate | type         | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260110 | Repayment    | 270.0             | 235.0            | 0.0               | 35.0                  | false    |
    When Admin sets the business date to "20260111"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan amortization schedule has 186 periods, with the following data for periods:
      | paymentNo | paymentDate      | expectedPaymentAmount | actualPaymentAmount | expectedBalance | actualBalance | expectedAmortizationAmount | actualAmortizationAmount | expectedDiscountFeeBalance |
      | 0         | 20260101  | -9000.00              |                     | 9000.00         | 9000.00       |                            |                          | 0.00                       |
      | 1         | 20260102  | 50.00                 | 0.00                | 8950.00         | 9000.00       | 0.00                       | 0.00                     | 0.00                       |
      | 2         | 20260103  | 50.00                 | 0.00                | 8900.00         | 9000.00       | 0.00                       | 0.00                     | 0.00                       |
      | 3         | 20260104  | 50.00                 | 0.00                | 8850.00         | 9000.00       | 0.00                       | 0.00                     | 0.00                       |
      | 4         | 20260105  | 50.00                 | 0.00                | 8800.00         | 9000.00       | 0.00                       | 0.00                     | 0.00                       |
      | 5         | 20260106  | 50.00                 | 0.00                | 8750.00         | 9000.00       | 0.00                       | 0.00                     | 0.00                       |
      | 6         | 20260107  | 50.00                 | 0.00                | 8700.00         | 9000.00       | 0.00                       | 0.00                     | 0.00                       |
      | 7         | 20260108  | 50.00                 | 0.00                | 8650.00         | 9000.00       | 0.00                       | 0.00                     | 0.00                       |
      | 8         | 20260109  | 50.00                 | 0.00                | 8600.00         | 9000.00       | 0.00                       | 0.00                     | 0.00                       |
      | 9         | 20260110  | 50.00                 | 235.00              | 8550.00         | 8765.00       | 0.00                       | 0.00                     | 0.00                       |
      | 10        | 20260111  | 50.00                 |                     | 8500.00         |               | 0.00                       |                          | 0.00                       |
      | 11        | 20260112  | 50.00                 |                     | 8450.00         |               | 0.00                       |                          | 0.00                       |
      | 12        | 20260113  | 50.00                 |                     | 8400.00         |               | 0.00                       |                          | 0.00                       |
      | 13        | 20260114  | 50.00                 |                     | 8350.00         |               | 0.00                       |                          | 0.00                       |
      | 14        | 20260115  | 50.00                 |                     | 8300.00         |               | 0.00                       |                          | 0.00                       |
      | 15        | 20260116  | 50.00                 |                     | 8250.00         |               | 0.00                       |                          | 0.00                       |
      | 16        | 20260117  | 50.00                 |                     | 8200.00         |               | 0.00                       |                          | 0.00                       |
      | 17        | 20260118  | 50.00                 |                     | 8150.00         |               | 0.00                       |                          | 0.00                       |
      | 18        | 20260119  | 50.00                 |                     | 8100.00         |               | 0.00                       |                          | 0.00                       |
      | 19        | 20260120  | 50.00                 |                     | 8050.00         |               | 0.00                       |                          | 0.00                       |
      | 20        | 20260121  | 50.00                 |                     | 8000.00         |               | 0.00                       |                          | 0.00                       |
      | 21        | 20260122  | 50.00                 |                     | 7950.00         |               | 0.00                       |                          | 0.00                       |
      | 22        | 20260123  | 50.00                 |                     | 7900.00         |               | 0.00                       |                          | 0.00                       |
      | 23        | 20260124  | 50.00                 |                     | 7850.00         |               | 0.00                       |                          | 0.00                       |
      | 24        | 20260125  | 50.00                 |                     | 7800.00         |               | 0.00                       |                          | 0.00                       |
      | 25        | 20260126  | 50.00                 |                     | 7750.00         |               | 0.00                       |                          | 0.00                       |
      | 26        | 20260127  | 50.00                 |                     | 7700.00         |               | 0.00                       |                          | 0.00                       |
      | 27        | 20260128  | 50.00                 |                     | 7650.00         |               | 0.00                       |                          | 0.00                       |
      | 28        | 20260129  | 50.00                 |                     | 7600.00         |               | 0.00                       |                          | 0.00                       |
      | 29        | 20260130  | 50.00                 |                     | 7550.00         |               | 0.00                       |                          | 0.00                       |
      | 30        | 20260131  | 50.00                 |                     | 7500.00         |               | 0.00                       |                          | 0.00                       |
      | 31        | 20260201 | 50.00                 |                     | 7450.00         |               | 0.00                       |                          | 0.00                       |
      | 32        | 20260202 | 50.00                 |                     | 7400.00         |               | 0.00                       |                          | 0.00                       |
      | 33        | 20260203 | 50.00                 |                     | 7350.00         |               | 0.00                       |                          | 0.00                       |
      | 34        | 20260204 | 50.00                 |                     | 7300.00         |               | 0.00                       |                          | 0.00                       |
      | 35        | 20260205 | 50.00                 |                     | 7250.00         |               | 0.00                       |                          | 0.00                       |
      | 36        | 20260206 | 50.00                 |                     | 7200.00         |               | 0.00                       |                          | 0.00                       |
      | 37        | 20260207 | 50.00                 |                     | 7150.00         |               | 0.00                       |                          | 0.00                       |
      | 38        | 20260208 | 50.00                 |                     | 7100.00         |               | 0.00                       |                          | 0.00                       |
      | 39        | 20260209 | 50.00                 |                     | 7050.00         |               | 0.00                       |                          | 0.00                       |
      | 40        | 20260210 | 50.00                 |                     | 7000.00         |               | 0.00                       |                          | 0.00                       |
      | 41        | 20260211 | 50.00                 |                     | 6950.00         |               | 0.00                       |                          | 0.00                       |
      | 42        | 20260212 | 50.00                 |                     | 6900.00         |               | 0.00                       |                          | 0.00                       |
      | 43        | 20260213 | 50.00                 |                     | 6850.00         |               | 0.00                       |                          | 0.00                       |
      | 44        | 20260214 | 50.00                 |                     | 6800.00         |               | 0.00                       |                          | 0.00                       |
      | 45        | 20260215 | 50.00                 |                     | 6750.00         |               | 0.00                       |                          | 0.00                       |
      | 46        | 20260216 | 50.00                 |                     | 6700.00         |               | 0.00                       |                          | 0.00                       |
      | 47        | 20260217 | 50.00                 |                     | 6650.00         |               | 0.00                       |                          | 0.00                       |
      | 48        | 20260218 | 50.00                 |                     | 6600.00         |               | 0.00                       |                          | 0.00                       |
      | 49        | 20260219 | 50.00                 |                     | 6550.00         |               | 0.00                       |                          | 0.00                       |
      | 50        | 20260220 | 50.00                 |                     | 6500.00         |               | 0.00                       |                          | 0.00                       |
      | 51        | 20260221 | 50.00                 |                     | 6450.00         |               | 0.00                       |                          | 0.00                       |
      | 52        | 20260222 | 50.00                 |                     | 6400.00         |               | 0.00                       |                          | 0.00                       |
      | 53        | 20260223 | 50.00                 |                     | 6350.00         |               | 0.00                       |                          | 0.00                       |
      | 54        | 20260224 | 50.00                 |                     | 6300.00         |               | 0.00                       |                          | 0.00                       |
      | 55        | 20260225 | 50.00                 |                     | 6250.00         |               | 0.00                       |                          | 0.00                       |
      | 56        | 20260226 | 50.00                 |                     | 6200.00         |               | 0.00                       |                          | 0.00                       |
      | 57        | 20260227 | 50.00                 |                     | 6150.00         |               | 0.00                       |                          | 0.00                       |
      | 58        | 20260228 | 50.00                 |                     | 6100.00         |               | 0.00                       |                          | 0.00                       |
      | 59        | 20260301    | 50.00                 |                     | 6050.00         |               | 0.00                       |                          | 0.00                       |
      | 60        | 20260302    | 50.00                 |                     | 6000.00         |               | 0.00                       |                          | 0.00                       |
      | 61        | 20260303    | 50.00                 |                     | 5950.00         |               | 0.00                       |                          | 0.00                       |
      | 62        | 20260304    | 50.00                 |                     | 5900.00         |               | 0.00                       |                          | 0.00                       |
      | 63        | 20260305    | 50.00                 |                     | 5850.00         |               | 0.00                       |                          | 0.00                       |
      | 64        | 20260306    | 50.00                 |                     | 5800.00         |               | 0.00                       |                          | 0.00                       |
      | 65        | 20260307    | 50.00                 |                     | 5750.00         |               | 0.00                       |                          | 0.00                       |
      | 66        | 20260308    | 50.00                 |                     | 5700.00         |               | 0.00                       |                          | 0.00                       |
      | 67        | 20260309    | 50.00                 |                     | 5650.00         |               | 0.00                       |                          | 0.00                       |
      | 68        | 20260310    | 50.00                 |                     | 5600.00         |               | 0.00                       |                          | 0.00                       |
      | 69        | 20260311    | 50.00                 |                     | 5550.00         |               | 0.00                       |                          | 0.00                       |
      | 70        | 20260312    | 50.00                 |                     | 5500.00         |               | 0.00                       |                          | 0.00                       |
      | 71        | 20260313    | 50.00                 |                     | 5450.00         |               | 0.00                       |                          | 0.00                       |
      | 72        | 20260314    | 50.00                 |                     | 5400.00         |               | 0.00                       |                          | 0.00                       |
      | 73        | 20260315    | 50.00                 |                     | 5350.00         |               | 0.00                       |                          | 0.00                       |
      | 74        | 20260316    | 50.00                 |                     | 5300.00         |               | 0.00                       |                          | 0.00                       |
      | 75        | 20260317    | 50.00                 |                     | 5250.00         |               | 0.00                       |                          | 0.00                       |
      | 76        | 20260318    | 50.00                 |                     | 5200.00         |               | 0.00                       |                          | 0.00                       |
      | 77        | 20260319    | 50.00                 |                     | 5150.00         |               | 0.00                       |                          | 0.00                       |
      | 78        | 20260320    | 50.00                 |                     | 5100.00         |               | 0.00                       |                          | 0.00                       |
      | 79        | 20260321    | 50.00                 |                     | 5050.00         |               | 0.00                       |                          | 0.00                       |
      | 80        | 20260322    | 50.00                 |                     | 5000.00         |               | 0.00                       |                          | 0.00                       |
      | 81        | 20260323    | 50.00                 |                     | 4950.00         |               | 0.00                       |                          | 0.00                       |
      | 82        | 20260324    | 50.00                 |                     | 4900.00         |               | 0.00                       |                          | 0.00                       |
      | 83        | 20260325    | 50.00                 |                     | 4850.00         |               | 0.00                       |                          | 0.00                       |
      | 84        | 20260326    | 50.00                 |                     | 4800.00         |               | 0.00                       |                          | 0.00                       |
      | 85        | 20260327    | 50.00                 |                     | 4750.00         |               | 0.00                       |                          | 0.00                       |
      | 86        | 20260328    | 50.00                 |                     | 4700.00         |               | 0.00                       |                          | 0.00                       |
      | 87        | 20260329    | 50.00                 |                     | 4650.00         |               | 0.00                       |                          | 0.00                       |
      | 88        | 20260330    | 50.00                 |                     | 4600.00         |               | 0.00                       |                          | 0.00                       |
      | 89        | 20260331    | 50.00                 |                     | 4550.00         |               | 0.00                       |                          | 0.00                       |
      | 90        | 20260401    | 50.00                 |                     | 4500.00         |               | 0.00                       |                          | 0.00                       |
      | 91        | 20260402    | 50.00                 |                     | 4450.00         |               | 0.00                       |                          | 0.00                       |
      | 92        | 20260403    | 50.00                 |                     | 4400.00         |               | 0.00                       |                          | 0.00                       |
      | 93        | 20260404    | 50.00                 |                     | 4350.00         |               | 0.00                       |                          | 0.00                       |
      | 94        | 20260405    | 50.00                 |                     | 4300.00         |               | 0.00                       |                          | 0.00                       |
      | 95        | 20260406    | 50.00                 |                     | 4250.00         |               | 0.00                       |                          | 0.00                       |
      | 96        | 20260407    | 50.00                 |                     | 4200.00         |               | 0.00                       |                          | 0.00                       |
      | 97        | 20260408    | 50.00                 |                     | 4150.00         |               | 0.00                       |                          | 0.00                       |
      | 98        | 20260409    | 50.00                 |                     | 4100.00         |               | 0.00                       |                          | 0.00                       |
      | 99        | 20260410    | 50.00                 |                     | 4050.00         |               | 0.00                       |                          | 0.00                       |
      | 100       | 20260411    | 50.00                 |                     | 4000.00         |               | 0.00                       |                          | 0.00                       |
      | 101       | 20260412    | 50.00                 |                     | 3950.00         |               | 0.00                       |                          | 0.00                       |
      | 102       | 20260413    | 50.00                 |                     | 3900.00         |               | 0.00                       |                          | 0.00                       |
      | 103       | 20260414    | 50.00                 |                     | 3850.00         |               | 0.00                       |                          | 0.00                       |
      | 104       | 20260415    | 50.00                 |                     | 3800.00         |               | 0.00                       |                          | 0.00                       |
      | 105       | 20260416    | 50.00                 |                     | 3750.00         |               | 0.00                       |                          | 0.00                       |
      | 106       | 20260417    | 50.00                 |                     | 3700.00         |               | 0.00                       |                          | 0.00                       |
      | 107       | 20260418    | 50.00                 |                     | 3650.00         |               | 0.00                       |                          | 0.00                       |
      | 108       | 20260419    | 50.00                 |                     | 3600.00         |               | 0.00                       |                          | 0.00                       |
      | 109       | 20260420    | 50.00                 |                     | 3550.00         |               | 0.00                       |                          | 0.00                       |
      | 110       | 20260421    | 50.00                 |                     | 3500.00         |               | 0.00                       |                          | 0.00                       |
      | 111       | 20260422    | 50.00                 |                     | 3450.00         |               | 0.00                       |                          | 0.00                       |
      | 112       | 20260423    | 50.00                 |                     | 3400.00         |               | 0.00                       |                          | 0.00                       |
      | 113       | 20260424    | 50.00                 |                     | 3350.00         |               | 0.00                       |                          | 0.00                       |
      | 114       | 20260425    | 50.00                 |                     | 3300.00         |               | 0.00                       |                          | 0.00                       |
      | 115       | 20260426    | 50.00                 |                     | 3250.00         |               | 0.00                       |                          | 0.00                       |
      | 116       | 20260427    | 50.00                 |                     | 3200.00         |               | 0.00                       |                          | 0.00                       |
      | 117       | 20260428    | 50.00                 |                     | 3150.00         |               | 0.00                       |                          | 0.00                       |
      | 118       | 20260429    | 50.00                 |                     | 3100.00         |               | 0.00                       |                          | 0.00                       |
      | 119       | 20260430    | 50.00                 |                     | 3050.00         |               | 0.00                       |                          | 0.00                       |
      | 120       | 20260501      | 50.00                 |                     | 3000.00         |               | 0.00                       |                          | 0.00                       |
      | 121       | 20260502      | 50.00                 |                     | 2950.00         |               | 0.00                       |                          | 0.00                       |
      | 122       | 20260503      | 50.00                 |                     | 2900.00         |               | 0.00                       |                          | 0.00                       |
      | 123       | 20260504      | 50.00                 |                     | 2850.00         |               | 0.00                       |                          | 0.00                       |
      | 124       | 20260505      | 50.00                 |                     | 2800.00         |               | 0.00                       |                          | 0.00                       |
      | 125       | 20260506      | 50.00                 |                     | 2750.00         |               | 0.00                       |                          | 0.00                       |
      | 126       | 20260507      | 50.00                 |                     | 2700.00         |               | 0.00                       |                          | 0.00                       |
      | 127       | 20260508      | 50.00                 |                     | 2650.00         |               | 0.00                       |                          | 0.00                       |
      | 128       | 20260509      | 50.00                 |                     | 2600.00         |               | 0.00                       |                          | 0.00                       |
      | 129       | 20260510      | 50.00                 |                     | 2550.00         |               | 0.00                       |                          | 0.00                       |
      | 130       | 20260511      | 50.00                 |                     | 2500.00         |               | 0.00                       |                          | 0.00                       |
      | 131       | 20260512      | 50.00                 |                     | 2450.00         |               | 0.00                       |                          | 0.00                       |
      | 132       | 20260513      | 50.00                 |                     | 2400.00         |               | 0.00                       |                          | 0.00                       |
      | 133       | 20260514      | 50.00                 |                     | 2350.00         |               | 0.00                       |                          | 0.00                       |
      | 134       | 20260515      | 50.00                 |                     | 2300.00         |               | 0.00                       |                          | 0.00                       |
      | 135       | 20260516      | 50.00                 |                     | 2250.00         |               | 0.00                       |                          | 0.00                       |
      | 136       | 20260517      | 50.00                 |                     | 2200.00         |               | 0.00                       |                          | 0.00                       |
      | 137       | 20260518      | 50.00                 |                     | 2150.00         |               | 0.00                       |                          | 0.00                       |
      | 138       | 20260519      | 50.00                 |                     | 2100.00         |               | 0.00                       |                          | 0.00                       |
      | 139       | 20260520      | 50.00                 |                     | 2050.00         |               | 0.00                       |                          | 0.00                       |
      | 140       | 20260521      | 50.00                 |                     | 2000.00         |               | 0.00                       |                          | 0.00                       |
      | 141       | 20260522      | 50.00                 |                     | 1950.00         |               | 0.00                       |                          | 0.00                       |
      | 142       | 20260523      | 50.00                 |                     | 1900.00         |               | 0.00                       |                          | 0.00                       |
      | 143       | 20260524      | 50.00                 |                     | 1850.00         |               | 0.00                       |                          | 0.00                       |
      | 144       | 20260525      | 50.00                 |                     | 1800.00         |               | 0.00                       |                          | 0.00                       |
      | 145       | 20260526      | 50.00                 |                     | 1750.00         |               | 0.00                       |                          | 0.00                       |
      | 146       | 20260527      | 50.00                 |                     | 1700.00         |               | 0.00                       |                          | 0.00                       |
      | 147       | 20260528      | 50.00                 |                     | 1650.00         |               | 0.00                       |                          | 0.00                       |
      | 148       | 20260529      | 50.00                 |                     | 1600.00         |               | 0.00                       |                          | 0.00                       |
      | 149       | 20260530      | 50.00                 |                     | 1550.00         |               | 0.00                       |                          | 0.00                       |
      | 150       | 20260531      | 50.00                 |                     | 1500.00         |               | 0.00                       |                          | 0.00                       |
      | 151       | 20260601     | 50.00                 |                     | 1450.00         |               | 0.00                       |                          | 0.00                       |
      | 152       | 20260602     | 50.00                 |                     | 1400.00         |               | 0.00                       |                          | 0.00                       |
      | 153       | 20260603     | 50.00                 |                     | 1350.00         |               | 0.00                       |                          | 0.00                       |
      | 154       | 20260604     | 50.00                 |                     | 1300.00         |               | 0.00                       |                          | 0.00                       |
      | 155       | 20260605     | 50.00                 |                     | 1250.00         |               | 0.00                       |                          | 0.00                       |
      | 156       | 20260606     | 50.00                 |                     | 1200.00         |               | 0.00                       |                          | 0.00                       |
      | 157       | 20260607     | 50.00                 |                     | 1150.00         |               | 0.00                       |                          | 0.00                       |
      | 158       | 20260608     | 50.00                 |                     | 1100.00         |               | 0.00                       |                          | 0.00                       |
      | 159       | 20260609     | 50.00                 |                     | 1050.00         |               | 0.00                       |                          | 0.00                       |
      | 160       | 20260610     | 50.00                 |                     | 1000.00         |               | 0.00                       |                          | 0.00                       |
      | 161       | 20260611     | 50.00                 |                     | 950.00          |               | 0.00                       |                          | 0.00                       |
      | 162       | 20260612     | 50.00                 |                     | 900.00          |               | 0.00                       |                          | 0.00                       |
      | 163       | 20260613     | 50.00                 |                     | 850.00          |               | 0.00                       |                          | 0.00                       |
      | 164       | 20260614     | 50.00                 |                     | 800.00          |               | 0.00                       |                          | 0.00                       |
      | 165       | 20260615     | 50.00                 |                     | 750.00          |               | 0.00                       |                          | 0.00                       |
      | 166       | 20260616     | 50.00                 |                     | 700.00          |               | 0.00                       |                          | 0.00                       |
      | 167       | 20260617     | 50.00                 |                     | 650.00          |               | 0.00                       |                          | 0.00                       |
      | 168       | 20260618     | 50.00                 |                     | 600.00          |               | 0.00                       |                          | 0.00                       |
      | 169       | 20260619     | 50.00                 |                     | 550.00          |               | 0.00                       |                          | 0.00                       |
      | 170       | 20260620     | 50.00                 |                     | 500.00          |               | 0.00                       |                          | 0.00                       |
      | 171       | 20260621     | 50.00                 |                     | 450.00          |               | 0.00                       |                          | 0.00                       |
      | 172       | 20260622     | 50.00                 |                     | 400.00          |               | 0.00                       |                          | 0.00                       |
      | 173       | 20260623     | 50.00                 |                     | 350.00          |               | 0.00                       |                          | 0.00                       |
      | 174       | 20260624     | 50.00                 |                     | 300.00          |               | 0.00                       |                          | 0.00                       |
      | 175       | 20260625     | 50.00                 |                     | 250.00          |               | 0.00                       |                          | 0.00                       |
      | 176       | 20260626     | 50.00                 |                     | 200.00          |               | 0.00                       |                          | 0.00                       |
      | 177       | 20260627     | 50.00                 |                     | 150.00          |               | 0.00                       |                          | 0.00                       |
      | 178       | 20260628     | 50.00                 |                     | 100.00          |               | 0.00                       |                          | 0.00                       |
      | 179       | 20260629     | 50.00                 |                     | 50.00           |               | 0.00                       |                          | 0.00                       |
      | 180       | 20260630     | 50.00                 |                     | 0.00            |               | 0.00                       |                          | 0.00                       |
      | 181       | 20260701     | 50.00                 |                     | 0.00            |               | 0.00                       |                          | 0.00                       |
      | 182       | 20260702     | 50.00                 |                     | 0.00            |               | 0.00                       |                          | 0.00                       |
      | 183       | 20260703     | 50.00                 |                     | 0.00            |               | 0.00                       |                          | 0.00                       |
      | 184       | 20260704     | 50.00                 |                     | 0.00            |               | 0.00                       |                          | 0.00                       |
      | 185       | 20260705     | 15.00                 |                     | 0.00            |               | 0.00                       |                          | 0.00                       |

  @TestRailId:C85422
  Scenario: Verify Working Capital Repayment with fee and penalty charges within amortization schedule with DUE_FEE_PENALTY_PRINCIPAL allocation - UC11
    Given Admin sets the business date to "20260101"
    And Admin creates a client with random data and creates-approves-disburses a working capital loan with the following data:
      | LoanProduct                    | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP_DUE_FEE_PENALTY_PRINCIPAL | 20260101 | 20260101          | 9000            | 100000       | 18                | 0        |
    When Admin sets the business date to "20260110"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_FEE" specified due date charge to working capital loan with "20260112" due date and 35.0 transaction amount
    And Admin adds "WORKING_CAPITAL_SPECIFIED_DUE_DATE_PENALTY" specified due date charge to working capital loan with "20260112" due date and 43.0 transaction amount
    Then Working Capital Loan has charges with the following data:
      | Charge Name                  | Due Date        | Amount | Currency | isPenalty | Charge Time Type   | Charge Calculation Type | Charge Payment mode |
      | Working Capital Loan Fee     | 20260112 | 35.0   | EUR      | false     | Specified due date | Flat                    | Regular             |
      | Working Capital Loan Penalty | 20260112 | 43.0   | EUR      | true      | Specified due date | Flat                    | Regular             |
    When Admin sets the business date to "20260112"
    And Admin runs inline COB job for Working Capital Loan by loanId
    And Customer makes repayment on "20260112" with 270.0 transaction amount on Working Capital loan
    And Working capital loan account has the correct data:
      | principal | totalPaidPrincipal | totalPaymentVolume | realizedIncome | unrealizedIncome | overpaymentAmount |
      | 9000.0    | 192.0              | 100000.0           | 0.0            | 0.0              | 0.0             |
    And Working Capital Loan charge balances has the following data:
      | Fee Amount | Fee Outstanding | Fee Paid | Penalty Amount | Penalty Outstanding | Penalty Paid |
      | 35.0       | 0.0             | 35.0     | 43.0           | 0.0                 | 43.0         |
    And Working Capital Loan has transactions:
      | transactionDate | type         | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260112 | Repayment    | 270.0             | 192.0            | 35.0              | 43.0                  | false    |
    When Admin sets the business date to "20260113"
    And Admin runs inline COB job for Working Capital Loan by loanId
    Then Working Capital loan amortization schedule has 189 periods, with the following data for periods:
      | paymentNo | paymentDate      | expectedPaymentAmount | actualPaymentAmount | expectedBalance | actualBalance | expectedAmortizationAmount | actualAmortizationAmount | expectedDiscountFeeBalance |
      | 0         | 20260101  | -9000.00              |                     | 9000.00         | 9000.00       |                            |                          | 0.00                       |
      | 1         | 20260102  | 50.00                 | 0.00                | 8950.00         | 9000.00       | 0.00                       | 0.00                     | 0.00                       |
      | 2         | 20260103  | 50.00                 | 0.00                | 8900.00         | 9000.00       | 0.00                       | 0.00                     | 0.00                       |
      | 3         | 20260104  | 50.00                 | 0.00                | 8850.00         | 9000.00       | 0.00                       | 0.00                     | 0.00                       |
      | 4         | 20260105  | 50.00                 | 0.00                | 8800.00         | 9000.00       | 0.00                       | 0.00                     | 0.00                       |
      | 5         | 20260106  | 50.00                 | 0.00                | 8750.00         | 9000.00       | 0.00                       | 0.00                     | 0.00                       |
      | 6         | 20260107  | 50.00                 | 0.00                | 8700.00         | 9000.00       | 0.00                       | 0.00                     | 0.00                       |
      | 7         | 20260108  | 50.00                 | 0.00                | 8650.00         | 9000.00       | 0.00                       | 0.00                     | 0.00                       |
      | 8         | 20260109  | 50.00                 | 0.00                | 8600.00         | 9000.00       | 0.00                       | 0.00                     | 0.00                       |
      | 9         | 20260110  | 50.00                 | 0.00                | 8550.00         | 9000.00       | 0.00                       | 0.00                     | 0.00                       |
      | 10        | 20260111  | 50.00                 | 0.00                | 8500.00         | 9000.00       | 0.00                       | 0.00                     | 0.00                       |
      | 11        | 20260112  | 50.00                 | 192.00              | 8450.00         | 8808.00       | 0.00                       | 0.00                     | 0.00                       |
      | 12        | 20260113  | 50.00                 |                     | 8400.00         |               | 0.00                       |                          | 0.00                       |
      | 13        | 20260114  | 50.00                 |                     | 8350.00         |               | 0.00                       |                          | 0.00                       |
      | 14        | 20260115  | 50.00                 |                     | 8300.00         |               | 0.00                       |                          | 0.00                       |
      | 15        | 20260116  | 50.00                 |                     | 8250.00         |               | 0.00                       |                          | 0.00                       |
      | 16        | 20260117  | 50.00                 |                     | 8200.00         |               | 0.00                       |                          | 0.00                       |
      | 17        | 20260118  | 50.00                 |                     | 8150.00         |               | 0.00                       |                          | 0.00                       |
      | 18        | 20260119  | 50.00                 |                     | 8100.00         |               | 0.00                       |                          | 0.00                       |
      | 19        | 20260120  | 50.00                 |                     | 8050.00         |               | 0.00                       |                          | 0.00                       |
      | 20        | 20260121  | 50.00                 |                     | 8000.00         |               | 0.00                       |                          | 0.00                       |
      | 21        | 20260122  | 50.00                 |                     | 7950.00         |               | 0.00                       |                          | 0.00                       |
      | 22        | 20260123  | 50.00                 |                     | 7900.00         |               | 0.00                       |                          | 0.00                       |
      | 23        | 20260124  | 50.00                 |                     | 7850.00         |               | 0.00                       |                          | 0.00                       |
      | 24        | 20260125  | 50.00                 |                     | 7800.00         |               | 0.00                       |                          | 0.00                       |
      | 25        | 20260126  | 50.00                 |                     | 7750.00         |               | 0.00                       |                          | 0.00                       |
      | 26        | 20260127  | 50.00                 |                     | 7700.00         |               | 0.00                       |                          | 0.00                       |
      | 27        | 20260128  | 50.00                 |                     | 7650.00         |               | 0.00                       |                          | 0.00                       |
      | 28        | 20260129  | 50.00                 |                     | 7600.00         |               | 0.00                       |                          | 0.00                       |
      | 29        | 20260130  | 50.00                 |                     | 7550.00         |               | 0.00                       |                          | 0.00                       |
      | 30        | 20260131  | 50.00                 |                     | 7500.00         |               | 0.00                       |                          | 0.00                       |
      | 31        | 20260201 | 50.00                 |                     | 7450.00         |               | 0.00                       |                          | 0.00                       |
      | 32        | 20260202 | 50.00                 |                     | 7400.00         |               | 0.00                       |                          | 0.00                       |
      | 33        | 20260203 | 50.00                 |                     | 7350.00         |               | 0.00                       |                          | 0.00                       |
      | 34        | 20260204 | 50.00                 |                     | 7300.00         |               | 0.00                       |                          | 0.00                       |
      | 35        | 20260205 | 50.00                 |                     | 7250.00         |               | 0.00                       |                          | 0.00                       |
      | 36        | 20260206 | 50.00                 |                     | 7200.00         |               | 0.00                       |                          | 0.00                       |
      | 37        | 20260207 | 50.00                 |                     | 7150.00         |               | 0.00                       |                          | 0.00                       |
      | 38        | 20260208 | 50.00                 |                     | 7100.00         |               | 0.00                       |                          | 0.00                       |
      | 39        | 20260209 | 50.00                 |                     | 7050.00         |               | 0.00                       |                          | 0.00                       |
      | 40        | 20260210 | 50.00                 |                     | 7000.00         |               | 0.00                       |                          | 0.00                       |
      | 41        | 20260211 | 50.00                 |                     | 6950.00         |               | 0.00                       |                          | 0.00                       |
      | 42        | 20260212 | 50.00                 |                     | 6900.00         |               | 0.00                       |                          | 0.00                       |
      | 43        | 20260213 | 50.00                 |                     | 6850.00         |               | 0.00                       |                          | 0.00                       |
      | 44        | 20260214 | 50.00                 |                     | 6800.00         |               | 0.00                       |                          | 0.00                       |
      | 45        | 20260215 | 50.00                 |                     | 6750.00         |               | 0.00                       |                          | 0.00                       |
      | 46        | 20260216 | 50.00                 |                     | 6700.00         |               | 0.00                       |                          | 0.00                       |
      | 47        | 20260217 | 50.00                 |                     | 6650.00         |               | 0.00                       |                          | 0.00                       |
      | 48        | 20260218 | 50.00                 |                     | 6600.00         |               | 0.00                       |                          | 0.00                       |
      | 49        | 20260219 | 50.00                 |                     | 6550.00         |               | 0.00                       |                          | 0.00                       |
      | 50        | 20260220 | 50.00                 |                     | 6500.00         |               | 0.00                       |                          | 0.00                       |
      | 51        | 20260221 | 50.00                 |                     | 6450.00         |               | 0.00                       |                          | 0.00                       |
      | 52        | 20260222 | 50.00                 |                     | 6400.00         |               | 0.00                       |                          | 0.00                       |
      | 53        | 20260223 | 50.00                 |                     | 6350.00         |               | 0.00                       |                          | 0.00                       |
      | 54        | 20260224 | 50.00                 |                     | 6300.00         |               | 0.00                       |                          | 0.00                       |
      | 55        | 20260225 | 50.00                 |                     | 6250.00         |               | 0.00                       |                          | 0.00                       |
      | 56        | 20260226 | 50.00                 |                     | 6200.00         |               | 0.00                       |                          | 0.00                       |
      | 57        | 20260227 | 50.00                 |                     | 6150.00         |               | 0.00                       |                          | 0.00                       |
      | 58        | 20260228 | 50.00                 |                     | 6100.00         |               | 0.00                       |                          | 0.00                       |
      | 59        | 20260301    | 50.00                 |                     | 6050.00         |               | 0.00                       |                          | 0.00                       |
      | 60        | 20260302    | 50.00                 |                     | 6000.00         |               | 0.00                       |                          | 0.00                       |
      | 61        | 20260303    | 50.00                 |                     | 5950.00         |               | 0.00                       |                          | 0.00                       |
      | 62        | 20260304    | 50.00                 |                     | 5900.00         |               | 0.00                       |                          | 0.00                       |
      | 63        | 20260305    | 50.00                 |                     | 5850.00         |               | 0.00                       |                          | 0.00                       |
      | 64        | 20260306    | 50.00                 |                     | 5800.00         |               | 0.00                       |                          | 0.00                       |
      | 65        | 20260307    | 50.00                 |                     | 5750.00         |               | 0.00                       |                          | 0.00                       |
      | 66        | 20260308    | 50.00                 |                     | 5700.00         |               | 0.00                       |                          | 0.00                       |
      | 67        | 20260309    | 50.00                 |                     | 5650.00         |               | 0.00                       |                          | 0.00                       |
      | 68        | 20260310    | 50.00                 |                     | 5600.00         |               | 0.00                       |                          | 0.00                       |
      | 69        | 20260311    | 50.00                 |                     | 5550.00         |               | 0.00                       |                          | 0.00                       |
      | 70        | 20260312    | 50.00                 |                     | 5500.00         |               | 0.00                       |                          | 0.00                       |
      | 71        | 20260313    | 50.00                 |                     | 5450.00         |               | 0.00                       |                          | 0.00                       |
      | 72        | 20260314    | 50.00                 |                     | 5400.00         |               | 0.00                       |                          | 0.00                       |
      | 73        | 20260315    | 50.00                 |                     | 5350.00         |               | 0.00                       |                          | 0.00                       |
      | 74        | 20260316    | 50.00                 |                     | 5300.00         |               | 0.00                       |                          | 0.00                       |
      | 75        | 20260317    | 50.00                 |                     | 5250.00         |               | 0.00                       |                          | 0.00                       |
      | 76        | 20260318    | 50.00                 |                     | 5200.00         |               | 0.00                       |                          | 0.00                       |
      | 77        | 20260319    | 50.00                 |                     | 5150.00         |               | 0.00                       |                          | 0.00                       |
      | 78        | 20260320    | 50.00                 |                     | 5100.00         |               | 0.00                       |                          | 0.00                       |
      | 79        | 20260321    | 50.00                 |                     | 5050.00         |               | 0.00                       |                          | 0.00                       |
      | 80        | 20260322    | 50.00                 |                     | 5000.00         |               | 0.00                       |                          | 0.00                       |
      | 81        | 20260323    | 50.00                 |                     | 4950.00         |               | 0.00                       |                          | 0.00                       |
      | 82        | 20260324    | 50.00                 |                     | 4900.00         |               | 0.00                       |                          | 0.00                       |
      | 83        | 20260325    | 50.00                 |                     | 4850.00         |               | 0.00                       |                          | 0.00                       |
      | 84        | 20260326    | 50.00                 |                     | 4800.00         |               | 0.00                       |                          | 0.00                       |
      | 85        | 20260327    | 50.00                 |                     | 4750.00         |               | 0.00                       |                          | 0.00                       |
      | 86        | 20260328    | 50.00                 |                     | 4700.00         |               | 0.00                       |                          | 0.00                       |
      | 87        | 20260329    | 50.00                 |                     | 4650.00         |               | 0.00                       |                          | 0.00                       |
      | 88        | 20260330    | 50.00                 |                     | 4600.00         |               | 0.00                       |                          | 0.00                       |
      | 89        | 20260331    | 50.00                 |                     | 4550.00         |               | 0.00                       |                          | 0.00                       |
      | 90        | 20260401    | 50.00                 |                     | 4500.00         |               | 0.00                       |                          | 0.00                       |
      | 91        | 20260402    | 50.00                 |                     | 4450.00         |               | 0.00                       |                          | 0.00                       |
      | 92        | 20260403    | 50.00                 |                     | 4400.00         |               | 0.00                       |                          | 0.00                       |
      | 93        | 20260404    | 50.00                 |                     | 4350.00         |               | 0.00                       |                          | 0.00                       |
      | 94        | 20260405    | 50.00                 |                     | 4300.00         |               | 0.00                       |                          | 0.00                       |
      | 95        | 20260406    | 50.00                 |                     | 4250.00         |               | 0.00                       |                          | 0.00                       |
      | 96        | 20260407    | 50.00                 |                     | 4200.00         |               | 0.00                       |                          | 0.00                       |
      | 97        | 20260408    | 50.00                 |                     | 4150.00         |               | 0.00                       |                          | 0.00                       |
      | 98        | 20260409    | 50.00                 |                     | 4100.00         |               | 0.00                       |                          | 0.00                       |
      | 99        | 20260410    | 50.00                 |                     | 4050.00         |               | 0.00                       |                          | 0.00                       |
      | 100       | 20260411    | 50.00                 |                     | 4000.00         |               | 0.00                       |                          | 0.00                       |
      | 101       | 20260412    | 50.00                 |                     | 3950.00         |               | 0.00                       |                          | 0.00                       |
      | 102       | 20260413    | 50.00                 |                     | 3900.00         |               | 0.00                       |                          | 0.00                       |
      | 103       | 20260414    | 50.00                 |                     | 3850.00         |               | 0.00                       |                          | 0.00                       |
      | 104       | 20260415    | 50.00                 |                     | 3800.00         |               | 0.00                       |                          | 0.00                       |
      | 105       | 20260416    | 50.00                 |                     | 3750.00         |               | 0.00                       |                          | 0.00                       |
      | 106       | 20260417    | 50.00                 |                     | 3700.00         |               | 0.00                       |                          | 0.00                       |
      | 107       | 20260418    | 50.00                 |                     | 3650.00         |               | 0.00                       |                          | 0.00                       |
      | 108       | 20260419    | 50.00                 |                     | 3600.00         |               | 0.00                       |                          | 0.00                       |
      | 109       | 20260420    | 50.00                 |                     | 3550.00         |               | 0.00                       |                          | 0.00                       |
      | 110       | 20260421    | 50.00                 |                     | 3500.00         |               | 0.00                       |                          | 0.00                       |
      | 111       | 20260422    | 50.00                 |                     | 3450.00         |               | 0.00                       |                          | 0.00                       |
      | 112       | 20260423    | 50.00                 |                     | 3400.00         |               | 0.00                       |                          | 0.00                       |
      | 113       | 20260424    | 50.00                 |                     | 3350.00         |               | 0.00                       |                          | 0.00                       |
      | 114       | 20260425    | 50.00                 |                     | 3300.00         |               | 0.00                       |                          | 0.00                       |
      | 115       | 20260426    | 50.00                 |                     | 3250.00         |               | 0.00                       |                          | 0.00                       |
      | 116       | 20260427    | 50.00                 |                     | 3200.00         |               | 0.00                       |                          | 0.00                       |
      | 117       | 20260428    | 50.00                 |                     | 3150.00         |               | 0.00                       |                          | 0.00                       |
      | 118       | 20260429    | 50.00                 |                     | 3100.00         |               | 0.00                       |                          | 0.00                       |
      | 119       | 20260430    | 50.00                 |                     | 3050.00         |               | 0.00                       |                          | 0.00                       |
      | 120       | 20260501      | 50.00                 |                     | 3000.00         |               | 0.00                       |                          | 0.00                       |
      | 121       | 20260502      | 50.00                 |                     | 2950.00         |               | 0.00                       |                          | 0.00                       |
      | 122       | 20260503      | 50.00                 |                     | 2900.00         |               | 0.00                       |                          | 0.00                       |
      | 123       | 20260504      | 50.00                 |                     | 2850.00         |               | 0.00                       |                          | 0.00                       |
      | 124       | 20260505      | 50.00                 |                     | 2800.00         |               | 0.00                       |                          | 0.00                       |
      | 125       | 20260506      | 50.00                 |                     | 2750.00         |               | 0.00                       |                          | 0.00                       |
      | 126       | 20260507      | 50.00                 |                     | 2700.00         |               | 0.00                       |                          | 0.00                       |
      | 127       | 20260508      | 50.00                 |                     | 2650.00         |               | 0.00                       |                          | 0.00                       |
      | 128       | 20260509      | 50.00                 |                     | 2600.00         |               | 0.00                       |                          | 0.00                       |
      | 129       | 20260510      | 50.00                 |                     | 2550.00         |               | 0.00                       |                          | 0.00                       |
      | 130       | 20260511      | 50.00                 |                     | 2500.00         |               | 0.00                       |                          | 0.00                       |
      | 131       | 20260512      | 50.00                 |                     | 2450.00         |               | 0.00                       |                          | 0.00                       |
      | 132       | 20260513      | 50.00                 |                     | 2400.00         |               | 0.00                       |                          | 0.00                       |
      | 133       | 20260514      | 50.00                 |                     | 2350.00         |               | 0.00                       |                          | 0.00                       |
      | 134       | 20260515      | 50.00                 |                     | 2300.00         |               | 0.00                       |                          | 0.00                       |
      | 135       | 20260516      | 50.00                 |                     | 2250.00         |               | 0.00                       |                          | 0.00                       |
      | 136       | 20260517      | 50.00                 |                     | 2200.00         |               | 0.00                       |                          | 0.00                       |
      | 137       | 20260518      | 50.00                 |                     | 2150.00         |               | 0.00                       |                          | 0.00                       |
      | 138       | 20260519      | 50.00                 |                     | 2100.00         |               | 0.00                       |                          | 0.00                       |
      | 139       | 20260520      | 50.00                 |                     | 2050.00         |               | 0.00                       |                          | 0.00                       |
      | 140       | 20260521      | 50.00                 |                     | 2000.00         |               | 0.00                       |                          | 0.00                       |
      | 141       | 20260522      | 50.00                 |                     | 1950.00         |               | 0.00                       |                          | 0.00                       |
      | 142       | 20260523      | 50.00                 |                     | 1900.00         |               | 0.00                       |                          | 0.00                       |
      | 143       | 20260524      | 50.00                 |                     | 1850.00         |               | 0.00                       |                          | 0.00                       |
      | 144       | 20260525      | 50.00                 |                     | 1800.00         |               | 0.00                       |                          | 0.00                       |
      | 145       | 20260526      | 50.00                 |                     | 1750.00         |               | 0.00                       |                          | 0.00                       |
      | 146       | 20260527      | 50.00                 |                     | 1700.00         |               | 0.00                       |                          | 0.00                       |
      | 147       | 20260528      | 50.00                 |                     | 1650.00         |               | 0.00                       |                          | 0.00                       |
      | 148       | 20260529      | 50.00                 |                     | 1600.00         |               | 0.00                       |                          | 0.00                       |
      | 149       | 20260530      | 50.00                 |                     | 1550.00         |               | 0.00                       |                          | 0.00                       |
      | 150       | 20260531      | 50.00                 |                     | 1500.00         |               | 0.00                       |                          | 0.00                       |
      | 151       | 20260601     | 50.00                 |                     | 1450.00         |               | 0.00                       |                          | 0.00                       |
      | 152       | 20260602     | 50.00                 |                     | 1400.00         |               | 0.00                       |                          | 0.00                       |
      | 153       | 20260603     | 50.00                 |                     | 1350.00         |               | 0.00                       |                          | 0.00                       |
      | 154       | 20260604     | 50.00                 |                     | 1300.00         |               | 0.00                       |                          | 0.00                       |
      | 155       | 20260605     | 50.00                 |                     | 1250.00         |               | 0.00                       |                          | 0.00                       |
      | 156       | 20260606     | 50.00                 |                     | 1200.00         |               | 0.00                       |                          | 0.00                       |
      | 157       | 20260607     | 50.00                 |                     | 1150.00         |               | 0.00                       |                          | 0.00                       |
      | 158       | 20260608     | 50.00                 |                     | 1100.00         |               | 0.00                       |                          | 0.00                       |
      | 159       | 20260609     | 50.00                 |                     | 1050.00         |               | 0.00                       |                          | 0.00                       |
      | 160       | 20260610     | 50.00                 |                     | 1000.00         |               | 0.00                       |                          | 0.00                       |
      | 161       | 20260611     | 50.00                 |                     | 950.00          |               | 0.00                       |                          | 0.00                       |
      | 162       | 20260612     | 50.00                 |                     | 900.00          |               | 0.00                       |                          | 0.00                       |
      | 163       | 20260613     | 50.00                 |                     | 850.00          |               | 0.00                       |                          | 0.00                       |
      | 164       | 20260614     | 50.00                 |                     | 800.00          |               | 0.00                       |                          | 0.00                       |
      | 165       | 20260615     | 50.00                 |                     | 750.00          |               | 0.00                       |                          | 0.00                       |
      | 166       | 20260616     | 50.00                 |                     | 700.00          |               | 0.00                       |                          | 0.00                       |
      | 167       | 20260617     | 50.00                 |                     | 650.00          |               | 0.00                       |                          | 0.00                       |
      | 168       | 20260618     | 50.00                 |                     | 600.00          |               | 0.00                       |                          | 0.00                       |
      | 169       | 20260619     | 50.00                 |                     | 550.00          |               | 0.00                       |                          | 0.00                       |
      | 170       | 20260620     | 50.00                 |                     | 500.00          |               | 0.00                       |                          | 0.00                       |
      | 171       | 20260621     | 50.00                 |                     | 450.00          |               | 0.00                       |                          | 0.00                       |
      | 172       | 20260622     | 50.00                 |                     | 400.00          |               | 0.00                       |                          | 0.00                       |
      | 173       | 20260623     | 50.00                 |                     | 350.00          |               | 0.00                       |                          | 0.00                       |
      | 174       | 20260624     | 50.00                 |                     | 300.00          |               | 0.00                       |                          | 0.00                       |
      | 175       | 20260625     | 50.00                 |                     | 250.00          |               | 0.00                       |                          | 0.00                       |
      | 176       | 20260626     | 50.00                 |                     | 200.00          |               | 0.00                       |                          | 0.00                       |
      | 177       | 20260627     | 50.00                 |                     | 150.00          |               | 0.00                       |                          | 0.00                       |
      | 178       | 20260628     | 50.00                 |                     | 100.00          |               | 0.00                       |                          | 0.00                       |
      | 179       | 20260629     | 50.00                 |                     | 50.00           |               | 0.00                       |                          | 0.00                       |
      | 180       | 20260630     | 50.00                 |                     | 0.00            |               | 0.00                       |                          | 0.00                       |
      | 181       | 20260701     | 50.00                 |                     | 0.00            |               | 0.00                       |                          | 0.00                       |
      | 182       | 20260702     | 50.00                 |                     | 0.00            |               | 0.00                       |                          | 0.00                       |
      | 183       | 20260703     | 50.00                 |                     | 0.00            |               | 0.00                       |                          | 0.00                       |
      | 184       | 20260704     | 50.00                 |                     | 0.00            |               | 0.00                       |                          | 0.00                       |
      | 185       | 20260705     | 50.00                 |                     | 0.00            |               | 0.00                       |                          | 0.00                       |
      | 186       | 20260706     | 50.00                 |                     | 0.00            |               | 0.00                       |                          | 0.00                       |
      | 187       | 20260707     | 50.00                 |                     | 0.00            |               | 0.00                       |                          | 0.00                       |
      | 188       | 20260708     |  8.00                 |                     | 0.00            |               | 0.00                       |                          | 0.00                       |
