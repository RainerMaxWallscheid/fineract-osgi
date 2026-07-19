@ChargeOffFeature
Feature: Charge-off - Part1

  @TestRailId:C2565
  Scenario: As a user I want to do a Charge-off for non-fraud loan after disbursement
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230222"
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name         | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable     |        | 1000.0 |
      | EXPENSE | 744007       | Credit Loss/Bad Debt | 1000.0 |        |

  @TestRailId:C2566
  Scenario: As a user I want to do a Charge-off for non-fraud loan after repayment
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230105"
    And Customer makes "AUTOPAY" repayment on "20230105" with 250 EUR transaction amount
    When Admin sets the business date to "20230222"
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230105" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name         | Debit | Credit |
      | ASSET   | 112601       | Loans Receivable     |       | 750.0  |
      | EXPENSE | 744007       | Credit Loss/Bad Debt | 750.0 |        |

  @TestRailId:C2567
  Scenario: As a user I want to do a Repayment undo after Charge-off for non-fraud
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230105"
    And Customer makes "AUTOPAY" repayment on "20230105" with 250 EUR transaction amount
    When Admin sets the business date to "20230222"
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    When Customer undo "1"th repayment on "20230105"
    Then Loan status will be "ACTIVE"
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230105" is reverted
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230105" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 250.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 250.0  |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name         | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable     |        | 1000.0 |
      | EXPENSE | 744007       | Credit Loss/Bad Debt | 1000.0 |        |

  @TestRailId:C2568
  Scenario: As a user I want to do Charge-off for fraud loan when FEE is added
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    And Admin adds an NSF fee because of payment bounce with "20230101" transaction date
    When Admin sets the business date to "20230222"
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name            | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable        |        | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable |        | 10.0   |
      | EXPENSE | 744007       | Credit Loss/Bad Debt    | 1000.0 |        |
      | INCOME  | 404008       | Fee Charge Off          | 10.0   |        |

  @TestRailId:C2569
  Scenario: As a user I want to do a Merchant Refund after charge-off (fee portion)
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    And Admin adds an NSF fee because of payment bounce with "20230101" transaction date
    When Admin sets the business date to "20230222"
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    When Admin makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230222" with 100 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name            | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable        |        | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable |        | 10.0   |
      | EXPENSE | 744007       | Credit Loss/Bad Debt    | 1000.0 |        |
      | INCOME  | 404008       | Fee Charge Off          | 10.0   |        |
    Then Loan Transactions tab has a "MERCHANT_ISSUED_REFUND" transaction with date "20230222" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt      |       | 90.0   |
      | INCOME    | 404008       | Fee Charge Off            |       | 10.0   |
      | LIABILITY | 145023       | Suspense/Clearing account | 100.0 |        |

  @TestRailId:C2570
  Scenario: As a user I want to do a Charge-off for non-fraud loan when FEE and PENALTY added
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    And Admin adds an NSF fee because of payment bounce with "20230101" transaction date
    When Admin sets the business date to "20230222"
    And Admin adds a 10 % Processing charge to the loan with "en" locale on date: "20230222"
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name            | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable        |        | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable |        | 110.0  |
      | EXPENSE | 744007       | Credit Loss/Bad Debt    | 1000.0 |        |
      | INCOME  | 404008       | Fee Charge Off          | 110.0  |        |

  @TestRailId:C2571 @chargeoffOnLoanWithInterest
  Scenario: As a user I want to do Charge-off for non-fraud loan when FEE and PENALTY added (interest portion)
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_FLAT | 20230101    | 1000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    And Admin adds an NSF fee because of payment bounce with "20230101" transaction date
    When Admin sets the business date to "20230222"
    And Admin adds a 10 % Processing charge to the loan with "en" locale on date: "20230222"
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable           |        | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable    |        | 143.0  |
      | EXPENSE | 744007       | Credit Loss/Bad Debt       | 1000.0 |        |
      | INCOME  | 404001       | Interest Income Charge Off | 30.0   |        |
      | INCOME  | 404008       | Fee Charge Off             | 113.0  |        |

  @TestRailId:C2572 @chargeoffOnLoanWithInterest
  Scenario: As a user I want to do a Merchant Refund after charge-off for non fraud loan (interest portion)
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_FLAT | 20230101    | 1000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    And Admin adds an NSF fee because of payment bounce with "20230101" transaction date
    When Admin sets the business date to "20230222"
    And Admin adds a 10 % Processing charge to the loan with "en" locale on date: "20230222"
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    When Admin makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230222" with 500 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable           |        | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable    |        | 143.0  |
      | EXPENSE | 744007       | Credit Loss/Bad Debt       | 1000.0 |        |
      | INCOME  | 404001       | Interest Income Charge Off | 30.0   |        |
      | INCOME  | 404008       | Fee Charge Off             | 113.0  |        |
    Then Loan Transactions tab has a "MERCHANT_ISSUED_REFUND" transaction with date "20230222" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit | Credit |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt       |       | 367.0  |
      | INCOME    | 404001       | Interest Income Charge Off |       | 20.0   |
      | INCOME    | 404008       | Fee Charge Off             |       | 113.0  |
      | LIABILITY | 145023       | Suspense/Clearing account  | 500.0 |        |

  @TestRailId:C2573 @chargeoffOnLoanWithInterest
  Scenario: As a user I want to do a Payout refund after charge-off for non fraud loan (interest portion)
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_FLAT | 20230101    | 1000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    And Admin adds an NSF fee because of payment bounce with "20230101" transaction date
    When Admin sets the business date to "20230222"
    And Admin adds a 10 % Processing charge to the loan with "en" locale on date: "20230222"
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    When Admin makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20230222" with 500 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable           |        | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable    |        | 143.0  |
      | EXPENSE | 744007       | Credit Loss/Bad Debt       | 1000.0 |        |
      | INCOME  | 404001       | Interest Income Charge Off | 30.0   |        |
      | INCOME  | 404008       | Fee Charge Off             | 113.0  |        |
    Then Loan Transactions tab has a "PAYOUT_REFUND" transaction with date "20230222" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit | Credit |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt       |       | 367.0  |
      | INCOME    | 404001       | Interest Income Charge Off |       | 20.0   |
      | INCOME    | 404008       | Fee Charge Off             |       | 113.0  |
      | LIABILITY | 145023       | Suspense/Clearing account  | 500.0 |        |

  @TestRailId:C2574 @chargeoffOnLoanWithInterest
  Scenario:  As a user I want to do a Repayment after Charge-off for fraud loan when FEE and PENALTY added (product with interest)
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_FLAT | 20230101    | 1000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    And Admin adds an NSF fee because of payment bounce with "20230101" transaction date
    When Admin sets the business date to "20230222"
    And Admin adds a 10 % Processing charge to the loan with "en" locale on date: "20230222"
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230222" with 500 EUR transaction amount and system-generated Idempotency key
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable           |        | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable    |        | 143.0  |
      | EXPENSE | 744007       | Credit Loss/Bad Debt       | 1000.0 |        |
      | INCOME  | 404001       | Interest Income Charge Off | 30.0   |        |
      | INCOME  | 404008       | Fee Charge Off             | 113.0  |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230222" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | INCOME    | 744008       | Recoveries                |       | 500.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 500.0 |        |

  @TestRailId:C2575
  Scenario: As a user I want to do a Charge-off for fraud loan after disbursement
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230222"
    Then Admin can successfully set Fraud flag to the loan
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable           |        | 1000.0 |
      | EXPENSE | 744037       | Credit Loss/Bad Debt-Fraud | 1000.0 |        |

  @TestRailId:C2576
  Scenario: As a user I want to do a Repayment undo after Charge-off for fraud loan
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230105"
    And Customer makes "AUTOPAY" repayment on "20230105" with 250 EUR transaction amount
    When Admin sets the business date to "20230222"
    Then Admin can successfully set Fraud flag to the loan
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    When Customer undo "1"th repayment on "20230105"
    Then Loan status will be "ACTIVE"
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230105" is reverted
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230105" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 250.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 250.0  |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable           |        | 1000.0 |
      | EXPENSE | 744037       | Credit Loss/Bad Debt-Fraud | 1000.0 |        |

  @TestRailId:C2577
  Scenario: As a user I want to do a Charge-off for fraud loan when FEE is added
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    And Admin adds an NSF fee because of payment bounce with "20230101" transaction date
    When Admin sets the business date to "20230222"
    Then Admin can successfully set Fraud flag to the loan
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable           |        | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable    |        | 10.0   |
      | EXPENSE | 744037       | Credit Loss/Bad Debt-Fraud | 1000.0 |        |
      | INCOME  | 404008       | Fee Charge Off             | 10.0   |        |

  @TestRailId:C2578
  Scenario: As a user I want to do a Charge-off for fraud loan when FEE and PENALTY added
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    And Admin adds an NSF fee because of payment bounce with "20230101" transaction date
    When Admin sets the business date to "20230222"
    And Admin adds a 10 % Processing charge to the loan with "en" locale on date: "20230222"
    Then Admin can successfully set Fraud flag to the loan
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable           |        | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable    |        | 110.0  |
      | EXPENSE | 744037       | Credit Loss/Bad Debt-Fraud | 1000.0 |        |
      | INCOME  | 404008       | Fee Charge Off             | 110.0  |        |

  @TestRailId:C2579 @chargeoffOnLoanWithInterest
  Scenario: As a user I want to do a Charge-off for fraud loan when FEE and PENALTY added (interest portion)
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_FLAT | 20230101    | 1000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    And Admin adds an NSF fee because of payment bounce with "20230101" transaction date
    When Admin sets the business date to "20230222"
    And Admin adds a 10 % Processing charge to the loan with "en" locale on date: "20230222"
    Then Admin can successfully set Fraud flag to the loan
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable           |        | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable    |        | 143.0  |
      | EXPENSE | 744037       | Credit Loss/Bad Debt-Fraud | 1000.0 |        |
      | INCOME  | 404001       | Interest Income Charge Off | 30.0   |        |
      | INCOME  | 404008       | Fee Charge Off             | 113.0  |        |

  @TestRailId:C2580 @chargeoffOnLoanWithInterest
  Scenario: As a user I want to do a Merchant issue refund for fraud loan when FEE and PENALTY added (interest portion)
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_FLAT | 20230101    | 1000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    And Admin adds an NSF fee because of payment bounce with "20230101" transaction date
    When Admin sets the business date to "20230222"
    And Admin adds a 10 % Processing charge to the loan with "en" locale on date: "20230222"
    Then Admin can successfully set Fraud flag to the loan
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    When Admin makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230222" with 500 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable           |        | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable    |        | 143.0  |
      | EXPENSE | 744037       | Credit Loss/Bad Debt-Fraud | 1000.0 |        |
      | INCOME  | 404001       | Interest Income Charge Off | 30.0   |        |
      | INCOME  | 404008       | Fee Charge Off             | 113.0  |        |
    Then Loan Transactions tab has a "MERCHANT_ISSUED_REFUND" transaction with date "20230222" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit | Credit |
      | EXPENSE   | 744037       | Credit Loss/Bad Debt-Fraud |       | 367.0  |
      | INCOME    | 404001       | Interest Income Charge Off |       | 20.0   |
      | INCOME    | 404008       | Fee Charge Off             |       | 113.0  |
      | LIABILITY | 145023       | Suspense/Clearing account  | 500.0 |        |

  @TestRailId:C2581 @chargeoffOnLoanWithInterest
  Scenario: As a user I want to do Payout refund for fraud loan when FEE and PENALTY added (interest portion)
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_FLAT | 20230101    | 1000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    And Admin adds an NSF fee because of payment bounce with "20230101" transaction date
    When Admin sets the business date to "20230222"
    And Admin adds a 10 % Processing charge to the loan with "en" locale on date: "20230222"
    Then Admin can successfully set Fraud flag to the loan
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    When Customer makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20230222" with 500 EUR transaction amount and system-generated Idempotency key
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable           |        | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable    |        | 143.0  |
      | EXPENSE | 744037       | Credit Loss/Bad Debt-Fraud | 1000.0 |        |
      | INCOME  | 404001       | Interest Income Charge Off | 30.0   |        |
      | INCOME  | 404008       | Fee Charge Off             | 113.0  |        |
    Then Loan Transactions tab has a "PAYOUT_REFUND" transaction with date "20230222" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit | Credit |
      | EXPENSE   | 744037       | Credit Loss/Bad Debt-Fraud |       | 367.0  |
      | INCOME    | 404001       | Interest Income Charge Off |       | 20.0   |
      | INCOME    | 404008       | Fee Charge Off             |       | 113.0  |
      | LIABILITY | 145023       | Suspense/Clearing account  | 500.0 |        |

  @TestRailId:C2582 @chargeoffOnLoanWithInterest
  Scenario: As a user I want to do a Repayment after Charge-off for fraud loan when FEE and PENALTY added
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_FLAT | 20230101    | 1000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    And Admin adds an NSF fee because of payment bounce with "20230101" transaction date
    When Admin sets the business date to "20230222"
    And Admin adds a 10 % Processing charge to the loan with "en" locale on date: "20230222"
    Then Admin can successfully set Fraud flag to the loan
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230222" with 500 EUR transaction amount and system-generated Idempotency key
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable           |        | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable    |        | 143.0  |
      | EXPENSE | 744037       | Credit Loss/Bad Debt-Fraud | 1000.0 |        |
      | INCOME  | 404001       | Interest Income Charge Off | 30.0   |        |
      | INCOME  | 404008       | Fee Charge Off             | 113.0  |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230222" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | INCOME    | 744008       | Recoveries                |       | 500.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 500.0 |        |

  @TestRailId:C2591 @chargeoffOnLoanWithInterest
  Scenario: As a user I want to repay a loan which was charged-off
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_FLAT | 20230101    | 1000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    And Admin adds an NSF fee because of payment bounce with "20230101" transaction date
    When Admin sets the business date to "20230222"
    And Admin adds a 10 % Processing charge to the loan with "en" locale on date: "20230222"
    Then Admin can successfully set Fraud flag to the loan
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230222" with 500 EUR transaction amount and system-generated Idempotency key
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20230223"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230223" with 643 EUR transaction amount and system-generated Idempotency key
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan marked as charged-off on "20230222"
    Then Loan has 0 outstanding amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees  | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101  |                  | 1000.0          |               |          | 0.0   |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20230201 | 20230222 | 667.0           | 333.0         | 10.0     | 0.0   | 10.0      | 353.0 | 353.0 | 0.0        | 353.0 | 0.0         |
      | 2  | 28   | 20230301    | 20230223 | 334.0           | 333.0         | 10.0     | 103.0 | 0.0       | 446.0 | 446.0 | 446.0      | 0.0   | 0.0         |
      | 3  | 31   | 20230401    | 20230223 | 0.0             | 334.0         | 10.0     | 0.0   | 0.0       | 344.0 | 344.0 | 344.0      | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees  | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 1000.0        | 30.0     | 103.0 | 10.0      | 1143.0 | 1143.0 | 790.0      | 353.0 | 0.0         |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable           |        | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable    |        | 143.0  |
      | EXPENSE | 744037       | Credit Loss/Bad Debt-Fraud | 1000.0 |        |
      | INCOME  | 404001       | Interest Income Charge Off | 30.0   |        |
      | INCOME  | 404008       | Fee Charge Off             | 113.0  |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230222" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | INCOME    | 744008       | Recoveries                |       | 500.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 500.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230223" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | INCOME    | 744008       | Recoveries                |       | 643.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 643.0 |        |

  @TestRailId:C2592 @chargeoffOnLoanWithInterest
  Scenario: As a user I want to do a charge-off undo before any other transactions on the loan
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_FLAT | 20230101    | 1000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    And Admin adds an NSF fee because of payment bounce with "20230101" transaction date
    When Admin sets the business date to "20230222"
    And Admin adds a 10 % Processing charge to the loan with "en" locale on date: "20230222"
    Then Admin can successfully set Fraud flag to the loan
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees  | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0   |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20230201 |           | 667.0           | 333.0         | 10.0     | 0.0   | 10.0      | 353.0 | 0.0  | 0.0        | 0.0  | 353.0       |
      | 2  | 28   | 20230301    |           | 334.0           | 333.0         | 10.0     | 103.0 | 0.0       | 446.0 | 0.0  | 0.0        | 0.0  | 446.0       |
      | 3  | 31   | 20230401    |           | 0.0             | 334.0         | 10.0     | 0.0   | 0.0       | 344.0 | 0.0  | 0.0        | 0.0  | 344.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 30       | 103  | 10        | 1143 | 0    | 0          | 0    | 1143        |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable           |        | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable    |        | 143.0  |
      | EXPENSE | 744037       | Credit Loss/Bad Debt-Fraud | 1000.0 |        |
      | INCOME  | 404001       | Interest Income Charge Off | 30.0   |        |
      | INCOME  | 404008       | Fee Charge Off             | 113.0  |        |
    Then Admin does a charge-off undo the loan
    When Admin sets the business date to "20230223"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230223" with 200 EUR transaction amount and system-generated Idempotency key
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable           |        | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable    |        | 143.0  |
      | EXPENSE | 744037       | Credit Loss/Bad Debt-Fraud | 1000.0 |        |
      | INCOME  | 404001       | Interest Income Charge Off | 30.0   |        |
      | INCOME  | 404008       | Fee Charge Off             | 113.0  |        |
      | ASSET   | 112601       | Loans Receivable           | 1000.0 |        |
      | ASSET   | 112603       | Interest/Fee Receivable    | 143.0  |        |
      | EXPENSE | 744037       | Credit Loss/Bad Debt-Fraud |        | 1000.0 |
      | INCOME  | 404001       | Interest Income Charge Off |        | 30.0   |
      | INCOME  | 404008       | Fee Charge Off             |        | 113.0  |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230223" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 180.0  |
      | ASSET     | 112603       | Interest/Fee Receivable   |       | 20.0   |
      | LIABILITY | 145023       | Suspense/Clearing account | 200.0 |        |

  @TestRailId:C2593
  Scenario: As a user I want to do a Charge-off before the last repayment
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230222"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230222" with 200 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20230223"
    Then Charge-off transaction is not possible on "20230221"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |       |             |
      | 1  | 30   | 20230131 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 200.0 | 0.0        | 200.0 | 800.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 200  | 0          | 200  | 800         |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230222" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 200.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 200.0 |        |

  @TestRailId:C2594
  Scenario: As a user I want to do a Charge-off between 2 repayments
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230222"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230222" with 200 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20230224"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230224" with 200 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20230225"
    Then Charge-off transaction is not possible on "20230223"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |       |             |
      | 1  | 30   | 20230131 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 400.0 | 0.0        | 400.0 | 600.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 400  | 0          | 400  | 600         |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230222" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 200.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 200.0 |        |

  @TestRailId:C2595
  Scenario: As a user I want to do a backdated Charge-off when only disbursement transaction happened
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230222"
    And Admin does charge-off the loan on "20230210"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230131 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 0    | 0          | 0    | 1000        |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230210" which has the following Journal entries:
      | Type    | Account code | Account name         | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable     |        | 1000.0 |
      | EXPENSE | 744007       | Credit Loss/Bad Debt | 1000.0 |        |

  @TestRailId:C2596
  Scenario: As a user I want to do an undo on a transaction which was created before the Charge-off
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230222"
    And Customer makes "AUTOPAY" repayment on "20230122" with 250 EUR transaction amount
    When Admin sets the business date to "20230223"
    And Admin does charge-off the loan on "20230223"
    When Customer undo "1"th repayment on "20230122"
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230122" is reverted
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230131 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 0    | 0          | 0    | 1000        |

  @TestRailId:C2597
  Scenario: As a user I want to do an undo on a transaction which was created on the Charge-off day
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230222"
    And Customer makes "AUTOPAY" repayment on "20230122" with 250 EUR transaction amount
    And Admin does charge-off the loan on "20230222"
    When Customer undo "1"th repayment on "20230122"
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230122" is reverted
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230131 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 0    | 0          | 0    | 1000        |

  @TestRailId:C2598
  Scenario: As a user I want to do a second Charge-off
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230222"
    And Admin does charge-off the loan on "20230222"
    Then Second Charge-off is not possible on "20230222"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230131 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 0    | 0          | 0    | 1000        |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name         | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable     |        | 1000.0 |
      | EXPENSE | 744007       | Credit Loss/Bad Debt | 1000.0 |        |

  @TestRailId:C2599
  Scenario: As a user I want to do a second Charge-off undo
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230222"
    And Admin does charge-off the loan on "20230222"
    When Admin does a charge-off undo the loan
    And Charge-off undo is not possible as the loan is not charged-off
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230131 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 0    | 0          | 0    | 1000        |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |

  @TestRailId:C2600
  Scenario: As a user I want to add charge after Charge-off
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230222"
    And Admin does charge-off the loan on "20230222"
    When Admin is not able to add "LOAN_SNOOZE_FEE" due date charge with "20230222" due date and 200 EUR transaction amount because the of charged-off account
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230131 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 0    | 0          | 0    | 1000        |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name         | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable     |        | 1000.0 |
      | EXPENSE | 744007       | Credit Loss/Bad Debt | 1000.0 |        |

  @TestRailId:C2706
  Scenario: Verify that Charge-off NOT results an error anymore when to be applied on a loan with an interest
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_FLAT | 20230101    | 1000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    And Admin adds an NSF fee because of payment bounce with "20230101" transaction date
    When Admin sets the business date to "20230222"
    And Admin adds a 10 % Processing charge to the loan with "en" locale on date: "20230222"
    And Admin does charge-off the loan on "20230222"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees  | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0   |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20230201 |           | 667.0           | 333.0         | 10.0     | 0.0   | 10.0      | 353.0 | 0.0  | 0.0        | 0.0  | 353.0       |
      | 2  | 28   | 20230301    |           | 334.0           | 333.0         | 10.0     | 103.0 | 0.0       | 446.0 | 0.0  | 0.0        | 0.0  | 446.0       |
      | 3  | 31   | 20230401    |           | 0.0             | 334.0         | 10.0     | 0.0   | 0.0       | 344.0 | 0.0  | 0.0        | 0.0  | 344.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 30       | 103  | 10        | 1143 | 0    | 0          | 0    | 1143        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees  | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0   | 0.0       | 1000.0       |
      | 20230222 | Accrual          | 17.5   | 0.0       | 17.5     | 0.0   | 0.0       | 0.0          |
      | 20230222 | Charge-off       | 1143.0 | 1000.0    | 30.0     | 103.0 | 10.0      | 0.0          |

  @TestRailId:C2761
  Scenario: Verify that charge-off is reversed/replayed if Scheduled repayment which was placed on a date before the charge-off is reversed after the charge-off
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230125"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230125" due date and 20 EUR transaction amount
    When Admin sets the business date to "20230301"
    When Customer makes "REPAYMENT" transaction with "SCHEDULED" payment type on "20230301" with 1000 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20230601"
    And Admin does charge-off the loan on "20230601"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20230101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 30   | 20230131 |           | 0.0             | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 1000.0 | 0.0        | 1000.0 | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 0         | 1020 | 1000 | 0          | 1000 | 20          |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230301    | Repayment        | 1000.0 | 980.0     | 0.0      | 20.0 | 0.0       | 20.0         |
      | 20230601     | Charge-off       | 20.0   | 20.0      | 0.0      | 0.0  | 0.0       | 0.0          |
    When Admin sets the business date to "20230605"
    When Customer undo "1"th "Repayment" transaction made on "20230301"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230131 |           | 0.0             | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 0.0  | 0.0        | 0.0  | 1020.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 0         | 1020 | 0    | 0          | 0    | 1020        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230301    | Repayment        | 1000.0 | 980.0     | 0.0      | 20.0 | 0.0       | 20.0         |
      | 20230601     | Charge-off       | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230301" is reverted

  @TestRailId:C3568
  Scenario: Verify that charge-off is reversed/replayed if repayment is reversed after the charge-off with COB process
    When Admin sets the business date to "20250221"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_ACCRUAL_ACTIVITY_POSTING | 20240221  | 500            | 9.99                   | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1             | MONTHS                  | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250121" with "500" amount and expected disbursement date on "20250121"
    And Admin successfully disburse the loan on "20250121" with "500" EUR transaction amount
    When Admin sets the business date to "20250223"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250121  |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250221 |           | 334.71          | 165.29        | 4.16     | 0.0  | 0.0       | 169.45 | 0.0  | 0.0        | 0.0  | 169.45      |
      | 2  | 28   | 20250321    |           | 168.14          | 166.57        | 2.88     | 0.0  | 0.0       | 169.45 | 0.0  | 0.0        | 0.0  | 169.45      |
      | 3  | 31   | 20250421    |           | 0.0             | 168.14        | 1.4      | 0.0  | 0.0       | 169.54 | 0.0  | 0.0        | 0.0  | 169.54      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 500.0         | 8.44     | 0.0  | 0         | 508.44 | 0.0  | 0.0        | 0.0  | 508.44      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Replayed | Reverted |
      | 20250121  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20250221 | Accrual Activity | 4.16   | 0.0       | 4.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250222 | Accrual          | 4.31   | 0.0       | 4.31     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20250221"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20250221" due date and 20 EUR transaction amount
    When Admin sets the business date to "20250222"
    When Customer makes "REPAYMENT" transaction with "SCHEDULED" payment type on "20250222" with 169.45 EUR transaction amount and system-generated Idempotency key
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20250224"
    And Admin does charge-off the loan on "20250224"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250121  |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250221 |           | 334.71          | 165.29        | 4.16     | 20.0 | 0.0       | 189.45 | 169.45 | 0.0        | 169.45 | 20.0        |
      | 2  | 28   | 20250321    |           | 168.11          | 166.6         | 2.85     | 0.0  | 0.0       | 169.45 | 0.0    | 0.0        | 0.0    | 169.45      |
      | 3  | 31   | 20250421    |           | 0.0             | 168.11        | 1.4      | 0.0  | 0.0       | 169.51 | 0.0    | 0.0        | 0.0    | 169.51      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      | 500.0         | 8.41     | 20.0 | 0         | 528.41 | 169.45 | 0.0        | 169.45 | 358.96      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Replayed | Reverted |
      | 20250121  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20250221 | Accrual Activity | 24.16  | 0.0       | 4.16     | 20.0 | 0.0       | 0.0          | true     | false    |
      | 20250222 | Accrual          | 4.31   | 0.0       | 4.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250222 | Repayment        | 169.45 | 149.45    | 0.0      | 20.0 | 0.0       | 350.55       | false    | false    |
      | 20250224 | Accrual          | 0.21   | 0.0       | 0.21     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250224 | Charge-off       | 358.96 | 350.55    | 8.41     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Customer undo "1"th "Repayment" transaction made on "20250222"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250121  |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250221 |           | 334.71          | 165.29        | 4.16     | 20.0 | 0.0       | 189.45 | 0.0  | 0.0        | 0.0  | 189.45      |
      | 2  | 28   | 20250321    |           | 168.19          | 166.52        | 2.93     | 0.0  | 0.0       | 169.45 | 0.0  | 0.0        | 0.0  | 169.45      |
      | 3  | 31   | 20250421    |           | 0.0             | 168.19        | 1.4      | 0.0  | 0.0       | 169.59 | 0.0  | 0.0        | 0.0  | 169.59      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 500.0         | 8.49     | 20.0 | 0         | 528.49 | 0.0  | 0.0        | 0.0  | 528.49      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Replayed | Reverted |
      | 20250121  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20250221 | Accrual Activity | 24.16  | 0.0       | 4.16     | 20.0 | 0.0       | 0.0          | true     | false    |
      | 20250222 | Accrual          | 4.31   | 0.0       | 4.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250222 | Repayment        | 169.45 | 149.45    | 0.0      | 20.0 | 0.0       | 350.55       | false    | true     |
      | 20250224 | Accrual          | 0.21   | 0.0       | 0.21     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250224 | Accrual          | 0.09   | 0.0       | 0.09     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250224 | Charge-off       | 528.49 | 500.0     | 8.49     | 20.0 | 0.0       | 0.0          | true     | false    |
    Then On Loan Transactions tab the "Repayment" Transaction with date "20250222" is reverted
    And LoanAccrualTransactionCreatedBusinessEvent is raised on "20250224"
    And "Charge-off" transaction on "20250224" got reverse-replayed on "20250224"
    Then BulkBusinessEvent is not raised on "20250224"

  @TestRailId:C2762
  Scenario: Verify that charge-off is reversed/replayed if Real time repayment which was placed on a date before the charge-off is reversed after the charge-off
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230125"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230125" due date and 20 EUR transaction amount
    When Admin sets the business date to "20230210"
    When Customer makes "REPAYMENT" transaction with "REAL_TIME" payment type on "20230210" with 1020 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20230215"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230215" due date and 15 EUR transaction amount
    When Admin sets the business date to "20230601"
    And Admin does charge-off the loan on "20230601"
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20230101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 30   | 20230131  | 20230210 | 0.0             | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 1020.0 | 0.0        | 1020.0 | 0.0         |
      | 2  | 15   | 20230215 |                  | 0.0             | 0.0           | 0.0      | 0.0  | 15.0      | 15.0   | 0.0    | 0.0        | 0.0    | 15.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 15        | 1035 | 1020 | 0          | 1020 | 15          |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230210 | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230210 | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230601     | Charge-off       | 15.0   | 0.0       | 0.0      | 0.0  | 15.0      | 0.0          |
    When Admin sets the business date to "20230610"
    When Customer undo "1"th "Repayment" transaction made on "20230210"
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230131  |           | 0.0             | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 0.0  | 0.0        | 0.0  | 1020.0      |
      | 2  | 15   | 20230215 |           | 0.0             | 0.0           | 0.0      | 0.0  | 15.0      | 15.0   | 0.0  | 0.0        | 0.0  | 15.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 15        | 1035 | 0    | 0          | 0    | 1035        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230210 | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230210 | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230601     | Charge-off       | 1035.0 | 1000.0    | 0.0      | 20.0 | 15.0      | 0.0          |
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230210" is reverted

  @TestRailId:C2763
  Scenario: Verify that charge-off is reversed/replayed if Autopay repayment which was placed on a date before the charge-off is reversed after the charge-off
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230125"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230125" due date and 20 EUR transaction amount
    When Admin sets the business date to "20230210"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230210" with 1020 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20230215"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230215" due date and 15 EUR transaction amount
    When Admin sets the business date to "20230601"
    And Admin does charge-off the loan on "20230601"
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20230101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 30   | 20230131  | 20230210 | 0.0             | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 1020.0 | 0.0        | 1020.0 | 0.0         |
      | 2  | 15   | 20230215 |                  | 0.0             | 0.0           | 0.0      | 0.0  | 15.0      | 15.0   | 0.0    | 0.0        | 0.0    | 15.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 15        | 1035 | 1020 | 0          | 1020 | 15          |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230210 | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230210 | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230601     | Charge-off       | 15.0   | 0.0       | 0.0      | 0.0  | 15.0      | 0.0          |
    When Admin sets the business date to "20230610"
    When Customer undo "1"th "Repayment" transaction made on "20230210"
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230131  |           | 0.0             | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 0.0  | 0.0        | 0.0  | 1020.0      |
      | 2  | 15   | 20230215 |           | 0.0             | 0.0           | 0.0      | 0.0  | 15.0      | 15.0   | 0.0  | 0.0        | 0.0  | 15.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 15        | 1035 | 0    | 0          | 0    | 1035        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230210 | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230210 | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230601     | Charge-off       | 1035.0 | 1000.0    | 0.0      | 20.0 | 15.0      | 0.0          |
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230210" is reverted

  @TestRailId:C2764
  Scenario: Verify that charge-off is NOT reversed/replayed if OCA repayment which was placed and reversed on a date after the charge-off
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230125"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230125" due date and 20 EUR transaction amount
    When Admin sets the business date to "20230601"
    And Admin does charge-off the loan on "20230601"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230131 |           | 0.0             | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 0.0  | 0.0        | 0.0  | 1020.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 0         | 1020 | 0    | 0          | 0    | 1020        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230601     | Charge-off       | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
    When Admin sets the business date to "20230610"
    When Customer makes "REPAYMENT" transaction with "OCA_PAYMENT" payment type on "20230610" with 1000 EUR transaction amount and system-generated Idempotency key
    When Customer undo "1"th "Repayment" transaction made on "20230610"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230131 |           | 0.0             | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 0.0  | 0.0        | 0.0  | 1020.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 0         | 1020 | 0    | 0          | 0    | 1020        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230601     | Charge-off       | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230610     | Repayment        | 1000.0 | 980.0     | 0.0      | 20.0 | 0.0       | 20.0         |
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230610" is reverted

  @TestRailId:C2765
  Scenario: Verify that charge-off is reversed/replayed if Goodwill credit transaction is placed on a date before the charge-off on business date after the charge-off
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230125"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230125" due date and 20 EUR transaction amount
    When Admin sets the business date to "20230601"
    And Admin does charge-off the loan on "20230601"
    When Admin sets the business date to "20230610"
    When Admin makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20230129" with 500 EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20230131 |           | 0.0             | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 500.0 | 500.0      | 0.0  | 520.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 0         | 1020 | 500  | 500        | 0    | 520         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230129  | Goodwill Credit  | 500.0  | 480.0     | 0.0      | 20.0 | 0.0       | 520.0        |
      | 20230601     | Charge-off       | 520.0  | 520.0     | 0.0      | 0.0  | 0.0       | 0.0          |

  @TestRailId:C2766
  Scenario: As a user I want to do a undo Charge-off with reversal external Id
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230222"
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name         | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable     |        | 1000.0 |
      | EXPENSE | 744007       | Credit Loss/Bad Debt | 1000.0 |        |
    When Admin sets the business date to "20230223"
    And Admin does a charge-off undo the loan with reversal external Id
    Then Loan Charge-off undo event has reversed on date "20230223" for charge-off undo

  @TestRailId:C2767
  Scenario: Verify that charge-off is reversed/replayed in case of partial payment, charge-off, second part of payment, reverse 1st payment
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230210"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230210" with 500 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20230601"
    And Admin does charge-off the loan on "20230601"
    When Admin sets the business date to "20230605"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230605" with 500 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20230101 |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 30   | 20230131 | 20230605 | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 1000.0 | 0.0        | 1000.0 | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 1000 | 0          | 1000 | 0           |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230210 | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230601     | Charge-off       | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20230605     | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 0.0          |
    When Admin sets the business date to "20230610"
    When Customer undo "1"th "Repayment" transaction made on "20230210"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |       |             |
      | 1  | 30   | 20230131 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 500.0 | 0.0        | 500.0 | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 500  | 0          | 500  | 500         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230210 | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230601     | Charge-off       | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20230605     | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 500.0        |
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230210" is reverted
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230210" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 500.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 500.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 500.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 500.0  |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230601" which has the following Journal entries:
      | Type    | Account code | Account name         | Debit  | Credit |
      | ASSET   | 112601       | Loans Receivable     |        | 1000.0 |
      | EXPENSE | 744007       | Credit Loss/Bad Debt | 1000.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230605" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | INCOME    | 744008       | Recoveries                |       | 500.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 500.0 |        |

  @TestRailId:C2768
  Scenario: Verify that charge-off is results an error in case of partial payment, charge-off, fee added after charge-off
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230210"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230210" with 300 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20230601"
    And Admin does charge-off the loan on "20230601"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |       |             |
      | 1  | 30   | 20230131 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 300.0 | 0.0        | 300.0 | 700.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 300  | 0          | 300  | 700         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230210 | Repayment        | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 700.0        |
      | 20230601     | Charge-off       | 700.0  | 700.0     | 0.0      | 0.0  | 0.0       | 0.0          |
    When Admin sets the business date to "20230610"
    Then Loan charge transaction with the following data results a 403 error and "CHARGED_OFF" error message
      | Charge type     | dueDate      | amount |
      | LOAN_SNOOZE_FEE | 20230610 | 20     |

  @TestRailId:C2779
  Scenario: Verify that on interest bearing loans the accrual of interest is stopped when the loan is charged-off
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_PERIOD_DAILY | 20230101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230102"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230103"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230104"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20230201 |           | 0.0             | 1000.0        | 10.19    | 0.0  | 0.0       | 1010.19 | 0.0  | 0.0        | 0.0  | 1010.19     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000          | 10.19    | 0    | 0         | 1010.19 | 0    | 0          | 0    | 1010.19     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20230103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
    When Admin sets the business date to "20230105"
    And Admin does charge-off the loan on "20230105"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20230201 |           | 0.0             | 1000.0        | 10.19    | 0.0  | 0.0       | 1010.19 | 0.0  | 0.0        | 0.0  | 1010.19     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000          | 10.19    | 0    | 0         | 1010.19 | 0    | 0          | 0    | 1010.19     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230102  | Accrual          | 0.33    | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20230103  | Accrual          | 0.33    | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20230105  | Accrual          | 0.65    | 0.0       | 0.65     | 0.0  | 0.0       | 0.0          |
      | 20230105  | Charge-off       | 1010.19 | 1000.0    | 10.19    | 0.0  | 0.0       | 0.0          |

  @TestRailId:C2780
  Scenario: Verify that on interest bearing loans the accrual of interest is resumed and aggregated when the charge-off is reverted
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_PERIOD_DAILY | 20230101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230102"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230103"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230104"
    And Admin does charge-off the loan on "20230104"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20230201 |           | 0.0             | 1000.0        | 10.19    | 0.0  | 0.0       | 1010.19 | 0.0  | 0.0        | 0.0  | 1010.19     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000          | 10.19    | 0    | 0         | 1010.19 | 0    | 0          | 0    | 1010.19     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230102  | Accrual          | 0.33    | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20230104  | Accrual          | 0.66    | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          |
      | 20230104  | Charge-off       | 1010.19 | 1000.0    | 10.19    | 0.0  | 0.0       | 0.0          |
    When Admin sets the business date to "20230105"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230106"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230107"
    Then Admin does a charge-off undo the loan
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20230201 |           | 0.0             | 1000.0        | 10.19    | 0.0  | 0.0       | 1010.19 | 0.0  | 0.0        | 0.0  | 1010.19     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000          | 10.19    | 0    | 0         | 1010.19 | 0    | 0          | 0    | 1010.19     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230102  | Accrual          | 0.33    | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20230104  | Accrual          | 0.66    | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          |
      | 20230104  | Charge-off       | 1010.19 | 1000.0    | 10.19    | 0.0  | 0.0       | 0.0          |
      | 20230106  | Accrual          | 0.65    | 0.0       | 0.65     | 0.0  | 0.0       | 0.0          |
    Then On Loan Transactions tab the "Charge-off" Transaction with date "20230104" is reverted

  @TestRailId:C2781
  Scenario: Verify that on interest bearing loans the accrual of interest is stopped when the loan is charged-off even if fully paid after the charge-off
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_PERIOD_DAILY | 20230101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230102"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230103"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230104"
    And Admin does charge-off the loan on "20230104"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20230201 |           | 0.0             | 1000.0        | 10.19    | 0.0  | 0.0       | 1010.19 | 0.0  | 0.0        | 0.0  | 1010.19     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000          | 10.19    | 0    | 0         | 1010.19 | 0    | 0          | 0    | 1010.19     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230102  | Accrual          | 0.33    | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20230104  | Accrual          | 0.66    | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          |
      | 20230104  | Charge-off       | 1010.19 | 1000.0    | 10.19    | 0.0  | 0.0       | 0.0          |
    When Admin sets the business date to "20230105"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230106"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230106" with 1010.19 EUR transaction amount and system-generated Idempotency key
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0     |            |      |             |
      | 1  | 31   | 20230201 | 20230106 | 0.0             | 1000.0        | 10.19    | 0.0  | 0.0       | 1010.19 | 1010.19 | 1010.19    | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 1000          | 10.19    | 0    | 0         | 1010.19 | 1010.19 | 1010.19    | 0    | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230102  | Accrual          | 0.33    | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20230104  | Accrual          | 0.66    | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          |
      | 20230104  | Charge-off       | 1010.19 | 1000.0    | 10.19    | 0.0  | 0.0       | 0.0          |
      | 20230106  | Repayment        | 1010.19 | 1000.0    | 10.19    | 0.0  | 0.0       | 0.0          |

  @TestRailId:C3545
  Scenario: Accrual handling in case of charged-off loan when charge-off behavior is regular, interestRecalculation = true, cumulative loan
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_PERIOD_DAILY_INT_RECALC | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.59           | 16.41         | 0.59     | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 2  | 29   | 20240301    |           | 67.05           | 16.54         | 0.46     | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 3  | 31   | 20240401    |           | 50.45           | 16.6          | 0.4      | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 4  | 30   | 20240501      |           | 33.74           | 16.71         | 0.29     | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 5  | 31   | 20240601     |           | 16.94           | 16.8          | 0.2      | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 6  | 30   | 20240701     |           | 0.0             | 16.94         | 0.1      | 0.0  | 0.0       | 17.04 | 0.0  | 0.0        | 0.0  | 17.04       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100           | 2.04     | 0    | 0         | 102.04 | 0    | 0          | 0    | 102.04      |
    When Admin sets the business date to "20240214"
    When Admin runs inline COB job for Loan
    And Admin does charge-off the loan on "20240214"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.59           | 16.41         | 0.59     | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 2  | 29   | 20240301    |           | 67.1            | 16.49         | 0.51     | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 3  | 31   | 20240401    |           | 50.5            | 16.6          | 0.4      | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 4  | 30   | 20240501      |           | 33.79           | 16.71         | 0.29     | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 5  | 31   | 20240601     |           | 16.99           | 16.8          | 0.2      | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 6  | 30   | 20240701     |           | 0.0             | 16.99         | 0.1      | 0.0  | 0.0       | 17.09 | 0.0  | 0.0        | 0.0  | 17.09       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100           | 2.09     | 0    | 0         | 102.09 | 0    | 0          | 0    | 102.09      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240102  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Charge-off       | 102.09 | 100.0     | 2.09     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240214"

  @TestRailId:C2782
  Scenario: Verify that the accrual of charges is not happened when the loan is charged-off on charge's due date but resumed when the charge-off is reverted
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230102"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230102" due date and 10 EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230103"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230131 |           | 0.0             | 1000.0        | 0.0      | 10.0 | 0.0       | 1010.0 | 0.0  | 0.0        | 0.0  | 1010.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000          | 0.0      | 10   | 0         | 1010.0 | 0    | 0          | 0    | 1010.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230102  | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
    When Admin sets the business date to "20230104"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230104" due date and 15 EUR transaction amount
    And Admin does charge-off the loan on "20230104"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230105"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230131 |           | 0.0             | 1000.0        | 0.0      | 25.0 | 0.0       | 1025.0 | 0.0  | 0.0        | 0.0  | 1025.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000          | 0.0      | 25   | 0         | 1025.0 | 0    | 0          | 0    | 1025.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230102  | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230104  | Charge-off       | 1025.0 | 1000.0    | 0.0      | 25.0 | 0.0       | 0.0          |
    When Admin sets the business date to "20230106"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230107"
    Then Admin does a charge-off undo the loan
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230131 |           | 0.0             | 1000.0        | 0.0      | 25.0 | 0.0       | 1025.0 | 0.0  | 0.0        | 0.0  | 1025.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000          | 0.0      | 25   | 0         | 1025.0 | 0    | 0          | 0    | 1025.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230102  | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230104  | Charge-off       | 1025.0 | 1000.0    | 0.0      | 25.0 | 0.0       | 0.0          |
      | 20230106  | Accrual          | 15.0   | 0.0       | 0.0      | 15.0 | 0.0       | 0.0          |
    Then On Loan Transactions tab the "Charge-off" Transaction with date "20230104" is reverted

  @TestRailId:C2891 @AdvancedPaymentAllocation
  Scenario: Verify that the user is able to do a Charge-off for fraud loan when FEE and PENALTY added - LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION product
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    And Admin adds an NSF fee because of payment bounce with "20230101" transaction date
    When Admin sets the business date to "20230222"
    And Admin adds a 10 % Processing charge to the loan with "en" locale on date: "20230222"
    Then Admin can successfully set Fraud flag to the loan
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit | Credit |
      | ASSET   | 112601       | Loans Receivable           |       | 750.0  |
      | ASSET   | 112603       | Interest/Fee Receivable    |       | 110.0  |
      | EXPENSE | 744037       | Credit Loss/Bad Debt-Fraud | 750.0 |        |
      | INCOME  | 404008       | Fee Charge Off             | 110.0 |        |

  @TestRailId:C2892 @AdvancedPaymentAllocation
  Scenario: Verify that the user is able to do a Charge-off for non-fraud loan after disbursement - LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION product
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230222"
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name         | Debit | Credit |
      | ASSET   | 112601       | Loans Receivable     |       | 750.0  |
      | EXPENSE | 744007       | Credit Loss/Bad Debt | 750.0 |        |

  @TestRailId:C2893 @AdvancedPaymentAllocation
  Scenario: Verify that the user is able to do a Charge-off for non-fraud loan after repayment - LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION product
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230105"
    And Customer makes "AUTOPAY" repayment on "20230105" with 250 EUR transaction amount
    When Admin sets the business date to "20230222"
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230105" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name         | Debit | Credit |
      | ASSET   | 112601       | Loans Receivable     |       | 500.0  |
      | EXPENSE | 744007       | Credit Loss/Bad Debt | 500.0 |        |

  @TestRailId:C2894 @AdvancedPaymentAllocation
  Scenario: Verify that the user is able to do a Repayment undo after Charge-off for non-fraud - LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION product
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230105"
    And Customer makes "AUTOPAY" repayment on "20230105" with 250 EUR transaction amount
    When Admin sets the business date to "20230222"
    And Admin does charge-off the loan on "20230222"
    Then Loan marked as charged-off on "20230222"
    When Customer undo "1"th repayment on "20230105"
    Then Loan status will be "ACTIVE"
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230105" is reverted
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230105" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 250.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 250.0  |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20230222" which has the following Journal entries:
      | Type    | Account code | Account name         | Debit | Credit |
      | ASSET   | 112601       | Loans Receivable     |       | 750.0  |
      | EXPENSE | 744007       | Credit Loss/Bad Debt | 750.0 |        |

  @TestRailId:C2895 @AdvancedPaymentAllocation
  Scenario: Verify that the user is able to do a backdated Charge-off when only disbursement transaction happened - LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION product
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230222"
    And Admin does charge-off the loan on "20230210"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20230131  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 250  | 0          | 0    | 750         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230210 | Charge-off       | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          |

  @TestRailId:C2896 @AdvancedPaymentAllocation
  Scenario: Verify that charge-off is reversed/replayed if Goodwill credit transaction is placed on a date before the charge-off on business date after the charge-off - - LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION product
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230125"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230125" due date and 20 EUR transaction amount
    When Admin sets the business date to "20230601"
    And Admin does charge-off the loan on "20230601"
    When Admin sets the business date to "20230610"
    When Admin makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20230129" with 500 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230101  | 20230101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20230116  | 20230129 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 3  | 15   | 20230131  |                 | 250.0           | 250.0         | 0.0      | 20.0 | 0.0       | 270.0 | 0.0   | 0.0        | 0.0   | 270.0       |
      | 4  | 15   | 20230215 | 20230129 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 0         | 1020 | 750  | 250        | 250  | 270         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230129  | Goodwill Credit  | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 250.0        |
      | 20230601     | Charge-off       | 270.0  | 250.0     | 0.0      | 20.0 | 0.0       | 0.0          |

  @TestRailId:C3067 @AdvancedPaymentAllocation
  Scenario: Verify charge-off GL entries in case of reverse-replay on fraud loan
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240201" with "1000" amount and expected disbursement date on "20240201"
    When Admin successfully disburse the loan on "20240201" with "1000" EUR transaction amount
    When Admin sets the business date to "20240202"
    And Customer makes "AUTOPAY" repayment on "20240202" with 100 EUR transaction amount
    When Admin sets the business date to "20240203"
    Then Admin can successfully set Fraud flag to the loan
    When Admin sets the business date to "20240203"
    And Admin does charge-off the loan on "20240203"
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240203" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit | Credit |
      | ASSET   | 112601       | Loans Receivable           |       | 650.0  |
      | EXPENSE | 744037       | Credit Loss/Bad Debt-Fraud | 650.0 |        |
    When Admin sets the business date to "20240204"
    When Customer undo "1"th "Repayment" transaction made on "20240202"
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240203" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit | Credit |
      | ASSET   | 112601       | Loans Receivable           |       | 750.0  |
      | EXPENSE | 744037       | Credit Loss/Bad Debt-Fraud | 750.0 |        |
    Then In Loan transactions the replayed "CHARGE_OFF" transaction with date "20240203" has a reverted transaction pair with the following Journal entries:
      | Type    | Account code | Account name               | Debit | Credit |
      | ASSET   | 112601       | Loans Receivable           |       | 650.0  |
      | EXPENSE | 744037       | Credit Loss/Bad Debt-Fraud | 650.0 |        |
      | ASSET   | 112601       | Loans Receivable           | 650.0 |        |
      | EXPENSE | 744037       | Credit Loss/Bad Debt-Fraud |       | 650.0  |

