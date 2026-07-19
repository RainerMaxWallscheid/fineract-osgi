@WorkingCapitalDiscountAdjustmentFeature
Feature: Working Capital Discount Adjustment

  @TestRailId:C83024
  Scenario: Verify Discount fee adjustment is processed successfully - UC1
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 100             | 100                | 1                 |          |
    Then Working capital loan creation was successful
    Then Admin successfully approves the working capital loan on "20260101" with "100" amount and expected disbursement date on "20260101"
    Then Admin successfully disburse the Working Capital loan on "20260101" with "100" EUR transaction amount
    Then Admin adds Discount fee with "12" amount on Working Capital loan account for last disbursement
    Then Admin adds Discount fee adjustment with "5" amount on Working Capital loan account for last discount
    And Working capital loan account has the correct data:
      | product.name | submittedOnDate | expectedDisbursementDate | status | principal | approvedPrincipal | totalPaymentVolume | periodPaymentRate | discount | totalDiscountFee | totalDiscountFeeAdjustment |
      | WCLP         | 2026-01-01      | 2026-01-01               | Active | 107.0     | 100.0             | 100.0              | 1.0               | 7.0      | 12.0             | 5.0                        |
    And Working Capital Loan has transactions:
      | transactionDate | type                    | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement            | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee            | 12.0              | 12.0             | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee Adjustment | 5.0               | 5.0              | 0.0               | 0.0                   | false    |

  @TestRailId:C83025
  Scenario: Verify Discount fee adjustment fails when amount exceeds discount fee amount - UC2
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 100             | 100          | 1                 |          |
    Then Working capital loan creation was successful
    Then Admin successfully approves the working capital loan on "20260101" with "100" amount and expected disbursement date on "20260101"
    Then Admin successfully disburse the Working Capital loan on "20260101" with "100" EUR transaction amount
    Then Admin adds Discount fee with "12" amount on Working Capital loan account for last disbursement
    Then Add Discount fee adjustment with "13" amount on Working Capital loan account failed due to exceeding discount amount
    And Working Capital Loan has transactions:
      | transactionDate | type         | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee | 12.0              | 12.0             | 0.0               | 0.0                   | false    |

  @TestRailId:C83026
  Scenario: Verify Discount fee adjustment fails when 2nd amount exceeds discount fee amount - UC3
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 100             | 100          | 1                 |          |
    Then Working capital loan creation was successful
    Then Admin successfully approves the working capital loan on "20260101" with "100" amount and expected disbursement date on "20260101"
    Then Admin successfully disburse the Working Capital loan on "20260101" with "100" EUR transaction amount
    Then Admin adds Discount fee with "12" amount on Working Capital loan account for last disbursement
    Then Admin adds Discount fee adjustment with "11" amount on Working Capital loan account for last discount
    And Working Capital Loan has transactions:
      | transactionDate | type                    | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement            | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee            | 12.0              | 12.0             | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee Adjustment | 11.0              | 11.0              | 0.0               | 0.0                   | false    |
    Then Add Discount fee adjustment with "3" amount on Working Capital loan account failed due to exceeding discount amount
    And Working Capital Loan has transactions:
      | transactionDate | type                    | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement            | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee            | 12.0              | 12.0             | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee Adjustment | 11.0              | 11.0             | 0.0               | 0.0                   | false    |

  @TestRailId:C83027
  Scenario: Verify Discount fee adjustment fails when transaction date is before discount fee date - UC4
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 100             | 100          | 1                 |          |
    Then Working capital loan creation was successful
    Then Admin successfully approves the working capital loan on "20260101" with "100" amount and expected disbursement date on "20260101"
    Then Admin successfully disburse the Working Capital loan on "20260101" with "100" EUR transaction amount
    Then Admin adds Discount fee with "12" amount on Working Capital loan account for last disbursement
    Then Add Discount fee adjustment with "2" amount and transaction date "20251231" on Working Capital loan account failed due to transaction date before discount fee date
    And Working Capital Loan has transactions:
      | transactionDate | type         | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee | 12.0              | 12.0             | 0.0               | 0.0                   | false    |

  @TestRailId:C83029
  Scenario: Verify Discount fee adjustment fails with transaction future date - UC6
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 100             | 100          | 1                 |          |
    Then Working capital loan creation was successful
    Then Admin successfully approves the working capital loan on "20260101" with "100" amount and expected disbursement date on "20260101"
    Then Admin successfully disburse the Working Capital loan on "20260101" with "100" EUR transaction amount
    Then Admin adds Discount fee with "12" amount on Working Capital loan account for last disbursement
    And Working Capital Loan has transactions:
      | transactionDate | type         | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee | 12.0              | 12.0             | 0.0               | 0.0                   | false    |
    When Admin sets the business date to "20260120"
    Then Add Discount fee adjustment with "2" amount and transaction date "20260125" on Working Capital loan account failed due to future date
    And Working Capital Loan has transactions:
      | transactionDate | type         | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee | 12.0              | 12.0             | 0.0               | 0.0                   | false    |

  @TestRailId:C83030
  Scenario: Verify a few Discount fee adjustments are processed successfully on the same date - UC7
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 100             | 100          | 1                 |          |
    Then Working capital loan creation was successful
    Then Admin successfully approves the working capital loan on "20260101" with "100" amount and expected disbursement date on "20260101"
    Then Admin successfully disburse the Working Capital loan on "20260101" with "100" EUR transaction amount
    Then Admin adds Discount fee with "12" amount on Working Capital loan account for last disbursement
    And Working Capital Loan has transactions:
      | transactionDate | type         | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee | 12.0              | 12.0             | 0.0               | 0.0                   | false    |
    Then Admin adds Discount fee adjustment with "5" amount on Working Capital loan account for last discount
    And Working Capital Loan has transactions:
      | transactionDate | type                    | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement            | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee            | 12.0              | 12.0             | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee Adjustment | 5.0               | 5.0              | 0.0               | 0.0                   | false    |
    Then Admin adds Discount fee adjustment with "7" amount on Working Capital loan account for last discount
    And Working Capital Loan has transactions:
      | transactionDate | type                    | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement            | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee            | 12.0              | 12.0             | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee Adjustment | 5.0               | 5.0              | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee Adjustment | 7.0               | 7.0              | 0.0               | 0.0                   | false    |

  @TestRailId:C83031
  Scenario: Verify a few Discount fee adjustments are processed successfully on diff dates - UC8
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 100             | 100          | 1                 |          |
    Then Working capital loan creation was successful
    Then Admin successfully approves the working capital loan on "20260101" with "100" amount and expected disbursement date on "20260101"
    Then Admin successfully disburse the Working Capital loan on "20260101" with "100" EUR transaction amount
    Then Admin adds Discount fee with "12" amount on Working Capital loan account for last disbursement
    And Working Capital Loan has transactions:
      | transactionDate | type         | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee | 12.0              | 12.0             | 0.0               | 0.0                   | false    |
    Then Admin adds Discount fee adjustment with "5" amount on Working Capital loan account for last discount
    And Working Capital Loan has transactions:
      | transactionDate | type                    | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement            | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee            | 12.0              | 12.0             | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee Adjustment | 5.0               | 5.0              | 0.0               | 0.0                   | false    |
    And WorkingCapitalLoanDiscountFeeAdjustmentTransactionBusinessEvent is raised with amount "5" on "20260101" date
    When Admin sets the business date to "20260103"
    And Admin adds Discount fee adjustment with "7" amount on transaction date "20260103" on Working Capital loan account for last discount
    And Working Capital Loan has transactions:
      | transactionDate | type                    | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement            | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee            | 12.0              | 12.0             | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee Adjustment | 5.0               | 5.0              | 0.0               | 0.0                   | false    |
      | 20260103 | Discount Fee Adjustment | 7.0               | 7.0              | 0.0               | 0.0                   | false    |
    And WorkingCapitalLoanDiscountFeeAdjustmentTransactionBusinessEvent is raised with amount "7" on "20260103" date

  @TestRailId:C83032
  Scenario Outline: Verify Discount fee adjustment fails when transaction amount is zero - UC9
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 100             | 100          | 1                 |          |
    Then Working capital loan creation was successful
    Then Admin successfully approves the working capital loan on "20260101" with "100" amount and expected disbursement date on "20260101"
    Then Admin successfully disburse the Working Capital loan on "20260101" with "100" EUR transaction amount
    Then Admin adds Discount fee with "12" amount on Working Capital loan account for last disbursement
    And Working Capital Loan has transactions:
      | transactionDate | type         | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee | 12.0              | 12.0             | 0.0               | 0.0                   | false    |
    Then Add Discount fee adjustment with "<discount_fee_adj_amount>" amount and transaction date "20260101" on Working Capital loan account failed as amount must be greater then zero
    And Working Capital Loan has transactions:
      | transactionDate | type         | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee | 12.0              | 12.0             | 0.0               | 0.0                   | false    |

    Examples:
      | discount_fee_adj_amount |
      | 0                       |
      | -1                      |

  @TestRailId:C83033
  Scenario: Verify Discount fee adjustment failed when loan is closed - UC10
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct         | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP_ACC_DEF_REV_AM | 20260101 | 20260101          | 100             | 100          | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "100" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "100" EUR transaction amount
    Then Admin adds Discount fee with "12" amount on Working Capital loan account for last disbursement
    When Admin sets the business date to "20260102"
    And Customer makes repayment on "20260102" with 112.0 transaction amount on Working Capital loan
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"
    And Working Capital Loan has transactions:
      | transactionDate | type                      | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement              | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee              | 12.0              | 12.0             | 0.0               | 0.0                   | false    |
      | 20260102 | Repayment                 | 112.0             | 112.0            | 0.0               | 0.0                   | false    |
      | 20260102 | Discount Fee Amortization | 12.0              |                  |                   |                       | false    |
    Then Add Discount fee adjustment with "12" amount and transaction date "20260102" on Working Capital loan account failed due to not active loan
    And Working Capital Loan has transactions:
      | transactionDate | type                      | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement              | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee              | 12.0              | 12.0             | 0.0               | 0.0                   | false    |
      | 20260102 | Repayment                 | 112.0             | 112.0            | 0.0               | 0.0                   | false    |
      | 20260102 | Discount Fee Amortization | 12.0              |                  |                   |                       | false    |

  @TestRailId:C83034
  Scenario: Verify Discount fee adjustment failed when loan is overpaid - UC11
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct         | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP_ACC_DEF_REV_AM | 20260101 | 20260101          | 100             | 100          | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "100" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "100" EUR transaction amount
    Then Admin adds Discount fee with "12" amount on Working Capital loan account for last disbursement
    When Admin sets the business date to "20260102"
    And Customer makes repayment on "20260102" with 152.0 transaction amount on Working Capital loan
    Then Working Capital loan status will be "OVERPAID"
    And Working Capital Loan has transactions:
      | transactionDate | type                      | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement              | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee              | 12.0              | 12.0             | 0.0               | 0.0                   | false    |
      | 20260102 | Repayment                 | 152.0             | 112.0            | 0.0               | 0.0                   | false    |
      | 20260102 | Discount Fee Amortization | 12.0              |                  |                   |                       | false    |
    Then Add Discount fee adjustment with "12" amount and transaction date "20260102" on Working Capital loan account failed due to not active loan
    And Working Capital Loan has transactions:
      | transactionDate | type                      | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement              | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee              | 12.0              | 12.0             | 0.0               | 0.0                   | false    |
      | 20260102 | Repayment                 | 152.0             | 112.0            | 0.0               | 0.0                   | false    |
      | 20260102 | Discount Fee Amortization | 12.0              |                  |                   |                       | false    |

  @TestRailId:C83035
  Scenario: Verify Discount fee adjustment transaction is successful after repayment - UC12
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct         | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP_ACC_DEF_REV_AM | 20260101 | 20260101          | 100             | 100          | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "100" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "100" EUR transaction amount
    Then Admin adds Discount fee with "12" amount on Working Capital loan account for last disbursement
    When Admin sets the business date to "20260102"
    And Customer makes repayment on "20260102" with 50.0 transaction amount on Working Capital loan
    And Working Capital Loan has transactions:
      | transactionDate | type         | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee | 12.0              | 12.0             | 0.0               | 0.0                   | false    |
      | 20260102 | Repayment    | 50.0              | 50.0             | 0.0               | 0.0                   | false    |
    Then Working Capital Loan Transactions tab has a "DISCOUNT_FEE" transaction with date "20260101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 12.0  |        |
      | LIABILITY | 240005       | Deferred Interest Revenue |       | 12.0   |
    And Admin adds Discount fee adjustment with "10" amount on transaction date "20260102" on Working Capital loan account for last discount
    And Working Capital Loan has transactions:
      | transactionDate | type                    | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement            | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee            | 12.0              | 12.0             | 0.0               | 0.0                   | false    |
      | 20260102 | Repayment               | 50.0              | 50.0             | 0.0               | 0.0                   | false    |
      | 20260102 | Discount Fee Adjustment | 10.0              | 10.0             | 0.0               | 0.0                   | false    |
    Then Working Capital Loan Transactions tab has a "DISCOUNT_FEE_ADJUSTMENT" transaction with date "20260102" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | LIABILITY | 240005       | Deferred Interest Revenue | 10.0  |        |
      | ASSET     | 112601       | Loans Receivable          |       | 10.0   |
    And WorkingCapitalLoanDiscountFeeTransactionBusinessEvent is raised with amount "12" on "20260101" date
    And WorkingCapitalLoanDiscountFeeAdjustmentTransactionBusinessEvent is raised with amount "10" on "20260102" date

  @TestRailId:C85207
  Scenario: Verify Discount fee and multiple Discount fee adjustments on the same day post correct journal entries
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct         | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP_ACC_DEF_REV_AM | 20260101 | 20260101          | 100             | 100          | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "100" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "100" EUR transaction amount
    Then Admin adds Discount fee with "12" amount on Working Capital loan account for last disbursement
    Then Working Capital Loan Transactions tab has a "DISCOUNT_FEE" transaction with date "20260101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 12.0  |        |
      | LIABILITY | 240005       | Deferred Interest Revenue |       | 12.0   |
    And Admin adds Discount fee adjustment with "5" amount on Working Capital loan account for last discount
    And Admin adds Discount fee adjustment with "7" amount on Working Capital loan account for last discount
    And Working Capital Loan has transactions:
      | transactionDate | type                    | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement            | 100.0             | 100.0            | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee            | 12.0              | 12.0             | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee Adjustment | 5.0               | 5.0              | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee Adjustment | 7.0               | 7.0              | 0.0               | 0.0                   | false    |
    Then Working Capital Loan Transactions tab has 2 "DISCOUNT_FEE_ADJUSTMENT" transactions with date "20260101" which have the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | LIABILITY | 240005       | Deferred Interest Revenue | 5.0   |        |
      | ASSET     | 112601       | Loans Receivable          |       | 5.0    |
      | LIABILITY | 240005       | Deferred Interest Revenue | 7.0   |        |
      | ASSET     | 112601       | Loans Receivable          |       | 7.0    |

  @TestRailId:C83036
  Scenario: Verify discount fee adjustment transaction with classification field set - UC13
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20260101 | 20260101          | 9000            | 100000       | 18                | 1000     |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    Then Admin adds Discount fee with "1000" amount on Working Capital loan account for last disbursement
    And Working Capital Loan has transactions:
      | transactionDate | type         | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee | 1000.0            | 1000.0           | 0.0               | 0.0                   | false    |
    And Admin adds Discount fee adjustment with "100" amount on transaction date "20260101" on Working Capital loan account for last discount and "working_capital_loan_discount_fee_classification_value" classification
    And Working Capital Loan has transactions:
      | transactionDate | type                    | transactionAmount | principalPortion | feeChargesPortion | penaltyChargesPortion | reversed |
      | 20260101 | Disbursement            | 9000.0            | 9000.0           | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee            | 1000.0            | 1000.0           | 0.0               | 0.0                   | false    |
      | 20260101 | Discount Fee Adjustment | 100.0              | 100.0            | 0.0               | 0.0                   | false    |
    And Working Capital Loan has a "DISCOUNT_FEE_ADJUSTMENT" transaction with date "20260101" which has classification code value "working_capital_loan_discount_fee_classification_value"

  @TestRailId:C83037
  Scenario: Verify amortization schedule after discount fee adjustment - EIR discount adjustment S1.1
    When Admin sets the business date to "20190101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20190101 | 20190101          | 9000            | 100000       | 18                | 1000     |
    And Admin successfully approves the working capital loan on "20190101" with "9000" amount and "1000" discount amount and expected disbursement date on "20190101"
    And Admin successfully disburse the Working Capital loan on "20190101" with "9000" EUR transaction amount and "1000" discount amount
    Then Working Capital loan amortization schedule has 201 periods, with the following data for periods:
      | paymentNo | paymentDate      | expectedPaymentAmount | actualPaymentAmount | expectedBalance | expectedAmortizationAmount | actualAmortizationAmount | expectedDiscountFeeBalance |
      | 0         | 20190101  | -9000.00              |                     | 9000.00         |                            |                          | 1000.00                    |
      | 1         | 20190102  | 50.00                 |                     | 8959.61         | 9.61                       |                          | 990.39                     |
      | 2         | 20190103  | 50.00                 |                     | 8919.18         | 9.57                       |                          | 980.82                     |
      | 3         | 20190104  | 50.00                 |                     | 8878.70         | 9.52                       |                          | 971.30                     |
      | 4         | 20190105  | 50.00                 |                     | 8838.18         | 9.48                       |                          | 961.82                     |
      | 5         | 20190106  | 50.00                 |                     | 8797.62         | 9.44                       |                          | 952.38                     |
      | 6         | 20190107  | 50.00                 |                     | 8757.01         | 9.39                       |                          | 942.99                     |
      | 7         | 20190108  | 50.00                 |                     | 8716.36         | 9.35                       |                          | 933.64                     |
      | 8         | 20190109  | 50.00                 |                     | 8675.67         | 9.31                       |                          | 924.33                     |
      | 9         | 20190110  | 50.00                 |                     | 8634.94         | 9.26                       |                          | 915.07                     |
      | 10        | 20190111  | 50.00                 |                     | 8594.16         | 9.22                       |                          | 905.85                     |
      | 11        | 20190112  | 50.00                 |                     | 8553.33         | 9.18                       |                          | 896.67                     |
      | 12        | 20190113  | 50.00                 |                     | 8512.47         | 9.13                       |                          | 887.54                     |
      | 13        | 20190114  | 50.00                 |                     | 8471.56         | 9.09                       |                          | 878.45                     |
      | 14        | 20190115  | 50.00                 |                     | 8430.60         | 9.05                       |                          | 869.40                     |
      | 15        | 20190116  | 50.00                 |                     | 8389.61         | 9.00                       |                          | 860.40                     |
      | 16        | 20190117  | 50.00                 |                     | 8348.56         | 8.96                       |                          | 851.44                     |
      | 17        | 20190118  | 50.00                 |                     | 8307.48         | 8.91                       |                          | 842.53                     |
      | 18        | 20190119  | 50.00                 |                     | 8266.35         | 8.87                       |                          | 833.66                     |
      | 19        | 20190120  | 50.00                 |                     | 8225.18         | 8.83                       |                          | 824.83                     |
      | 20        | 20190121  | 50.00                 |                     | 8183.96         | 8.78                       |                          | 816.05                     |
      | 21        | 20190122  | 50.00                 |                     | 8142.70         | 8.74                       |                          | 807.31                     |
      | 22        | 20190123  | 50.00                 |                     | 8101.39         | 8.69                       |                          | 798.62                     |
      | 23        | 20190124  | 50.00                 |                     | 8060.04         | 8.65                       |                          | 789.97                     |
      | 24        | 20190125  | 50.00                 |                     | 8018.65         | 8.61                       |                          | 781.36                     |
      | 25        | 20190126  | 50.00                 |                     | 7977.21         | 8.56                       |                          | 772.80                     |
      | 26        | 20190127  | 50.00                 |                     | 7935.73         | 8.52                       |                          | 764.28                     |
      | 27        | 20190128  | 50.00                 |                     | 7894.21         | 8.47                       |                          | 755.81                     |
      | 28        | 20190129  | 50.00                 |                     | 7852.63         | 8.43                       |                          | 747.38                     |
      | 29        | 20190130  | 50.00                 |                     | 7811.02         | 8.39                       |                          | 738.99                     |
      | 30        | 20190131  | 50.00                 |                     | 7769.36         | 8.34                       |                          | 730.65                     |
      | 31        | 20190201 | 50.00                 |                     | 7727.66         | 8.30                       |                          | 722.35                     |
      | 32        | 20190202 | 50.00                 |                     | 7685.91         | 8.25                       |                          | 714.10                     |
      | 33        | 20190203 | 50.00                 |                     | 7644.12         | 8.21                       |                          | 705.89                     |
      | 34        | 20190204 | 50.00                 |                     | 7602.28         | 8.16                       |                          | 697.73                     |
      | 35        | 20190205 | 50.00                 |                     | 7560.40         | 8.12                       |                          | 689.61                     |
      | 36        | 20190206 | 50.00                 |                     | 7518.47         | 8.07                       |                          | 681.54                     |
      | 37        | 20190207 | 50.00                 |                     | 7476.50         | 8.03                       |                          | 673.51                     |
      | 38        | 20190208 | 50.00                 |                     | 7434.48         | 7.98                       |                          | 665.53                     |
      | 39        | 20190209 | 50.00                 |                     | 7392.42         | 7.94                       |                          | 657.59                     |
      | 40        | 20190210 | 50.00                 |                     | 7350.31         | 7.89                       |                          | 649.70                     |
      | 41        | 20190211 | 50.00                 |                     | 7308.16         | 7.85                       |                          | 641.85                     |
      | 42        | 20190212 | 50.00                 |                     | 7265.97         | 7.80                       |                          | 634.05                     |
      | 43        | 20190213 | 50.00                 |                     | 7223.72         | 7.76                       |                          | 626.29                     |
      | 44        | 20190214 | 50.00                 |                     | 7181.44         | 7.71                       |                          | 618.58                     |
      | 45        | 20190215 | 50.00                 |                     | 7139.11         | 7.67                       |                          | 610.91                     |
      | 46        | 20190216 | 50.00                 |                     | 7096.73         | 7.62                       |                          | 603.29                     |
      | 47        | 20190217 | 50.00                 |                     | 7054.31         | 7.58                       |                          | 595.71                     |
      | 48        | 20190218 | 50.00                 |                     | 7011.84         | 7.53                       |                          | 588.18                     |
      | 49        | 20190219 | 50.00                 |                     | 6969.33         | 7.49                       |                          | 580.69                     |
      | 50        | 20190220 | 50.00                 |                     | 6926.77         | 7.44                       |                          | 573.25                     |
      | 51        | 20190221 | 50.00                 |                     | 6884.17         | 7.40                       |                          | 565.85                     |
      | 52        | 20190222 | 50.00                 |                     | 6841.52         | 7.35                       |                          | 558.50                     |
      | 53        | 20190223 | 50.00                 |                     | 6798.82         | 7.31                       |                          | 551.19                     |
      | 54        | 20190224 | 50.00                 |                     | 6756.08         | 7.26                       |                          | 543.93                     |
      | 55        | 20190225 | 50.00                 |                     | 6713.30         | 7.21                       |                          | 536.72                     |
      | 56        | 20190226 | 50.00                 |                     | 6670.47         | 7.17                       |                          | 529.55                     |
      | 57        | 20190227 | 50.00                 |                     | 6627.59         | 7.12                       |                          | 522.43                     |
      | 58        | 20190228 | 50.00                 |                     | 6584.67         | 7.08                       |                          | 515.35                     |
      | 59        | 20190301    | 50.00                 |                     | 6541.70         | 7.03                       |                          | 508.32                     |
      | 60        | 20190302    | 50.00                 |                     | 6498.68         | 6.99                       |                          | 501.33                     |
      | 61        | 20190303    | 50.00                 |                     | 6455.62         | 6.94                       |                          | 494.39                     |
      | 62        | 20190304    | 50.00                 |                     | 6412.51         | 6.89                       |                          | 487.50                     |
      | 63        | 20190305    | 50.00                 |                     | 6369.36         | 6.85                       |                          | 480.65                     |
      | 64        | 20190306    | 50.00                 |                     | 6326.16         | 6.80                       |                          | 473.85                     |
      | 65        | 20190307    | 50.00                 |                     | 6282.92         | 6.76                       |                          | 467.09                     |
      | 66        | 20190308    | 50.00                 |                     | 6239.63         | 6.71                       |                          | 460.38                     |
      | 67        | 20190309    | 50.00                 |                     | 6196.29         | 6.66                       |                          | 453.72                     |
      | 68        | 20190310    | 50.00                 |                     | 6152.91         | 6.62                       |                          | 447.10                     |
      | 69        | 20190311    | 50.00                 |                     | 6109.48         | 6.57                       |                          | 440.53                     |
      | 70        | 20190312    | 50.00                 |                     | 6066.00         | 6.52                       |                          | 434.01                     |
      | 71        | 20190313    | 50.00                 |                     | 6022.48         | 6.48                       |                          | 427.53                     |
      | 72        | 20190314    | 50.00                 |                     | 5978.91         | 6.43                       |                          | 421.10                     |
      | 73        | 20190315    | 50.00                 |                     | 5935.29         | 6.38                       |                          | 414.72                     |
      | 74        | 20190316    | 50.00                 |                     | 5891.63         | 6.34                       |                          | 408.38                     |
      | 75        | 20190317    | 50.00                 |                     | 5847.92         | 6.29                       |                          | 402.09                     |
      | 76        | 20190318    | 50.00                 |                     | 5804.17         | 6.24                       |                          | 395.85                     |
      | 77        | 20190319    | 50.00                 |                     | 5760.36         | 6.20                       |                          | 389.65                     |
      | 78        | 20190320    | 50.00                 |                     | 5716.52         | 6.15                       |                          | 383.50                     |
      | 79        | 20190321    | 50.00                 |                     | 5672.62         | 6.10                       |                          | 377.40                     |
      | 80        | 20190322    | 50.00                 |                     | 5628.68         | 6.06                       |                          | 371.34                     |
      | 81        | 20190323    | 50.00                 |                     | 5584.69         | 6.01                       |                          | 365.33                     |
      | 82        | 20190324    | 50.00                 |                     | 5540.65         | 5.96                       |                          | 359.37                     |
      | 83        | 20190325    | 50.00                 |                     | 5496.57         | 5.92                       |                          | 353.45                     |
      | 84        | 20190326    | 50.00                 |                     | 5452.44         | 5.87                       |                          | 347.58                     |
      | 85        | 20190327    | 50.00                 |                     | 5408.26         | 5.82                       |                          | 341.76                     |
      | 86        | 20190328    | 50.00                 |                     | 5364.03         | 5.78                       |                          | 335.98                     |
      | 87        | 20190329    | 50.00                 |                     | 5319.76         | 5.73                       |                          | 330.25                     |
      | 88        | 20190330    | 50.00                 |                     | 5275.44         | 5.68                       |                          | 324.57                     |
      | 89        | 20190331    | 50.00                 |                     | 5231.08         | 5.63                       |                          | 318.94                     |
      | 90        | 20190401    | 50.00                 |                     | 5186.66         | 5.59                       |                          | 313.35                     |
      | 91        | 20190402    | 50.00                 |                     | 5142.20         | 5.54                       |                          | 307.81                     |
      | 92        | 20190403    | 50.00                 |                     | 5097.69         | 5.49                       |                          | 302.32                     |
      | 93        | 20190404    | 50.00                 |                     | 5053.13         | 5.44                       |                          | 296.88                     |
      | 94        | 20190405    | 50.00                 |                     | 5008.53         | 5.40                       |                          | 291.48                     |
      | 95        | 20190406    | 50.00                 |                     | 4963.88         | 5.35                       |                          | 286.13                     |
      | 96        | 20190407    | 50.00                 |                     | 4919.18         | 5.30                       |                          | 280.83                     |
      | 97        | 20190408    | 50.00                 |                     | 4874.43         | 5.25                       |                          | 275.58                     |
      | 98        | 20190409    | 50.00                 |                     | 4829.64         | 5.20                       |                          | 270.38                     |
      | 99        | 20190410    | 50.00                 |                     | 4784.79         | 5.16                       |                          | 265.22                     |
      | 100       | 20190411    | 50.00                 |                     | 4739.90         | 5.11                       |                          | 260.11                     |
      | 101       | 20190412    | 50.00                 |                     | 4694.96         | 5.06                       |                          | 255.05                     |
      | 102       | 20190413    | 50.00                 |                     | 4649.98         | 5.01                       |                          | 250.04                     |
      | 103       | 20190414    | 50.00                 |                     | 4604.94         | 4.97                       |                          | 245.07                     |
      | 104       | 20190415    | 50.00                 |                     | 4559.86         | 4.92                       |                          | 240.15                     |
      | 105       | 20190416    | 50.00                 |                     | 4514.73         | 4.87                       |                          | 235.28                     |
      | 106       | 20190417    | 50.00                 |                     | 4469.55         | 4.82                       |                          | 230.46                     |
      | 107       | 20190418    | 50.00                 |                     | 4424.32         | 4.77                       |                          | 225.69                     |
      | 108       | 20190419    | 50.00                 |                     | 4379.05         | 4.72                       |                          | 220.97                     |
      | 109       | 20190420    | 50.00                 |                     | 4333.72         | 4.68                       |                          | 216.29                     |
      | 110       | 20190421    | 50.00                 |                     | 4288.35         | 4.63                       |                          | 211.66                     |
      | 111       | 20190422    | 50.00                 |                     | 4242.93         | 4.58                       |                          | 207.08                     |
      | 112       | 20190423    | 50.00                 |                     | 4197.46         | 4.53                       |                          | 202.55                     |
      | 113       | 20190424    | 50.00                 |                     | 4151.94         | 4.48                       |                          | 198.07                     |
      | 114       | 20190425    | 50.00                 |                     | 4106.38         | 4.43                       |                          | 193.64                     |
      | 115       | 20190426    | 50.00                 |                     | 4060.76         | 4.38                       |                          | 189.26                     |
      | 116       | 20190427    | 50.00                 |                     | 4015.10         | 4.34                       |                          | 184.92                     |
      | 117       | 20190428    | 50.00                 |                     | 3969.38         | 4.29                       |                          | 180.63                     |
      | 118       | 20190429    | 50.00                 |                     | 3923.62         | 4.24                       |                          | 176.39                     |
      | 119       | 20190430    | 50.00                 |                     | 3877.81         | 4.19                       |                          | 172.20                     |
      | 120       | 20190501      | 50.00                 |                     | 3831.95         | 4.14                       |                          | 168.06                     |
      | 121       | 20190502      | 50.00                 |                     | 3786.04         | 4.09                       |                          | 163.97                     |
      | 122       | 20190503      | 50.00                 |                     | 3740.09         | 4.04                       |                          | 159.93                     |
      | 123       | 20190504      | 50.00                 |                     | 3694.08         | 3.99                       |                          | 155.94                     |
      | 124       | 20190505      | 50.00                 |                     | 3648.03         | 3.94                       |                          | 152.00                     |
      | 125       | 20190506      | 50.00                 |                     | 3601.92         | 3.90                       |                          | 148.10                     |
      | 126       | 20190507      | 50.00                 |                     | 3555.77         | 3.85                       |                          | 144.25                     |
      | 127       | 20190508      | 50.00                 |                     | 3509.56         | 3.80                       |                          | 140.45                     |
      | 128       | 20190509      | 50.00                 |                     | 3463.31         | 3.75                       |                          | 136.70                     |
      | 129       | 20190510      | 50.00                 |                     | 3417.01         | 3.70                       |                          | 133.00                     |
      | 130       | 20190511      | 50.00                 |                     | 3370.66         | 3.65                       |                          | 129.35                     |
      | 131       | 20190512      | 50.00                 |                     | 3324.26         | 3.60                       |                          | 125.75                     |
      | 132       | 20190513      | 50.00                 |                     | 3277.81         | 3.55                       |                          | 122.20                     |
      | 133       | 20190514      | 50.00                 |                     | 3231.31         | 3.50                       |                          | 118.70                     |
      | 134       | 20190515      | 50.00                 |                     | 3184.76         | 3.45                       |                          | 115.25                     |
      | 135       | 20190516      | 50.00                 |                     | 3138.16         | 3.40                       |                          | 111.85                     |
      | 136       | 20190517      | 50.00                 |                     | 3091.51         | 3.35                       |                          | 108.50                     |
      | 137       | 20190518      | 50.00                 |                     | 3044.81         | 3.30                       |                          | 105.20                     |
      | 138       | 20190519      | 50.00                 |                     | 2998.06         | 3.25                       |                          | 101.95                     |
      | 139       | 20190520      | 50.00                 |                     | 2951.26         | 3.20                       |                          | 98.75                      |
      | 140       | 20190521      | 50.00                 |                     | 2904.42         | 3.15                       |                          | 95.60                      |
      | 141       | 20190522      | 50.00                 |                     | 2857.52         | 3.10                       |                          | 92.50                      |
      | 142       | 20190523      | 50.00                 |                     | 2810.57         | 3.05                       |                          | 89.45                      |
      | 143       | 20190524      | 50.00                 |                     | 2763.57         | 3.00                       |                          | 86.45                      |
      | 144       | 20190525      | 50.00                 |                     | 2716.52         | 2.95                       |                          | 83.50                      |
      | 145       | 20190526      | 50.00                 |                     | 2669.42         | 2.90                       |                          | 80.60                      |
      | 146       | 20190527      | 50.00                 |                     | 2622.27         | 2.85                       |                          | 77.75                      |
      | 147       | 20190528      | 50.00                 |                     | 2575.07         | 2.80                       |                          | 74.95                      |
      | 148       | 20190529      | 50.00                 |                     | 2527.82         | 2.75                       |                          | 72.20                      |
      | 149       | 20190530      | 50.00                 |                     | 2480.52         | 2.70                       |                          | 69.50                      |
      | 150       | 20190531      | 50.00                 |                     | 2433.17         | 2.65                       |                          | 66.85                      |
      | 151       | 20190601     | 50.00                 |                     | 2385.77         | 2.60                       |                          | 64.25                      |
      | 152       | 20190602     | 50.00                 |                     | 2338.31         | 2.55                       |                          | 61.70                      |
      | 153       | 20190603     | 50.00                 |                     | 2290.81         | 2.50                       |                          | 59.20                      |
      | 154       | 20190604     | 50.00                 |                     | 2243.26         | 2.45                       |                          | 56.75                      |
      | 155       | 20190605     | 50.00                 |                     | 2195.65         | 2.40                       |                          | 54.35                      |
      | 156       | 20190606     | 50.00                 |                     | 2148.00         | 2.34                       |                          | 52.01                      |
      | 157       | 20190607     | 50.00                 |                     | 2100.29         | 2.29                       |                          | 49.72                      |
      | 158       | 20190608     | 50.00                 |                     | 2052.53         | 2.24                       |                          | 47.48                      |
      | 159       | 20190609     | 50.00                 |                     | 2004.73         | 2.19                       |                          | 45.29                      |
      | 160       | 20190610     | 50.00                 |                     | 1956.87         | 2.14                       |                          | 43.15                      |
      | 161       | 20190611     | 50.00                 |                     | 1908.96         | 2.09                       |                          | 41.06                      |
      | 162       | 20190612     | 50.00                 |                     | 1860.99         | 2.04                       |                          | 39.02                      |
      | 163       | 20190613     | 50.00                 |                     | 1812.98         | 1.99                       |                          | 37.03                      |
      | 164       | 20190614     | 50.00                 |                     | 1764.92         | 1.94                       |                          | 35.09                      |
      | 165       | 20190615     | 50.00                 |                     | 1716.80         | 1.88                       |                          | 33.21                      |
      | 166       | 20190616     | 50.00                 |                     | 1668.64         | 1.83                       |                          | 31.38                      |
      | 167       | 20190617     | 50.00                 |                     | 1620.42         | 1.78                       |                          | 29.60                      |
      | 168       | 20190618     | 50.00                 |                     | 1572.15         | 1.73                       |                          | 27.87                      |
      | 169       | 20190619     | 50.00                 |                     | 1523.83         | 1.68                       |                          | 26.19                      |
      | 170       | 20190620     | 50.00                 |                     | 1475.45         | 1.63                       |                          | 24.56                      |
      | 171       | 20190621     | 50.00                 |                     | 1427.03         | 1.58                       |                          | 22.98                      |
      | 172       | 20190622     | 50.00                 |                     | 1378.55         | 1.52                       |                          | 21.46                      |
      | 173       | 20190623     | 50.00                 |                     | 1330.02         | 1.47                       |                          | 19.99                      |
      | 174       | 20190624     | 50.00                 |                     | 1281.45         | 1.42                       |                          | 18.57                      |
      | 175       | 20190625     | 50.00                 |                     | 1232.81         | 1.37                       |                          | 17.20                      |
      | 176       | 20190626     | 50.00                 |                     | 1184.13         | 1.32                       |                          | 15.88                      |
      | 177       | 20190627     | 50.00                 |                     | 1135.39         | 1.26                       |                          | 14.62                      |
      | 178       | 20190628     | 50.00                 |                     | 1086.61         | 1.21                       |                          | 13.41                      |
      | 179       | 20190629     | 50.00                 |                     | 1037.77         | 1.16                       |                          | 12.25                      |
      | 180       | 20190630     | 50.00                 |                     | 988.88          | 1.11                       |                          | 11.14                      |
      | 181       | 20190701     | 50.00                 |                     | 939.93          | 1.06                       |                          | 10.08                      |
      | 182       | 20190702     | 50.00                 |                     | 890.93          | 1.00                       |                          | 9.08                       |
      | 183       | 20190703     | 50.00                 |                     | 841.89          | 0.95                       |                          | 8.13                       |
      | 184       | 20190704     | 50.00                 |                     | 792.79          | 0.90                       |                          | 7.23                       |
      | 185       | 20190705     | 50.00                 |                     | 743.63          | 0.85                       |                          | 6.38                       |
      | 186       | 20190706     | 50.00                 |                     | 694.43          | 0.79                       |                          | 5.59                       |
      | 187       | 20190707     | 50.00                 |                     | 645.17          | 0.74                       |                          | 4.85                       |
      | 188       | 20190708     | 50.00                 |                     | 595.86          | 0.69                       |                          | 4.16                       |
      | 189       | 20190709     | 50.00                 |                     | 546.49          | 0.64                       |                          | 3.52                       |
      | 190       | 20190710     | 50.00                 |                     | 497.08          | 0.58                       |                          | 2.94                       |
      | 191       | 20190711     | 50.00                 |                     | 447.61          | 0.53                       |                          | 2.41                       |
      | 192       | 20190712     | 50.00                 |                     | 398.08          | 0.48                       |                          | 1.93                       |
      | 193       | 20190713     | 50.00                 |                     | 348.51          | 0.43                       |                          | 1.50                       |
      | 194       | 20190714     | 50.00                 |                     | 298.88          | 0.37                       |                          | 1.13                       |
      | 195       | 20190715     | 50.00                 |                     | 249.20          | 0.32                       |                          | 0.81                       |
      | 196       | 20190716     | 50.00                 |                     | 199.47          | 0.27                       |                          | 0.54                       |
      | 197       | 20190717     | 50.00                 |                     | 149.68          | 0.21                       |                          | 0.33                       |
      | 198       | 20190718     | 50.00                 |                     | 99.84           | 0.16                       |                          | 0.17                       |
      | 199       | 20190719     | 50.00                 |                     | 49.95           | 0.11                       |                          | 0.06                       |
      | 200       | 20190720     | 50.00                 |                     | 0.00            | 0.05                       |                          | 0.01                       |
    When Admin sets the business date to "20190102"
    And Customer makes repayment on "20190102" with 50 transaction amount on Working Capital loan
    When Admin sets the business date to "20190103"
    And Customer makes repayment on "20190103" with 50 transaction amount on Working Capital loan
    When Admin sets the business date to "20190104"
    And Customer makes repayment on "20190104" with 50 transaction amount on Working Capital loan
    When Admin sets the business date to "20190105"
    And Admin loads discount fee transaction from Working Capital loan for adjustment
    And Admin adds Discount fee adjustment with "500" amount on transaction date "20190105" on Working Capital loan account for last discount
    Then Working Capital loan amortization schedule has 191 periods, with the following data for periods:
      | paymentNo | paymentDate      | expectedPaymentAmount | actualPaymentAmount | expectedBalance | expectedAmortizationAmount | actualAmortizationAmount | expectedDiscountFeeBalance |
      | 0         | 20190101  | -9000.00              |                     | 9000.00         |                            |                          | 500.00                     |
      | 1         | 20190102  | 50.00                 | 50.00               | 8955.14         | 5.14                       | 5.14                     | 494.86                     |
      | 2         | 20190103  | 50.00                 | 50.00               | 8910.26         | 5.12                       | 5.12                     | 489.74                     |
      | 3         | 20190104  | 50.00                 | 50.00               | 8865.35         | 5.09                       | 5.09                     | 484.65                     |
      | 4         | 20190105  | 50.00                 |                     | 8820.42         | 5.07                       |                          | 479.58                     |
      | 5         | 20190106  | 50.00                 |                     | 8775.46         | 5.04                       |                          | 474.54                     |
      | 6         | 20190107  | 50.00                 |                     | 8730.47         | 5.01                       |                          | 469.53                     |
      | 7         | 20190108  | 50.00                 |                     | 8685.46         | 4.99                       |                          | 464.54                     |
      | 8         | 20190109  | 50.00                 |                     | 8640.43         | 4.96                       |                          | 459.58                     |
      | 9         | 20190110  | 50.00                 |                     | 8595.36         | 4.94                       |                          | 454.64                     |
      | 10        | 20190111  | 50.00                 |                     | 8550.28         | 4.91                       |                          | 449.73                     |
      | 11        | 20190112  | 50.00                 |                     | 8505.16         | 4.89                       |                          | 444.84                     |
      | 12        | 20190113  | 50.00                 |                     | 8460.02         | 4.86                       |                          | 439.98                     |
      | 13        | 20190114  | 50.00                 |                     | 8414.86         | 4.83                       |                          | 435.15                     |
      | 14        | 20190115  | 50.00                 |                     | 8369.66         | 4.81                       |                          | 430.34                     |
      | 15        | 20190116  | 50.00                 |                     | 8324.45         | 4.78                       |                          | 425.56                     |
      | 16        | 20190117  | 50.00                 |                     | 8279.20         | 4.76                       |                          | 420.80                     |
      | 17        | 20190118  | 50.00                 |                     | 8233.94         | 4.73                       |                          | 416.07                     |
      | 18        | 20190119  | 50.00                 |                     | 8188.64         | 4.71                       |                          | 411.36                     |
      | 19        | 20190120  | 50.00                 |                     | 8143.32         | 4.68                       |                          | 406.68                     |
      | 20        | 20190121  | 50.00                 |                     | 8097.97         | 4.65                       |                          | 402.03                     |
      | 21        | 20190122  | 50.00                 |                     | 8052.60         | 4.63                       |                          | 397.40                     |
      | 22        | 20190123  | 50.00                 |                     | 8007.20         | 4.60                       |                          | 392.80                     |
      | 23        | 20190124  | 50.00                 |                     | 7961.78         | 4.58                       |                          | 388.22                     |
      | 24        | 20190125  | 50.00                 |                     | 7916.33         | 4.55                       |                          | 383.67                     |
      | 25        | 20190126  | 50.00                 |                     | 7870.85         | 4.52                       |                          | 379.15                     |
      | 26        | 20190127  | 50.00                 |                     | 7825.35         | 4.50                       |                          | 374.65                     |
      | 27        | 20190128  | 50.00                 |                     | 7779.82         | 4.47                       |                          | 370.18                     |
      | 28        | 20190129  | 50.00                 |                     | 7734.27         | 4.45                       |                          | 365.73                     |
      | 29        | 20190130  | 50.00                 |                     | 7688.69         | 4.42                       |                          | 361.31                     |
      | 30        | 20190131  | 50.00                 |                     | 7643.08         | 4.39                       |                          | 356.92                     |
      | 31        | 20190201 | 50.00                 |                     | 7597.45         | 4.37                       |                          | 352.55                     |
      | 32        | 20190202 | 50.00                 |                     | 7551.79         | 4.34                       |                          | 348.21                     |
      | 33        | 20190203 | 50.00                 |                     | 7506.11         | 4.32                       |                          | 343.89                     |
      | 34        | 20190204 | 50.00                 |                     | 7460.40         | 4.29                       |                          | 339.60                     |
      | 35        | 20190205 | 50.00                 |                     | 7414.66         | 4.26                       |                          | 335.34                     |
      | 36        | 20190206 | 50.00                 |                     | 7368.90         | 4.24                       |                          | 331.10                     |
      | 37        | 20190207 | 50.00                 |                     | 7323.11         | 4.21                       |                          | 326.89                     |
      | 38        | 20190208 | 50.00                 |                     | 7277.29         | 4.18                       |                          | 322.71                     |
      | 39        | 20190209 | 50.00                 |                     | 7231.45         | 4.16                       |                          | 318.55                     |
      | 40        | 20190210 | 50.00                 |                     | 7185.58         | 4.13                       |                          | 314.42                     |
      | 41        | 20190211 | 50.00                 |                     | 7139.69         | 4.11                       |                          | 310.31                     |
      | 42        | 20190212 | 50.00                 |                     | 7093.77         | 4.08                       |                          | 306.23                     |
      | 43        | 20190213 | 50.00                 |                     | 7047.82         | 4.05                       |                          | 302.18                     |
      | 44        | 20190214 | 50.00                 |                     | 7001.85         | 4.03                       |                          | 298.15                     |
      | 45        | 20190215 | 50.00                 |                     | 6955.85         | 4.00                       |                          | 294.15                     |
      | 46        | 20190216 | 50.00                 |                     | 6909.83         | 3.97                       |                          | 290.18                     |
      | 47        | 20190217 | 50.00                 |                     | 6863.78         | 3.95                       |                          | 286.23                     |
      | 48        | 20190218 | 50.00                 |                     | 6817.70         | 3.92                       |                          | 282.31                     |
      | 49        | 20190219 | 50.00                 |                     | 6771.59         | 3.90                       |                          | 278.41                     |
      | 50        | 20190220 | 50.00                 |                     | 6725.46         | 3.87                       |                          | 274.54                     |
      | 51        | 20190221 | 50.00                 |                     | 6679.31         | 3.84                       |                          | 270.70                     |
      | 52        | 20190222 | 50.00                 |                     | 6633.12         | 3.82                       |                          | 266.88                     |
      | 53        | 20190223 | 50.00                 |                     | 6586.91         | 3.79                       |                          | 263.09                     |
      | 54        | 20190224 | 50.00                 |                     | 6540.68         | 3.76                       |                          | 259.33                     |
      | 55        | 20190225 | 50.00                 |                     | 6494.42         | 3.74                       |                          | 255.59                     |
      | 56        | 20190226 | 50.00                 |                     | 6448.13         | 3.71                       |                          | 251.88                     |
      | 57        | 20190227 | 50.00                 |                     | 6401.81         | 3.68                       |                          | 248.20                     |
      | 58        | 20190228 | 50.00                 |                     | 6355.47         | 3.66                       |                          | 244.54                     |
      | 59        | 20190301    | 50.00                 |                     | 6309.10         | 3.63                       |                          | 240.91                     |
      | 60        | 20190302    | 50.00                 |                     | 6262.71         | 3.61                       |                          | 237.30                     |
      | 61        | 20190303    | 50.00                 |                     | 6216.29         | 3.58                       |                          | 233.72                     |
      | 62        | 20190304    | 50.00                 |                     | 6169.84         | 3.55                       |                          | 230.17                     |
      | 63        | 20190305    | 50.00                 |                     | 6123.36         | 3.53                       |                          | 226.64                     |
      | 64        | 20190306    | 50.00                 |                     | 6076.86         | 3.50                       |                          | 223.14                     |
      | 65        | 20190307    | 50.00                 |                     | 6030.34         | 3.47                       |                          | 219.67                     |
      | 66        | 20190308    | 50.00                 |                     | 5983.78         | 3.45                       |                          | 216.22                     |
      | 67        | 20190309    | 50.00                 |                     | 5937.20         | 3.42                       |                          | 212.80                     |
      | 68        | 20190310    | 50.00                 |                     | 5890.59         | 3.39                       |                          | 209.41                     |
      | 69        | 20190311    | 50.00                 |                     | 5843.96         | 3.37                       |                          | 206.04                     |
      | 70        | 20190312    | 50.00                 |                     | 5797.30         | 3.34                       |                          | 202.70                     |
      | 71        | 20190313    | 50.00                 |                     | 5750.61         | 3.31                       |                          | 199.39                     |
      | 72        | 20190314    | 50.00                 |                     | 5703.90         | 3.29                       |                          | 196.10                     |
      | 73        | 20190315    | 50.00                 |                     | 5657.16         | 3.26                       |                          | 192.84                     |
      | 74        | 20190316    | 50.00                 |                     | 5610.39         | 3.23                       |                          | 189.61                     |
      | 75        | 20190317    | 50.00                 |                     | 5563.60         | 3.21                       |                          | 186.40                     |
      | 76        | 20190318    | 50.00                 |                     | 5516.78         | 3.18                       |                          | 183.22                     |
      | 77        | 20190319    | 50.00                 |                     | 5469.93         | 3.15                       |                          | 180.07                     |
      | 78        | 20190320    | 50.00                 |                     | 5423.06         | 3.13                       |                          | 176.94                     |
      | 79        | 20190321    | 50.00                 |                     | 5376.15         | 3.10                       |                          | 173.84                     |
      | 80        | 20190322    | 50.00                 |                     | 5329.23         | 3.07                       |                          | 170.77                     |
      | 81        | 20190323    | 50.00                 |                     | 5282.27         | 3.05                       |                          | 167.72                     |
      | 82        | 20190324    | 50.00                 |                     | 5235.29         | 3.02                       |                          | 164.70                     |
      | 83        | 20190325    | 50.00                 |                     | 5188.28         | 2.99                       |                          | 161.71                     |
      | 84        | 20190326    | 50.00                 |                     | 5141.25         | 2.96                       |                          | 158.75                     |
      | 85        | 20190327    | 50.00                 |                     | 5094.18         | 2.94                       |                          | 155.81                     |
      | 86        | 20190328    | 50.00                 |                     | 5047.10         | 2.91                       |                          | 152.90                     |
      | 87        | 20190329    | 50.00                 |                     | 4999.98         | 2.88                       |                          | 150.02                     |
      | 88        | 20190330    | 50.00                 |                     | 4952.84         | 2.86                       |                          | 147.16                     |
      | 89        | 20190331    | 50.00                 |                     | 4905.67         | 2.83                       |                          | 144.33                     |
      | 90        | 20190401    | 50.00                 |                     | 4858.47         | 2.80                       |                          | 141.53                     |
      | 91        | 20190402    | 50.00                 |                     | 4811.25         | 2.78                       |                          | 138.75                     |
      | 92        | 20190403    | 50.00                 |                     | 4764.00         | 2.75                       |                          | 136.00                     |
      | 93        | 20190404    | 50.00                 |                     | 4716.72         | 2.72                       |                          | 133.28                     |
      | 94        | 20190405    | 50.00                 |                     | 4669.41         | 2.70                       |                          | 130.58                     |
      | 95        | 20190406    | 50.00                 |                     | 4622.08         | 2.67                       |                          | 127.91                     |
      | 96        | 20190407    | 50.00                 |                     | 4574.72         | 2.64                       |                          | 125.27                     |
      | 97        | 20190408    | 50.00                 |                     | 4527.34         | 2.61                       |                          | 122.66                     |
      | 98        | 20190409    | 50.00                 |                     | 4479.93         | 2.59                       |                          | 120.07                     |
      | 99        | 20190410    | 50.00                 |                     | 4432.49         | 2.56                       |                          | 117.51                     |
      | 100       | 20190411    | 50.00                 |                     | 4385.02         | 2.53                       |                          | 114.98                     |
      | 101       | 20190412    | 50.00                 |                     | 4337.52         | 2.51                       |                          | 112.47                     |
      | 102       | 20190413    | 50.00                 |                     | 4290.00         | 2.48                       |                          | 109.99                     |
      | 103       | 20190414    | 50.00                 |                     | 4242.45         | 2.45                       |                          | 107.54                     |
      | 104       | 20190415    | 50.00                 |                     | 4194.88         | 2.42                       |                          | 105.12                     |
      | 105       | 20190416    | 50.00                 |                     | 4147.28         | 2.40                       |                          | 102.72                     |
      | 106       | 20190417    | 50.00                 |                     | 4099.65         | 2.37                       |                          | 100.35                     |
      | 107       | 20190418    | 50.00                 |                     | 4051.99         | 2.34                       |                          | 98.01                      |
      | 108       | 20190419    | 50.00                 |                     | 4004.30         | 2.32                       |                          | 95.69                      |
      | 109       | 20190420    | 50.00                 |                     | 3956.59         | 2.29                       |                          | 93.40                      |
      | 110       | 20190421    | 50.00                 |                     | 3908.85         | 2.26                       |                          | 91.14                      |
      | 111       | 20190422    | 50.00                 |                     | 3861.09         | 2.23                       |                          | 88.91                      |
      | 112       | 20190423    | 50.00                 |                     | 3813.29         | 2.21                       |                          | 86.70                      |
      | 113       | 20190424    | 50.00                 |                     | 3765.47         | 2.18                       |                          | 84.52                      |
      | 114       | 20190425    | 50.00                 |                     | 3717.62         | 2.15                       |                          | 82.37                      |
      | 115       | 20190426    | 50.00                 |                     | 3669.75         | 2.12                       |                          | 80.25                      |
      | 116       | 20190427    | 50.00                 |                     | 3621.85         | 2.10                       |                          | 78.15                      |
      | 117       | 20190428    | 50.00                 |                     | 3573.92         | 2.07                       |                          | 76.08                      |
      | 118       | 20190429    | 50.00                 |                     | 3525.96         | 2.04                       |                          | 74.04                      |
      | 119       | 20190430    | 50.00                 |                     | 3477.97         | 2.01                       |                          | 72.03                      |
      | 120       | 20190501      | 50.00                 |                     | 3429.96         | 1.99                       |                          | 70.04                      |
      | 121       | 20190502      | 50.00                 |                     | 3381.92         | 1.96                       |                          | 68.08                      |
      | 122       | 20190503      | 50.00                 |                     | 3333.85         | 1.93                       |                          | 66.15                      |
      | 123       | 20190504      | 50.00                 |                     | 3285.76         | 1.91                       |                          | 64.24                      |
      | 124       | 20190505      | 50.00                 |                     | 3237.64         | 1.88                       |                          | 62.36                      |
      | 125       | 20190506      | 50.00                 |                     | 3189.49         | 1.85                       |                          | 60.51                      |
      | 126       | 20190507      | 50.00                 |                     | 3141.31         | 1.82                       |                          | 58.69                      |
      | 127       | 20190508      | 50.00                 |                     | 3093.10         | 1.80                       |                          | 56.89                      |
      | 128       | 20190509      | 50.00                 |                     | 3044.87         | 1.77                       |                          | 55.12                      |
      | 129       | 20190510      | 50.00                 |                     | 2996.61         | 1.74                       |                          | 53.38                      |
      | 130       | 20190511      | 50.00                 |                     | 2948.32         | 1.71                       |                          | 51.67                      |
      | 131       | 20190512      | 50.00                 |                     | 2900.01         | 1.68                       |                          | 49.99                      |
      | 132       | 20190513      | 50.00                 |                     | 2851.67         | 1.66                       |                          | 48.33                      |
      | 133       | 20190514      | 50.00                 |                     | 2803.30         | 1.63                       |                          | 46.70                      |
      | 134       | 20190515      | 50.00                 |                     | 2754.90         | 1.60                       |                          | 45.10                      |
      | 135       | 20190516      | 50.00                 |                     | 2706.47         | 1.57                       |                          | 43.53                      |
      | 136       | 20190517      | 50.00                 |                     | 2658.02         | 1.55                       |                          | 41.98                      |
      | 137       | 20190518      | 50.00                 |                     | 2609.54         | 1.52                       |                          | 40.46                      |
      | 138       | 20190519      | 50.00                 |                     | 2561.03         | 1.49                       |                          | 38.97                      |
      | 139       | 20190520      | 50.00                 |                     | 2512.49         | 1.46                       |                          | 37.51                      |
      | 140       | 20190521      | 50.00                 |                     | 2463.93         | 1.44                       |                          | 36.07                      |
      | 141       | 20190522      | 50.00                 |                     | 2415.34         | 1.41                       |                          | 34.66                      |
      | 142       | 20190523      | 50.00                 |                     | 2366.72         | 1.38                       |                          | 33.28                      |
      | 143       | 20190524      | 50.00                 |                     | 2318.07         | 1.35                       |                          | 31.93                      |
      | 144       | 20190525      | 50.00                 |                     | 2269.39         | 1.32                       |                          | 30.61                      |
      | 145       | 20190526      | 50.00                 |                     | 2220.69         | 1.30                       |                          | 29.31                      |
      | 146       | 20190527      | 50.00                 |                     | 2171.96         | 1.27                       |                          | 28.04                      |
      | 147       | 20190528      | 50.00                 |                     | 2123.20         | 1.24                       |                          | 26.80                      |
      | 148       | 20190529      | 50.00                 |                     | 2074.41         | 1.21                       |                          | 25.59                      |
      | 149       | 20190530      | 50.00                 |                     | 2025.60         | 1.19                       |                          | 24.40                      |
      | 150       | 20190531      | 50.00                 |                     | 1976.76         | 1.16                       |                          | 23.24                      |
      | 151       | 20190601     | 50.00                 |                     | 1927.89         | 1.13                       |                          | 22.11                      |
      | 152       | 20190602     | 50.00                 |                     | 1878.99         | 1.10                       |                          | 21.01                      |
      | 153       | 20190603     | 50.00                 |                     | 1830.06         | 1.07                       |                          | 19.94                      |
      | 154       | 20190604     | 50.00                 |                     | 1781.11         | 1.05                       |                          | 18.89                      |
      | 155       | 20190605     | 50.00                 |                     | 1732.13         | 1.02                       |                          | 17.87                      |
      | 156       | 20190606     | 50.00                 |                     | 1683.12         | 0.99                       |                          | 16.88                      |
      | 157       | 20190607     | 50.00                 |                     | 1634.08         | 0.96                       |                          | 15.92                      |
      | 158       | 20190608     | 50.00                 |                     | 1585.01         | 0.93                       |                          | 14.99                      |
      | 159       | 20190609     | 50.00                 |                     | 1535.92         | 0.91                       |                          | 14.08                      |
      | 160       | 20190610     | 50.00                 |                     | 1486.79         | 0.88                       |                          | 13.20                      |
      | 161       | 20190611     | 50.00                 |                     | 1437.64         | 0.85                       |                          | 12.35                      |
      | 162       | 20190612     | 50.00                 |                     | 1388.47         | 0.82                       |                          | 11.53                      |
      | 163       | 20190613     | 50.00                 |                     | 1339.26         | 0.79                       |                          | 10.74                      |
      | 164       | 20190614     | 50.00                 |                     | 1290.02         | 0.77                       |                          | 9.97                       |
      | 165       | 20190615     | 50.00                 |                     | 1240.76         | 0.74                       |                          | 9.23                       |
      | 166       | 20190616     | 50.00                 |                     | 1191.47         | 0.71                       |                          | 8.52                       |
      | 167       | 20190617     | 50.00                 |                     | 1142.15         | 0.68                       |                          | 7.84                       |
      | 168       | 20190618     | 50.00                 |                     | 1092.80         | 0.65                       |                          | 7.19                       |
      | 169       | 20190619     | 50.00                 |                     | 1043.43         | 0.62                       |                          | 6.57                       |
      | 170       | 20190620     | 50.00                 |                     | 994.02          | 0.60                       |                          | 5.97                       |
      | 171       | 20190621     | 50.00                 |                     | 944.59          | 0.57                       |                          | 5.40                       |
      | 172       | 20190622     | 50.00                 |                     | 895.13          | 0.54                       |                          | 4.86                       |
      | 173       | 20190623     | 50.00                 |                     | 845.64          | 0.51                       |                          | 4.35                       |
      | 174       | 20190624     | 50.00                 |                     | 796.13          | 0.48                       |                          | 3.87                       |
      | 175       | 20190625     | 50.00                 |                     | 746.58          | 0.45                       |                          | 3.42                       |
      | 176       | 20190626     | 50.00                 |                     | 697.01          | 0.43                       |                          | 2.99                       |
      | 177       | 20190627     | 50.00                 |                     | 647.41          | 0.40                       |                          | 2.59                       |
      | 178       | 20190628     | 50.00                 |                     | 597.78          | 0.37                       |                          | 2.22                       |
      | 179       | 20190629     | 50.00                 |                     | 548.12          | 0.34                       |                          | 1.88                       |
      | 180       | 20190630     | 50.00                 |                     | 498.43          | 0.31                       |                          | 1.57                       |
      | 181       | 20190701     | 50.00                 |                     | 448.72          | 0.28                       |                          | 1.29                       |
      | 182       | 20190702     | 50.00                 |                     | 398.97          | 0.26                       |                          | 1.03                       |
      | 183       | 20190703     | 50.00                 |                     | 349.20          | 0.23                       |                          | 0.80                       |
      | 184       | 20190704     | 50.00                 |                     | 299.40          | 0.20                       |                          | 0.60                       |
      | 185       | 20190705     | 50.00                 |                     | 249.57          | 0.17                       |                          | 0.43                       |
      | 186       | 20190706     | 50.00                 |                     | 199.71          | 0.14                       |                          | 0.29                       |
      | 187       | 20190707     | 50.00                 |                     | 149.83          | 0.11                       |                          | 0.18                       |
      | 188       | 20190708     | 50.00                 |                     | 99.91           | 0.09                       |                          | 0.09                       |
      | 189       | 20190709     | 50.00                 |                     | 49.97           | 0.06                       |                          | 0.03                       |
      | 190       | 20190710     | 50.00                 |                     | 0.00            | 0.03                       |                          | 0.00                       |

  @TestRailId:C83038
  Scenario: Verify amortization schedule after discount fee adjustment made after repayment - EIR discount adjustment S1.2
    When Admin sets the business date to "20190101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct | submittedOnDate | expectedDisbursementDate | principalAmount | totalPayment | periodPaymentRate | discount |
      | WCLP        | 20190101 | 20190101          | 9000            | 100000       | 18                | 1000     |
    And Admin successfully approves the working capital loan on "20190101" with "9000" amount and "1000" discount amount and expected disbursement date on "20190101"
    And Admin successfully disburse the Working Capital loan on "20190101" with "9000" EUR transaction amount and "1000" discount amount
    Then Working Capital loan amortization schedule has 201 periods, with the following data for periods:
      | paymentNo | paymentDate      | expectedPaymentAmount | actualPaymentAmount | expectedBalance | expectedAmortizationAmount | actualAmortizationAmount | expectedDiscountFeeBalance |
      | 0         | 20190101  | -9000.00              |                     | 9000.00         |                            |                          | 1000.00                    |
      | 1         | 20190102  | 50.00                 |                     | 8959.61         | 9.61                       |                          | 990.39                     |
      | 2         | 20190103  | 50.00                 |                     | 8919.18         | 9.57                       |                          | 980.82                     |
      | 3         | 20190104  | 50.00                 |                     | 8878.70         | 9.52                       |                          | 971.30                     |
      | 4         | 20190105  | 50.00                 |                     | 8838.18         | 9.48                       |                          | 961.82                     |
      | 5         | 20190106  | 50.00                 |                     | 8797.62         | 9.44                       |                          | 952.38                     |
      | 6         | 20190107  | 50.00                 |                     | 8757.01         | 9.39                       |                          | 942.99                     |
      | 7         | 20190108  | 50.00                 |                     | 8716.36         | 9.35                       |                          | 933.64                     |
      | 8         | 20190109  | 50.00                 |                     | 8675.67         | 9.31                       |                          | 924.33                     |
      | 9         | 20190110  | 50.00                 |                     | 8634.94         | 9.26                       |                          | 915.07                     |
      | 10        | 20190111  | 50.00                 |                     | 8594.16         | 9.22                       |                          | 905.85                     |
      | 11        | 20190112  | 50.00                 |                     | 8553.33         | 9.18                       |                          | 896.67                     |
      | 12        | 20190113  | 50.00                 |                     | 8512.47         | 9.13                       |                          | 887.54                     |
      | 13        | 20190114  | 50.00                 |                     | 8471.56         | 9.09                       |                          | 878.45                     |
      | 14        | 20190115  | 50.00                 |                     | 8430.60         | 9.05                       |                          | 869.40                     |
      | 15        | 20190116  | 50.00                 |                     | 8389.61         | 9.00                       |                          | 860.40                     |
      | 16        | 20190117  | 50.00                 |                     | 8348.56         | 8.96                       |                          | 851.44                     |
      | 17        | 20190118  | 50.00                 |                     | 8307.48         | 8.91                       |                          | 842.53                     |
      | 18        | 20190119  | 50.00                 |                     | 8266.35         | 8.87                       |                          | 833.66                     |
      | 19        | 20190120  | 50.00                 |                     | 8225.18         | 8.83                       |                          | 824.83                     |
      | 20        | 20190121  | 50.00                 |                     | 8183.96         | 8.78                       |                          | 816.05                     |
      | 21        | 20190122  | 50.00                 |                     | 8142.70         | 8.74                       |                          | 807.31                     |
      | 22        | 20190123  | 50.00                 |                     | 8101.39         | 8.69                       |                          | 798.62                     |
      | 23        | 20190124  | 50.00                 |                     | 8060.04         | 8.65                       |                          | 789.97                     |
      | 24        | 20190125  | 50.00                 |                     | 8018.65         | 8.61                       |                          | 781.36                     |
      | 25        | 20190126  | 50.00                 |                     | 7977.21         | 8.56                       |                          | 772.80                     |
      | 26        | 20190127  | 50.00                 |                     | 7935.73         | 8.52                       |                          | 764.28                     |
      | 27        | 20190128  | 50.00                 |                     | 7894.21         | 8.47                       |                          | 755.81                     |
      | 28        | 20190129  | 50.00                 |                     | 7852.63         | 8.43                       |                          | 747.38                     |
      | 29        | 20190130  | 50.00                 |                     | 7811.02         | 8.39                       |                          | 738.99                     |
      | 30        | 20190131  | 50.00                 |                     | 7769.36         | 8.34                       |                          | 730.65                     |
      | 31        | 20190201 | 50.00                 |                     | 7727.66         | 8.30                       |                          | 722.35                     |
      | 32        | 20190202 | 50.00                 |                     | 7685.91         | 8.25                       |                          | 714.10                     |
      | 33        | 20190203 | 50.00                 |                     | 7644.12         | 8.21                       |                          | 705.89                     |
      | 34        | 20190204 | 50.00                 |                     | 7602.28         | 8.16                       |                          | 697.73                     |
      | 35        | 20190205 | 50.00                 |                     | 7560.40         | 8.12                       |                          | 689.61                     |
      | 36        | 20190206 | 50.00                 |                     | 7518.47         | 8.07                       |                          | 681.54                     |
      | 37        | 20190207 | 50.00                 |                     | 7476.50         | 8.03                       |                          | 673.51                     |
      | 38        | 20190208 | 50.00                 |                     | 7434.48         | 7.98                       |                          | 665.53                     |
      | 39        | 20190209 | 50.00                 |                     | 7392.42         | 7.94                       |                          | 657.59                     |
      | 40        | 20190210 | 50.00                 |                     | 7350.31         | 7.89                       |                          | 649.70                     |
      | 41        | 20190211 | 50.00                 |                     | 7308.16         | 7.85                       |                          | 641.85                     |
      | 42        | 20190212 | 50.00                 |                     | 7265.97         | 7.80                       |                          | 634.05                     |
      | 43        | 20190213 | 50.00                 |                     | 7223.72         | 7.76                       |                          | 626.29                     |
      | 44        | 20190214 | 50.00                 |                     | 7181.44         | 7.71                       |                          | 618.58                     |
      | 45        | 20190215 | 50.00                 |                     | 7139.11         | 7.67                       |                          | 610.91                     |
      | 46        | 20190216 | 50.00                 |                     | 7096.73         | 7.62                       |                          | 603.29                     |
      | 47        | 20190217 | 50.00                 |                     | 7054.31         | 7.58                       |                          | 595.71                     |
      | 48        | 20190218 | 50.00                 |                     | 7011.84         | 7.53                       |                          | 588.18                     |
      | 49        | 20190219 | 50.00                 |                     | 6969.33         | 7.49                       |                          | 580.69                     |
      | 50        | 20190220 | 50.00                 |                     | 6926.77         | 7.44                       |                          | 573.25                     |
      | 51        | 20190221 | 50.00                 |                     | 6884.17         | 7.40                       |                          | 565.85                     |
      | 52        | 20190222 | 50.00                 |                     | 6841.52         | 7.35                       |                          | 558.50                     |
      | 53        | 20190223 | 50.00                 |                     | 6798.82         | 7.31                       |                          | 551.19                     |
      | 54        | 20190224 | 50.00                 |                     | 6756.08         | 7.26                       |                          | 543.93                     |
      | 55        | 20190225 | 50.00                 |                     | 6713.30         | 7.21                       |                          | 536.72                     |
      | 56        | 20190226 | 50.00                 |                     | 6670.47         | 7.17                       |                          | 529.55                     |
      | 57        | 20190227 | 50.00                 |                     | 6627.59         | 7.12                       |                          | 522.43                     |
      | 58        | 20190228 | 50.00                 |                     | 6584.67         | 7.08                       |                          | 515.35                     |
      | 59        | 20190301    | 50.00                 |                     | 6541.70         | 7.03                       |                          | 508.32                     |
      | 60        | 20190302    | 50.00                 |                     | 6498.68         | 6.99                       |                          | 501.33                     |
      | 61        | 20190303    | 50.00                 |                     | 6455.62         | 6.94                       |                          | 494.39                     |
      | 62        | 20190304    | 50.00                 |                     | 6412.51         | 6.89                       |                          | 487.50                     |
      | 63        | 20190305    | 50.00                 |                     | 6369.36         | 6.85                       |                          | 480.65                     |
      | 64        | 20190306    | 50.00                 |                     | 6326.16         | 6.80                       |                          | 473.85                     |
      | 65        | 20190307    | 50.00                 |                     | 6282.92         | 6.76                       |                          | 467.09                     |
      | 66        | 20190308    | 50.00                 |                     | 6239.63         | 6.71                       |                          | 460.38                     |
      | 67        | 20190309    | 50.00                 |                     | 6196.29         | 6.66                       |                          | 453.72                     |
      | 68        | 20190310    | 50.00                 |                     | 6152.91         | 6.62                       |                          | 447.10                     |
      | 69        | 20190311    | 50.00                 |                     | 6109.48         | 6.57                       |                          | 440.53                     |
      | 70        | 20190312    | 50.00                 |                     | 6066.00         | 6.52                       |                          | 434.01                     |
      | 71        | 20190313    | 50.00                 |                     | 6022.48         | 6.48                       |                          | 427.53                     |
      | 72        | 20190314    | 50.00                 |                     | 5978.91         | 6.43                       |                          | 421.10                     |
      | 73        | 20190315    | 50.00                 |                     | 5935.29         | 6.38                       |                          | 414.72                     |
      | 74        | 20190316    | 50.00                 |                     | 5891.63         | 6.34                       |                          | 408.38                     |
      | 75        | 20190317    | 50.00                 |                     | 5847.92         | 6.29                       |                          | 402.09                     |
      | 76        | 20190318    | 50.00                 |                     | 5804.17         | 6.24                       |                          | 395.85                     |
      | 77        | 20190319    | 50.00                 |                     | 5760.36         | 6.20                       |                          | 389.65                     |
      | 78        | 20190320    | 50.00                 |                     | 5716.52         | 6.15                       |                          | 383.50                     |
      | 79        | 20190321    | 50.00                 |                     | 5672.62         | 6.10                       |                          | 377.40                     |
      | 80        | 20190322    | 50.00                 |                     | 5628.68         | 6.06                       |                          | 371.34                     |
      | 81        | 20190323    | 50.00                 |                     | 5584.69         | 6.01                       |                          | 365.33                     |
      | 82        | 20190324    | 50.00                 |                     | 5540.65         | 5.96                       |                          | 359.37                     |
      | 83        | 20190325    | 50.00                 |                     | 5496.57         | 5.92                       |                          | 353.45                     |
      | 84        | 20190326    | 50.00                 |                     | 5452.44         | 5.87                       |                          | 347.58                     |
      | 85        | 20190327    | 50.00                 |                     | 5408.26         | 5.82                       |                          | 341.76                     |
      | 86        | 20190328    | 50.00                 |                     | 5364.03         | 5.78                       |                          | 335.98                     |
      | 87        | 20190329    | 50.00                 |                     | 5319.76         | 5.73                       |                          | 330.25                     |
      | 88        | 20190330    | 50.00                 |                     | 5275.44         | 5.68                       |                          | 324.57                     |
      | 89        | 20190331    | 50.00                 |                     | 5231.08         | 5.63                       |                          | 318.94                     |
      | 90        | 20190401    | 50.00                 |                     | 5186.66         | 5.59                       |                          | 313.35                     |
      | 91        | 20190402    | 50.00                 |                     | 5142.20         | 5.54                       |                          | 307.81                     |
      | 92        | 20190403    | 50.00                 |                     | 5097.69         | 5.49                       |                          | 302.32                     |
      | 93        | 20190404    | 50.00                 |                     | 5053.13         | 5.44                       |                          | 296.88                     |
      | 94        | 20190405    | 50.00                 |                     | 5008.53         | 5.40                       |                          | 291.48                     |
      | 95        | 20190406    | 50.00                 |                     | 4963.88         | 5.35                       |                          | 286.13                     |
      | 96        | 20190407    | 50.00                 |                     | 4919.18         | 5.30                       |                          | 280.83                     |
      | 97        | 20190408    | 50.00                 |                     | 4874.43         | 5.25                       |                          | 275.58                     |
      | 98        | 20190409    | 50.00                 |                     | 4829.64         | 5.20                       |                          | 270.38                     |
      | 99        | 20190410    | 50.00                 |                     | 4784.79         | 5.16                       |                          | 265.22                     |
      | 100       | 20190411    | 50.00                 |                     | 4739.90         | 5.11                       |                          | 260.11                     |
      | 101       | 20190412    | 50.00                 |                     | 4694.96         | 5.06                       |                          | 255.05                     |
      | 102       | 20190413    | 50.00                 |                     | 4649.98         | 5.01                       |                          | 250.04                     |
      | 103       | 20190414    | 50.00                 |                     | 4604.94         | 4.97                       |                          | 245.07                     |
      | 104       | 20190415    | 50.00                 |                     | 4559.86         | 4.92                       |                          | 240.15                     |
      | 105       | 20190416    | 50.00                 |                     | 4514.73         | 4.87                       |                          | 235.28                     |
      | 106       | 20190417    | 50.00                 |                     | 4469.55         | 4.82                       |                          | 230.46                     |
      | 107       | 20190418    | 50.00                 |                     | 4424.32         | 4.77                       |                          | 225.69                     |
      | 108       | 20190419    | 50.00                 |                     | 4379.05         | 4.72                       |                          | 220.97                     |
      | 109       | 20190420    | 50.00                 |                     | 4333.72         | 4.68                       |                          | 216.29                     |
      | 110       | 20190421    | 50.00                 |                     | 4288.35         | 4.63                       |                          | 211.66                     |
      | 111       | 20190422    | 50.00                 |                     | 4242.93         | 4.58                       |                          | 207.08                     |
      | 112       | 20190423    | 50.00                 |                     | 4197.46         | 4.53                       |                          | 202.55                     |
      | 113       | 20190424    | 50.00                 |                     | 4151.94         | 4.48                       |                          | 198.07                     |
      | 114       | 20190425    | 50.00                 |                     | 4106.38         | 4.43                       |                          | 193.64                     |
      | 115       | 20190426    | 50.00                 |                     | 4060.76         | 4.38                       |                          | 189.26                     |
      | 116       | 20190427    | 50.00                 |                     | 4015.10         | 4.34                       |                          | 184.92                     |
      | 117       | 20190428    | 50.00                 |                     | 3969.38         | 4.29                       |                          | 180.63                     |
      | 118       | 20190429    | 50.00                 |                     | 3923.62         | 4.24                       |                          | 176.39                     |
      | 119       | 20190430    | 50.00                 |                     | 3877.81         | 4.19                       |                          | 172.20                     |
      | 120       | 20190501      | 50.00                 |                     | 3831.95         | 4.14                       |                          | 168.06                     |
      | 121       | 20190502      | 50.00                 |                     | 3786.04         | 4.09                       |                          | 163.97                     |
      | 122       | 20190503      | 50.00                 |                     | 3740.09         | 4.04                       |                          | 159.93                     |
      | 123       | 20190504      | 50.00                 |                     | 3694.08         | 3.99                       |                          | 155.94                     |
      | 124       | 20190505      | 50.00                 |                     | 3648.03         | 3.94                       |                          | 152.00                     |
      | 125       | 20190506      | 50.00                 |                     | 3601.92         | 3.90                       |                          | 148.10                     |
      | 126       | 20190507      | 50.00                 |                     | 3555.77         | 3.85                       |                          | 144.25                     |
      | 127       | 20190508      | 50.00                 |                     | 3509.56         | 3.80                       |                          | 140.45                     |
      | 128       | 20190509      | 50.00                 |                     | 3463.31         | 3.75                       |                          | 136.70                     |
      | 129       | 20190510      | 50.00                 |                     | 3417.01         | 3.70                       |                          | 133.00                     |
      | 130       | 20190511      | 50.00                 |                     | 3370.66         | 3.65                       |                          | 129.35                     |
      | 131       | 20190512      | 50.00                 |                     | 3324.26         | 3.60                       |                          | 125.75                     |
      | 132       | 20190513      | 50.00                 |                     | 3277.81         | 3.55                       |                          | 122.20                     |
      | 133       | 20190514      | 50.00                 |                     | 3231.31         | 3.50                       |                          | 118.70                     |
      | 134       | 20190515      | 50.00                 |                     | 3184.76         | 3.45                       |                          | 115.25                     |
      | 135       | 20190516      | 50.00                 |                     | 3138.16         | 3.40                       |                          | 111.85                     |
      | 136       | 20190517      | 50.00                 |                     | 3091.51         | 3.35                       |                          | 108.50                     |
      | 137       | 20190518      | 50.00                 |                     | 3044.81         | 3.30                       |                          | 105.20                     |
      | 138       | 20190519      | 50.00                 |                     | 2998.06         | 3.25                       |                          | 101.95                     |
      | 139       | 20190520      | 50.00                 |                     | 2951.26         | 3.20                       |                          | 98.75                      |
      | 140       | 20190521      | 50.00                 |                     | 2904.42         | 3.15                       |                          | 95.60                      |
      | 141       | 20190522      | 50.00                 |                     | 2857.52         | 3.10                       |                          | 92.50                      |
      | 142       | 20190523      | 50.00                 |                     | 2810.57         | 3.05                       |                          | 89.45                      |
      | 143       | 20190524      | 50.00                 |                     | 2763.57         | 3.00                       |                          | 86.45                      |
      | 144       | 20190525      | 50.00                 |                     | 2716.52         | 2.95                       |                          | 83.50                      |
      | 145       | 20190526      | 50.00                 |                     | 2669.42         | 2.90                       |                          | 80.60                      |
      | 146       | 20190527      | 50.00                 |                     | 2622.27         | 2.85                       |                          | 77.75                      |
      | 147       | 20190528      | 50.00                 |                     | 2575.07         | 2.80                       |                          | 74.95                      |
      | 148       | 20190529      | 50.00                 |                     | 2527.82         | 2.75                       |                          | 72.20                      |
      | 149       | 20190530      | 50.00                 |                     | 2480.52         | 2.70                       |                          | 69.50                      |
      | 150       | 20190531      | 50.00                 |                     | 2433.17         | 2.65                       |                          | 66.85                      |
      | 151       | 20190601     | 50.00                 |                     | 2385.77         | 2.60                       |                          | 64.25                      |
      | 152       | 20190602     | 50.00                 |                     | 2338.31         | 2.55                       |                          | 61.70                      |
      | 153       | 20190603     | 50.00                 |                     | 2290.81         | 2.50                       |                          | 59.20                      |
      | 154       | 20190604     | 50.00                 |                     | 2243.26         | 2.45                       |                          | 56.75                      |
      | 155       | 20190605     | 50.00                 |                     | 2195.65         | 2.40                       |                          | 54.35                      |
      | 156       | 20190606     | 50.00                 |                     | 2148.00         | 2.34                       |                          | 52.01                      |
      | 157       | 20190607     | 50.00                 |                     | 2100.29         | 2.29                       |                          | 49.72                      |
      | 158       | 20190608     | 50.00                 |                     | 2052.53         | 2.24                       |                          | 47.48                      |
      | 159       | 20190609     | 50.00                 |                     | 2004.73         | 2.19                       |                          | 45.29                      |
      | 160       | 20190610     | 50.00                 |                     | 1956.87         | 2.14                       |                          | 43.15                      |
      | 161       | 20190611     | 50.00                 |                     | 1908.96         | 2.09                       |                          | 41.06                      |
      | 162       | 20190612     | 50.00                 |                     | 1860.99         | 2.04                       |                          | 39.02                      |
      | 163       | 20190613     | 50.00                 |                     | 1812.98         | 1.99                       |                          | 37.03                      |
      | 164       | 20190614     | 50.00                 |                     | 1764.92         | 1.94                       |                          | 35.09                      |
      | 165       | 20190615     | 50.00                 |                     | 1716.80         | 1.88                       |                          | 33.21                      |
      | 166       | 20190616     | 50.00                 |                     | 1668.64         | 1.83                       |                          | 31.38                      |
      | 167       | 20190617     | 50.00                 |                     | 1620.42         | 1.78                       |                          | 29.60                      |
      | 168       | 20190618     | 50.00                 |                     | 1572.15         | 1.73                       |                          | 27.87                      |
      | 169       | 20190619     | 50.00                 |                     | 1523.83         | 1.68                       |                          | 26.19                      |
      | 170       | 20190620     | 50.00                 |                     | 1475.45         | 1.63                       |                          | 24.56                      |
      | 171       | 20190621     | 50.00                 |                     | 1427.03         | 1.58                       |                          | 22.98                      |
      | 172       | 20190622     | 50.00                 |                     | 1378.55         | 1.52                       |                          | 21.46                      |
      | 173       | 20190623     | 50.00                 |                     | 1330.02         | 1.47                       |                          | 19.99                      |
      | 174       | 20190624     | 50.00                 |                     | 1281.45         | 1.42                       |                          | 18.57                      |
      | 175       | 20190625     | 50.00                 |                     | 1232.81         | 1.37                       |                          | 17.20                      |
      | 176       | 20190626     | 50.00                 |                     | 1184.13         | 1.32                       |                          | 15.88                      |
      | 177       | 20190627     | 50.00                 |                     | 1135.39         | 1.26                       |                          | 14.62                      |
      | 178       | 20190628     | 50.00                 |                     | 1086.61         | 1.21                       |                          | 13.41                      |
      | 179       | 20190629     | 50.00                 |                     | 1037.77         | 1.16                       |                          | 12.25                      |
      | 180       | 20190630     | 50.00                 |                     | 988.88          | 1.11                       |                          | 11.14                      |
      | 181       | 20190701     | 50.00                 |                     | 939.93          | 1.06                       |                          | 10.08                      |
      | 182       | 20190702     | 50.00                 |                     | 890.93          | 1.00                       |                          | 9.08                       |
      | 183       | 20190703     | 50.00                 |                     | 841.89          | 0.95                       |                          | 8.13                       |
      | 184       | 20190704     | 50.00                 |                     | 792.79          | 0.90                       |                          | 7.23                       |
      | 185       | 20190705     | 50.00                 |                     | 743.63          | 0.85                       |                          | 6.38                       |
      | 186       | 20190706     | 50.00                 |                     | 694.43          | 0.79                       |                          | 5.59                       |
      | 187       | 20190707     | 50.00                 |                     | 645.17          | 0.74                       |                          | 4.85                       |
      | 188       | 20190708     | 50.00                 |                     | 595.86          | 0.69                       |                          | 4.16                       |
      | 189       | 20190709     | 50.00                 |                     | 546.49          | 0.64                       |                          | 3.52                       |
      | 190       | 20190710     | 50.00                 |                     | 497.08          | 0.58                       |                          | 2.94                       |
      | 191       | 20190711     | 50.00                 |                     | 447.61          | 0.53                       |                          | 2.41                       |
      | 192       | 20190712     | 50.00                 |                     | 398.08          | 0.48                       |                          | 1.93                       |
      | 193       | 20190713     | 50.00                 |                     | 348.51          | 0.43                       |                          | 1.50                       |
      | 194       | 20190714     | 50.00                 |                     | 298.88          | 0.37                       |                          | 1.13                       |
      | 195       | 20190715     | 50.00                 |                     | 249.20          | 0.32                       |                          | 0.81                       |
      | 196       | 20190716     | 50.00                 |                     | 199.47          | 0.27                       |                          | 0.54                       |
      | 197       | 20190717     | 50.00                 |                     | 149.68          | 0.21                       |                          | 0.33                       |
      | 198       | 20190718     | 50.00                 |                     | 99.84           | 0.16                       |                          | 0.17                       |
      | 199       | 20190719     | 50.00                 |                     | 49.95           | 0.11                       |                          | 0.06                       |
      | 200       | 20190720     | 50.00                 |                     | 0.00            | 0.05                       |                          | 0.01                       |
    When Admin sets the business date to "20190105"
    And Customer makes repayment on "20190105" with 50 transaction amount on Working Capital loan
    When Admin sets the business date to "20190108"
    And Admin loads discount fee transaction from Working Capital loan for adjustment
    And Admin adds Discount fee adjustment with "500" amount on transaction date "20190108" on Working Capital loan account for last discount
    Then Working Capital loan amortization schedule has 194 periods, with the following data for periods:
      | paymentNo | paymentDate      | expectedPaymentAmount | actualPaymentAmount | expectedBalance | actualBalance | expectedAmortizationAmount | actualAmortizationAmount | expectedDiscountFeeBalance |
      | 0         | 20190101  | -9000.00              |                     | 9000.00         | 9000.00       |                            |                          | 500.00                     |
      | 1         | 20190102  | 50.00                 | 0.00                | 8955.14         | 9000.00       | 5.14                       | 0.00                     | 494.86                     |
      | 2         | 20190103  | 50.00                 | 0.00                | 8910.26         | 9000.00       | 5.12                       | 0.00                     | 489.74                     |
      | 3         | 20190104  | 50.00                 | 0.00                | 8865.35         | 9000.00       | 5.09                       | 0.00                     | 484.65                     |
      | 4         | 20190105  | 50.00                 | 50.00               | 8820.42         | 8955.14       | 5.07                       | 5.14                     | 479.58                     |
      | 5         | 20190106  | 50.00                 |                     | 8775.46         |               | 5.04                       |                          | 474.54                     |
      | 6         | 20190107  | 50.00                 |                     | 8730.47         |               | 5.01                       |                          | 469.53                     |
      | 7         | 20190108  | 50.00                 |                     | 8685.46         |               | 4.99                       |                          | 464.54                     |
      | 8         | 20190109  | 50.00                 |                     | 8640.43         |               | 4.96                       |                          | 459.58                     |
      | 9         | 20190110  | 50.00                 |                     | 8595.36         |               | 4.94                       |                          | 454.64                     |
      | 10        | 20190111  | 50.00                 |                     | 8550.28         |               | 4.91                       |                          | 449.73                     |
      | 11        | 20190112  | 50.00                 |                     | 8505.16         |               | 4.89                       |                          | 444.84                     |
      | 12        | 20190113  | 50.00                 |                     | 8460.02         |               | 4.86                       |                          | 439.98                     |
      | 13        | 20190114  | 50.00                 |                     | 8414.86         |               | 4.83                       |                          | 435.15                     |
      | 14        | 20190115  | 50.00                 |                     | 8369.66         |               | 4.81                       |                          | 430.34                     |
      | 15        | 20190116  | 50.00                 |                     | 8324.45         |               | 4.78                       |                          | 425.56                     |
      | 16        | 20190117  | 50.00                 |                     | 8279.20         |               | 4.76                       |                          | 420.80                     |
      | 17        | 20190118  | 50.00                 |                     | 8233.94         |               | 4.73                       |                          | 416.07                     |
      | 18        | 20190119  | 50.00                 |                     | 8188.64         |               | 4.71                       |                          | 411.36                     |
      | 19        | 20190120  | 50.00                 |                     | 8143.32         |               | 4.68                       |                          | 406.68                     |
      | 20        | 20190121  | 50.00                 |                     | 8097.97         |               | 4.65                       |                          | 402.03                     |
      | 21        | 20190122  | 50.00                 |                     | 8052.60         |               | 4.63                       |                          | 397.40                     |
      | 22        | 20190123  | 50.00                 |                     | 8007.20         |               | 4.60                       |                          | 392.80                     |
      | 23        | 20190124  | 50.00                 |                     | 7961.78         |               | 4.58                       |                          | 388.22                     |
      | 24        | 20190125  | 50.00                 |                     | 7916.33         |               | 4.55                       |                          | 383.67                     |
      | 25        | 20190126  | 50.00                 |                     | 7870.85         |               | 4.52                       |                          | 379.15                     |
      | 26        | 20190127  | 50.00                 |                     | 7825.35         |               | 4.50                       |                          | 374.65                     |
      | 27        | 20190128  | 50.00                 |                     | 7779.82         |               | 4.47                       |                          | 370.18                     |
      | 28        | 20190129  | 50.00                 |                     | 7734.27         |               | 4.45                       |                          | 365.73                     |
      | 29        | 20190130  | 50.00                 |                     | 7688.69         |               | 4.42                       |                          | 361.31                     |
      | 30        | 20190131  | 50.00                 |                     | 7643.08         |               | 4.39                       |                          | 356.92                     |
      | 31        | 20190201 | 50.00                 |                     | 7597.45         |               | 4.37                       |                          | 352.55                     |
      | 32        | 20190202 | 50.00                 |                     | 7551.79         |               | 4.34                       |                          | 348.21                     |
      | 33        | 20190203 | 50.00                 |                     | 7506.11         |               | 4.32                       |                          | 343.89                     |
      | 34        | 20190204 | 50.00                 |                     | 7460.40         |               | 4.29                       |                          | 339.60                     |
      | 35        | 20190205 | 50.00                 |                     | 7414.66         |               | 4.26                       |                          | 335.34                     |
      | 36        | 20190206 | 50.00                 |                     | 7368.90         |               | 4.24                       |                          | 331.10                     |
      | 37        | 20190207 | 50.00                 |                     | 7323.11         |               | 4.21                       |                          | 326.89                     |
      | 38        | 20190208 | 50.00                 |                     | 7277.29         |               | 4.18                       |                          | 322.71                     |
      | 39        | 20190209 | 50.00                 |                     | 7231.45         |               | 4.16                       |                          | 318.55                     |
      | 40        | 20190210 | 50.00                 |                     | 7185.58         |               | 4.13                       |                          | 314.42                     |
      | 41        | 20190211 | 50.00                 |                     | 7139.69         |               | 4.11                       |                          | 310.31                     |
      | 42        | 20190212 | 50.00                 |                     | 7093.77         |               | 4.08                       |                          | 306.23                     |
      | 43        | 20190213 | 50.00                 |                     | 7047.82         |               | 4.05                       |                          | 302.18                     |
      | 44        | 20190214 | 50.00                 |                     | 7001.85         |               | 4.03                       |                          | 298.15                     |
      | 45        | 20190215 | 50.00                 |                     | 6955.85         |               | 4.00                       |                          | 294.15                     |
      | 46        | 20190216 | 50.00                 |                     | 6909.83         |               | 3.97                       |                          | 290.18                     |
      | 47        | 20190217 | 50.00                 |                     | 6863.78         |               | 3.95                       |                          | 286.23                     |
      | 48        | 20190218 | 50.00                 |                     | 6817.70         |               | 3.92                       |                          | 282.31                     |
      | 49        | 20190219 | 50.00                 |                     | 6771.59         |               | 3.90                       |                          | 278.41                     |
      | 50        | 20190220 | 50.00                 |                     | 6725.46         |               | 3.87                       |                          | 274.54                     |
      | 51        | 20190221 | 50.00                 |                     | 6679.31         |               | 3.84                       |                          | 270.70                     |
      | 52        | 20190222 | 50.00                 |                     | 6633.12         |               | 3.82                       |                          | 266.88                     |
      | 53        | 20190223 | 50.00                 |                     | 6586.91         |               | 3.79                       |                          | 263.09                     |
      | 54        | 20190224 | 50.00                 |                     | 6540.68         |               | 3.76                       |                          | 259.33                     |
      | 55        | 20190225 | 50.00                 |                     | 6494.42         |               | 3.74                       |                          | 255.59                     |
      | 56        | 20190226 | 50.00                 |                     | 6448.13         |               | 3.71                       |                          | 251.88                     |
      | 57        | 20190227 | 50.00                 |                     | 6401.81         |               | 3.68                       |                          | 248.20                     |
      | 58        | 20190228 | 50.00                 |                     | 6355.47         |               | 3.66                       |                          | 244.54                     |
      | 59        | 20190301    | 50.00                 |                     | 6309.10         |               | 3.63                       |                          | 240.91                     |
      | 60        | 20190302    | 50.00                 |                     | 6262.71         |               | 3.61                       |                          | 237.30                     |
      | 61        | 20190303    | 50.00                 |                     | 6216.29         |               | 3.58                       |                          | 233.72                     |
      | 62        | 20190304    | 50.00                 |                     | 6169.84         |               | 3.55                       |                          | 230.17                     |
      | 63        | 20190305    | 50.00                 |                     | 6123.36         |               | 3.53                       |                          | 226.64                     |
      | 64        | 20190306    | 50.00                 |                     | 6076.86         |               | 3.50                       |                          | 223.14                     |
      | 65        | 20190307    | 50.00                 |                     | 6030.34         |               | 3.47                       |                          | 219.67                     |
      | 66        | 20190308    | 50.00                 |                     | 5983.78         |               | 3.45                       |                          | 216.22                     |
      | 67        | 20190309    | 50.00                 |                     | 5937.20         |               | 3.42                       |                          | 212.80                     |
      | 68        | 20190310    | 50.00                 |                     | 5890.59         |               | 3.39                       |                          | 209.41                     |
      | 69        | 20190311    | 50.00                 |                     | 5843.96         |               | 3.37                       |                          | 206.04                     |
      | 70        | 20190312    | 50.00                 |                     | 5797.30         |               | 3.34                       |                          | 202.70                     |
      | 71        | 20190313    | 50.00                 |                     | 5750.61         |               | 3.31                       |                          | 199.39                     |
      | 72        | 20190314    | 50.00                 |                     | 5703.90         |               | 3.29                       |                          | 196.10                     |
      | 73        | 20190315    | 50.00                 |                     | 5657.16         |               | 3.26                       |                          | 192.84                     |
      | 74        | 20190316    | 50.00                 |                     | 5610.39         |               | 3.23                       |                          | 189.61                     |
      | 75        | 20190317    | 50.00                 |                     | 5563.60         |               | 3.21                       |                          | 186.40                     |
      | 76        | 20190318    | 50.00                 |                     | 5516.78         |               | 3.18                       |                          | 183.22                     |
      | 77        | 20190319    | 50.00                 |                     | 5469.93         |               | 3.15                       |                          | 180.07                     |
      | 78        | 20190320    | 50.00                 |                     | 5423.06         |               | 3.13                       |                          | 176.94                     |
      | 79        | 20190321    | 50.00                 |                     | 5376.15         |               | 3.10                       |                          | 173.84                     |
      | 80        | 20190322    | 50.00                 |                     | 5329.23         |               | 3.07                       |                          | 170.77                     |
      | 81        | 20190323    | 50.00                 |                     | 5282.27         |               | 3.05                       |                          | 167.72                     |
      | 82        | 20190324    | 50.00                 |                     | 5235.29         |               | 3.02                       |                          | 164.70                     |
      | 83        | 20190325    | 50.00                 |                     | 5188.28         |               | 2.99                       |                          | 161.71                     |
      | 84        | 20190326    | 50.00                 |                     | 5141.25         |               | 2.96                       |                          | 158.75                     |
      | 85        | 20190327    | 50.00                 |                     | 5094.18         |               | 2.94                       |                          | 155.81                     |
      | 86        | 20190328    | 50.00                 |                     | 5047.10         |               | 2.91                       |                          | 152.90                     |
      | 87        | 20190329    | 50.00                 |                     | 4999.98         |               | 2.88                       |                          | 150.02                     |
      | 88        | 20190330    | 50.00                 |                     | 4952.84         |               | 2.86                       |                          | 147.16                     |
      | 89        | 20190331    | 50.00                 |                     | 4905.67         |               | 2.83                       |                          | 144.33                     |
      | 90        | 20190401    | 50.00                 |                     | 4858.47         |               | 2.80                       |                          | 141.53                     |
      | 91        | 20190402    | 50.00                 |                     | 4811.25         |               | 2.78                       |                          | 138.75                     |
      | 92        | 20190403    | 50.00                 |                     | 4764.00         |               | 2.75                       |                          | 136.00                     |
      | 93        | 20190404    | 50.00                 |                     | 4716.72         |               | 2.72                       |                          | 133.28                     |
      | 94        | 20190405    | 50.00                 |                     | 4669.41         |               | 2.70                       |                          | 130.58                     |
      | 95        | 20190406    | 50.00                 |                     | 4622.08         |               | 2.67                       |                          | 127.91                     |
      | 96        | 20190407    | 50.00                 |                     | 4574.72         |               | 2.64                       |                          | 125.27                     |
      | 97        | 20190408    | 50.00                 |                     | 4527.34         |               | 2.61                       |                          | 122.66                     |
      | 98        | 20190409    | 50.00                 |                     | 4479.93         |               | 2.59                       |                          | 120.07                     |
      | 99        | 20190410    | 50.00                 |                     | 4432.49         |               | 2.56                       |                          | 117.51                     |
      | 100       | 20190411    | 50.00                 |                     | 4385.02         |               | 2.53                       |                          | 114.98                     |
      | 101       | 20190412    | 50.00                 |                     | 4337.52         |               | 2.51                       |                          | 112.47                     |
      | 102       | 20190413    | 50.00                 |                     | 4290.00         |               | 2.48                       |                          | 109.99                     |
      | 103       | 20190414    | 50.00                 |                     | 4242.45         |               | 2.45                       |                          | 107.54                     |
      | 104       | 20190415    | 50.00                 |                     | 4194.88         |               | 2.42                       |                          | 105.12                     |
      | 105       | 20190416    | 50.00                 |                     | 4147.28         |               | 2.40                       |                          | 102.72                     |
      | 106       | 20190417    | 50.00                 |                     | 4099.65         |               | 2.37                       |                          | 100.35                     |
      | 107       | 20190418    | 50.00                 |                     | 4051.99         |               | 2.34                       |                          | 98.01                      |
      | 108       | 20190419    | 50.00                 |                     | 4004.30         |               | 2.32                       |                          | 95.69                      |
      | 109       | 20190420    | 50.00                 |                     | 3956.59         |               | 2.29                       |                          | 93.40                      |
      | 110       | 20190421    | 50.00                 |                     | 3908.85         |               | 2.26                       |                          | 91.14                      |
      | 111       | 20190422    | 50.00                 |                     | 3861.09         |               | 2.23                       |                          | 88.91                      |
      | 112       | 20190423    | 50.00                 |                     | 3813.29         |               | 2.21                       |                          | 86.70                      |
      | 113       | 20190424    | 50.00                 |                     | 3765.47         |               | 2.18                       |                          | 84.52                      |
      | 114       | 20190425    | 50.00                 |                     | 3717.62         |               | 2.15                       |                          | 82.37                      |
      | 115       | 20190426    | 50.00                 |                     | 3669.75         |               | 2.12                       |                          | 80.25                      |
      | 116       | 20190427    | 50.00                 |                     | 3621.85         |               | 2.10                       |                          | 78.15                      |
      | 117       | 20190428    | 50.00                 |                     | 3573.92         |               | 2.07                       |                          | 76.08                      |
      | 118       | 20190429    | 50.00                 |                     | 3525.96         |               | 2.04                       |                          | 74.04                      |
      | 119       | 20190430    | 50.00                 |                     | 3477.97         |               | 2.01                       |                          | 72.03                      |
      | 120       | 20190501      | 50.00                 |                     | 3429.96         |               | 1.99                       |                          | 70.04                      |
      | 121       | 20190502      | 50.00                 |                     | 3381.92         |               | 1.96                       |                          | 68.08                      |
      | 122       | 20190503      | 50.00                 |                     | 3333.85         |               | 1.93                       |                          | 66.15                      |
      | 123       | 20190504      | 50.00                 |                     | 3285.76         |               | 1.91                       |                          | 64.24                      |
      | 124       | 20190505      | 50.00                 |                     | 3237.64         |               | 1.88                       |                          | 62.36                      |
      | 125       | 20190506      | 50.00                 |                     | 3189.49         |               | 1.85                       |                          | 60.51                      |
      | 126       | 20190507      | 50.00                 |                     | 3141.31         |               | 1.82                       |                          | 58.69                      |
      | 127       | 20190508      | 50.00                 |                     | 3093.10         |               | 1.80                       |                          | 56.89                      |
      | 128       | 20190509      | 50.00                 |                     | 3044.87         |               | 1.77                       |                          | 55.12                      |
      | 129       | 20190510      | 50.00                 |                     | 2996.61         |               | 1.74                       |                          | 53.38                      |
      | 130       | 20190511      | 50.00                 |                     | 2948.32         |               | 1.71                       |                          | 51.67                      |
      | 131       | 20190512      | 50.00                 |                     | 2900.01         |               | 1.68                       |                          | 49.99                      |
      | 132       | 20190513      | 50.00                 |                     | 2851.67         |               | 1.66                       |                          | 48.33                      |
      | 133       | 20190514      | 50.00                 |                     | 2803.30         |               | 1.63                       |                          | 46.70                      |
      | 134       | 20190515      | 50.00                 |                     | 2754.90         |               | 1.60                       |                          | 45.10                      |
      | 135       | 20190516      | 50.00                 |                     | 2706.47         |               | 1.57                       |                          | 43.53                      |
      | 136       | 20190517      | 50.00                 |                     | 2658.02         |               | 1.55                       |                          | 41.98                      |
      | 137       | 20190518      | 50.00                 |                     | 2609.54         |               | 1.52                       |                          | 40.46                      |
      | 138       | 20190519      | 50.00                 |                     | 2561.03         |               | 1.49                       |                          | 38.97                      |
      | 139       | 20190520      | 50.00                 |                     | 2512.49         |               | 1.46                       |                          | 37.51                      |
      | 140       | 20190521      | 50.00                 |                     | 2463.93         |               | 1.44                       |                          | 36.07                      |
      | 141       | 20190522      | 50.00                 |                     | 2415.34         |               | 1.41                       |                          | 34.66                      |
      | 142       | 20190523      | 50.00                 |                     | 2366.72         |               | 1.38                       |                          | 33.28                      |
      | 143       | 20190524      | 50.00                 |                     | 2318.07         |               | 1.35                       |                          | 31.93                      |
      | 144       | 20190525      | 50.00                 |                     | 2269.39         |               | 1.32                       |                          | 30.61                      |
      | 145       | 20190526      | 50.00                 |                     | 2220.69         |               | 1.30                       |                          | 29.31                      |
      | 146       | 20190527      | 50.00                 |                     | 2171.96         |               | 1.27                       |                          | 28.04                      |
      | 147       | 20190528      | 50.00                 |                     | 2123.20         |               | 1.24                       |                          | 26.80                      |
      | 148       | 20190529      | 50.00                 |                     | 2074.41         |               | 1.21                       |                          | 25.59                      |
      | 149       | 20190530      | 50.00                 |                     | 2025.60         |               | 1.19                       |                          | 24.40                      |
      | 150       | 20190531      | 50.00                 |                     | 1976.76         |               | 1.16                       |                          | 23.24                      |
      | 151       | 20190601     | 50.00                 |                     | 1927.89         |               | 1.13                       |                          | 22.11                      |
      | 152       | 20190602     | 50.00                 |                     | 1878.99         |               | 1.10                       |                          | 21.01                      |
      | 153       | 20190603     | 50.00                 |                     | 1830.06         |               | 1.07                       |                          | 19.94                      |
      | 154       | 20190604     | 50.00                 |                     | 1781.11         |               | 1.05                       |                          | 18.89                      |
      | 155       | 20190605     | 50.00                 |                     | 1732.13         |               | 1.02                       |                          | 17.87                      |
      | 156       | 20190606     | 50.00                 |                     | 1683.12         |               | 0.99                       |                          | 16.88                      |
      | 157       | 20190607     | 50.00                 |                     | 1634.08         |               | 0.96                       |                          | 15.92                      |
      | 158       | 20190608     | 50.00                 |                     | 1585.01         |               | 0.93                       |                          | 14.99                      |
      | 159       | 20190609     | 50.00                 |                     | 1535.92         |               | 0.91                       |                          | 14.08                      |
      | 160       | 20190610     | 50.00                 |                     | 1486.79         |               | 0.88                       |                          | 13.20                      |
      | 161       | 20190611     | 50.00                 |                     | 1437.64         |               | 0.85                       |                          | 12.35                      |
      | 162       | 20190612     | 50.00                 |                     | 1388.47         |               | 0.82                       |                          | 11.53                      |
      | 163       | 20190613     | 50.00                 |                     | 1339.26         |               | 0.79                       |                          | 10.74                      |
      | 164       | 20190614     | 50.00                 |                     | 1290.02         |               | 0.77                       |                          | 9.97                       |
      | 165       | 20190615     | 50.00                 |                     | 1240.76         |               | 0.74                       |                          | 9.23                       |
      | 166       | 20190616     | 50.00                 |                     | 1191.47         |               | 0.71                       |                          | 8.52                       |
      | 167       | 20190617     | 50.00                 |                     | 1142.15         |               | 0.68                       |                          | 7.84                       |
      | 168       | 20190618     | 50.00                 |                     | 1092.80         |               | 0.65                       |                          | 7.19                       |
      | 169       | 20190619     | 50.00                 |                     | 1043.43         |               | 0.62                       |                          | 6.57                       |
      | 170       | 20190620     | 50.00                 |                     | 994.02          |               | 0.60                       |                          | 5.97                       |
      | 171       | 20190621     | 50.00                 |                     | 944.59          |               | 0.57                       |                          | 5.40                       |
      | 172       | 20190622     | 50.00                 |                     | 895.13          |               | 0.54                       |                          | 4.86                       |
      | 173       | 20190623     | 50.00                 |                     | 845.64          |               | 0.51                       |                          | 4.35                       |
      | 174       | 20190624     | 50.00                 |                     | 796.13          |               | 0.48                       |                          | 3.87                       |
      | 175       | 20190625     | 50.00                 |                     | 746.58          |               | 0.45                       |                          | 3.42                       |
      | 176       | 20190626     | 50.00                 |                     | 697.01          |               | 0.43                       |                          | 2.99                       |
      | 177       | 20190627     | 50.00                 |                     | 647.41          |               | 0.40                       |                          | 2.59                       |
      | 178       | 20190628     | 50.00                 |                     | 597.78          |               | 0.37                       |                          | 2.22                       |
      | 179       | 20190629     | 50.00                 |                     | 548.12          |               | 0.34                       |                          | 1.88                       |
      | 180       | 20190630     | 50.00                 |                     | 498.43          |               | 0.31                       |                          | 1.57                       |
      | 181       | 20190701     | 50.00                 |                     | 448.72          |               | 0.28                       |                          | 1.29                       |
      | 182       | 20190702     | 50.00                 |                     | 398.97          |               | 0.26                       |                          | 1.03                       |
      | 183       | 20190703     | 50.00                 |                     | 349.20          |               | 0.23                       |                          | 0.80                       |
      | 184       | 20190704     | 50.00                 |                     | 299.40          |               | 0.20                       |                          | 0.60                       |
      | 185       | 20190705     | 50.00                 |                     | 249.57          |               | 0.17                       |                          | 0.43                       |
      | 186       | 20190706     | 50.00                 |                     | 199.71          |               | 0.14                       |                          | 0.29                       |
      | 187       | 20190707     | 50.00                 |                     | 149.83          |               | 0.11                       |                          | 0.18                       |
      | 188       | 20190708     | 50.00                 |                     | 99.91           |               | 0.09                       |                          | 0.09                       |
      | 189       | 20190709     | 50.00                 |                     | 49.97           |               | 0.06                       |                          | 0.03                       |
      | 190       | 20190710     | 50.00                 |                     | 0.00            |               | 0.03                       |                          | 0.00                       |
      | 191       | 20190711     | 50.00                 |                     | 0.00            |               | 0.00                       |                          | 0.00                       |
      | 192       | 20190712     | 50.00                 |                     | 0.00            |               | 0.00                       |                          | 0.00                       |
      | 193       | 20190713     | 50.00                 |                     | 0.00            |               | 0.00                       |                          | 0.00                       |
