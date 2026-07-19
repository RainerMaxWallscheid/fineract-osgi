@WorkingCapital
@WorkingCapitalCBRAccountingEntries
Feature: Working Capital Loan Credit Balance Refund Accounting Entries

  @TestRailId:C85182
  Scenario: Verify CBR GL entries - UC01: partial refund keeps OVERPAID
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct         | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | WCLP_ACC_DEF_REV_AM | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    When Admin sets the business date to "20260102"
    And Customer makes repayment on "20260102" with 9100.0 transaction amount on Working Capital loan
    Then Working Capital loan status will be "OVERPAID"
    When Admin sets the business date to "20260103"
    And Customer makes credit balance refund on "20260103" with 50.0 transaction amount on Working Capital loan
    Then Working Capital loan status will be "OVERPAID"
    And Working Capital Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20260103" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | LIABILITY | 245000       | Other Credit Liability    | 50.0  |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 50.0   |

  @TestRailId:C85183
  Scenario: Verify CBR GL entries - UC02: full refund closes loan
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct         | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | WCLP_ACC_DEF_REV_AM | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    When Admin sets the business date to "20260102"
    And Customer makes repayment on "20260102" with 9050.0 transaction amount on Working Capital loan
    Then Working Capital loan status will be "OVERPAID"
    When Admin sets the business date to "20260103"
    And Customer makes credit balance refund on "20260103" with 50.0 transaction amount on Working Capital loan
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"
    And Working Capital Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20260103" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | LIABILITY | 245000       | Other Credit Liability    | 50.0  |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 50.0   |

  @TestRailId:C85184
  Scenario: Verify CBR GL entries - UC03: multiple refunds same day
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct         | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | WCLP_ACC_DEF_REV_AM | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    When Admin sets the business date to "20260102"
    And Customer makes repayment on "20260102" with 9200.0 transaction amount on Working Capital loan
    Then Working Capital loan status will be "OVERPAID"
    When Admin sets the business date to "20260103"
    And Customer makes credit balance refund on "20260103" with 40.0 transaction amount on Working Capital loan
    And Customer makes credit balance refund on "20260103" with 60.0 transaction amount on Working Capital loan
    Then Working Capital loan status will be "OVERPAID"
    And Working Capital Loan Transactions tab has 2 "CREDIT_BALANCE_REFUND" transactions with date "20260103" which have the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | LIABILITY | 245000       | Other Credit Liability    | 40.0  |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 40.0   |
      | LIABILITY | 245000       | Other Credit Liability    | 60.0  |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 60.0   |

  @TestRailId:C85185
  Scenario: Verify CBR GL entries - UC04: refund with payment details
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct         | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | WCLP_ACC_DEF_REV_AM | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    When Admin sets the business date to "20260102"
    And Customer makes repayment on "20260102" with 9100.0 transaction amount on Working Capital loan
    Then Working Capital loan status will be "OVERPAID"
    When Admin sets the business date to "20260103"
    And Customer makes credit balance refund on "20260103" with 25.0 transaction amount on Working Capital loan with the following payment details:
      | paymentType   | accountNumber | checkNumber | routingCode | receiptNumber | bankNumber |
      | CHECK_PAYMENT | 12345         | 321         | 456         | 789           | 654        |
    Then Working Capital loan status will be "OVERPAID"
    And Working Capital Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20260103" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | LIABILITY | 245000       | Other Credit Liability    | 25.0  |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 25.0   |

  @TestRailId:C85186
  Scenario: Verify CBR GL entries - UC05: multiple refunds on different days
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a working capital loan with the following data:
      | LoanProduct         | submittedOnDate | expectedDisbursementDate | principalAmount | totalPaymentVolume | periodPaymentRate | discount |
      | WCLP_ACC_DEF_REV_AM | 20260101 | 20260101          | 9000            | 100000             | 18                | 0        |
    And Admin successfully approves the working capital loan on "20260101" with "9000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the Working Capital loan on "20260101" with "9000" EUR transaction amount
    When Admin sets the business date to "20260102"
    And Customer makes repayment on "20260102" with 9200.0 transaction amount on Working Capital loan
    Then Working Capital loan status will be "OVERPAID"
    And Working Capital loan balance overpaymentAmount is "200.00"
    When Admin sets the business date to "20260103"
    And Customer makes credit balance refund on "20260103" with 50.0 transaction amount on Working Capital loan
    Then Working Capital loan status will be "OVERPAID"
    And Working Capital loan balance overpaymentAmount is "150.00"
    And Working Capital Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20260103" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | LIABILITY | 245000       | Other Credit Liability    | 50.0  |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 50.0   |
    When Admin sets the business date to "20260104"
    And Customer makes credit balance refund on "20260104" with 75.0 transaction amount on Working Capital loan
    Then Working Capital loan status will be "OVERPAID"
    And Working Capital loan balance overpaymentAmount is "75.00"
    And Working Capital Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20260104" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | LIABILITY | 245000       | Other Credit Liability    | 75.0  |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 75.0   |
    When Admin sets the business date to "20260105"
    And Customer makes credit balance refund on "20260105" with 75.0 transaction amount on Working Capital loan
    Then Working Capital loan status will be "CLOSED_OBLIGATIONS_MET"
    And Working Capital Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20260105" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | LIABILITY | 245000       | Other Credit Liability    | 75.0  |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 75.0   |
