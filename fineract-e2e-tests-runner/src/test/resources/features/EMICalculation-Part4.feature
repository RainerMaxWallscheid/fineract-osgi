@Emi
Feature: EMI calculation and repayment schedule checks for interest bearing loans - Part4

  @TestRailId:C3836
  Scenario: Progressive loan - flat interest, multi-disbursement, allowPartialPeriodInterestCalculation = false, actual/actual, second disbursement on the due date of installment period
    When Admin sets the business date to "20240601"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                             | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_INTEREST_FLAT_ADV_PMT_ALLOC_MULTIDISBURSE_PART_PERIOD_CALC_DISABLED | 20240101   | 3000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240601" with "3000" amount and expected disbursement date on "20240601"
    And Admin successfully disburse the loan on "20240601" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 666.67          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      | 2  | 31   | 20240801    |           | 333.34          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      | 3  | 31   | 20240901 |           | 0.0             | 333.34        | 10.0     | 0.0  | 0.0       | 343.34 | 0.0  | 0.0        | 0.0  | 343.34      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000          | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0  | 0.0        | 0.0  | 1030.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20240801"
    When Admin successfully disburse the loan on "20240801" with "250" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 666.67          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      | 2  | 31   | 20240801    |           | 333.34          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      |    |      | 20240801    |           | 250.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 3  | 31   | 20240901 |           | 0.0             | 583.34        | 12.5     | 0.0  | 0.0       | 595.84 | 0.0  | 0.0        | 0.0  | 595.84      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1250          | 32.5     | 0.0  | 0.0       | 1282.5  | 0.0  | 0.0        | 0.0  | 1282.5      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240801   | Disbursement            | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1250.0       |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20240601" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20240801" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 250.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 250.0  |
    And Customer makes "AUTOPAY" repayment on "20240801" with 1282.5 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20240601      |                | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 30   | 20240701      | 20240801 | 666.67          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 343.33 | 0.0        | 343.33 | 0.0         |
      | 2  | 31   | 20240801    | 20240801 | 333.34          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 343.33 | 0.0        | 0.0    | 0.0         |
      |    |      | 20240801    |                | 250.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 3  | 31   | 20240901 | 20240801 | 0.0             | 583.34        | 12.5     | 0.0  | 0.0       | 595.84 | 595.84 | 595.84     | 0.0    | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      | 1250          | 32.5     | 0.0  | 0.0       | 1282.5  | 1282.5 | 595.84     | 343.33 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240801   | Disbursement            | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1250.0       |
      | 20240801   | Repayment               | 1282.5 | 1250.0    | 32.5     | 0.0  | 0.0       | 0.0          |
      | 20240801   | Accrual                 | 32.5   | 0.0       | 32.5     | 0.0  | 0.0       | 0.0          |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20240801" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          |        | 1250.0 |
      | ASSET     | 112603       | Interest/Fee Receivable   |        | 32.5   |
      | LIABILITY | 145023       | Suspense/Clearing account | 1282.5 |        |
    When Customer makes a repayment undo on "20240801"
    When Admin successfully undo last disbursal
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 666.67          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      | 2  | 31   | 20240801    |           | 333.34          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      | 3  | 31   | 20240901 |           | 0.0             | 333.34        | 10.0     | 0.0  | 0.0       | 343.34 | 0.0  | 0.0        | 0.0  | 343.34      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000          | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0  | 0.0        | 0.0  | 1030.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240801   | Repayment               | 1282.5 | 1250.0    | 32.5     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20240801   | Accrual                 | 32.5   | 0.0       | 32.5     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3837
  Scenario: Progressive loan - flat interest, multi-disbursement, allowPartialPeriodInterestCalculation = false, 360/30, second disbursement in the middle of installment period
    When Admin sets the business date to "20240601"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_INTEREST_FLAT_360_30_ADV_PMT_ALLOC_MULTIDISBURSE_PART_PERIOD_CALC_DISABLED | 20240101   | 3000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240601" with "3000" amount and expected disbursement date on "20240601"
    And Admin successfully disburse the loan on "20240601" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 666.67          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      | 2  | 31   | 20240801    |           | 333.34          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      | 3  | 31   | 20240901 |           | 0.0             | 333.34        | 10.0     | 0.0  | 0.0       | 343.34 | 0.0  | 0.0        | 0.0  | 343.34      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000          | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0  | 0.0        | 0.0  | 1030.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20240715"
    When Admin successfully disburse the loan on "20240715" with "250" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 666.67          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      |    |      | 20240715      |           | 250.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 2  | 31   | 20240801    |           | 458.33          | 458.34        | 12.5     | 0.0  | 0.0       | 470.84 | 0.0  | 0.0        | 0.0  | 470.84      |
      | 3  | 31   | 20240901 |           | 0.0             | 458.33        | 12.5     | 0.0  | 0.0       | 470.83 | 0.0  | 0.0        | 0.0  | 470.83      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1250          | 35.0     | 0.0  | 0.0       | 1285.0 | 0.0  | 0.0        | 0.0  | 1285.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240715     | Disbursement     | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1250.0       |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20240601" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20240715" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 250.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 250.0  |
    And Customer makes "AUTOPAY" repayment on "20240715" with 814.17 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20240601      |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 30   | 20240701      | 20240715 | 666.67          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 343.33 | 0.0        | 343.33 | 0.0         |
      |    |      | 20240715      |              | 250.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 31   | 20240801    | 20240715 | 458.33          | 458.34        | 12.5     | 0.0  | 0.0       | 470.84 | 470.84 | 470.84     | 0.0    | 0.0         |
      | 3  | 31   | 20240901 |              | 0.0             | 458.33        | 12.5     | 0.0  | 0.0       | 470.83 | 0.0    | 0.0        | 0.0    | 470.83      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      | 1250          | 35.0     | 0.0  | 0.0       | 1285.0 | 814.17 | 470.84     | 343.33 | 470.83      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240715     | Disbursement     | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1250.0       |
      | 20240715     | Repayment        | 814.17 | 791.67    | 22.5     | 0.0  | 0.0       | 458.33       |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20240715" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          |        | 791.67 |
      | ASSET     | 112603       | Interest/Fee Receivable   |        | 22.5   |
      | LIABILITY | 145023       | Suspense/Clearing account | 814.17 |        |
    When Customer makes a repayment undo on "20240715"
    When Admin successfully undo last disbursal
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 666.67          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      | 2  | 31   | 20240801    |           | 333.34          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      | 3  | 31   | 20240901 |           | 0.0             | 333.34        | 10.0     | 0.0  | 0.0       | 343.34 | 0.0  | 0.0        | 0.0  | 343.34      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000          | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0  | 0.0        | 0.0  | 1030.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240601     | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240715     | Repayment        | 814.17 | 791.67    | 22.5     | 0.0  | 0.0       | 458.33       | true     | false    |

  @TestRailId:C3838
  Scenario: Progressive loan - flat interest, multi-disbursement, allowPartialPeriodInterestCalculation = false, 360/30, second disbursement on the due date of installment period
    When Admin sets the business date to "20240601"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_INTEREST_FLAT_360_30_ADV_PMT_ALLOC_MULTIDISBURSE_PART_PERIOD_CALC_DISABLED | 20240101   | 3000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240601" with "3000" amount and expected disbursement date on "20240601"
    And Admin successfully disburse the loan on "20240601" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 666.67          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      | 2  | 31   | 20240801    |           | 333.34          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      | 3  | 31   | 20240901 |           | 0.0             | 333.34        | 10.0     | 0.0  | 0.0       | 343.34 | 0.0  | 0.0        | 0.0  | 343.34      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000          | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0  | 0.0        | 0.0  | 1030.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20240801"
    When Admin successfully disburse the loan on "20240801" with "250" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 666.67          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      | 2  | 31   | 20240801    |           | 333.34          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      |    |      | 20240801    |           | 250.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 3  | 31   | 20240901 |           | 0.0             | 583.34        | 12.5     | 0.0  | 0.0       | 595.84 | 0.0  | 0.0        | 0.0  | 595.84      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1250          | 32.5     | 0.0  | 0.0       | 1282.5  | 0.0  | 0.0        | 0.0  | 1282.5      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240801   | Disbursement            | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1250.0       |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20240601" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20240801" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 250.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 250.0  |
    And Customer makes "AUTOPAY" repayment on "20240801" with 1282.5 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20240601      |                | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 30   | 20240701      | 20240801 | 666.67          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 343.33 | 0.0        | 343.33 | 0.0         |
      | 2  | 31   | 20240801    | 20240801 | 333.34          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 343.33 | 0.0        | 0.0    | 0.0         |
      |    |      | 20240801    |                | 250.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 3  | 31   | 20240901 | 20240801 | 0.0             | 583.34        | 12.5     | 0.0  | 0.0       | 595.84 | 595.84 | 595.84     | 0.0    | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      | 1250          | 32.5     | 0.0  | 0.0       | 1282.5  | 1282.5 | 595.84     | 343.33 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240801   | Disbursement            | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1250.0       |
      | 20240801   | Repayment               | 1282.5 | 1250.0    | 32.5     | 0.0  | 0.0       | 0.0          |
      | 20240801   | Accrual                 | 32.5   | 0.0       | 32.5     | 0.0  | 0.0       | 0.0          |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20240801" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          |        | 1250.0 |
      | ASSET     | 112603       | Interest/Fee Receivable   |        | 32.5   |
      | LIABILITY | 145023       | Suspense/Clearing account | 1282.5 |        |
    When Customer makes a repayment undo on "20240801"
    When Admin successfully undo last disbursal
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 666.67          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      | 2  | 31   | 20240801    |           | 333.34          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      | 3  | 31   | 20240901 |           | 0.0             | 333.34        | 10.0     | 0.0  | 0.0       | 343.34 | 0.0  | 0.0        | 0.0  | 343.34      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000          | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0  | 0.0        | 0.0  | 1030.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240801   | Repayment               | 1282.5 | 1250.0    | 32.5     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20240801   | Accrual                 | 32.5   | 0.0       | 32.5     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3839
  Scenario: Progressive loan - down payment, flat interest, multi-disbursement, allowPartialPeriodInterestCalculation = false, actual/actual, second disbursement in the middle of installment period
    When Admin sets the business date to "20240601"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_INTEREST_FLAT_ADV_PMT_ALLOC_MULTIDISBURSE_PART_PERIOD_CALC_DISABLED | 20240101   | 3000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240601" with "3000" amount and expected disbursement date on "20240601"
    And Admin successfully disburse the loan on "20240601" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240601      |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 30   | 20240701      |           | 500.0           | 250.0         | 7.5      | 0.0  | 0.0       | 257.5 | 0.0  | 0.0        | 0.0  | 257.5       |
      | 3  | 31   | 20240801    |           | 250.0           | 250.0         | 7.5      | 0.0  | 0.0       | 257.5 | 0.0  | 0.0        | 0.0  | 257.5       |
      | 4  | 31   | 20240901 |           | 0.0             | 250.0         | 7.5      | 0.0  | 0.0       | 257.5 | 0.0  | 0.0        | 0.0  | 257.5       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000          | 22.5     | 0.0  | 0.0       | 1022.5 | 0.0  | 0.0        | 0.0  | 1022.5      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20240715"
    When Admin successfully disburse the loan on "20240715" with "250" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 0    | 20240601      |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0  | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 30   | 20240701      |           | 500.0           | 250.0         | 7.5      | 0.0  | 0.0       | 257.5  | 0.0  | 0.0        | 0.0  | 257.5       |
      |    |      | 20240715      |           | 250.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 3  | 0    | 20240715      |           | 687.5           | 62.5          | 0.0      | 0.0  | 0.0       | 62.5   | 0.0  | 0.0        | 0.0  | 62.5        |
      | 4  | 31   | 20240801    |           | 343.75          | 343.75        | 9.37     | 0.0  | 0.0       | 353.12 | 0.0  | 0.0        | 0.0  | 353.12      |
      | 5  | 31   | 20240901 |           | 0.0             | 343.75        | 9.37     | 0.0  | 0.0       | 353.12 | 0.0  | 0.0        | 0.0  | 353.12      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1250          | 26.24    | 0.0  | 0.0       | 1276.24 | 0.0  | 0.0        | 0.0  | 1276.24     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240715     | Disbursement            | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1250.0       |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20240601" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20240715" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 250.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 250.0  |
    And Customer makes "AUTOPAY" repayment on "20240715" with 923.12 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      |    |      | 20240601      |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |       |             |
      | 1  | 0    | 20240601      | 20240715 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0  | 250.0  | 0.0        | 250.0 | 0.0         |
      | 2  | 30   | 20240701      | 20240715 | 500.0           | 250.0         | 7.5      | 0.0  | 0.0       | 257.5  | 257.5  | 0.0        | 257.5 | 0.0         |
      |    |      | 20240715      |              | 250.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |       |             |
      | 3  | 0    | 20240715      | 20240715 | 687.5           | 62.5          | 0.0      | 0.0  | 0.0       | 62.5   | 62.5   | 0.0        | 0.0   | 0.0         |
      | 4  | 31   | 20240801    | 20240715 | 343.75          | 343.75        | 9.37     | 0.0  | 0.0       | 353.12 | 353.12 | 353.12     | 0.0   | 0.0         |
      | 5  | 31   | 20240901 |              | 0.0             | 343.75        | 9.37     | 0.0  | 0.0       | 353.12 | 0.0    | 0.0        | 0.0   | 353.12      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late  | Outstanding |
      | 1250          | 26.24    | 0.0  | 0.0       | 1276.24 | 923.12 | 353.12     | 507.5 | 353.12      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240715     | Disbursement            | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1250.0       |
      | 20240715     | Repayment               | 923.12 | 906.25    | 16.87    | 0.0  | 0.0       | 343.75       |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20240715" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          |        | 906.25 |
      | ASSET     | 112603       | Interest/Fee Receivable   |        | 16.87  |
      | LIABILITY | 145023       | Suspense/Clearing account | 923.12 |        |

  @TestRailId:С3893
  Scenario: Progressive loan - flat interest DAILY, multi-disbursement, actual/actual, second disbursement in the middle of installment period
    When Admin sets the business date to "20240601"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_INTEREST_FLAT_ADV_PMT_ALLOC_MULTIDISBURSE | 20240101   | 3000           | 12                     | FLAT          | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240601" with "3000" amount and expected disbursement date on "20240601"
    And Admin successfully disburse the loan on "20240601" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 666.45          | 333.55        | 9.84     | 0.0  | 0.0       | 343.39 | 0.0  | 0.0        | 0.0  | 343.39      |
      | 2  | 31   | 20240801    |           | 333.22          | 333.23        | 10.16    | 0.0  | 0.0       | 343.39 | 0.0  | 0.0        | 0.0  | 343.39      |
      | 3  | 31   | 20240901 |           | 0.0             | 333.22        | 10.16    | 0.0  | 0.0       | 343.38 | 0.0  | 0.0        | 0.0  | 343.38      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000          | 30.16    | 0.0  | 0.0       | 1030.16 | 0.0  | 0.0        | 0.0  | 1030.16     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20240715"
    When Admin successfully disburse the loan on "20240715" with "250" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 666.45          | 333.55        | 9.84     | 0.0  | 0.0       | 343.39 | 0.0  | 0.0        | 0.0  | 343.39      |
      |    |      | 20240715      |           | 250.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 2  | 31   | 20240801    |           | 457.65          | 458.8         | 11.56    | 0.0  | 0.0       | 470.36 | 0.0  | 0.0        | 0.0  | 470.36      |
      | 3  | 31   | 20240901 |           | 0.0             | 457.65        | 12.7     | 0.0  | 0.0       | 470.35 | 0.0  | 0.0        | 0.0  | 470.35      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1250          | 34.1     | 0.0  | 0.0       | 1284.1 | 0.0  | 0.0        | 0.0  | 1284.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240715     | Disbursement     | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1250.0       |

  @TestRailId:С3894
  Scenario: Progressive loan - flat interest DAILY, down-payment, multi-disbursement, actual/actual, second disbursement on the due date of installment period
    When Admin sets the business date to "20240601"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                               | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_INTEREST_FLAT_ADV_PMT_ALLOC_MULTIDISBURSE | 20240101   | 3000           | 12                     | FLAT          | DAILY                      | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240601" with "3000" amount and expected disbursement date on "20240601"
    And Admin successfully disburse the loan on "20240601" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 0    | 20240601      |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0  | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 30   | 20240701      |           | 499.84          | 250.16        | 7.38     | 0.0  | 0.0       | 257.54 | 0.0  | 0.0        | 0.0  | 257.54      |
      | 3  | 31   | 20240801    |           | 249.92          | 249.92        | 7.62     | 0.0  | 0.0       | 257.54 | 0.0  | 0.0        | 0.0  | 257.54      |
      | 4  | 31   | 20240901 |           | 0.0             | 249.92        | 7.62     | 0.0  | 0.0       | 257.54 | 0.0  | 0.0        | 0.0  | 257.54      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000          | 22.62    | 0.0  | 0.0       | 1022.62 | 0.0  | 0.0        | 0.0  | 1022.62     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20240801"
    When Admin successfully disburse the loan on "20240801" with "250" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 0    | 20240601      |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0  | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 30   | 20240701      |           | 499.84          | 250.16        | 7.38     | 0.0  | 0.0       | 257.54 | 0.0  | 0.0        | 0.0  | 257.54      |
      | 3  | 31   | 20240801    |           | 249.92          | 249.92        | 7.62     | 0.0  | 0.0       | 257.54 | 0.0  | 0.0        | 0.0  | 257.54      |
      |    |      | 20240801    |           | 250.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 4  | 0    | 20240801    |           | 437.42          | 62.5          | 0.0      | 0.0  | 0.0       | 62.5   | 0.0  | 0.0        | 0.0  | 62.5        |
      | 5  | 31   | 20240901 |           | 0.0             | 437.42        | 9.53     | 0.0  | 0.0       | 446.95 | 0.0  | 0.0        | 0.0  | 446.95      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1250          | 24.53    | 0.0  | 0.0       | 1274.53 | 0.0  | 0.0        | 0.0  | 1274.53     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240801   | Disbursement     | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1250.0       |

  @TestRailId:C3897
  Scenario: Progressive loan - flat interest DAILY, actual/actual, 4% interest rate
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_INTEREST_FLAT_ADV_PMT_ALLOC_MULTIDISBURSE  | 20240101   | 100            | 4                      | FLAT          | DAILY                      | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201|           | 66.67           | 33.33         | 0.34     | 0.0  | 0.0       | 33.67 | 0.0  | 0.0        | 0.0  | 33.67       |
      | 2  | 29   | 20240301   |           | 33.32           | 33.35         | 0.32     | 0.0  | 0.0       | 33.67 | 0.0  | 0.0        | 0.0  | 33.67       |
      | 3  | 31   | 20240401   |           | 0.0             | 33.32         | 0.34     | 0.0  | 0.0       | 33.66 | 0.0  | 0.0        | 0.0  | 33.66       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 100           | 1.0      | 0.0  | 0.0       | 101.0 | 0.0  | 0.0        | 0.0  | 101.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |

  @TestRailId:C3898
  Scenario: Progressive loan with downpayment - flat interest DAILY, actual/actual, 4% interest rate
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                               | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_INTEREST_FLAT_ADV_PMT_ALLOC_MULTIDISBURSE | 20240101   | 1000           | 4                      | FLAT          | DAILY                      | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 0    | 20240101 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0  | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20240201|           | 500.05          | 249.95        | 2.54     | 0.0  | 0.0       | 252.49 | 0.0  | 0.0        | 0.0  | 252.49      |
      | 3  | 29   | 20240301   |           | 249.94          | 250.11        | 2.38     | 0.0  | 0.0       | 252.49 | 0.0  | 0.0        | 0.0  | 252.49      |
      | 4  | 31   | 20240401   |           | 0.0             | 249.94        | 2.54     | 0.0  | 0.0       | 252.48 | 0.0  | 0.0        | 0.0  | 252.48      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000          | 7.46     | 0.0  | 0.0       | 1007.46| 0.0  | 0.0        | 0.0  | 1007.46     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |

  @TestRailId:C76742
  Scenario: Progressive loan with downpayment - 0.01 disbursement is assigned to the last installment and full repayment closes the loan
    When Admin sets the business date to "20260218"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADV_PMT_ALLOC_NO_MULTIPLES_OF | 20260218  | 100            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 48                | DAYS                  | 16             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260218" with "100" amount and expected disbursement date on "20260218"
    When Admin successfully disburse the loan on "20260218" with "0.01" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260218 |                  | 0.01            |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 0    | 20260218 | 20260218 | 0.01            | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 16   | 20260306    | 20260218 | 0.01            | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 16   | 20260322    | 20260218 | 0.01            | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 4  | 16   | 20260407    |                  | 0.0             | 0.01          | 0.0      | 0.0  | 0.0       | 0.01 | 0.0  | 0.0        | 0.0  | 0.01        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 0.01          | 0.0      | 0.0  | 0.0       | 0.01 | 0.0  | 0.0        | 0.0  | 0.01        |
    Then Loan has 0.01 outstanding amount
    When Admin sets the business date to "20260408"
    And Customer makes "AUTOPAY" repayment on "20260408" with 0.01 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0.0 outstanding amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20260218 | Disbursement     | 0.01   | 0.0       | 0.0      | 0.0  | 0.0       | 0.01         |
      | 20260408    | Repayment        | 0.01   | 0.01      | 0.0      | 0.0  | 0.0       | 0.0          |

  @TestRailId:C76743
  Scenario: Disbursement of 0.01 on progressive product with installmentAmountInMultiplesOf distributes residual to last installment
    When Admin sets the business date to "20260218"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20260218  | 100            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 48                | DAYS                  | 16             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260218" with "100" amount and expected disbursement date on "20260218"
    When Admin successfully disburse the loan on "20260218" with "0.01" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan has 0.01 outstanding amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260218 |                  | 0.01            |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 0    | 20260218 | 20260218 | 0.01            | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 16   | 20260306    | 20260218 | 0.01            | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 16   | 20260322    | 20260218 | 0.01            | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 4  | 16   | 20260407    |                  | 0.0             | 0.01          | 0.0      | 0.0  | 0.0       | 0.01 | 0.0  | 0.0        | 0.0  | 0.01        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 0.01          | 0.0      | 0.0  | 0.0       | 0.01 | 0.0  | 0.0        | 0.0  | 0.01        |
    When Admin sets the business date to "20260408"
    And Customer makes "AUTOPAY" repayment on "20260408" with 0.01 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0.0 outstanding amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20260218 | Disbursement     | 0.01   | 0.0       | 0.0      | 0.0  | 0.0       | 0.01         |
      | 20260408    | Repayment        | 0.01   | 0.01      | 0.0      | 0.0  | 0.0       | 0.0          |

  @TestRailId:C76744
  Scenario: Disbursement of 0.02 on progressive product with installmentAmountInMultiplesOf distributes residual across remaining installments
    When Admin sets the business date to "20260218"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20260218  | 100            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 48                | DAYS                  | 16             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260218" with "100" amount and expected disbursement date on "20260218"
    When Admin successfully disburse the loan on "20260218" with "0.02" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan has 0.02 outstanding amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260218 |                  | 0.02            |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 0    | 20260218 | 20260218 | 0.02            | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 16   | 20260306    |                  | 0.01            | 0.01          | 0.0      | 0.0  | 0.0       | 0.01 | 0.0  | 0.0        | 0.0  | 0.01        |
      | 3  | 16   | 20260322    |                  | 0.0             | 0.01          | 0.0      | 0.0  | 0.0       | 0.01 | 0.0  | 0.0        | 0.0  | 0.01        |
      | 4  | 16   | 20260407    | 20260218 | 0.0             | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 0.02          | 0.0      | 0.0  | 0.0       | 0.02 | 0.0  | 0.0        | 0.0  | 0.02        |
    When Admin sets the business date to "20260306"
    And Customer makes "AUTOPAY" repayment on "20260306" with 0.02 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0.0 outstanding amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260218 |                  | 0.02            |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 0    | 20260218 | 20260218 | 0.02            | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 16   | 20260306    | 20260306    | 0.01            | 0.01          | 0.0      | 0.0  | 0.0       | 0.01 | 0.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 16   | 20260322    | 20260306    | 0.0             | 0.01          | 0.0      | 0.0  | 0.0       | 0.01 | 0.01 | 0.01       | 0.0  | 0.0         |
      | 4  | 16   | 20260407    | 20260218 | 0.0             | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 0.02          | 0.0      | 0.0  | 0.0       | 0.02 | 0.02 | 0.01       | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20260218 | Disbursement     | 0.02   | 0.0       | 0.0      | 0.0  | 0.0       | 0.02         |
      | 20260306    | Repayment        | 0.02   | 0.02      | 0.0      | 0.0  | 0.0       | 0.0          |

  @TestRailId:C76745
  Scenario: Partial repayment of 0.01 residual does not flip loan to OVERPAID
    When Admin sets the business date to "20260218"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20260218  | 100            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 48                | DAYS                  | 16             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260218" with "100" amount and expected disbursement date on "20260218"
    When Admin successfully disburse the loan on "20260218" with "0.01" EUR transaction amount
    Then Loan status will be "ACTIVE"
    # Repayment of 0.01 on the disbursement day must close the loan, NOT leave balance 0.01 and flip to OVERPAID
    And Customer makes "AUTOPAY" repayment on "20260218" with 0.01 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0.0 outstanding amount

  @TestRailId:C76746
  Scenario: Multi-disbursement, 0.01 first tranche followed by 99.99 second tranche amortises cleanly
    When Admin sets the business date to "20260218"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20260218  | 100            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 48                | DAYS                  | 16             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260218" with "100" amount and expected disbursement date on "20260218"
    # First tranche
    When Admin successfully disburse the loan on "20260218" with "0.01" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan has 0.01 outstanding amount
    # Second tranche on the same day, before any installment is due, must re-amortise to a full 100-loan schedule.
    # Auto-downpayment on 99.99 is round(99.99 * 25%, multiplesOf=1) = 25, so outstanding = 0.01 + 99.99 - 25 = 75.00.
    When Admin successfully disburse the loan on "20260218" with "99.99" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan has 75.0 outstanding amount
    # Pay down full outstanding, loan must close cleanly (not OVERPAID with a ghost 0.01 residual from the first tranche)
    When Admin sets the business date to "20260408"
    And Customer makes "AUTOPAY" repayment on "20260408" with 75 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0.0 outstanding amount

  @TestRailId:C80940
  Scenario: Verify that disbursement on interest-bearing progressive product with sub-multiplesOf EMI distributes principal across all 3 monthly installments
    When Admin sets the business date to "20260218"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DECLINING_CURRENCY_MULTIPLES_OF | 20260218  | 1              | 6                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260218" with "1" amount and expected disbursement date on "20260218"
    When Admin successfully disburse the loan on "20260218" with "1" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan has 1.0 outstanding amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260218 |           | 1.0             |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 28   | 20260318    |           | 0.67            | 0.33          | 0.0      | 0.0  | 0.0       | 0.33 | 0.0  | 0.0        | 0.0  | 0.33        |
      | 2  | 31   | 20260418    |           | 0.34            | 0.33          | 0.0      | 0.0  | 0.0       | 0.33 | 0.0  | 0.0        | 0.0  | 0.33        |
      | 3  | 30   | 20260518      |           | 0.0             | 0.34          | 0.0      | 0.0  | 0.0       | 0.34 | 0.0  | 0.0        | 0.0  | 0.34        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      | 1.0           | 0.0      | 0.0  | 0.0       | 1.0 | 0.0  | 0.0        | 0.0  | 1.0         |
    When Admin sets the business date to "20260518"
    And Customer makes "AUTOPAY" repayment on "20260518" with 1.0 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0.0 outstanding amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20260218 | Disbursement     | 1.0    | 0.0       | 0.0      | 0.0  | 0.0       | 1.0          |
      | 20260518      | Repayment        | 1.0    | 1.0       | 0.0      | 0.0  | 0.0       | 0.0          |

  @TestRailId:C80941
  Scenario: Verify that disbursement on interest-bearing progressive product with sub-multiplesOf EMI distributes both principal AND non-zero interest across all 3 monthly installments
    When Admin sets the business date to "20260218"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DECLINING_CURRENCY_MULTIPLES_OF | 20260218  | 1              | 24                     | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260218" with "1" amount and expected disbursement date on "20260218"
    When Admin successfully disburse the loan on "20260218" with "1" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan has 1.04 outstanding amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260218 |           | 1.0             |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 28   | 20260318    |           | 0.67            | 0.33          | 0.02     | 0.0  | 0.0       | 0.35 | 0.0  | 0.0        | 0.0  | 0.35        |
      | 2  | 31   | 20260418    |           | 0.33            | 0.34          | 0.01     | 0.0  | 0.0       | 0.35 | 0.0  | 0.0        | 0.0  | 0.35        |
      | 3  | 30   | 20260518      |           | 0.0             | 0.33          | 0.01     | 0.0  | 0.0       | 0.34 | 0.0  | 0.0        | 0.0  | 0.34        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1.0           | 0.04     | 0.0  | 0.0       | 1.04 | 0.0  | 0.0        | 0.0  | 1.04        |
    When Admin sets the business date to "20260518"
    And Customer makes "AUTOPAY" repayment on "20260518" with 1.04 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0.0 outstanding amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20260218 | Disbursement     | 1.0    | 0.0       | 0.0      | 0.0  | 0.0       | 1.0          |
      | 20260518      | Repayment        | 1.04   | 1.0       | 0.04     | 0.0  | 0.0       | 0.0          |
      | 20260518      | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          |
