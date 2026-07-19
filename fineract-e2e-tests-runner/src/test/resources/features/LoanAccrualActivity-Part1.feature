@LoanAccrualActivityFeature
Feature: LoanAccrualActivity - Part1

  @TestRailId:C3168
  Scenario: Verify accrual activity - UC1: No payment, advanced payment strategy
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20240103"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240102"
    When Admin sets the business date to "20240106"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240103"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240104"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240105"
    When Admin sets the business date to "20240107"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual Activity | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240106"
    Then LoanTransactionAccrualActivityPostBusinessEvent is raised on "20240106"

  @TestRailId:C3169
  Scenario: Verify accrual activity - UC2: No payment, advanced payment strategy, charges added to installment due date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240106" due date and 10 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240106" due date and 15 EUR transaction amount
    When Admin sets the business date to "20240103"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 10.0 | 15.0      | 276.03 | 0.0  | 0.0        | 0.0  | 276.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 0.0  | 0.0        | 0.0  | 1029.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240102"
    When Admin sets the business date to "20240106"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 10.0 | 15.0      | 276.03 | 0.0  | 0.0        | 0.0  | 276.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 0.0  | 0.0        | 0.0  | 1029.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240103"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240104"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240105"
    When Admin sets the business date to "20240107"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 10.0 | 15.0      | 276.03 | 0.0  | 0.0        | 0.0  | 276.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 0.0  | 0.0        | 0.0  | 1029.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual          | 25.33  | 0.0       | 0.33     | 10.0 | 15.0      | 0.0          |
      | 20240106  | Accrual Activity | 26.64  | 0.0       | 1.64     | 10.0 | 15.0      | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240106"
    Then LoanTransactionAccrualActivityPostBusinessEvent is raised on "20240106"

  @TestRailId:C3170
  Scenario: Verify accrual activity - UC3: No payment, advanced payment strategy, charges added after next installment due date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240107" due date and 10 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240107" due date and 15 EUR transaction amount
    When Admin sets the business date to "20240103"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 10.0 | 15.0      | 276.03 | 0.0  | 0.0        | 0.0  | 276.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 0.0  | 0.0        | 0.0  | 1029.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240102"
    When Admin sets the business date to "20240106"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 10.0 | 15.0      | 276.03 | 0.0  | 0.0        | 0.0  | 276.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 0.0  | 0.0        | 0.0  | 1029.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240103"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240104"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240105"
    When Admin sets the business date to "20240107"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 10.0 | 15.0      | 276.03 | 0.0  | 0.0        | 0.0  | 276.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 0.0  | 0.0        | 0.0  | 1029.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual Activity | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240106"
    Then LoanTransactionAccrualActivityPostBusinessEvent is raised on "20240106"
    When Admin sets the business date to "20240108"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 10.0 | 15.0      | 276.03 | 0.0  | 0.0        | 0.0  | 276.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 0.0  | 0.0        | 0.0  | 1029.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual Activity | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          |
      | 20240107  | Accrual          | 25.25  | 0.0       | 0.25     | 10.0 | 15.0      | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240107"

  @TestRailId:C3171
  Scenario: Verify accrual activity - UC4: No payment, cumulative payment strategy
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_PERIOD_DAILY_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20240103"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240102"
    When Admin sets the business date to "20240106"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240103"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240104"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240105"
    When Admin sets the business date to "20240107"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual Activity | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240106"
    Then LoanTransactionAccrualActivityPostBusinessEvent is raised on "20240106"

  @TestRailId:C3172
  Scenario: Verify accrual activity - UC5: No payment, cumulative payment strategy, charges added to installment due date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_PERIOD_DAILY_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240106" due date and 10 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240106" due date and 15 EUR transaction amount
    When Admin sets the business date to "20240103"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 10.0 | 15.0      | 276.0 | 0.0  | 0.0        | 0.0  | 276.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 0.0  | 0.0        | 0.0  | 1029.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240102"
    When Admin sets the business date to "20240106"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 10.0 | 15.0      | 276.0 | 0.0  | 0.0        | 0.0  | 276.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 0.0  | 0.0        | 0.0  | 1029.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240103"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240104"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240105"
    When Admin sets the business date to "20240107"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 10.0 | 15.0      | 276.0 | 0.0  | 0.0        | 0.0  | 276.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 0.0  | 0.0        | 0.0  | 1029.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual          | 25.33  | 0.0       | 0.33     | 10.0 | 15.0      | 0.0          |
      | 20240106  | Accrual Activity | 26.64  | 0.0       | 1.64     | 10.0 | 15.0      | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240106"
    Then LoanTransactionAccrualActivityPostBusinessEvent is raised on "20240106"

  @TestRailId:C3173
  Scenario: Verify accrual activity - UC6: No payment, cumulative payment strategy, charges added after next installment due date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_PERIOD_DAILY_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240107" due date and 10 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240107" due date and 15 EUR transaction amount
    When Admin sets the business date to "20240103"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 10.0 | 15.0      | 276.0 | 0.0  | 0.0        | 0.0  | 276.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 0.0  | 0.0        | 0.0  | 1029.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240102"
    When Admin sets the business date to "20240106"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 10.0 | 15.0      | 276.0 | 0.0  | 0.0        | 0.0  | 276.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 0.0  | 0.0        | 0.0  | 1029.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240103"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240104"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240105"
    When Admin sets the business date to "20240107"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 10.0 | 15.0      | 276.0 | 0.0  | 0.0        | 0.0  | 276.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 0.0  | 0.0        | 0.0  | 1029.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual Activity | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240106"
    Then LoanTransactionAccrualActivityPostBusinessEvent is raised on "20240106"
    When Admin sets the business date to "20240108"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 10.0 | 15.0      | 276.0 | 0.0  | 0.0        | 0.0  | 276.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 0.0  | 0.0        | 0.0  | 1029.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual Activity | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          |
      | 20240107  | Accrual          | 25.25  | 0.0       | 0.25     | 10.0 | 15.0      | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240107"

  @TestRailId:C3174
  Scenario: Verify accrual activity - UC7: Payment in time, advanced payment strategy
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20240103"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240102"
    When Admin sets the business date to "20240106"
    And Customer makes "AUTOPAY" repayment on "20240106" with 251.03 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 5    | 20240106 | 20240106 | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 251.03 | 0.0        | 0.0  | 0.0         |
      | 2  | 5    | 20240111 |                 | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0    | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |                 | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0    | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |                 | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0    | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 251.03 | 0.0        | 0.0  | 753.07      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Repayment        | 251.03 | 249.39    | 1.64     | 0.0  | 0.0       | 750.61       |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240103"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240104"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240105"
    When Admin sets the business date to "20240107"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 5    | 20240106 | 20240106 | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 251.03 | 0.0        | 0.0  | 0.0         |
      | 2  | 5    | 20240111 |                 | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0    | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |                 | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0    | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |                 | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0    | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 251.03 | 0.0        | 0.0  | 753.07      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Repayment        | 251.03 | 249.39    | 1.64     | 0.0  | 0.0       | 750.61       |
      | 20240106  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual Activity | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240106"
    Then LoanTransactionAccrualActivityPostBusinessEvent is raised on "20240106"

  @TestRailId:C3175
  Scenario: Verify accrual activity - UC8: Payment in time, advanced payment strategy, charges added to installment due date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240106" due date and 10 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240106" due date and 15 EUR transaction amount
    When Admin sets the business date to "20240103"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 10.0 | 15.0      | 276.03 | 0.0  | 0.0        | 0.0  | 276.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 0.0  | 0.0        | 0.0  | 1029.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240102"
    When Admin sets the business date to "20240106"
    And Customer makes "AUTOPAY" repayment on "20240106" with 276.03 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 5    | 20240106 | 20240106 | 750.61          | 249.39        | 1.64     | 10.0 | 15.0      | 276.03 | 276.03 | 0.0        | 0.0  | 0.0         |
      | 2  | 5    | 20240111 |                 | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0    | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |                 | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0    | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |                 | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0    | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 276.03 | 0.0        | 0.0  | 753.07      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Repayment        | 276.03 | 249.39    | 1.64     | 10.0 | 15.0      | 750.61       |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240103"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240104"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240105"
    When Admin sets the business date to "20240107"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 5    | 20240106 | 20240106 | 750.61          | 249.39        | 1.64     | 10.0 | 15.0      | 276.03 | 276.03 | 0.0        | 0.0  | 0.0         |
      | 2  | 5    | 20240111 |                 | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0    | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |                 | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0    | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |                 | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0    | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 276.03 | 0.0        | 0.0  | 753.07      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Repayment        | 276.03 | 249.39    | 1.64     | 10.0 | 15.0      | 750.61       |
      | 20240106  | Accrual          | 25.33  | 0.0       | 0.33     | 10.0 | 15.0      | 0.0          |
      | 20240106  | Accrual Activity | 26.64  | 0.0       | 1.64     | 10.0 | 15.0      | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240106"
    Then LoanTransactionAccrualActivityPostBusinessEvent is raised on "20240106"

  @TestRailId:C3176
  Scenario: Verify accrual activity - UC9: Payment in time, advanced payment strategy, charges added after next installment due date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240107" due date and 10 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240107" due date and 15 EUR transaction amount
    When Admin sets the business date to "20240103"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 10.0 | 15.0      | 276.03 | 0.0  | 0.0        | 0.0  | 276.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 0.0  | 0.0        | 0.0  | 1029.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240102"
    When Admin sets the business date to "20240106"
    And Customer makes "AUTOPAY" repayment on "20240106" with 251.03 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 5    | 20240106 | 20240106 | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 251.03 | 0.0        | 0.0  | 0.0         |
      | 2  | 5    | 20240111 |                 | 500.81          | 249.8         | 1.23     | 10.0 | 15.0      | 276.03 | 0.0    | 0.0        | 0.0  | 276.03      |
      | 3  | 5    | 20240116 |                 | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0    | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |                 | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0    | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 251.03 | 0.0        | 0.0  | 778.07      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Repayment        | 251.03 | 249.39    | 1.64     | 0.0  | 0.0       | 750.61       |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240103"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240104"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240105"
    When Admin sets the business date to "20240107"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 5    | 20240106 | 20240106 | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 251.03 | 0.0        | 0.0  | 0.0         |
      | 2  | 5    | 20240111 |                 | 500.81          | 249.8         | 1.23     | 10.0 | 15.0      | 276.03 | 0.0    | 0.0        | 0.0  | 276.03      |
      | 3  | 5    | 20240116 |                 | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0    | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |                 | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0    | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 251.03 | 0.0        | 0.0  | 778.07      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Repayment        | 251.03 | 249.39    | 1.64     | 0.0  | 0.0       | 750.61       |
      | 20240106  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual Activity | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240106"
    Then LoanTransactionAccrualActivityPostBusinessEvent is raised on "20240106"
    When Admin sets the business date to "20240108"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 5    | 20240106 | 20240106 | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 251.03 | 0.0        | 0.0  | 0.0         |
      | 2  | 5    | 20240111 |                 | 500.81          | 249.8         | 1.23     | 10.0 | 15.0      | 276.03 | 0.0    | 0.0        | 0.0  | 276.03      |
      | 3  | 5    | 20240116 |                 | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0    | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |                 | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0    | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 251.03 | 0.0        | 0.0  | 778.07      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Repayment        | 251.03 | 249.39    | 1.64     | 0.0  | 0.0       | 750.61       |
      | 20240106  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual Activity | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          |
      | 20240107  | Accrual          | 25.25  | 0.0       | 0.25     | 10.0 | 15.0      | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240107"

  @TestRailId:C3177
  Scenario: Verify accrual activity - UC10: Payment in time, cumulative payment strategy
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_PERIOD_DAILY_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20240103"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240102"
    When Admin sets the business date to "20240106"
    And Customer makes "AUTOPAY" repayment on "20240106" with 251 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 5    | 20240106 | 20240106 | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 251.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 5    | 20240111 |                 | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |                 | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |                 | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0   | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 251.0 | 0.0        | 0.0  | 753.1       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Repayment        | 251.0  | 249.36    | 1.64     | 0.0  | 0.0       | 750.64       |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240103"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240104"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240105"
    When Admin sets the business date to "20240107"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 5    | 20240106 | 20240106 | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 251.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 5    | 20240111 |                 | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |                 | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |                 | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0   | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 251.0 | 0.0        | 0.0  | 753.1       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Repayment        | 251.0  | 249.36    | 1.64     | 0.0  | 0.0       | 750.64       |
      | 20240106  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual Activity | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240106"
    Then LoanTransactionAccrualActivityPostBusinessEvent is raised on "20240106"

  @TestRailId:C3178
  Scenario: Verify accrual activity - UC11: Payment in time, cumulative payment strategy, charges added to installment due date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_PERIOD_DAILY_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240106" due date and 10 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240106" due date and 15 EUR transaction amount
    When Admin sets the business date to "20240103"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 10.0 | 15.0      | 276.0 | 0.0  | 0.0        | 0.0  | 276.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 0.0  | 0.0        | 0.0  | 1029.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240102"
    When Admin sets the business date to "20240106"
    And Customer makes "AUTOPAY" repayment on "20240106" with 276 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 5    | 20240106 | 20240106 | 750.64          | 249.36        | 1.64     | 10.0 | 15.0      | 276.0 | 276.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 5    | 20240111 |                 | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |                 | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |                 | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0   | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 276.0 | 0.0        | 0.0  | 753.1       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Repayment        | 276.0  | 249.36    | 1.64     | 10.0 | 15.0      | 750.64       |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240103"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240104"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240105"
    When Admin sets the business date to "20240107"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 5    | 20240106 | 20240106 | 750.64          | 249.36        | 1.64     | 10.0 | 15.0      | 276.0 | 276.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 5    | 20240111 |                 | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |                 | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |                 | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0   | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 276.0 | 0.0        | 0.0  | 753.1       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Repayment        | 276.0  | 249.36    | 1.64     | 10.0 | 15.0      | 750.64       |
      | 20240106  | Accrual          | 25.33  | 0.0       | 0.33     | 10.0 | 15.0      | 0.0          |
      | 20240106  | Accrual Activity | 26.64  | 0.0       | 1.64     | 10.0 | 15.0      | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240106"
    Then LoanTransactionAccrualActivityPostBusinessEvent is raised on "20240106"

  @TestRailId:C3179
  Scenario: Verify accrual activity - UC12: Payment in time, cumulative payment strategy, charges added after next installment due date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_PERIOD_DAILY_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240107" due date and 10 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240107" due date and 15 EUR transaction amount
    When Admin sets the business date to "20240103"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 10.0 | 15.0      | 276.0 | 0.0  | 0.0        | 0.0  | 276.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 0.0  | 0.0        | 0.0  | 1029.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240102"
    When Admin sets the business date to "20240106"
    And Customer makes "AUTOPAY" repayment on "20240106" with 251 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 5    | 20240106 | 20240106 | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 251.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 5    | 20240111 |                 | 500.87          | 249.77        | 1.23     | 10.0 | 15.0      | 276.0 | 0.0   | 0.0        | 0.0  | 276.0       |
      | 3  | 5    | 20240116 |                 | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |                 | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0   | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 251.0 | 0.0        | 0.0  | 778.1       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Repayment        | 251.0  | 249.36    | 1.64     | 0.0  | 0.0       | 750.64       |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240103"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240104"
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240105"
    When Admin sets the business date to "20240107"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 5    | 20240106 | 20240106 | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 251.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 5    | 20240111 |                 | 500.87          | 249.77        | 1.23     | 10.0 | 15.0      | 276.0 | 0.0   | 0.0        | 0.0  | 276.0       |
      | 3  | 5    | 20240116 |                 | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |                 | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0   | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 251.0 | 0.0        | 0.0  | 778.1       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Repayment        | 251.0  | 249.36    | 1.64     | 0.0  | 0.0       | 750.64       |
      | 20240106  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual Activity | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240106"
    Then LoanTransactionAccrualActivityPostBusinessEvent is raised on "20240106"
    When Admin sets the business date to "20240108"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 5    | 20240106 | 20240106 | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 251.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 5    | 20240111 |                 | 500.87          | 249.77        | 1.23     | 10.0 | 15.0      | 276.0 | 0.0   | 0.0        | 0.0  | 276.0       |
      | 3  | 5    | 20240116 |                 | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |                 | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0   | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 251.0 | 0.0        | 0.0  | 778.1       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Repayment        | 251.0  | 249.36    | 1.64     | 0.0  | 0.0       | 750.64       |
      | 20240106  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual Activity | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          |
      | 20240107  | Accrual          | 25.25  | 0.0       | 0.25     | 10.0 | 15.0      | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240107"

  @TestRailId:C3185
  Scenario: Verify accrual activity - UC13: Preclose, loan account fully paid before first installment due date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20240104"
    And Customer makes "AUTOPAY" repayment on "20240104" with 1004.1 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 5    | 20240106 | 20240104 | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 251.03 | 251.03     | 0.0  | 0.0         |
      | 2  | 5    | 20240111 | 20240104 | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 251.03 | 251.03     | 0.0  | 0.0         |
      | 3  | 5    | 20240116 | 20240104 | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 251.03 | 251.03     | 0.0  | 0.0         |
      | 4  | 5    | 20240121 | 20240104 | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 251.01 | 251.01     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 1004.1 | 1004.1     | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240104  | Repayment        | 1004.1 | 1000.0    | 4.1      | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 4.1    | 0.0       | 4.1      | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual Activity | 4.1    | 0.0       | 4.1      | 0.0  | 0.0       | 0.0          |

  @TestRailId:C3186
  Scenario: Verify accrual activity - UC14: Preclose, loan account overpaid before first installment due date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20240104"
    And Customer makes "AUTOPAY" repayment on "20240104" with 1100 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan has 95.9 overpaid amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 5    | 20240106 | 20240104 | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 251.03 | 251.03     | 0.0  | 0.0         |
      | 2  | 5    | 20240111 | 20240104 | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 251.03 | 251.03     | 0.0  | 0.0         |
      | 3  | 5    | 20240116 | 20240104 | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 251.03 | 251.03     | 0.0  | 0.0         |
      | 4  | 5    | 20240121 | 20240104 | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 251.01 | 251.01     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 1004.1 | 1004.1     | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240104  | Repayment        | 1100.0 | 1000.0    | 4.1      | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 4.1    | 0.0       | 4.1      | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual Activity | 4.1    | 0.0       | 4.1      | 0.0  | 0.0       | 0.0          |

  @TestRailId:C3187
  Scenario: Verify accrual activity - UC15: Preclose, loan account fully paid before first installment due date, reopen
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
#    --- Loan account pprepaid fully ---
    When Admin sets the business date to "20240104"
    And Customer makes "AUTOPAY" repayment on "20240104" with 1004.1 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 5    | 20240106 | 20240104 | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 251.03 | 251.03     | 0.0  | 0.0         |
      | 2  | 5    | 20240111 | 20240104 | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 251.03 | 251.03     | 0.0  | 0.0         |
      | 3  | 5    | 20240116 | 20240104 | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 251.03 | 251.03     | 0.0  | 0.0         |
      | 4  | 5    | 20240121 | 20240104 | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 251.01 | 251.01     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 1004.1 | 1004.1     | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240104  | Repayment        | 1004.1 | 1000.0    | 4.1      | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 4.1    | 0.0       | 4.1      | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual Activity | 4.1    | 0.0       | 4.1      | 0.0  | 0.0       | 0.0          |
#    --- Repayment undo ---
    When Admin sets the business date to "20240105"
    When Customer undo "1"th repayment on "20240104"
    When Admin runs inline COB job for Loan
    Then Loan status will be "ACTIVE"
    Then Loan has 1004.1 outstanding amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240104  | Repayment        | 1004.1 | 1000.0    | 4.1      | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20240104  | Accrual          | 4.1    | 0.0       | 4.1      | 0.0  | 0.0       | 0.0          | false    | false    |
#    --- Accrual activity ---
    When Admin sets the business date to "20240107"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement       | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240104  | Accrual            | 4.1    | 0.0       | 4.1      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Repayment          | 1004.1 | 1000.0    | 4.1      | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20240105  | Accrual Adjustment | 2.79   | 0.0       | 2.79     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual            | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual Activity   | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3188
  Scenario: Verify accrual activity - UC16: Preclose, loan account partially paid before first installment due date, fully paid after first installment date, reopen by undo 1st repayment
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
#    --- Loan account pprepaid partially ---
    When Admin sets the business date to "20240104"
    And Customer makes "AUTOPAY" repayment on "20240104" with 251.03 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 5    | 20240106 | 20240104 | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 251.03 | 251.03     | 0.0  | 0.0         |
      | 2  | 5    | 20240111 |                 | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0    | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |                 | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0    | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |                 | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0    | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 251.03 | 251.03     | 0.0  | 753.07      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Repayment        | 251.03 | 249.39    | 1.64     | 0.0  | 0.0       | 750.61       |
    #    --- Accrual activity ---
    When Admin sets the business date to "20240107"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 5    | 20240106 | 20240104 | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 251.03 | 251.03     | 0.0  | 0.0         |
      | 2  | 5    | 20240111 |                 | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0    | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |                 | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0    | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |                 | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0    | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 251.03 | 251.03     | 0.0  | 753.07      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Repayment        | 251.03 | 249.39    | 1.64     | 0.0  | 0.0       | 750.61       |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual Activity | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          |
#   --- Fully repaid ---
    When Admin sets the business date to "20240108"
    And Customer makes "AUTOPAY" repayment on "20240108" with 753.07 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 5    | 20240106 | 20240104 | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 251.03 | 251.03     | 0.0  | 0.0         |
      | 2  | 5    | 20240111 | 20240108 | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 251.03 | 251.03     | 0.0  | 0.0         |
      | 3  | 5    | 20240116 | 20240108 | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 251.03 | 251.03     | 0.0  | 0.0         |
      | 4  | 5    | 20240121 | 20240108 | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 251.01 | 251.01     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 1004.1 | 1004.1     | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Repayment        | 251.03 | 249.39    | 1.64     | 0.0  | 0.0       | 750.61       |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual Activity | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          |
      | 20240108  | Repayment        | 753.07 | 750.61    | 2.46     | 0.0  | 0.0       | 0.0          |
      | 20240108  | Accrual          | 2.46   | 0.0       | 2.46     | 0.0  | 0.0       | 0.0          |
      | 20240108  | Accrual Activity | 2.46   | 0.0       | 2.46     | 0.0  | 0.0       | 0.0          |
#    --- Repayment undo ---
    When Admin sets the business date to "20240109"
    When Customer undo "1"th repayment on "20240104"
    When Admin runs inline COB job for Loan
    Then Loan status will be "ACTIVE"
    Then Loan has 251.03 outstanding amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20240101 |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 5    | 20240106 | 20240108 | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 251.03 | 0.0        | 251.03 | 0.0         |
      | 2  | 5    | 20240111 | 20240108 | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 251.03 | 251.03     | 0.0    | 0.0         |
      | 3  | 5    | 20240116 |                 | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 251.01 | 251.01     | 0.0    | 0.02        |
      | 4  | 5    | 20240121 |                 | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0    | 0.0        | 0.0    | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 753.07 | 502.04     | 251.03 | 251.03      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Repayment        | 251.03 | 249.39    | 1.64     | 0.0  | 0.0       | 750.61       | true     | false    |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual Activity | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Repayment        | 753.07 | 749.4     | 3.67     | 0.0  | 0.0       | 250.6        | false    | true     |
      | 20240108  | Accrual          | 2.46   | 0.0       | 2.46     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3182
  Scenario: Verify accrual activity posting job
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240107"
    When Admin runs the Accrual Activity Posting job
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.61          | 249.39        | 1.64     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 2  | 5    | 20240111 |           | 500.81          | 249.8         | 1.23     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 3  | 5    | 20240116 |           | 250.6           | 250.21        | 0.82     | 0.0  | 0.0       | 251.03 | 0.0  | 0.0        | 0.0  | 251.03      |
      | 4  | 5    | 20240121 |           | 0.0             | 250.6         | 0.41     | 0.0  | 0.0       | 251.01 | 0.0  | 0.0        | 0.0  | 251.01      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240106  | Accrual Activity | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          |

  @TestRailId:C3183
  Scenario: Verify accrual activity reverse/replay - UC01: Backdated fee
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_PERIOD_DAILY_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20240103"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240106" due date and 10 EUR transaction amount
    When Admin sets the business date to "20240107"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 10.0 | 0.0       | 261.0 | 0.0  | 0.0        | 0.0  | 261.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 0.0       | 1014.1 | 0.0  | 0.0        | 0.0  | 1014.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 10.33  | 0.0       | 0.33     | 10.0 | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual Activity | 11.64  | 0.0       | 1.64     | 10.0 | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240108"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240104" due date and 15 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 10.0 | 15.0      | 276.0 | 0.0  | 0.0        | 0.0  | 276.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 0.0  | 0.0        | 0.0  | 1029.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 10.33  | 0.0       | 0.33     | 10.0 | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual Activity | 26.64  | 0.0       | 1.64     | 10.0 | 15.0      | 0.0          | false    | true     |

  @TestRailId:C3184
  Scenario: Verify accrual activity reverse/replay - UC02: Early payment, charge, backdated payment, backdated charge, repayment reversal
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_PERIOD_DAILY_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
#    --- Charge added ---
    When Admin sets the business date to "20240103"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240106" due date and 10 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 10.0 | 0.0       | 261.0 | 0.0  | 0.0        | 0.0  | 261.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 0.0       | 1014.1 | 0.0  | 0.0        | 0.0  | 1014.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
#    --- Early partial payment ---
    When Admin sets the business date to "20240104"
    And Customer makes "AUTOPAY" repayment on "20240104" with 150 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 10.0 | 0.0       | 261.0 | 150.0 | 150.0      | 0.0  | 111.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0   | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 0.0       | 1014.1 | 150.0 | 150.0      | 0.0  | 864.1       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Repayment        | 150.0  | 138.36    | 1.64     | 10.0 | 0.0       | 861.64       | false    | false    |
#   --- Accrual activity transaction ---
    When Admin sets the business date to "20240107"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 10.0 | 0.0       | 261.0 | 150.0 | 150.0      | 0.0  | 111.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0   | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 0.0       | 1014.1 | 150.0 | 150.0      | 0.0  | 864.1       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Repayment        | 150.0  | 138.36    | 1.64     | 10.0 | 0.0       | 861.64       | false    | false    |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 10.33  | 0.0       | 0.33     | 10.0 | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual Activity | 11.64  | 0.0       | 1.64     | 10.0 | 0.0       | 0.0          | false    | false    |
#   --- Backdated payment ---
    When Admin sets the business date to "20240108"
    And Customer makes "AUTOPAY" repayment on "20240105" with 80 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 10.0 | 0.0       | 261.0 | 230.0 | 230.0      | 0.0  | 31.0        |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0   | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 0.0       | 1014.1 | 230.0 | 230.0      | 0.0  | 784.1       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Repayment        | 150.0  | 138.36    | 1.64     | 10.0 | 0.0       | 861.64       | false    | false    |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Repayment        | 80.0   | 80.0      | 0.0      | 0.0  | 0.0       | 781.64       | false    | false    |
      | 20240106  | Accrual          | 10.33  | 0.0       | 0.33     | 10.0 | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual Activity | 11.64  | 0.0       | 1.64     | 10.0 | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
#   --- Backdated charge ---
    When Admin sets the business date to "20240109"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240105" due date and 15 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 10.0 | 15.0      | 276.0 | 230.0 | 230.0      | 0.0  | 46.0        |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0   | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 230.0 | 230.0      | 0.0  | 799.1       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Repayment        | 150.0  | 123.36    | 1.64     | 10.0 | 15.0      | 876.64       | false    | true     |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Repayment        | 80.0   | 80.0      | 0.0      | 0.0  | 0.0       | 796.64       | false    | false    |
      | 20240106  | Accrual          | 10.33  | 0.0       | 0.33     | 10.0 | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual Activity | 26.64  | 0.0       | 1.64     | 10.0 | 15.0      | 0.0          | false    | true     |
      | 20240106  | Accrual          | 15.0   | 0.0       | 0.0      | 0.0  | 15.0      | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
#   --- Repayment reversal ---
    When Admin sets the business date to "20240110"
    When Customer undo "1"th repayment on "20240104"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 10.0 | 15.0      | 276.0 | 80.0 | 80.0       | 0.0  | 196.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 10.0 | 15.0      | 1029.1 | 80.0 | 80.0       | 0.0  | 949.1       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Repayment        | 150.0  | 123.36    | 1.64     | 10.0 | 15.0      | 876.64       | true     | true     |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Repayment        | 80.0   | 53.36     | 1.64     | 10.0 | 15.0      | 946.64       | false    | true     |
      | 20240106  | Accrual          | 10.33  | 0.0       | 0.33     | 10.0 | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual Activity | 26.64  | 0.0       | 1.64     | 10.0 | 15.0      | 0.0          | false    | true     |
      | 20240106  | Accrual          | 15.0   | 0.0       | 0.0      | 0.0  | 15.0      | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual          | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3189
  Scenario: Verify accrual activity reverse/replay - UC03: Backdated repayment with interest recalculation enabled
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_DAILY_RECALCULATION_COMPOUNDING_NONE_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Admin sets the business date to "20240107"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0  | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.96          | 249.68        | 1.32     | 0.0  | 0.0       | 251.0  | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.78          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0  | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.78        | 0.41     | 0.0  | 0.0       | 251.19 | 0.0  | 0.0        | 0.0  | 251.19      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.19     | 0.0  | 0.0       | 1004.19 | 0.0  | 0.0        | 0.0  | 1004.19     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual Activity | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240108"
    And Customer makes "AUTOPAY" repayment on "20240104" with 150 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 5    | 20240106 |           | 750.55          | 249.45        | 1.55     | 0.0  | 0.0       | 251.0  | 150.0 | 150.0      | 0.0  | 101.0       |
      | 2  | 5    | 20240111 |           | 500.85          | 249.7         | 1.3      | 0.0  | 0.0       | 251.0  | 0.0   | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.67          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0  | 0.0   | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.67        | 0.41     | 0.0  | 0.0       | 251.08 | 0.0   | 0.0        | 0.0  | 251.08      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 4.08     | 0.0  | 0.0       | 1004.08 | 150.0 | 150.0      | 0.0  | 854.08      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Repayment        | 150.0  | 148.45    | 1.55     | 0.0  | 0.0       | 851.55       | false    | false    |
      | 20240105  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual Activity | 1.55   | 0.0       | 1.55     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20240106  | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.26   | 0.0       | 0.26     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:3709
  Scenario: Verify accrual and accrual activity after backdated payoff with overdue installments on progressive loan
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_ACCRUAL_ACTIVITY_POSTING | 20240101   | 1000           | 49.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | WEEKS                 | 1              | WEEKS                  | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240119"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type  | Amount  | Principal  | Interest  | Fees  | Penalties  | Loan Balance  | Reverted  | Replayed  |
      | 20240101   | Disbursement      | 1000.0  | 0.0        | 0.0       | 0.0   | 0.0        | 1000.0        | false     | false     |
      | 20240102   | Accrual           | 1.39    | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240103   | Accrual           | 1.39    | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240104   | Accrual           | 1.39    | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240105   | Accrual           | 1.38    | 0.0        | 1.38      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240106   | Accrual           | 1.39    | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240107   | Accrual           | 1.39    | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240108   | Accrual           | 1.39    | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240108   | Accrual Activity  | 9.72    | 0.0        | 9.72      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240109   | Accrual           | 1.39    | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240110   | Accrual           | 1.39    | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240111   | Accrual           | 1.39    | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240112   | Accrual           | 1.38    | 0.0        | 1.38      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240113   | Accrual           | 1.39    | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240114   | Accrual           | 1.39    | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240115   | Accrual           | 1.39    | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240115   | Accrual Activity  | 9.72    | 0.0        | 9.72      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240116   | Accrual           | 1.39    | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240117   | Accrual           | 1.39    | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240118   | Accrual           | 1.39    | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
    When Loan Pay-off is made on "20240111"
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type    | Amount   | Principal  | Interest  | Fees  | Penalties  | Loan Balance  | Reverted  | Replayed  |
      | 20240101   | Disbursement        | 1000.0   | 0.0        | 0.0       | 0.0   | 0.0        | 1000.0        | false     | false     |
      | 20240102   | Accrual             | 1.39     | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240103   | Accrual             | 1.39     | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240104   | Accrual             | 1.39     | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240105   | Accrual             | 1.38     | 0.0        | 1.38      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240106   | Accrual             | 1.39     | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240107   | Accrual             | 1.39     | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240108   | Accrual             | 1.39     | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240108   | Accrual Activity    | 9.72     | 0.0        | 9.72      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240109   | Accrual             | 1.39     | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240110   | Accrual             | 1.39     | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240111   | Accrual             | 1.39     | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240111   | Accrual Activity    | 4.17     | 0.0        | 4.17      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240111   | Repayment           | 1013.89  | 1000.0     | 13.89     | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240112   | Accrual             | 1.38     | 0.0        | 1.38      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240113   | Accrual             | 1.39     | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240114   | Accrual             | 1.39     | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240115   | Accrual             | 1.39     | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240116   | Accrual             | 1.39     | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240117   | Accrual             | 1.39     | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240118   | Accrual             | 1.39     | 0.0        | 1.39      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240119   | Accrual Adjustment  | 9.72     | 0.0        | 9.72      | 0.0   | 0.0        | 0.0           | false     | false     |

  @TestRailId:3710
  Scenario: Verify accrual and accrual activity after backdated payoff with overdue installments on cumulative loan
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_DAILY_RECALCULATION_COMPOUNDING_NONE_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240116"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type  | Amount  | Principal  | Interest  | Fees  | Penalties  | Loan Balance  | Reverted  | Replayed  |
      | 20240101   | Disbursement      | 1000.0  | 0.0        | 0.0       | 0.0   | 0.0        | 1000.0        | false     | false     |
      | 20240102   | Accrual           | 0.33    | 0.0        | 0.33      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240103   | Accrual           | 0.33    | 0.0        | 0.33      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240104   | Accrual           | 0.32    | 0.0        | 0.32      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240105   | Accrual           | 0.33    | 0.0        | 0.33      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240106   | Accrual           | 0.33    | 0.0        | 0.33      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240106   | Accrual Activity  | 1.64    | 0.0        | 1.64      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240107   | Accrual           | 0.28    | 0.0        | 0.28      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240108   | Accrual           | 0.31    | 0.0        | 0.31      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240109   | Accrual           | 0.35    | 0.0        | 0.35      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240110   | Accrual           | 0.37    | 0.0        | 0.37      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240111   | Accrual           | 0.33    | 0.0        | 0.33      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240111   | Accrual Activity  | 1.64    | 0.0        | 1.64      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240112   | Accrual           | 0.23    | 0.0        | 0.23      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240113   | Accrual           | 0.3     | 0.0        | 0.3       | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240114   | Accrual           | 0.36    | 0.0        | 0.36      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240115   | Accrual           | 0.42    | 0.0        | 0.42      | 0.0   | 0.0        | 0.0           | false     | false     |
    When Loan Pay-off is made on "20240111"
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type  | Amount   | Principal  | Interest  | Fees  | Penalties  | Loan Balance  | Reverted  | Replayed  |
      | 20240101   | Disbursement      | 1000.0   | 0.0        | 0.0       | 0.0   | 0.0        | 1000.0        | false     | false     |
      | 20240102   | Accrual           | 0.33     | 0.0        | 0.33      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240103   | Accrual           | 0.33     | 0.0        | 0.33      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240104   | Accrual           | 0.32     | 0.0        | 0.32      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240105   | Accrual           | 0.33     | 0.0        | 0.33      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240106   | Accrual           | 0.33     | 0.0        | 0.33      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240106   | Accrual Activity  | 1.64     | 0.0        | 1.64      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240107   | Accrual           | 0.28     | 0.0        | 0.28      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240108   | Accrual           | 0.31     | 0.0        | 0.31      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240109   | Accrual           | 0.35     | 0.0        | 0.35      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240110   | Accrual           | 0.37     | 0.0        | 0.37      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240111   | Accrual           | 0.33     | 0.0        | 0.33      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240111   | Accrual Activity  | 1.64     | 0.0        | 1.64      | 0.0   | 0.0        | 0.0           | false     | false     |
      | 20240111   | Repayment         | 1003.28  | 1000.0     | 3.28      | 0.0   | 0.0        | 0.0           | false     | false     |

  @TestRailId:3711
  Scenario: Verify accrual and accrual activity after backdated payoff on cumulative loan
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_DAILY_RECALCULATION_COMPOUNDING_NONE_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240106"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240106" with 251.0 EUR transaction amount
    When Admin sets the business date to "20240111"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240111" with 251.0 EUR transaction amount
    When Admin sets the business date to "20240116"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101   | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102   | Accrual           | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103   | Accrual           | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104   | Accrual           | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105   | Accrual           | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106   | Repayment         | 251.0  | 249.36    | 1.64     | 0.0  | 0.0       | 750.64       | false    | false    |
      | 20240106   | Accrual           | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106   | Accrual Activity  | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107   | Accrual           | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108   | Accrual           | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109   | Accrual           | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110   | Accrual           | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111   | Repayment         | 251.0  | 249.77    | 1.23     | 0.0  | 0.0       | 500.87       | false    | false    |
      | 20240111   | Accrual           | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111   | Accrual Activity  | 1.23   | 0.0       | 1.23     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112   | Accrual           | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113   | Accrual           | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114   | Accrual           | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115   | Accrual           | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Loan Pay-off is made on "20240111"
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101   | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102   | Accrual           | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103   | Accrual           | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104   | Accrual           | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105   | Accrual           | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106   | Repayment         | 251.0  | 249.36    | 1.64     | 0.0  | 0.0       | 750.64       | false    | false    |
      | 20240106   | Accrual           | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106   | Accrual Activity  | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107   | Accrual           | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108   | Accrual           | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109   | Accrual           | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110   | Accrual           | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111   | Repayment         | 251.0  | 249.77    | 1.23     | 0.0  | 0.0       | 500.87       | false    | false    |
      | 20240111   | Accrual           | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111   | Accrual Activity  | 1.23   | 0.0       | 1.23     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111   | Repayment         | 500.87 | 500.87    | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3190
  Scenario: Verify accrual activity reverse/replay - UC04: Early repayment with interest recalculation enabled
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_DAILY_RECALCULATION_COMPOUNDING_NONE_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Admin sets the business date to "20240103"
    And Customer makes "AUTOPAY" repayment on "20240103" with 150 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 5    | 20240106 |           | 750.5           | 249.5         | 1.5      | 0.0  | 0.0       | 251.0  | 150.0 | 150.0      | 0.0  | 101.0       |
      | 2  | 5    | 20240111 |           | 500.73          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0  | 0.0   | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.55          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0  | 0.0   | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.55        | 0.41     | 0.0  | 0.0       | 250.96 | 0.0   | 0.0        | 0.0  | 250.96      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 3.96     | 0.0  | 0.0       | 1003.96 | 150.0 | 150.0      | 0.0  | 853.96      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Repayment        | 150.0  | 148.5     | 1.5      | 0.0  | 0.0       | 851.5        | false    | false    |
    When Admin sets the business date to "20240107"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 5    | 20240106 |           | 750.5           | 249.5         | 1.5      | 0.0  | 0.0       | 251.0 | 150.0 | 150.0      | 0.0  | 101.0       |
      | 2  | 5    | 20240111 |           | 500.77          | 249.73        | 1.27     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.59          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.59        | 0.41     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 4.0      | 0.0  | 0.0       | 1004.0 | 150.0 | 150.0      | 0.0  | 854.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Repayment        | 150.0  | 148.5     | 1.5      | 0.0  | 0.0       | 851.5        | false    | false    |
      | 20240103  | Accrual          | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual Activity | 1.5    | 0.0       | 1.5      | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3191
  Scenario: Verify accrual activity reverse/replay - UC04: Early repayment reversed after due date with interest recalculation enabled
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_DAILY_RECALCULATION_COMPOUNDING_NONE_ACCRUAL_ACTIVITY | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 20                | DAYS                  | 5              | DAYS                   | 4                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 500.87          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.69          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.69        | 0.41     | 0.0  | 0.0       | 251.1 | 0.0  | 0.0        | 0.0  | 251.1       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.1      | 0.0  | 0.0       | 1004.1 | 0.0  | 0.0        | 0.0  | 1004.1      |
    When Admin sets the business date to "20240103"
    And Customer makes "AUTOPAY" repayment on "20240103" with 150 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 5    | 20240106 |           | 750.5           | 249.5         | 1.5      | 0.0  | 0.0       | 251.0  | 150.0 | 150.0      | 0.0  | 101.0       |
      | 2  | 5    | 20240111 |           | 500.73          | 249.77        | 1.23     | 0.0  | 0.0       | 251.0  | 0.0   | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.55          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0  | 0.0   | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.55        | 0.41     | 0.0  | 0.0       | 250.96 | 0.0   | 0.0        | 0.0  | 250.96      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 3.96     | 0.0  | 0.0       | 1003.96 | 150.0 | 150.0      | 0.0  | 853.96      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Repayment        | 150.0  | 148.5     | 1.5      | 0.0  | 0.0       | 851.5        | false    | false    |
    When Admin sets the business date to "20240107"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 5    | 20240106 |           | 750.5           | 249.5         | 1.5      | 0.0  | 0.0       | 251.0 | 150.0 | 150.0      | 0.0  | 101.0       |
      | 2  | 5    | 20240111 |           | 500.77          | 249.73        | 1.27     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.59          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.59        | 0.41     | 0.0  | 0.0       | 251.0 | 0.0   | 0.0        | 0.0  | 251.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 4.0      | 0.0  | 0.0       | 1004.0 | 150.0 | 150.0      | 0.0  | 854.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Repayment        | 150.0  | 148.5     | 1.5      | 0.0  | 0.0       | 851.5        | false    | false    |
      | 20240103  | Accrual          | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual Activity | 1.5    | 0.0       | 1.5      | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240108"
    When Customer undo "1"th repayment on "20240103"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 5    | 20240106 |           | 750.64          | 249.36        | 1.64     | 0.0  | 0.0       | 251.0  | 0.0  | 0.0        | 0.0  | 251.0       |
      | 2  | 5    | 20240111 |           | 501.04          | 249.6         | 1.4      | 0.0  | 0.0       | 251.0  | 0.0  | 0.0        | 0.0  | 251.0       |
      | 3  | 5    | 20240116 |           | 250.86          | 250.18        | 0.82     | 0.0  | 0.0       | 251.0  | 0.0  | 0.0        | 0.0  | 251.0       |
      | 4  | 5    | 20240121 |           | 0.0             | 250.86        | 0.41     | 0.0  | 0.0       | 251.27 | 0.0  | 0.0        | 0.0  | 251.27      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 4.27     | 0.0  | 0.0       | 1004.27 | 0.0  | 0.0        | 0.0  | 1004.27     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Repayment        | 150.0  | 148.5     | 1.5      | 0.0  | 0.0       | 851.5        | true     | false    |
      | 20240103  | Accrual          | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual Activity | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20240106  | Accrual          | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3268
  Scenario: Verify reversal of accruals when repayment got reversed
    When Admin sets the business date to "20240422"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240422     | 400            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240422" with "400" amount and expected disbursement date on "20240812"
    When Admin successfully disburse the loan on "20240422" with "400" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20240422     |           | 400.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 30   | 20240522       |           | 333.0           | 67.0          | 0.0      | 0.0  | 0.0       | 67.0 | 0.0  | 0.0        | 0.0  | 67.0        |
      | 2  | 31   | 20240622      |           | 266.0           | 67.0          | 0.0      | 0.0  | 0.0       | 67.0 | 0.0  | 0.0        | 0.0  | 67.0        |
      | 3  | 30   | 20240722      |           | 199.0           | 67.0          | 0.0      | 0.0  | 0.0       | 67.0 | 0.0  | 0.0        | 0.0  | 67.0        |
      | 4  | 31   | 20240822    |           | 132.0           | 67.0          | 0.0      | 0.0  | 0.0       | 67.0 | 0.0  | 0.0        | 0.0  | 67.0        |
      | 5  | 31   | 20240922 |           | 65.0            | 67.0          | 0.0      | 0.0  | 0.0       | 67.0 | 0.0  | 0.0        | 0.0  | 67.0        |
      | 6  | 30   | 20241022   |           | 0.0             | 65.0          | 0.0      | 0.0  | 0.0       | 65.0 | 0.0  | 0.0        | 0.0  | 65.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 0.0  | 0.0        | 0.0  | 400.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240422    | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20240422" with 600 EUR transaction amount
    Then Loan status will be "OVERPAID"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240422" due date and 30 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of     | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20240422 | Flat             | 30.0 | 30.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20240422     |               | 400.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 30   | 20240522       | 20240422 | 333.0           | 67.0          | 0.0      | 0.0  | 30.0      | 97.0 | 97.0 | 97.0       | 0.0  | 0.0         |
      | 2  | 31   | 20240622      | 20240422 | 266.0           | 67.0          | 0.0      | 0.0  | 0.0       | 67.0 | 67.0 | 67.0       | 0.0  | 0.0         |
      | 3  | 30   | 20240722      | 20240422 | 199.0           | 67.0          | 0.0      | 0.0  | 0.0       | 67.0 | 67.0 | 67.0       | 0.0  | 0.0         |
      | 4  | 31   | 20240822    | 20240422 | 132.0           | 67.0          | 0.0      | 0.0  | 0.0       | 67.0 | 67.0 | 67.0       | 0.0  | 0.0         |
      | 5  | 31   | 20240922 | 20240422 | 65.0            | 67.0          | 0.0      | 0.0  | 0.0       | 67.0 | 67.0 | 67.0       | 0.0  | 0.0         |
      | 6  | 30   | 20241022   | 20240422 | 0.0             | 65.0          | 0.0      | 0.0  | 0.0       | 65.0 | 65.0 | 65.0       | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 400.0         | 0.0      | 0.0  | 30.0      | 430.0 | 430.0 | 430.0      | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240422    | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        | false    | false    |
      | 20240422    | Accrual          | 30.0   | 0.0       | 0.0      | 0.0  | 30.0      | 0.0          | false    | false    |
      | 20240422    | Repayment        | 600.0  | 400.0     | 0.0      | 0.0  | 30.0      | 0.0          | false    | true     |
    When Admin sets the business date to "20241010"
    When Admin makes a charge adjustment for the last "LOAN_NSF_FEE" type charge which is due on "20240422" with 15 EUR transaction amount and externalId ""
    When Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20240422" with 15 EUR transaction amount and self-generated Idempotency key
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240422    | Disbursement      | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        | false    | false    |
      | 20240422    | Accrual           | 30.0   | 0.0       | 0.0      | 0.0  | 30.0      | 0.0          | false    | false    |
      | 20240422    | Repayment         | 600.0  | 400.0     | 0.0      | 0.0  | 30.0      | 0.0          | false    | true     |
      | 20240422    | Goodwill Credit   | 15.0   | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241010  | Charge Adjustment | 15.0   | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    When Customer undo "1"th "Repayment" transaction made on "20240422"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20240422     |           | 400.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 30   | 20240522       |           | 333.0           | 67.0          | 0.0      | 0.0  | 30.0      | 97.0 | 30.0 | 15.0       | 15.0 | 67.0        |
      | 2  | 31   | 20240622      |           | 266.0           | 67.0          | 0.0      | 0.0  | 0.0       | 67.0 | 0.0  | 0.0        | 0.0  | 67.0        |
      | 3  | 30   | 20240722      |           | 199.0           | 67.0          | 0.0      | 0.0  | 0.0       | 67.0 | 0.0  | 0.0        | 0.0  | 67.0        |
      | 4  | 31   | 20240822    |           | 132.0           | 67.0          | 0.0      | 0.0  | 0.0       | 67.0 | 0.0  | 0.0        | 0.0  | 67.0        |
      | 5  | 31   | 20240922 |           | 65.0            | 67.0          | 0.0      | 0.0  | 0.0       | 67.0 | 0.0  | 0.0        | 0.0  | 67.0        |
      | 6  | 30   | 20241022   |           | 0.0             | 65.0          | 0.0      | 0.0  | 0.0       | 65.0 | 0.0  | 0.0        | 0.0  | 65.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 400.0         | 0.0      | 0.0  | 30.0      | 430.0 | 30.0 | 15.0       | 15.0 | 400.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240422    | Disbursement      | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        | false    | false    |
      | 20240422    | Accrual           | 30.0   | 0.0       | 0.0      | 0.0  | 30.0      | 0.0          | false    | false    |
      | 20240422    | Repayment         | 600.0  | 400.0     | 0.0      | 0.0  | 30.0      | 0.0          | true     | true     |
      | 20240422    | Goodwill Credit   | 15.0   | 0.0       | 0.0      | 0.0  | 15.0      | 400.0        | false    | true     |
      | 20241010  | Charge Adjustment | 15.0   | 0.0       | 0.0      | 0.0  | 15.0      | 400.0        | false    | true     |

  @TestRailId:C3274
  Scenario: Verify accrual activity for repayment reversal on the progressive loan
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PAYMENT_ALLOC_INTEREST_RECALCULATION_DAILY_EMI_360_30_MULTIDISBURSE | 20240101   | 1000           | 26                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 757.98          | 242.02        | 21.67    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 2  | 29   | 20240301    |           | 510.71          | 247.27        | 16.42    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |           | 258.09          | 252.62        | 11.07    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |           | 0.0             | 258.09        | 5.59     | 0.0  | 0.0       | 263.68 | 0.0  | 0.0        | 0.0  | 263.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 54.75    | 0.0  | 0.0       | 1054.75 | 0.0  | 0.0        | 0.0  | 1054.75     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Admin sets the business date to "20240114"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 757.98          | 242.02        | 21.67    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 2  | 29   | 20240301    |           | 510.71          | 247.27        | 16.42    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |           | 258.09          | 252.62        | 11.07    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |           | 0.0             | 258.09        | 5.59     | 0.0  | 0.0       | 263.68 | 0.0  | 0.0        | 0.0  | 263.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 54.75    | 0.0  | 0.0       | 1054.75 | 0.0  | 0.0        | 0.0  | 1054.75     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240113  | Accrual          | 8.39   | 0.0       | 8.39     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240115"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 757.98          | 242.02        | 21.67    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 2  | 29   | 20240301    |           | 510.71          | 247.27        | 16.42    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |           | 258.09          | 252.62        | 11.07    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |           | 0.0             | 258.09        | 5.59     | 0.0  | 0.0       | 263.68 | 0.0  | 0.0        | 0.0  | 263.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 54.75    | 0.0  | 0.0       | 1054.75 | 0.0  | 0.0        | 0.0  | 1054.75     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240113  | Accrual          | 8.39   | 0.0       | 8.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
    When Customer makes "AUTOPAY" repayment on "20240115" with 263.69 EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 | 20240115 | 746.09          | 253.91        | 9.78     | 0.0  | 0.0       | 263.69 | 263.69 | 263.69     | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                 | 507.44          | 238.65        | 25.04    | 0.0  | 0.0       | 263.69 | 0.0    | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |                 | 254.74          | 252.7         | 10.99    | 0.0  | 0.0       | 263.69 | 0.0    | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |                 | 0.0             | 254.74        | 5.52     | 0.0  | 0.0       | 260.26 | 0.0    | 0.0        | 0.0  | 260.26      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 51.33    | 0.0  | 0.0       | 1051.33 | 263.69 | 263.69     | 0.0  | 787.64      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240113  | Accrual          | 8.39   | 0.0       | 8.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Repayment        | 263.69 | 253.91    | 9.78     | 0.0  | 0.0       | 746.09       | false    | false    |
    When Admin sets the business date to "20240121"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240113  | Accrual          | 8.39   | 0.0       | 8.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Repayment        | 263.69 | 253.91    | 9.78     | 0.0  | 0.0       | 746.09       | false    | false    |
      | 20240115  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual          | 0.53   | 0.0       | 0.53     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Customer undo "1"th repayment on "20240115"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 757.98          | 242.02        | 21.67    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 2  | 29   | 20240301    |           | 510.71          | 247.27        | 16.42    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |           | 258.09          | 252.62        | 11.07    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |           | 0.0             | 258.09        | 5.59     | 0.0  | 0.0       | 263.68 | 0.0  | 0.0        | 0.0  | 263.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 54.75    | 0.0  | 0.0       | 1054.75 | 0.0  | 0.0        | 0.0  | 1054.75     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240113  | Accrual          | 8.39   | 0.0       | 8.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Repayment        | 263.69 | 253.91    | 9.78     | 0.0  | 0.0       | 746.09       | true     | false    |
      | 20240115  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual          | 0.53   | 0.0       | 0.53     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240123"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 757.98          | 242.02        | 21.67    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 2  | 29   | 20240301    |           | 510.71          | 247.27        | 16.42    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |           | 258.09          | 252.62        | 11.07    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |           | 0.0             | 258.09        | 5.59     | 0.0  | 0.0       | 263.68 | 0.0  | 0.0        | 0.0  | 263.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 54.75    | 0.0  | 0.0       | 1054.75 | 0.0  | 0.0        | 0.0  | 1054.75     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240113  | Accrual          | 8.39   | 0.0       | 8.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Repayment        | 263.69 | 253.91    | 9.78     | 0.0  | 0.0       | 746.09       | true     | false    |
      | 20240115  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual          | 0.53   | 0.0       | 0.53     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual          | 1.59   | 0.0       | 1.59     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240128"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 757.98          | 242.02        | 21.67    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 2  | 29   | 20240301    |           | 510.71          | 247.27        | 16.42    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |           | 258.09          | 252.62        | 11.07    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |           | 0.0             | 258.09        | 5.59     | 0.0  | 0.0       | 263.68 | 0.0  | 0.0        | 0.0  | 263.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 54.75    | 0.0  | 0.0       | 1054.75 | 0.0  | 0.0        | 0.0  | 1054.75     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240113  | Accrual          | 8.39   | 0.0       | 8.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Repayment        | 263.69 | 253.91    | 9.78     | 0.0  | 0.0       | 746.09       | true     | false    |
      | 20240115  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual          | 0.53   | 0.0       | 0.53     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual          | 1.59   | 0.0       | 1.59     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3494
  Scenario: Verify non negative amount for Accrual Activity on backdated repayment
    When Admin sets the business date to "20241209"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_ACCRUAL_ACTIVITY | 20241209  | 800            | 33.3                   | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20241209" with "800" amount and expected disbursement date on "20241209"
    When Admin successfully disburse the loan on "20241209" with "800" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20241209 |           | 800.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250109  |           | 675.62          | 124.38        | 22.2     | 0.0  | 0.0       | 146.58 | 0.0  | 0.0        | 0.0  | 146.58      |
      | 2  | 31   | 20250209 |           | 547.79          | 127.83        | 18.75    | 0.0  | 0.0       | 146.58 | 0.0  | 0.0        | 0.0  | 146.58      |
      | 3  | 28   | 20250309    |           | 416.41          | 131.38        | 15.2     | 0.0  | 0.0       | 146.58 | 0.0  | 0.0        | 0.0  | 146.58      |
      | 4  | 31   | 20250409    |           | 281.39          | 135.02        | 11.56    | 0.0  | 0.0       | 146.58 | 0.0  | 0.0        | 0.0  | 146.58      |
      | 5  | 30   | 20250509      |           | 142.62          | 138.77        | 7.81     | 0.0  | 0.0       | 146.58 | 0.0  | 0.0        | 0.0  | 146.58      |
      | 6  | 31   | 20250609     |           | 0.0             | 142.62        | 3.96     | 0.0  | 0.0       | 146.58 | 0.0  | 0.0        | 0.0  | 146.58      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 800.0         | 79.48    | 0.0  | 0.0       | 879.48 | 0.0  | 0.0        | 0.0  | 879.48      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241209 | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
    When Admin sets the business date to "20241211"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241209 | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20241210 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20250108"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241209 | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20241210 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241211 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241212 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241213 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241214 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241215 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241216 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241217 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241218 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241219 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241220 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241221 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241222 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241223 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241224 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241225 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241226 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241227 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241228 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241229 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241230 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241231 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250101  | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250102  | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20250109"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20250109" with 146.58 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20241209 |                 | 800.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250109  | 20250109 | 675.62          | 124.38        | 22.2     | 0.0  | 0.0       | 146.58 | 146.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250209 |                 | 547.79          | 127.83        | 18.75    | 0.0  | 0.0       | 146.58 | 0.0    | 0.0        | 0.0  | 146.58      |
      | 3  | 28   | 20250309    |                 | 416.41          | 131.38        | 15.2     | 0.0  | 0.0       | 146.58 | 0.0    | 0.0        | 0.0  | 146.58      |
      | 4  | 31   | 20250409    |                 | 281.39          | 135.02        | 11.56    | 0.0  | 0.0       | 146.58 | 0.0    | 0.0        | 0.0  | 146.58      |
      | 5  | 30   | 20250509      |                 | 142.62          | 138.77        | 7.81     | 0.0  | 0.0       | 146.58 | 0.0    | 0.0        | 0.0  | 146.58      |
      | 6  | 31   | 20250609     |                 | 0.0             | 142.62        | 3.96     | 0.0  | 0.0       | 146.58 | 0.0    | 0.0        | 0.0  | 146.58      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 800.0         | 79.48    | 0.0  | 0.0       | 879.48 | 146.58 | 0.0        | 0.0  | 732.90      |
    When Admin sets the business date to "20250110"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241209 | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20241210 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241211 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241212 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241213 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241214 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241215 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241216 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241217 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241218 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241219 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241220 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241221 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241222 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241223 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241224 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241225 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241226 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241227 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241228 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241229 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241230 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241231 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250101  | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250102  | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Repayment        | 146.58 | 124.38    | 22.2     | 0.0  | 0.0       | 675.62       | false    | false    |
      | 20250109  | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual Activity | 22.2   | 0.0       | 22.2     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20250111"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20250110" with 676.22 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20241209 |                 | 800.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250109  | 20250109 | 675.62          | 124.38        | 22.2     | 0.0  | 0.0       | 146.58 | 146.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250209 | 20250110 | 529.64          | 145.98        | 0.6      | 0.0  | 0.0       | 146.58 | 146.58 | 146.58     | 0.0  | 0.0         |
      | 3  | 28   | 20250309    | 20250110 | 383.06          | 146.58        | 0.0      | 0.0  | 0.0       | 146.58 | 146.58 | 146.58     | 0.0  | 0.0         |
      | 4  | 31   | 20250409    | 20250110 | 236.48          | 146.58        | 0.0      | 0.0  | 0.0       | 146.58 | 146.58 | 146.58     | 0.0  | 0.0         |
      | 5  | 30   | 20250509      | 20250110 | 89.9            | 146.58        | 0.0      | 0.0  | 0.0       | 146.58 | 146.58 | 146.58     | 0.0  | 0.0         |
      | 6  | 31   | 20250609     | 20250110 | 0.0             | 89.9          | 0.0      | 0.0  | 0.0       | 89.9   | 89.9   | 89.9       | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 800.0         | 22.8     | 0.0  | 0.0       | 822.8 | 822.8 | 676.22     | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241209 | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20241210 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241211 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241212 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241213 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241214 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241215 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241216 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241217 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241218 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241219 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241220 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241221 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241222 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241223 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241224 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241225 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241226 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241227 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241228 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241229 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241230 | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241231 | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250101  | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250102  | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Repayment        | 146.58 | 124.38    | 22.2     | 0.0  | 0.0       | 675.62       | false    | false    |
      | 20250109  | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual Activity | 22.2   | 0.0       | 22.2     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.6    | 0.0       | 0.6      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Repayment        | 676.22 | 675.62    | 0.6      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual Activity | 0.6    | 0.0       | 0.6      | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3495
  Scenario: Verify non negative amount for Accrual Activity on backdated repayment and accrual adjustment
    When Admin sets the business date to "20241209"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_ACCRUAL_ACTIVITY | 20241209  | 800            | 33.3                   | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20241209" with "800" amount and expected disbursement date on "20241209"
    When Admin successfully disburse the loan on "20241209" with "800" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20241209 |           | 800.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250109  |           | 675.62          | 124.38        | 22.2     | 0.0  | 0.0       | 146.58 | 0.0  | 0.0        | 0.0  | 146.58      |
      | 2  | 31   | 20250209 |           | 547.79          | 127.83        | 18.75    | 0.0  | 0.0       | 146.58 | 0.0  | 0.0        | 0.0  | 146.58      |
      | 3  | 28   | 20250309    |           | 416.41          | 131.38        | 15.2     | 0.0  | 0.0       | 146.58 | 0.0  | 0.0        | 0.0  | 146.58      |
      | 4  | 31   | 20250409    |           | 281.39          | 135.02        | 11.56    | 0.0  | 0.0       | 146.58 | 0.0  | 0.0        | 0.0  | 146.58      |
      | 5  | 30   | 20250509      |           | 142.62          | 138.77        | 7.81     | 0.0  | 0.0       | 146.58 | 0.0  | 0.0        | 0.0  | 146.58      |
      | 6  | 31   | 20250609     |           | 0.0             | 142.62        | 3.96     | 0.0  | 0.0       | 146.58 | 0.0  | 0.0        | 0.0  | 146.58      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 800.0         | 79.48    | 0.0  | 0.0       | 879.48 | 0.0  | 0.0        | 0.0  | 879.48      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241209 | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
    When Admin sets the business date to "20250108"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241209 | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20250107  | Accrual          | 20.77  | 0.0       | 20.77    | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20250109"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20250109" with 146.58 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20241209 |                 | 800.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250109  | 20250109 | 675.62          | 124.38        | 22.2     | 0.0  | 0.0       | 146.58 | 146.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250209 |                 | 547.79          | 127.83        | 18.75    | 0.0  | 0.0       | 146.58 | 0.0    | 0.0        | 0.0  | 146.58      |
      | 3  | 28   | 20250309    |                 | 416.41          | 131.38        | 15.2     | 0.0  | 0.0       | 146.58 | 0.0    | 0.0        | 0.0  | 146.58      |
      | 4  | 31   | 20250409    |                 | 281.39          | 135.02        | 11.56    | 0.0  | 0.0       | 146.58 | 0.0    | 0.0        | 0.0  | 146.58      |
      | 5  | 30   | 20250509      |                 | 142.62          | 138.77        | 7.81     | 0.0  | 0.0       | 146.58 | 0.0    | 0.0        | 0.0  | 146.58      |
      | 6  | 31   | 20250609     |                 | 0.0             | 142.62        | 3.96     | 0.0  | 0.0       | 146.58 | 0.0    | 0.0        | 0.0  | 146.58      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 800.0         | 79.48    | 0.0  | 0.0       | 879.48 | 146.58 | 0.0        | 0.0  | 732.90      |
    When Admin sets the business date to "20250110"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241209 | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20250107  | Accrual          | 20.77  | 0.0       | 20.77    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Repayment        | 146.58 | 124.38    | 22.2     | 0.0  | 0.0       | 675.62       | false    | false    |
      | 20250109  | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual Activity | 22.2   | 0.0       | 22.2     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20250111"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20250109" with 675.62 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20241209 |                 | 800.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250109  | 20250109 | 675.62          | 124.38        | 22.2     | 0.0  | 0.0       | 146.58 | 146.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250209 | 20250109 | 529.04          | 146.58        | 0.0      | 0.0  | 0.0       | 146.58 | 146.58 | 146.58     | 0.0  | 0.0         |
      | 3  | 28   | 20250309    | 20250109 | 382.46          | 146.58        | 0.0      | 0.0  | 0.0       | 146.58 | 146.58 | 146.58     | 0.0  | 0.0         |
      | 4  | 31   | 20250409    | 20250109 | 235.88          | 146.58        | 0.0      | 0.0  | 0.0       | 146.58 | 146.58 | 146.58     | 0.0  | 0.0         |
      | 5  | 30   | 20250509      | 20250109 | 89.3            | 146.58        | 0.0      | 0.0  | 0.0       | 146.58 | 146.58 | 146.58     | 0.0  | 0.0         |
      | 6  | 31   | 20250609     | 20250109 | 0.0             | 89.3          | 0.0      | 0.0  | 0.0       | 89.3   | 89.3   | 89.3       | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 800.0         | 22.2     | 0.0  | 0.0       | 822.2 | 822.2 | 675.62     | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241209 | Disbursement       | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20250107  | Accrual            | 20.77  | 0.0       | 20.77    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual            | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Repayment          | 146.58 | 124.38    | 22.2     | 0.0  | 0.0       | 675.62       | false    | false    |
      | 20250109  | Accrual            | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual Activity   | 22.2   | 0.0       | 22.2     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Repayment          | 675.62 | 675.62    | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual            | 0.6    | 0.0       | 0.6      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual Adjustment | 0.6    | 0.0       | 0.6      | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3496
  Scenario: Verify non negative amount for Accrual Activity on backdated repayment, accrual adjustment and revert activity
    When Admin sets the business date to "20241209"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_ACCRUAL_ACTIVITY | 20241209  | 800            | 33.3                   | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20241209" with "800" amount and expected disbursement date on "20241209"
    When Admin successfully disburse the loan on "20241209" with "800" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20241209 |           | 800.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250109  |           | 675.62          | 124.38        | 22.2     | 0.0  | 0.0       | 146.58 | 0.0  | 0.0        | 0.0  | 146.58      |
      | 2  | 31   | 20250209 |           | 547.79          | 127.83        | 18.75    | 0.0  | 0.0       | 146.58 | 0.0  | 0.0        | 0.0  | 146.58      |
      | 3  | 28   | 20250309    |           | 416.41          | 131.38        | 15.2     | 0.0  | 0.0       | 146.58 | 0.0  | 0.0        | 0.0  | 146.58      |
      | 4  | 31   | 20250409    |           | 281.39          | 135.02        | 11.56    | 0.0  | 0.0       | 146.58 | 0.0  | 0.0        | 0.0  | 146.58      |
      | 5  | 30   | 20250509      |           | 142.62          | 138.77        | 7.81     | 0.0  | 0.0       | 146.58 | 0.0  | 0.0        | 0.0  | 146.58      |
      | 6  | 31   | 20250609     |           | 0.0             | 142.62        | 3.96     | 0.0  | 0.0       | 146.58 | 0.0  | 0.0        | 0.0  | 146.58      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 800.0         | 79.48    | 0.0  | 0.0       | 879.48 | 0.0  | 0.0        | 0.0  | 879.48      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241209 | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
    When Admin sets the business date to "20250108"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241209 | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20250107  | Accrual          | 20.77  | 0.0       | 20.77    | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20250109"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20250109" with 146.58 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20241209 |                 | 800.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250109  | 20250109 | 675.62          | 124.38        | 22.2     | 0.0  | 0.0       | 146.58 | 146.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250209 |                 | 547.79          | 127.83        | 18.75    | 0.0  | 0.0       | 146.58 | 0.0    | 0.0        | 0.0  | 146.58      |
      | 3  | 28   | 20250309    |                 | 416.41          | 131.38        | 15.2     | 0.0  | 0.0       | 146.58 | 0.0    | 0.0        | 0.0  | 146.58      |
      | 4  | 31   | 20250409    |                 | 281.39          | 135.02        | 11.56    | 0.0  | 0.0       | 146.58 | 0.0    | 0.0        | 0.0  | 146.58      |
      | 5  | 30   | 20250509      |                 | 142.62          | 138.77        | 7.81     | 0.0  | 0.0       | 146.58 | 0.0    | 0.0        | 0.0  | 146.58      |
      | 6  | 31   | 20250609     |                 | 0.0             | 142.62        | 3.96     | 0.0  | 0.0       | 146.58 | 0.0    | 0.0        | 0.0  | 146.58      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 800.0         | 79.48    | 0.0  | 0.0       | 879.48 | 146.58 | 0.0        | 0.0  | 732.90      |
    When Admin sets the business date to "20250110"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241209 | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20250107  | Accrual          | 20.77  | 0.0       | 20.77    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Repayment        | 146.58 | 124.38    | 22.2     | 0.0  | 0.0       | 675.62       | false    | false    |
      | 20250109  | Accrual          | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual Activity | 22.2   | 0.0       | 22.2     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20250111"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20250108" with 675.03 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20241209 |                 | 800.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250109  | 20250108 | 674.9           | 125.1         | 21.48    | 0.0  | 0.0       | 146.58 | 146.58 | 146.58     | 0.0  | 0.0         |
      | 2  | 31   | 20250209 | 20250108 | 528.32          | 146.58        | 0.0      | 0.0  | 0.0       | 146.58 | 146.58 | 146.58     | 0.0  | 0.0         |
      | 3  | 28   | 20250309    | 20250108 | 381.74          | 146.58        | 0.0      | 0.0  | 0.0       | 146.58 | 146.58 | 146.58     | 0.0  | 0.0         |
      | 4  | 31   | 20250409    | 20250108 | 235.16          | 146.58        | 0.0      | 0.0  | 0.0       | 146.58 | 146.58 | 146.58     | 0.0  | 0.0         |
      | 5  | 30   | 20250509      | 20250109 | 88.71           | 146.45        | 0.13     | 0.0  | 0.0       | 146.58 | 146.58 | 146.58     | 0.0  | 0.0         |
      | 6  | 31   | 20250609     | 20250109 | 0.0             | 88.71         | 0.0      | 0.0  | 0.0       | 88.71  | 88.71  | 88.71      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 800.0         | 21.61    | 0.0  | 0.0       | 821.61 | 821.61 | 821.61     | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241209 | Disbursement       | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20250107  | Accrual            | 20.77  | 0.0       | 20.77    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual            | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Repayment          | 675.03 | 653.55    | 21.48    | 0.0  | 0.0       | 146.45       | false    | false    |
      | 20250108  | Accrual Activity   | 21.61  | 0.0       | 21.61    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Repayment          | 146.58 | 146.45    | 0.13     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20250109  | Accrual            | 0.72   | 0.0       | 0.72     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual            | 0.6    | 0.0       | 0.6      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual Adjustment | 1.19   | 0.0       | 1.19     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3275
  Scenario: Verify accrual activity for backdated repayment on the progressive loan, accrual adjustment needed
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PAYMENT_ALLOC_INTEREST_RECALCULATION_DAILY_EMI_360_30_MULTIDISBURSE | 20240101   | 1000           | 26                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 757.98          | 242.02        | 21.67    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 2  | 29   | 20240301    |           | 510.71          | 247.27        | 16.42    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |           | 258.09          | 252.62        | 11.07    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |           | 0.0             | 258.09        | 5.59     | 0.0  | 0.0       | 263.68 | 0.0  | 0.0        | 0.0  | 263.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 54.75    | 0.0  | 0.0       | 1054.75 | 0.0  | 0.0        | 0.0  | 1054.75     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Admin sets the business date to "20240119"
    And Admin runs inline COB job for Loan
    And Admin sets the business date to "20240121"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 757.98          | 242.02        | 21.67    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 2  | 29   | 20240301    |           | 510.71          | 247.27        | 16.42    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |           | 258.09          | 252.62        | 11.07    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |           | 0.0             | 258.09        | 5.59     | 0.0  | 0.0       | 263.68 | 0.0  | 0.0        | 0.0  | 263.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 54.75    | 0.0  | 0.0       | 1054.75 | 0.0  | 0.0        | 0.0  | 1054.75     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240118  | Accrual          | 11.88  | 0.0       | 11.88    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240121"
    And Customer makes "AUTOPAY" repayment on "20240115" with 263.69 EUR transaction amount
    When Admin sets the business date to "20240123"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 | 20240115 | 746.09          | 253.91        | 9.78     | 0.0  | 0.0       | 263.69 | 263.69 | 263.69     | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                 | 507.44          | 238.65        | 25.04    | 0.0  | 0.0       | 263.69 | 0.0    | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |                 | 254.74          | 252.7         | 10.99    | 0.0  | 0.0       | 263.69 | 0.0    | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |                 | 0.0             | 254.74        | 5.52     | 0.0  | 0.0       | 260.26 | 0.0    | 0.0        | 0.0  | 260.26      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 51.33    | 0.0  | 0.0       | 1051.33 | 263.69 | 263.69     | 0.0  | 787.64      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement       | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240115  | Repayment          | 263.69 | 253.91    | 9.78     | 0.0  | 0.0       | 746.09       | false    | false    |
      | 20240118  | Accrual            | 11.88  | 0.0       | 11.88    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual Adjustment | 0.37   | 0.0       | 0.37     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual            | 0.53   | 0.0       | 0.53     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240126"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 | 20240115 | 746.09          | 253.91        | 9.78     | 0.0  | 0.0       | 263.69 | 263.69 | 263.69     | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                 | 507.44          | 238.65        | 25.04    | 0.0  | 0.0       | 263.69 | 0.0    | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |                 | 254.74          | 252.7         | 10.99    | 0.0  | 0.0       | 263.69 | 0.0    | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |                 | 0.0             | 254.74        | 5.52     | 0.0  | 0.0       | 260.26 | 0.0    | 0.0        | 0.0  | 260.26      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 51.33    | 0.0  | 0.0       | 1051.33 | 263.69 | 263.69     | 0.0  | 787.64      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement       | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240115  | Repayment          | 263.69 | 253.91    | 9.78     | 0.0  | 0.0       | 746.09       | false    | false    |
      | 20240118  | Accrual            | 11.88  | 0.0       | 11.88    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual Adjustment | 0.37   | 0.0       | 0.37     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual            | 0.53   | 0.0       | 0.53     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual            | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual            | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual            | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3276
  Scenario: Verify accrual activity for backdated repayment on the progressive loan, accrual adjustment not needed
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PAYMENT_ALLOC_INTEREST_RECALCULATION_DAILY_EMI_360_30_MULTIDISBURSE | 20240101   | 1000           | 26                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 757.98          | 242.02        | 21.67    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 2  | 29   | 20240301    |           | 510.71          | 247.27        | 16.42    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |           | 258.09          | 252.62        | 11.07    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |           | 0.0             | 258.09        | 5.59     | 0.0  | 0.0       | 263.68 | 0.0  | 0.0        | 0.0  | 263.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 54.75    | 0.0  | 0.0       | 1054.75 | 0.0  | 0.0        | 0.0  | 1054.75     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Admin sets the business date to "20240117"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 757.98          | 242.02        | 21.67    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 2  | 29   | 20240301    |           | 510.71          | 247.27        | 16.42    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |           | 258.09          | 252.62        | 11.07    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |           | 0.0             | 258.09        | 5.59     | 0.0  | 0.0       | 263.68 | 0.0  | 0.0        | 0.0  | 263.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 54.75    | 0.0  | 0.0       | 1054.75 | 0.0  | 0.0        | 0.0  | 1054.75     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20240115" with 263.69 EUR transaction amount
    When Admin sets the business date to "20240118"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 | 20240115 | 746.09          | 253.91        | 9.78     | 0.0  | 0.0       | 263.69 | 263.69 | 263.69     | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                 | 507.44          | 238.65        | 25.04    | 0.0  | 0.0       | 263.69 | 0.0    | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |                 | 254.74          | 252.7         | 10.99    | 0.0  | 0.0       | 263.69 | 0.0    | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |                 | 0.0             | 254.74        | 5.52     | 0.0  | 0.0       | 260.26 | 0.0    | 0.0        | 0.0  | 260.26      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 51.33    | 0.0  | 0.0       | 1051.33 | 263.69 | 263.69     | 0.0  | 787.64      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Repayment        | 263.69 | 253.91    | 9.78     | 0.0  | 0.0       | 746.09       | false    | false    |
      | 20240116  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual          | 0.35   | 0.0       | 0.35     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240126"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 | 20240115 | 746.09          | 253.91        | 9.78     | 0.0  | 0.0       | 263.69 | 263.69 | 263.69     | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                 | 507.44          | 238.65        | 25.04    | 0.0  | 0.0       | 263.69 | 0.0    | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |                 | 254.74          | 252.7         | 10.99    | 0.0  | 0.0       | 263.69 | 0.0    | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |                 | 0.0             | 254.74        | 5.52     | 0.0  | 0.0       | 260.26 | 0.0    | 0.0        | 0.0  | 260.26      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 51.33    | 0.0  | 0.0       | 1051.33 | 263.69 | 263.69     | 0.0  | 787.64      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Repayment        | 263.69 | 253.91    | 9.78     | 0.0  | 0.0       | 746.09       | false    | false    |
      | 20240116  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual          | 0.35   | 0.0       | 0.35     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual          | 0.53   | 0.0       | 0.53     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual          | 0.52   | 0.0       | 0.52     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3284
  Scenario: Verify accrual activity for backdated disbursal on the progressive loan, accrual adjustment not needed
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PAYMENT_ALLOC_INTEREST_RECALCULATION_DAILY_EMI_360_30_MULTIDISBURSE | 20240101   | 1500           | 26                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1500" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 757.98          | 242.02        | 21.67    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 2  | 29   | 20240301    |           | 510.71          | 247.27        | 16.42    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |           | 258.09          | 252.62        | 11.07    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |           | 0.0             | 258.09        | 5.59     | 0.0  | 0.0       | 263.68 | 0.0  | 0.0        | 0.0  | 263.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 54.75    | 0.0  | 0.0       | 1054.75 | 0.0  | 0.0        | 0.0  | 1054.75     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Admin sets the business date to "20240120"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 757.98          | 242.02        | 21.67    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 2  | 29   | 20240301    |           | 510.71          | 247.27        | 16.42    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |           | 258.09          | 252.62        | 11.07    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |           | 0.0             | 258.09        | 5.59     | 0.0  | 0.0       | 263.68 | 0.0  | 0.0        | 0.0  | 263.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 54.75    | 0.0  | 0.0       | 1054.75 | 0.0  | 0.0        | 0.0  | 1054.75     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin successfully disburse the loan on "20240115" with "500" EUR transaction amount
    When Admin sets the business date to "20240121"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240115  |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 1133.34         | 366.66        | 27.61    | 0.0  | 0.0       | 394.27 | 0.0  | 0.0        | 0.0  | 394.27      |
      | 2  | 29   | 20240301    |           | 763.63          | 369.71        | 24.56    | 0.0  | 0.0       | 394.27 | 0.0  | 0.0        | 0.0  | 394.27      |
      | 3  | 31   | 20240401    |           | 385.91          | 377.72        | 16.55    | 0.0  | 0.0       | 394.27 | 0.0  | 0.0        | 0.0  | 394.27      |
      | 4  | 30   | 20240501      |           | 0.0             | 385.91        | 8.36     | 0.0  | 0.0       | 394.27 | 0.0  | 0.0        | 0.0  | 394.27      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1500.0        | 77.08    | 0.0  | 0.0       | 1577.08 | 0.0  | 0.0        | 0.0  | 1577.08     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    | false    |
      | 20240116  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual          | 2.45   | 0.0       | 2.45     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240202"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240115  |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 1133.34         | 366.66        | 27.61    | 0.0  | 0.0       | 394.27 | 0.0  | 0.0        | 0.0  | 394.27      |
      | 2  | 29   | 20240301    |           | 763.9           | 369.44        | 24.83    | 0.0  | 0.0       | 394.27 | 0.0  | 0.0        | 0.0  | 394.27      |
      | 3  | 31   | 20240401    |           | 386.18          | 377.72        | 16.55    | 0.0  | 0.0       | 394.27 | 0.0  | 0.0        | 0.0  | 394.27      |
      | 4  | 30   | 20240501      |           | 0.0             | 386.18        | 8.37     | 0.0  | 0.0       | 394.55 | 0.0  | 0.0        | 0.0  | 394.55      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1500.0        | 77.36    | 0.0  | 0.0       | 1577.36 | 0.0  | 0.0        | 0.0  | 1577.36     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    | false    |
      | 20240116  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual          | 2.45   | 0.0       | 2.45     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual          | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual          | 1.04   | 0.0       | 1.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual          | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual          | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual          | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual          | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual          | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual          | 1.04   | 0.0       | 1.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual          | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual          | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual          | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual          | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3285
  Scenario: Verify accrual activity for reversal of last disbursement on the progressive loan, accrual adjustment needed
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PAYMENT_ALLOC_INTEREST_RECALCULATION_DAILY_EMI_360_30_MULTIDISBURSE | 20240101   | 1500           | 26                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1500" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 757.98          | 242.02        | 21.67    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 2  | 29   | 20240301    |           | 510.71          | 247.27        | 16.42    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |           | 258.09          | 252.62        | 11.07    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |           | 0.0             | 258.09        | 5.59     | 0.0  | 0.0       | 263.68 | 0.0  | 0.0        | 0.0  | 263.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 54.75    | 0.0  | 0.0       | 1054.75 | 0.0  | 0.0        | 0.0  | 1054.75     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Admin sets the business date to "20240120"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 757.98          | 242.02        | 21.67    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 2  | 29   | 20240301    |           | 510.71          | 247.27        | 16.42    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |           | 258.09          | 252.62        | 11.07    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |           | 0.0             | 258.09        | 5.59     | 0.0  | 0.0       | 263.68 | 0.0  | 0.0        | 0.0  | 263.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 54.75    | 0.0  | 0.0       | 1054.75 | 0.0  | 0.0        | 0.0  | 1054.75     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240120"
    When Admin successfully disburse the loan on "20240115" with "500" EUR transaction amount
    When Admin sets the business date to "20240122"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240115  |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 1133.34         | 366.66        | 27.61    | 0.0  | 0.0       | 394.27 | 0.0  | 0.0        | 0.0  | 394.27      |
      | 2  | 29   | 20240301    |           | 763.63          | 369.71        | 24.56    | 0.0  | 0.0       | 394.27 | 0.0  | 0.0        | 0.0  | 394.27      |
      | 3  | 31   | 20240401    |           | 385.91          | 377.72        | 16.55    | 0.0  | 0.0       | 394.27 | 0.0  | 0.0        | 0.0  | 394.27      |
      | 4  | 30   | 20240501      |           | 0.0             | 385.91        | 8.36     | 0.0  | 0.0       | 394.27 | 0.0  | 0.0        | 0.0  | 394.27      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1500.0        | 77.08    | 0.0  | 0.0       | 1577.08 | 0.0  | 0.0        | 0.0  | 1577.08     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    | false    |
      | 20240116  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual          | 2.45   | 0.0       | 2.45     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual          | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240131"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240115  |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 1133.34         | 366.66        | 27.61    | 0.0  | 0.0       | 394.27 | 0.0  | 0.0        | 0.0  | 394.27      |
      | 2  | 29   | 20240301    |           | 763.63          | 369.71        | 24.56    | 0.0  | 0.0       | 394.27 | 0.0  | 0.0        | 0.0  | 394.27      |
      | 3  | 31   | 20240401    |           | 385.91          | 377.72        | 16.55    | 0.0  | 0.0       | 394.27 | 0.0  | 0.0        | 0.0  | 394.27      |
      | 4  | 30   | 20240501      |           | 0.0             | 385.91        | 8.36     | 0.0  | 0.0       | 394.27 | 0.0  | 0.0        | 0.0  | 394.27      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1500.0        | 77.08    | 0.0  | 0.0       | 1577.08 | 0.0  | 0.0        | 0.0  | 1577.08     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    | false    |
      | 20240116  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual          | 2.45   | 0.0       | 2.45     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual          | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual          | 1.04   | 0.0       | 1.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual          | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual          | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual          | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual          | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual          | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual          | 1.04   | 0.0       | 1.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual          | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual          | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Admin successfully undo last disbursal
    When Admin sets the business date to "20240202"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 757.98          | 242.02        | 21.67    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 2  | 29   | 20240301    |           | 510.89          | 247.09        | 16.6     | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |           | 258.27          | 252.62        | 11.07    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |           | 0.0             | 258.27        | 5.6      | 0.0  | 0.0       | 263.87 | 0.0  | 0.0        | 0.0  | 263.87      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 54.94    | 0.0  | 0.0       | 1054.94 | 0.0  | 0.0        | 0.0  | 1054.94     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement       | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual            | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual            | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual            | 2.45   | 0.0       | 2.45     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual            | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual            | 1.04   | 0.0       | 1.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual            | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual            | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual            | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual            | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual            | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual            | 1.04   | 0.0       | 1.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual            | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual            | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual Adjustment | 4.54   | 0.0       | 4.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual            | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3286
  Scenario: Verify accrual activity for reversal of last disbursement on the progressive loan, accrual adjustment not needed
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PAYMENT_ALLOC_INTEREST_RECALCULATION_DAILY_EMI_360_30_MULTIDISBURSE | 20240101   | 1100           | 26                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 757.98          | 242.02        | 21.67    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 2  | 29   | 20240301    |           | 510.71          | 247.27        | 16.42    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |           | 258.09          | 252.62        | 11.07    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |           | 0.0             | 258.09        | 5.59     | 0.0  | 0.0       | 263.68 | 0.0  | 0.0        | 0.0  | 263.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 54.75    | 0.0  | 0.0       | 1054.75 | 0.0  | 0.0        | 0.0  | 1054.75     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Admin sets the business date to "20240120"
    When Admin successfully disburse the loan on "20240120" with "100" EUR transaction amount
    When Admin sets the business date to "20240123"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240120  |           | 100.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 832.8           | 267.2         | 22.51    | 0.0  | 0.0       | 289.71 | 0.0  | 0.0        | 0.0  | 289.71      |
      | 2  | 29   | 20240301    |           | 561.13          | 271.67        | 18.04    | 0.0  | 0.0       | 289.71 | 0.0  | 0.0        | 0.0  | 289.71      |
      | 3  | 31   | 20240401    |           | 283.58          | 277.55        | 12.16    | 0.0  | 0.0       | 289.71 | 0.0  | 0.0        | 0.0  | 289.71      |
      | 4  | 30   | 20240501      |           | 0.0             | 283.58        | 6.14     | 0.0  | 0.0       | 289.72 | 0.0  | 0.0        | 0.0  | 289.72      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1100.0        | 58.85    | 0.0  | 0.0       | 1158.85 | 0.0  | 0.0        | 0.0  | 1158.85     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1100.0       | false    | false    |
      | 20240120  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual          | 0.77   | 0.0       | 0.77     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual          | 0.77   | 0.0       | 0.77     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Admin successfully undo last disbursal
    When Admin sets the business date to "20240202"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 757.98          | 242.02        | 21.67    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 2  | 29   | 20240301    |           | 510.89          | 247.09        | 16.6     | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 3  | 31   | 20240401    |           | 258.27          | 252.62        | 11.07    | 0.0  | 0.0       | 263.69 | 0.0  | 0.0        | 0.0  | 263.69      |
      | 4  | 30   | 20240501      |           | 0.0             | 258.27        | 5.6      | 0.0  | 0.0       | 263.87 | 0.0  | 0.0        | 0.0  | 263.87      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 54.94    | 0.0  | 0.0       | 1054.94 | 0.0  | 0.0        | 0.0  | 1054.94     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240102  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual          | 0.77   | 0.0       | 0.77     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual          | 0.77   | 0.0       | 0.77     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual          | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual          | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual          | 0.7    | 0.0       | 0.7      | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3386
  Scenario: Accrual activity transaction reversed without update external-id to null when an accrual activity is reversed
    When Admin sets the business date to "20250112"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_ACCRUAL_ACTIVITY_POSTING | 20250112   | 430            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250112  |           | 430.0           |               |          | 0.0  |           | 0.0    |      |            |      | 0.0         |
      | 1  | 31   | 20250212 |           | 323.44          | 106.56        | 2.51     | 0.0  | 0.0       | 109.07 | 0.0  | 0.0        | 0.0  | 109.07      |
      | 2  | 28   | 20250312    |           | 216.26          | 107.18        | 1.89     | 0.0  | 0.0       | 109.07 | 0.0  | 0.0        | 0.0  | 109.07      |
      | 3  | 31   | 20250412    |           | 108.45          | 107.81        | 1.26     | 0.0  | 0.0       | 109.07 | 0.0  | 0.0        | 0.0  | 109.07      |
      | 4  | 30   | 20250512      |           | 0.0             | 108.45        | 0.63     | 0.0  | 0.0       | 109.08 | 0.0  | 0.0        | 0.0  | 109.08      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 430           | 6.29     | 0    | 0         | 436.29 | 0    | 0          | 0    | 436.29      |
    And Admin successfully approves the loan on "20250112" with "430" amount and expected disbursement date on "20250112"
    And Admin successfully disburse the loan on "20250112" with "430" EUR transaction amount
    When Admin sets the business date to "20250116"
    And Customer makes "AUTOPAY" repayment on "20250116" with 430 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250112  | Disbursement     | 430.0  | 0.0       | 0.0      | 0.0  | 0.0       | 430.0        | false    | false    |
      | 20250116  | Repayment        | 430.0  | 429.68    | 0.32     | 0.0  | 0.0       | 0.32         | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20250116" with 10 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250112  |                 | 430.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250212 | 20250116 | 321.25          | 108.75        | 0.32     | 0.0  | 0.0       | 109.07 | 109.07 | 109.07     | 0.0  | 0.0         |
      | 2  | 28   | 20250312    | 20250116 | 212.18          | 109.07        | 0.0      | 0.0  | 0.0       | 109.07 | 109.07 | 109.07     | 0.0  | 0.0         |
      | 3  | 31   | 20250412    | 20250116 | 103.11          | 109.07        | 0.0      | 0.0  | 0.0       | 109.07 | 109.07 | 109.07     | 0.0  | 0.0         |
      | 4  | 30   | 20250512      | 20250116 | 0.0             | 103.11        | 0.0      | 0.0  | 0.0       | 103.11 | 103.11 | 103.11     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 430           | 0.32     | 0    | 0         | 430.32 | 430.32 | 430.32     | 0    | 0           |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250112  | Disbursement     | 430.0  | 0.0       | 0.0      | 0.0  | 0.0       | 430.0        | false    | false    |
      | 20250116  | Repayment        | 430.0  | 429.68    | 0.32     | 0.0  | 0.0       | 0.32         | false    | false    |
      | 20250116  | Repayment        | 10.0   | 0.32      | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250116  | Accrual Activity | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250116  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
#   --- check if 'Accrual Activity' transaction has non-null external-id and remember transaction
    Then In Loan Transactions the "1"th Transaction with type="Accrual Activity" and date "20250116" has non-null external-id
#   --- check if all transactions have non-null external-id
    Then In Loan Transactions all transactions have non-null external-id
    When Customer undo "2"th repayment on "20250116"
    When Admin runs inline COB job for Loan
    Then Loan status will be "ACTIVE"
    Then Loan has 0.33 outstanding amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250112  |                 | 430.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250212 | 20250116 | 321.25          | 108.75        | 0.32     | 0.0  | 0.0       | 109.07 | 109.07 | 109.07     | 0.0  | 0.0         |
      | 2  | 28   | 20250312    | 20250116 | 212.18          | 109.07        | 0.0      | 0.0  | 0.0       | 109.07 | 109.07 | 109.07     | 0.0  | 0.0         |
      | 3  | 31   | 20250412    | 20250116 | 103.11          | 109.07        | 0.0      | 0.0  | 0.0       | 109.07 | 109.07 | 109.07     | 0.0  | 0.0         |
      | 4  | 30   | 20250512      |                 | 0.0             | 103.11        | 0.01     | 0.0  | 0.0       | 103.12 | 102.79 | 102.79     | 0.0  | 0.33        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 430           | 0.33     | 0    | 0         | 430.33 | 430.0 | 430.0      | 0    | 0.33        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250112  | Disbursement     | 430.0  | 0.0       | 0.0      | 0.0  | 0.0       | 430.0        | false    | false    |
      | 20250116  | Repayment        | 430.0  | 429.68    | 0.32     | 0.0  | 0.0       | 0.32         | false    | false    |
      | 20250116  | Repayment        | 10.0   | 0.32      | 0.0      | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20250116  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
#   --- check if 'Accrual Activity' is reversed and has non-null external-id
    Then Check required "1"th transaction for non-null eternal-id
    Then In Loan Transactions all transactions have non-null external-id

  @TestRailId:C3398
  Scenario: Verify accrual activity for paid loan
    When Admin sets the business date to "20241220"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20241220  | 430            | 26                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20241220" with "430" amount and expected disbursement date on "20241220"
    When Admin successfully disburse the loan on "20241220" with "430" EUR transaction amount
    When Admin sets the business date to "20241230"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20241220 |           | 430.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 31   | 20250120  |           | 362.12          | 67.88         | 9.32     | 0.0  | 0.0       | 77.2 | 0.0  | 0.0        | 0.0  | 77.2        |
      | 2  | 31   | 20250220 |           | 292.77          | 69.35         | 7.85     | 0.0  | 0.0       | 77.2 | 0.0  | 0.0        | 0.0  | 77.2        |
      | 3  | 28   | 20250320    |           | 221.91          | 70.86         | 6.34     | 0.0  | 0.0       | 77.2 | 0.0  | 0.0        | 0.0  | 77.2        |
      | 4  | 31   | 20250420    |           | 149.52          | 72.39         | 4.81     | 0.0  | 0.0       | 77.2 | 0.0  | 0.0        | 0.0  | 77.2        |
      | 5  | 30   | 20250520      |           | 75.56           | 73.96         | 3.24     | 0.0  | 0.0       | 77.2 | 0.0  | 0.0        | 0.0  | 77.2        |
      | 6  | 31   | 20250620     |           | 0.0             | 75.56         | 1.64     | 0.0  | 0.0       | 77.2 | 0.0  | 0.0        | 0.0  | 77.2        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 430.0         | 33.2     | 0.0  | 0.0       | 463.2 | 0.0  | 0.0        | 0.0  | 463.2       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241220 | Disbursement     | 430.0  | 0.0       | 0.0      | 0.0  | 0.0       | 430.0        | false    | false    |
      | 20241229 | Accrual          | 2.7    | 0.0       | 2.7      | 0.0  | 0.0       | 0.0          | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20241230" with 200 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20241220 |                  | 430.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250120  | 20241230 | 355.81          | 74.19         | 3.01     | 0.0  | 0.0       | 77.2  | 77.2 | 77.2       | 0.0  | 0.0         |
      | 2  | 31   | 20250220 | 20241230 | 278.61          | 77.2          | 0.0      | 0.0  | 0.0       | 77.2  | 77.2 | 77.2       | 0.0  | 0.0         |
      | 3  | 28   | 20250320    |                  | 214.93          | 63.68         | 13.52    | 0.0  | 0.0       | 77.2  | 45.6 | 45.6       | 0.0  | 31.6        |
      | 4  | 31   | 20250420    |                  | 142.39          | 72.54         | 4.66     | 0.0  | 0.0       | 77.2  | 0.0  | 0.0        | 0.0  | 77.2        |
      | 5  | 30   | 20250520      |                  | 68.28           | 74.11         | 3.09     | 0.0  | 0.0       | 77.2  | 0.0  | 0.0        | 0.0  | 77.2        |
      | 6  | 31   | 20250620     |                  | 0.0             | 68.28         | 1.48     | 0.0  | 0.0       | 69.76 | 0.0  | 0.0        | 0.0  | 69.76       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 430.0         | 25.76    | 0.0  | 0.0       | 455.76 | 200.0 | 200.0      | 0.0  | 255.76      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241220 | Disbursement     | 430.0  | 0.0       | 0.0      | 0.0  | 0.0       | 430.0        | false    | false    |
      | 20241229 | Accrual          | 2.7    | 0.0       | 2.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241230 | Repayment        | 200.0  | 196.99    | 3.01     | 0.0  | 0.0       | 233.01       | false    | false    |
    When Admin sets the business date to "20250121"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20241220 |                  | 430.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250120  | 20241230 | 355.81          | 74.19         | 3.01     | 0.0  | 0.0       | 77.2  | 77.2 | 77.2       | 0.0  | 0.0         |
      | 2  | 31   | 20250220 | 20241230 | 278.61          | 77.2          | 0.0      | 0.0  | 0.0       | 77.2  | 77.2 | 77.2       | 0.0  | 0.0         |
      | 3  | 28   | 20250320    |                  | 214.93          | 63.68         | 13.52    | 0.0  | 0.0       | 77.2  | 45.6 | 45.6       | 0.0  | 31.6        |
      | 4  | 31   | 20250420    |                  | 142.39          | 72.54         | 4.66     | 0.0  | 0.0       | 77.2  | 0.0  | 0.0        | 0.0  | 77.2        |
      | 5  | 30   | 20250520      |                  | 68.28           | 74.11         | 3.09     | 0.0  | 0.0       | 77.2  | 0.0  | 0.0        | 0.0  | 77.2        |
      | 6  | 31   | 20250620     |                  | 0.0             | 68.28         | 1.48     | 0.0  | 0.0       | 69.76 | 0.0  | 0.0        | 0.0  | 69.76       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 430.0         | 25.76    | 0.0  | 0.0       | 455.76 | 200.0 | 200.0      | 0.0  | 255.76      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241220 | Disbursement     | 430.0  | 0.0       | 0.0      | 0.0  | 0.0       | 430.0        | false    | false    |
      | 20241229 | Accrual          | 2.7    | 0.0       | 2.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241230 | Repayment        | 200.0  | 196.99    | 3.01     | 0.0  | 0.0       | 233.01       | false    | false    |
      | 20241230 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241231 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250101  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250102  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250116  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250117  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250118  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250119  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250120  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20250220"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241220 | Disbursement     | 430.0  | 0.0       | 0.0      | 0.0  | 0.0       | 430.0        | false    | false    |
      | 20241229 | Accrual          | 2.7    | 0.0       | 2.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241230 | Repayment        | 200.0  | 196.99    | 3.01     | 0.0  | 0.0       | 233.01       | false    | false    |
      | 20241230 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241231 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250101  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250102  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250116  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250117  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250118  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250119  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250120  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250121  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250122  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250123  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250124  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250125  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250126  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250127  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250128  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250129  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250130  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250131  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250202 | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250203 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250204 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250205 | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250206 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250207 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250208 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250209 | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250210 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250211 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250212 | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250213 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250214 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250215 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250216 | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250217 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250218 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250219 | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20250322"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241220 | Disbursement     | 430.0  | 0.0       | 0.0      | 0.0  | 0.0       | 430.0        | false    | false    |
      | 20241229 | Accrual          | 2.7    | 0.0       | 2.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241230 | Repayment        | 200.0  | 196.99    | 3.01     | 0.0  | 0.0       | 233.01       | false    | false    |
      | 20241230 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241231 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250101  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250102  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250116  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250117  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250118  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250119  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250120  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250121  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250122  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250123  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250124  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250125  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250126  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250127  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250128  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250129  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250130  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250131  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250202 | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250203 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250204 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250205 | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250206 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250207 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250208 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250209 | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250210 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250211 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250212 | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250213 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250214 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250215 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250216 | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250217 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250218 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250219 | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250220 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250221 | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250222 | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250223 | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250224 | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250225 | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250226 | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250227 | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250228 | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250301    | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250302    | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250303    | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250304    | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250305    | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250306    | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250307    | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250308    | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250309    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250310    | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250311    | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250312    | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250313    | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250314    | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250315    | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250316    | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250317    | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250318    | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250319    | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250320    | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250321    | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3400
  Scenario: Verify Interest Payment Waiver isn't reversed and replayed after one accrual is created
    When Admin sets the business date to "20250112"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_ACCRUAL_ACTIVITY_POSTING | 20250112   | 430            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250112  |           | 430.0           |               |          | 0.0  |           | 0.0    |      |            |      | 0.0         |
      | 1  | 31   | 20250212 |           | 323.44          | 106.56        | 2.51     | 0.0  | 0.0       | 109.07 | 0.0  | 0.0        | 0.0  | 109.07      |
      | 2  | 28   | 20250312    |           | 216.26          | 107.18        | 1.89     | 0.0  | 0.0       | 109.07 | 0.0  | 0.0        | 0.0  | 109.07      |
      | 3  | 31   | 20250412    |           | 108.45          | 107.81        | 1.26     | 0.0  | 0.0       | 109.07 | 0.0  | 0.0        | 0.0  | 109.07      |
      | 4  | 30   | 20250512      |           | 0.0             | 108.45        | 0.63     | 0.0  | 0.0       | 109.08 | 0.0  | 0.0        | 0.0  | 109.08      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 430           | 6.29     | 0    | 0         | 436.29 | 0    | 0          | 0    | 436.29      |
    And Admin successfully approves the loan on "20250112" with "430" amount and expected disbursement date on "20250112"
    And Admin successfully disburse the loan on "20250112" with "430" EUR transaction amount
    When Admin sets the business date to "20250114"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250112  |           | 430.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250212 |           | 323.44          | 106.56        | 2.51     | 0.0  | 0.0       | 109.07 | 0.0  | 0.0        | 0.0  | 109.07      |
      | 2  | 28   | 20250312    |           | 216.26          | 107.18        | 1.89     | 0.0  | 0.0       | 109.07 | 0.0  | 0.0        | 0.0  | 109.07      |
      | 3  | 31   | 20250412    |           | 108.45          | 107.81        | 1.26     | 0.0  | 0.0       | 109.07 | 0.0  | 0.0        | 0.0  | 109.07      |
      | 4  | 30   | 20250512      |           | 0.0             | 108.45        | 0.63     | 0.0  | 0.0       | 109.08 | 0.0  | 0.0        | 0.0  | 109.08      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 430           | 6.29     | 0    | 0         | 436.29 | 0.0  | 0.0        | 0    | 436.29      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250112  | Disbursement     | 430.0  | 0.0       | 0.0      | 0.0  | 0.0       | 430.0        | false    | false    |
      | 20250113  | Accrual          | 0.08   | 0.0       | 0.08     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin makes "INTEREST_PAYMENT_WAIVER" transaction with "AUTOPAY" payment type on "20250114" with 10 EUR transaction amount
    Then In Loan Transactions all transactions have non-null external-id
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250112  |           | 430.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250212 |           | 323.38          | 106.62        | 2.45     | 0.0  | 0.0       | 109.07 | 10.0 | 10.0       | 0.0  | 99.07       |
      | 2  | 28   | 20250312    |           | 216.2           | 107.18        | 1.89     | 0.0  | 0.0       | 109.07 | 0.0  | 0.0        | 0.0  | 109.07      |
      | 3  | 31   | 20250412    |           | 108.39          | 107.81        | 1.26     | 0.0  | 0.0       | 109.07 | 0.0  | 0.0        | 0.0  | 109.07      |
      | 4  | 30   | 20250512      |           | 0.0             | 108.39        | 0.63     | 0.0  | 0.0       | 109.02 | 0.0  | 0.0        | 0.0  | 109.02      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 430           | 6.23     | 0    | 0         | 436.23 | 10.0 | 10.0       | 0    | 426.23      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250112  | Disbursement            | 430.0  | 0.0       | 0.0      | 0.0  | 0.0       | 430.0        | false    | false    |
      | 20250113  | Accrual                 | 0.08   | 0.0       | 0.08     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Interest Payment Waiver | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 420.0        | false    | false    |

  @TestRailId:C3401
  Scenario: Verify that accrual activity is not reverse replayed when undo happens on due date repayment
    When Admin sets the business date to "20240808"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20240808    | 400            | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 12                | MONTHS                | 1              | MONTHS                 | 12                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240808" with "400" amount and expected disbursement date on "20240808"
    When Admin successfully disburse the loan on "20240808" with "400" EUR transaction amount
    When Admin sets the business date to "20250108"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 12 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240808    |           | 400.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240908 |           | 368.53          | 31.47         | 4.07     | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 2  | 30   | 20241008   |           | 336.61          | 31.92         | 3.62     | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 3  | 31   | 20241108  |           | 304.49          | 32.12         | 3.42     | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 4  | 30   | 20241208  |           | 271.94          | 32.55         | 2.99     | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 5  | 31   | 20250108   |           | 239.17          | 32.77         | 2.77     | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 6  | 31   | 20250208  |           | 206.07          | 33.1          | 2.44     | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 7  | 28   | 20250308     |           | 172.43          | 33.64         | 1.9      | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 8  | 31   | 20250408     |           | 138.65          | 33.78         | 1.76     | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 9  | 30   | 20250508       |           | 104.48          | 34.17         | 1.37     | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 10 | 31   | 20250608      |           | 70.0            | 34.48         | 1.06     | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 11 | 30   | 20250708      |           | 35.15           | 34.85         | 0.69     | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 12 | 31   | 20250808    |           | 0.0             | 35.15         | 0.36     | 0.0  | 0.0       | 35.51 | 0.0  | 0.0        | 0.0  | 35.51       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 400.0         | 26.45    | 0.0  | 0.0       | 426.45 | 0.0  | 0.0        | 0.0  | 426.45      |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240808    | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240908 | Accrual Activity | 4.07   | 0.0       | 4.07     | 0.0  | 0.0       | 0.0          |
      | 20241008   | Accrual Activity | 3.62   | 0.0       | 3.62     | 0.0  | 0.0       | 0.0          |
      | 20241108  | Accrual Activity | 3.42   | 0.0       | 3.42     | 0.0  | 0.0       | 0.0          |
      | 20241208  | Accrual Activity | 2.99   | 0.0       | 2.99     | 0.0  | 0.0       | 0.0          |
      | 20250107   | Accrual          | 16.78  | 0.0       | 16.78    | 0.0  | 0.0       | 0.0          |
    And Customer makes "AUTOPAY" repayment on "20250108" with 500 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 12 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240808    |                 | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20240908 | 20250108 | 368.53          | 31.47         | 4.07     | 0.0  | 0.0       | 35.54 | 35.54 | 0.0        | 35.54 | 0.0         |
      | 2  | 30   | 20241008   | 20250108 | 336.61          | 31.92         | 3.62     | 0.0  | 0.0       | 35.54 | 35.54 | 0.0        | 35.54 | 0.0         |
      | 3  | 31   | 20241108  | 20250108 | 304.49          | 32.12         | 3.42     | 0.0  | 0.0       | 35.54 | 35.54 | 0.0        | 35.54 | 0.0         |
      | 4  | 30   | 20241208  | 20250108 | 271.94          | 32.55         | 2.99     | 0.0  | 0.0       | 35.54 | 35.54 | 0.0        | 35.54 | 0.0         |
      | 5  | 31   | 20250108   | 20250108 | 239.17          | 32.77         | 2.77     | 0.0  | 0.0       | 35.54 | 35.54 | 0.0        | 0.0   | 0.0         |
      | 6  | 31   | 20250208  | 20250108 | 206.07          | 33.1          | 2.44     | 0.0  | 0.0       | 35.54 | 35.54 | 35.54      | 0.0   | 0.0         |
      | 7  | 28   | 20250308     | 20250108 | 172.43          | 33.64         | 1.9      | 0.0  | 0.0       | 35.54 | 35.54 | 35.54      | 0.0   | 0.0         |
      | 8  | 31   | 20250408     | 20250108 | 138.65          | 33.78         | 1.76     | 0.0  | 0.0       | 35.54 | 35.54 | 35.54      | 0.0   | 0.0         |
      | 9  | 30   | 20250508       | 20250108 | 104.48          | 34.17         | 1.37     | 0.0  | 0.0       | 35.54 | 35.54 | 35.54      | 0.0   | 0.0         |
      | 10 | 31   | 20250608      | 20250108 | 70.0            | 34.48         | 1.06     | 0.0  | 0.0       | 35.54 | 35.54 | 35.54      | 0.0   | 0.0         |
      | 11 | 30   | 20250708      | 20250108 | 35.15           | 34.85         | 0.69     | 0.0  | 0.0       | 35.54 | 35.54 | 35.54      | 0.0   | 0.0         |
      | 12 | 31   | 20250808    | 20250108 | 0.0             | 35.15         | 0.36     | 0.0  | 0.0       | 35.51 | 35.51 | 35.51      | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      | 400.0         | 26.45    | 0.0  | 0.0       | 426.45 | 426.45 | 248.75     | 142.16 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240808    | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240908 | Accrual Activity | 4.07   | 0.0       | 4.07     | 0.0  | 0.0       | 0.0          |
      | 20241008   | Accrual Activity | 3.62   | 0.0       | 3.62     | 0.0  | 0.0       | 0.0          |
      | 20241108  | Accrual Activity | 3.42   | 0.0       | 3.42     | 0.0  | 0.0       | 0.0          |
      | 20241208  | Accrual Activity | 2.99   | 0.0       | 2.99     | 0.0  | 0.0       | 0.0          |
      | 20250107   | Accrual          | 16.78  | 0.0       | 16.78    | 0.0  | 0.0       | 0.0          |
      | 20250108   | Repayment        | 500.0  | 400.0     | 26.45    | 0.0  | 0.0       | 0.0          |
      | 20250108   | Accrual          | 9.67   | 0.0       | 9.67     | 0.0  | 0.0       | 0.0          |
      | 20250108   | Accrual Activity | 12.35  | 0.0       | 12.35    | 0.0  | 0.0       | 0.0          |
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    When Customer undo "1"th repayment on "20250108"
    Then Loan Repayment schedule has 12 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240808    |           | 400.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240908 |           | 368.53          | 31.47         | 4.07     | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 2  | 30   | 20241008   |           | 336.61          | 31.92         | 3.62     | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 3  | 31   | 20241108  |           | 304.49          | 32.12         | 3.42     | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 4  | 30   | 20241208  |           | 271.94          | 32.55         | 2.99     | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 5  | 31   | 20250108   |           | 239.17          | 32.77         | 2.77     | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 6  | 31   | 20250208  |           | 206.07          | 33.1          | 2.44     | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 7  | 28   | 20250308     |           | 172.43          | 33.64         | 1.9      | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 8  | 31   | 20250408     |           | 138.65          | 33.78         | 1.76     | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 9  | 30   | 20250508       |           | 104.48          | 34.17         | 1.37     | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 10 | 31   | 20250608      |           | 70.0            | 34.48         | 1.06     | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 11 | 30   | 20250708      |           | 35.15           | 34.85         | 0.69     | 0.0  | 0.0       | 35.54 | 0.0  | 0.0        | 0.0  | 35.54       |
      | 12 | 31   | 20250808    |           | 0.0             | 35.15         | 0.36     | 0.0  | 0.0       | 35.51 | 0.0  | 0.0        | 0.0  | 35.51       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 400.0         | 26.45    | 0.0  | 0.0       | 426.45 | 0.0  | 0.0        | 0.0  | 426.45      |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240808    | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        | false    | false    |
      | 20240908 | Accrual Activity | 4.07   | 0.0       | 4.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241008   | Accrual Activity | 3.62   | 0.0       | 3.62     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241108  | Accrual Activity | 3.42   | 0.0       | 3.42     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241208  | Accrual Activity | 2.99   | 0.0       | 2.99     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107   | Accrual          | 16.78  | 0.0       | 16.78    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108   | Repayment        | 500.0  | 400.0     | 26.45    | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20250108   | Accrual          | 9.67   | 0.0       | 9.67     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3444
  Scenario: Verify that interestRecognitionOnDisbursementDate setting is taking into account by apply periodic accrual job - backdated repayment case
    When Admin sets the business date to "20240131"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_RECOGNITION_DISBURSEMENT_DAILY_EMI_360_30_ACCRUAL_ACTIVITY | 20240131   | 2000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    Then Loan Product response contains interestRecognitionOnDisbursementDate flag with value "true"
    And Admin successfully approves the loan on "20240131" with "2000" amount and expected disbursement date on "20240131"
    When Admin successfully disburse the loan on "20240131" with "2000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240131  |           | 2000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 29   | 20240229 |           | 1671.5          | 328.5         | 11.67    | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
      | 2  | 31   | 20240331    |           | 1341.08         | 330.42        | 9.75     | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
      | 3  | 30   | 20240430    |           | 1008.73         | 332.35        | 7.82     | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
      | 4  | 31   | 20240531      |           | 674.44          | 334.29        | 5.88     | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
      | 5  | 30   | 20240630     |           | 338.2           | 336.24        | 3.93     | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
      | 6  | 31   | 20240731     |           | 0.0             | 338.2         | 1.97     | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 2000.0        | 41.02    | 0.0  | 0.0       | 2041.02 | 0.0  | 0.0        | 0.0  | 2041.02     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240131  | Disbursement     | 2000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 2000.0       | false    | false    |
    #run COB for 31 of Jan 2024
    And Admin runs inline COB job for Loan
    #move date to first period due - end of Feb 2024
    When Admin sets the business date to "20240301"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240131  |           | 2000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 29   | 20240229 |           | 1671.5          | 328.5         | 11.67    | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
      | 2  | 31   | 20240331    |           | 1341.14         | 330.36        | 9.81     | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
      | 3  | 30   | 20240430    |           | 1008.79         | 332.35        | 7.82     | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
      | 4  | 31   | 20240531      |           | 674.5           | 334.29        | 5.88     | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
      | 5  | 30   | 20240630     |           | 338.26          | 336.24        | 3.93     | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
      | 6  | 31   | 20240731     |           | 0.0             | 338.26        | 1.97     | 0.0  | 0.0       | 340.23 | 0.0  | 0.0        | 0.0  | 340.23      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 2000.0        | 41.08    | 0.0  | 0.0       | 2041.08 | 0.0  | 0.0        | 0.0  | 2041.08     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240131  | Disbursement     | 2000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 2000.0       | false    | false    |
      | 20240131  | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual          | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual          | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual          | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual          | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual          | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual          | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual Activity | 11.67  | 0.0       | 11.67    | 0.0  | 0.0       | 0.0          | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20240215" with 340.17 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240131  |                  | 2000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 29   | 20240229 | 20240215 | 1665.86         | 334.14        | 6.03     | 0.0  | 0.0       | 340.17 | 340.17 | 340.17     | 0.0  | 0.0         |
      | 2  | 31   | 20240331    |                  | 1340.11         | 325.75        | 14.42    | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 3  | 30   | 20240430    |                  | 1007.76         | 332.35        | 7.82     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 4  | 31   | 20240531      |                  | 673.47          | 334.29        | 5.88     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 5  | 30   | 20240630     |                  | 337.23          | 336.24        | 3.93     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 6  | 31   | 20240731     |                  | 0.0             | 337.23        | 1.97     | 0.0  | 0.0       | 339.2  | 0.0    | 0.0        | 0.0  | 339.2       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 2000.0        | 40.05    | 0.0  | 0.0       | 2040.05 | 340.17 | 340.17     | 0.0  | 1699.88     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240131  | Disbursement     | 2000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 2000.0       | false    | false    |
      | 20240131  | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual          | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual          | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual          | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Repayment        | 340.17 | 334.14    | 6.03     | 0.0  | 0.0       | 1665.86      | false    | false    |
      | 20240216 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual          | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual          | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual          | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual          | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual Activity | 6.03   | 0.0       | 6.03     | 0.0  | 0.0       | 0.0          | false    | true     |
    When Admin sets the business date to "20240401"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240131  |                  | 2000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 29   | 20240229 | 20240215 | 1665.86         | 334.14        | 6.03     | 0.0  | 0.0       | 340.17 | 340.17 | 340.17     | 0.0  | 0.0         |
      | 2  | 31   | 20240331    |                  | 1340.11         | 325.75        | 14.42    | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 3  | 30   | 20240430    |                  | 1007.82         | 332.29        | 7.88     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 4  | 31   | 20240531      |                  | 673.53          | 334.29        | 5.88     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 5  | 30   | 20240630     |                  | 337.29          | 336.24        | 3.93     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 6  | 31   | 20240731     |                  | 0.0             | 337.29        | 1.97     | 0.0  | 0.0       | 339.26 | 0.0    | 0.0        | 0.0  | 339.26      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 2000.0        | 40.11    | 0.0  | 0.0       | 2040.11 | 340.17 | 340.17     | 0.0  | 1699.94     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240131  | Disbursement       | 2000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 2000.0       | false    | false    |
      | 20240131  | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual            | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual            | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual            | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual            | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Repayment          | 340.17 | 334.14    | 6.03     | 0.0  | 0.0       | 1665.86      | false    | false    |
      | 20240216 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual            | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual            | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual            | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual            | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual            | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual Activity   | 6.03   | 0.0       | 6.03     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20240301    | Accrual Adjustment | 0.69   | 0.0       | 0.69     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual            | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual            | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual            | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual            | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual            | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual            | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual            | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual            | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual            | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Accrual            | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual            | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual            | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual            | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual            | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual            | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual            | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual            | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual            | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual            | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual            | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual            | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual            | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual            | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual            | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual            | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual            | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual            | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual            | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Accrual            | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual            | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual Activity   | 14.42  | 0.0       | 14.42    | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3503
  Scenario: Verify accruals on closed or overpaid backdated loan with current date before installment date with due-date charge config option - UC1
    When Global config "charge-accrual-date" value set to "due-date"
    When Admin sets the business date to "20250120"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 800            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "800" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "800" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 800.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 600.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
      | 2  | 28   | 20250301    |           | 400.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
      | 3  | 31   | 20250401    |           | 200.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
      | 4  | 30   | 20250501      |           | 0.0             | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 800.0         | 0.0      | 0.0  | 0.0       | 800.0 | 0.0  | 0.0        | 0.0  | 800.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250110" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 800.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 600.0           | 200.0         | 0.0      | 0.0  | 20.0      | 220.0 | 0.0  | 0.0        | 0.0  | 220.0       |
      | 2  | 28   | 20250301    |           | 400.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
      | 3  | 31   | 20250401    |           | 200.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
      | 4  | 30   | 20250501      |           | 0.0             | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 800.0         | 0.0      | 0.0  | 20.0      | 820.0 | 0.0  | 0.0        | 0.0  | 820.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
    Then Loan Charges tab has a given charge with the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20250110 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    And Customer makes "AUTOPAY" repayment on "20250116" with 820 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250101  |                 | 800.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20250201 | 20250116 | 600.0           | 200.0         | 0.0      | 0.0  | 20.0      | 220.0 | 220.0 | 220.0      | 0.0  | 0.0         |
      | 2  | 28   | 20250301    | 20250116 | 400.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 200.0 | 200.0      | 0.0  | 0.0         |
      | 3  | 31   | 20250401    | 20250116 | 200.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 200.0 | 200.0      | 0.0  | 0.0         |
      | 4  | 30   | 20250501      | 20250116 | 0.0             | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 200.0 | 200.0      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 800.0         | 0.0      | 0.0  | 20.0      | 820.0 | 820.0 | 820.0      | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20250116  | Repayment        | 820.0  | 800.0     | 0.0      | 0.0  | 20.0      | 0.0          | false    | false    |
      | 20250116  | Accrual Activity | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          | false    | false    |
      | 20250120  | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          | false    | false    |
    Then Loan Charges tab has a given charge with the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20250110 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    When Global config "charge-accrual-date" value set to "due-date"

  @TestRailId:C3504
  Scenario: Verify accruals on closed or overpaid backdated loan with current date after installment date with due-date charge config option - UC2
    When Global config "charge-accrual-date" value set to "due-date"
    When Admin sets the business date to "20250217"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 800            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "800" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "800" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 800.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 600.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
      | 2  | 28   | 20250301    |           | 400.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
      | 3  | 31   | 20250401    |           | 200.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
      | 4  | 30   | 20250501      |           | 0.0             | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 800.0         | 0.0      | 0.0  | 0.0       | 800.0 | 0.0  | 0.0        | 0.0  | 800.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250110" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 800.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 600.0           | 200.0         | 0.0      | 0.0  | 20.0      | 220.0 | 0.0  | 0.0        | 0.0  | 220.0       |
      | 2  | 28   | 20250301    |           | 400.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
      | 3  | 31   | 20250401    |           | 200.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
      | 4  | 30   | 20250501      |           | 0.0             | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 800.0         | 0.0      | 0.0  | 20.0      | 820.0 | 0.0  | 0.0        | 0.0  | 820.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
    Then Loan Charges tab has a given charge with the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20250110 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    And Customer makes "AUTOPAY" repayment on "20250116" with 820 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250101  |                 | 800.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20250201 | 20250116 | 600.0           | 200.0         | 0.0      | 0.0  | 20.0      | 220.0 | 220.0 | 220.0      | 0.0  | 0.0         |
      | 2  | 28   | 20250301    | 20250116 | 400.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 200.0 | 200.0      | 0.0  | 0.0         |
      | 3  | 31   | 20250401    | 20250116 | 200.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 200.0 | 200.0      | 0.0  | 0.0         |
      | 4  | 30   | 20250501      | 20250116 | 0.0             | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 200.0 | 200.0      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 800.0         | 0.0      | 0.0  | 20.0      | 820.0 | 820.0 | 820.0      | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20250116  | Repayment        | 820.0  | 800.0     | 0.0      | 0.0  | 20.0      | 0.0          | false    | false    |
      | 20250116  | Accrual Activity | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          | false    | false    |
      | 20250217 | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          | false    | false    |
    Then Loan Charges tab has a given charge with the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20250110 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    When Global config "charge-accrual-date" value set to "due-date"

  @TestRailId:C3505
  Scenario: Verify accruals on closed or overpaid backdated loan with current date before installment date with submitted-date charge config option - UC3
    When Global config "charge-accrual-date" value set to "submitted-date"
    When Admin sets the business date to "20250120"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 800            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "800" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "800" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 800.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 600.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
      | 2  | 28   | 20250301    |           | 400.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
      | 3  | 31   | 20250401    |           | 200.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
      | 4  | 30   | 20250501      |           | 0.0             | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 800.0         | 0.0      | 0.0  | 0.0       | 800.0 | 0.0  | 0.0        | 0.0  | 800.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250110" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 800.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 600.0           | 200.0         | 0.0      | 0.0  | 20.0      | 220.0 | 0.0  | 0.0        | 0.0  | 220.0       |
      | 2  | 28   | 20250301    |           | 400.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
      | 3  | 31   | 20250401    |           | 200.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
      | 4  | 30   | 20250501      |           | 0.0             | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 800.0         | 0.0      | 0.0  | 20.0      | 820.0 | 0.0  | 0.0        | 0.0  | 820.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
    Then Loan Charges tab has a given charge with the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20250110 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    And Customer makes "AUTOPAY" repayment on "20250116" with 820 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250101  |                 | 800.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20250201 | 20250116 | 600.0           | 200.0         | 0.0      | 0.0  | 20.0      | 220.0 | 220.0 | 220.0      | 0.0  | 0.0         |
      | 2  | 28   | 20250301    | 20250116 | 400.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 200.0 | 200.0      | 0.0  | 0.0         |
      | 3  | 31   | 20250401    | 20250116 | 200.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 200.0 | 200.0      | 0.0  | 0.0         |
      | 4  | 30   | 20250501      | 20250116 | 0.0             | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 200.0 | 200.0      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 800.0         | 0.0      | 0.0  | 20.0      | 820.0 | 820.0 | 820.0      | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20250116  | Repayment        | 820.0  | 800.0     | 0.0      | 0.0  | 20.0      | 0.0          | false    | false    |
      | 20250116  | Accrual Activity | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          | false    | false    |
      | 20250120  | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          | false    | false    |
    Then Loan Charges tab has a given charge with the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20250110 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    When Global config "charge-accrual-date" value set to "due-date"

  @TestRailId:C3506
  Scenario: Verify accruals on closed or overpaid backdated loan with current date after installment date with ігиьшееув-date charge config option - UC4
    When Global config "charge-accrual-date" value set to "submitted-date"
    When Admin sets the business date to "20250217"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 800            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "800" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "800" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 800.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 600.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
      | 2  | 28   | 20250301    |           | 400.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
      | 3  | 31   | 20250401    |           | 200.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
      | 4  | 30   | 20250501      |           | 0.0             | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 800.0         | 0.0      | 0.0  | 0.0       | 800.0 | 0.0  | 0.0        | 0.0  | 800.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250110" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 800.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 600.0           | 200.0         | 0.0      | 0.0  | 20.0      | 220.0 | 0.0  | 0.0        | 0.0  | 220.0       |
      | 2  | 28   | 20250301    |           | 400.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
      | 3  | 31   | 20250401    |           | 200.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
      | 4  | 30   | 20250501      |           | 0.0             | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 800.0         | 0.0      | 0.0  | 20.0      | 820.0 | 0.0  | 0.0        | 0.0  | 820.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
    Then Loan Charges tab has a given charge with the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20250110 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    And Customer makes "AUTOPAY" repayment on "20250116" with 820 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250101  |                 | 800.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20250201 | 20250116 | 600.0           | 200.0         | 0.0      | 0.0  | 20.0      | 220.0 | 220.0 | 220.0      | 0.0  | 0.0         |
      | 2  | 28   | 20250301    | 20250116 | 400.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 200.0 | 200.0      | 0.0  | 0.0         |
      | 3  | 31   | 20250401    | 20250116 | 200.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 200.0 | 200.0      | 0.0  | 0.0         |
      | 4  | 30   | 20250501      | 20250116 | 0.0             | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 200.0 | 200.0      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 800.0         | 0.0      | 0.0  | 20.0      | 820.0 | 820.0 | 820.0      | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20250116  | Repayment        | 820.0  | 800.0     | 0.0      | 0.0  | 20.0      | 0.0          | false    | false    |
      | 20250116  | Accrual Activity | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          | false    | false    |
      | 20250217 | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          | false    | false    |
    Then Loan Charges tab has a given charge with the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20250110 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    When Global config "charge-accrual-date" value set to "due-date"

  @TestRailId:C3507
  Scenario: Verify calculation of fraction period in case `interestRecognitionFromDisbursementDate` is true
    When Admin sets the business date to "20231113"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_RECOGNITION_DISBURSEMENT_DAILY_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20231113  | 5000           | 9.99                   | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231113" with "5000" amount and expected disbursement date on "20231113"
    When Admin successfully disburse the loan on "20231113" with "5000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20231113 |           | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20231213 |           | 4183.33         | 816.67        | 41.05    | 0.0  | 0.0       | 857.72 | 0.0  | 0.0        | 0.0  | 857.72      |
      | 2  | 31   | 20240113  |           | 3361.07         | 822.26        | 35.46    | 0.0  | 0.0       | 857.72 | 0.0  | 0.0        | 0.0  | 857.72      |
      | 3  | 31   | 20240213 |           | 2531.79         | 829.28        | 28.44    | 0.0  | 0.0       | 857.72 | 0.0  | 0.0        | 0.0  | 857.72      |
      | 4  | 29   | 20240313    |           | 1694.11         | 837.68        | 20.04    | 0.0  | 0.0       | 857.72 | 0.0  | 0.0        | 0.0  | 857.72      |
      | 5  | 31   | 20240413    |           | 850.72          | 843.39        | 14.33    | 0.0  | 0.0       | 857.72 | 0.0  | 0.0        | 0.0  | 857.72      |
      | 6  | 30   | 20240513      |           | 0.0             | 850.72        | 6.97     | 0.0  | 0.0       | 857.69 | 0.0  | 0.0        | 0.0  | 857.69      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 5000.0        | 146.29   | 0.0  | 0.0       | 5146.29 | 0.0  | 0.0        | 0.0  | 5146.29     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20231113 | Disbursement     | 5000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       | false    | false    |
    When Admin sets the business date to "20231210"
    And Customer makes "AUTOPAY" repayment on "20231210" with 857.72 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20231113 |                  | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 30   | 20231213 | 20231210 | 4179.23         | 820.77        | 36.95    | 0.0  | 0.0       | 857.72 | 857.72 | 857.72     | 0.0  | 0.0         |
      | 2  | 31   | 20240113  |                  | 3360.36         | 818.87        | 38.85    | 0.0  | 0.0       | 857.72 | 0.0    | 0.0        | 0.0  | 857.72      |
      | 3  | 31   | 20240213 |                  | 2531.07         | 829.29        | 28.43    | 0.0  | 0.0       | 857.72 | 0.0    | 0.0        | 0.0  | 857.72      |
      | 4  | 29   | 20240313    |                  | 1693.38         | 837.69        | 20.03    | 0.0  | 0.0       | 857.72 | 0.0    | 0.0        | 0.0  | 857.72      |
      | 5  | 31   | 20240413    |                  | 849.99          | 843.39        | 14.33    | 0.0  | 0.0       | 857.72 | 0.0    | 0.0        | 0.0  | 857.72      |
      | 6  | 30   | 20240513      |                  | 0.0             | 849.99        | 6.96     | 0.0  | 0.0       | 856.95 | 0.0    | 0.0        | 0.0  | 856.95      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 5000.0        | 145.55   | 0.0  | 0.0       | 5145.55 | 857.72 | 857.72     | 0.0  | 4287.83     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20231113 | Disbursement     | 5000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       | false    | false    |
      | 20231210 | Repayment        | 857.72 | 820.77    | 36.95    | 0.0  | 0.0       | 4179.23      | false    | false    |

  @TestRailId:C3522
  Scenario: Verify that interestRecognitionOnDisbursementDate setting is taking into account by apply periodic accrual job - payment on time for each period
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_RECOGNITION_DISBURSEMENT_DAILY_EMI_360_30_ACCRUAL_ACTIVITY | 20240101   | 200            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    Then Loan Product response contains interestRecognitionOnDisbursementDate flag with value "true"
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "200" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 200.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 167.15          | 32.85         | 1.17     | 0.0  | 0.0       | 34.02 | 0.0  | 0.0        | 0.0  | 34.02       |
      | 2  | 29   | 20240301    |           | 134.11          | 33.04         | 0.98     | 0.0  | 0.0       | 34.02 | 0.0  | 0.0        | 0.0  | 34.02       |
      | 3  | 31   | 20240401    |           | 100.87          | 33.24         | 0.78     | 0.0  | 0.0       | 34.02 | 0.0  | 0.0        | 0.0  | 34.02       |
      | 4  | 30   | 20240501      |           | 67.44           | 33.43         | 0.59     | 0.0  | 0.0       | 34.02 | 0.0  | 0.0        | 0.0  | 34.02       |
      | 5  | 31   | 20240601     |           | 33.81           | 33.63         | 0.39     | 0.0  | 0.0       | 34.02 | 0.0  | 0.0        | 0.0  | 34.02       |
      | 6  | 30   | 20240701     |           | 0.0             | 33.81         | 0.2      | 0.0  | 0.0       | 34.01 | 0.0  | 0.0        | 0.0  | 34.01       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 200.0         | 4.11     | 0.0  | 0.0       | 204.11 | 0.0  | 0.0        | 0.0  | 204.11      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
    #run COB for 01st of Jan 2024
    And Admin runs inline COB job for Loan
    #move date to first period due - beginning of Feb 2024
    When Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240201" with 34.02 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 167.15          | 32.85         | 1.17     | 0.0  | 0.0       | 34.02 | 34.02 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 134.11          | 33.04         | 0.98     | 0.0  | 0.0       | 34.02 | 0.0   | 0.0        | 0.0  | 34.02       |
      | 3  | 31   | 20240401    |                  | 100.87          | 33.24         | 0.78     | 0.0  | 0.0       | 34.02 | 0.0   | 0.0        | 0.0  | 34.02       |
      | 4  | 30   | 20240501      |                  | 67.44           | 33.43         | 0.59     | 0.0  | 0.0       | 34.02 | 0.0   | 0.0        | 0.0  | 34.02       |
      | 5  | 31   | 20240601     |                  | 33.81           | 33.63         | 0.39     | 0.0  | 0.0       | 34.02 | 0.0   | 0.0        | 0.0  | 34.02       |
      | 6  | 30   | 20240701     |                  | 0.0             | 33.81         | 0.2      | 0.0  | 0.0       | 34.01 | 0.0   | 0.0        | 0.0  | 34.01       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 200.0         | 4.11     | 0.0  | 0.0       | 204.11 | 34.02 | 0.0        | 0.0  | 170.09      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
      | 20240101  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Repayment        | 34.02  | 32.85     | 1.17     | 0.0  | 0.0       | 167.15       | false    | false    |
    When Admin sets the business date to "20240301"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240301" with 34.02 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 167.15          | 32.85         | 1.17     | 0.0  | 0.0       | 34.02 | 34.02 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 134.11          | 33.04         | 0.98     | 0.0  | 0.0       | 34.02 | 34.02 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    |                  | 100.87          | 33.24         | 0.78     | 0.0  | 0.0       | 34.02 | 0.0   | 0.0        | 0.0  | 34.02       |
      | 4  | 30   | 20240501      |                  | 67.44           | 33.43         | 0.59     | 0.0  | 0.0       | 34.02 | 0.0   | 0.0        | 0.0  | 34.02       |
      | 5  | 31   | 20240601     |                  | 33.81           | 33.63         | 0.39     | 0.0  | 0.0       | 34.02 | 0.0   | 0.0        | 0.0  | 34.02       |
      | 6  | 30   | 20240701     |                  | 0.0             | 33.81         | 0.2      | 0.0  | 0.0       | 34.01 | 0.0   | 0.0        | 0.0  | 34.01       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 200.0         | 4.11     | 0.0  | 0.0       | 204.11 | 68.04 | 0.0        | 0.0  | 136.07      |
    When Admin sets the business date to "20240401"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240401" with 34.02 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 167.15          | 32.85         | 1.17     | 0.0  | 0.0       | 34.02 | 34.02 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 134.11          | 33.04         | 0.98     | 0.0  | 0.0       | 34.02 | 34.02 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401    | 100.87          | 33.24         | 0.78     | 0.0  | 0.0       | 34.02 | 34.02 | 0.0        | 0.0  | 0.0         |
      | 4  | 30   | 20240501      |                  | 67.44           | 33.43         | 0.59     | 0.0  | 0.0       | 34.02 | 0.0   | 0.0        | 0.0  | 34.02       |
      | 5  | 31   | 20240601     |                  | 33.81           | 33.63         | 0.39     | 0.0  | 0.0       | 34.02 | 0.0   | 0.0        | 0.0  | 34.02       |
      | 6  | 30   | 20240701     |                  | 0.0             | 33.81         | 0.2      | 0.0  | 0.0       | 34.01 | 0.0   | 0.0        | 0.0  | 34.01       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 200.0         | 4.11     | 0.0  | 0.0       | 204.11 | 102.06 | 0.0        | 0.0  | 102.05      |
    When Admin sets the business date to "20240501"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240501" with 34.02 EUR transaction amount
    #And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 167.15          | 32.85         | 1.17     | 0.0  | 0.0       | 34.02 | 34.02 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 134.11          | 33.04         | 0.98     | 0.0  | 0.0       | 34.02 | 34.02 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401    | 100.87          | 33.24         | 0.78     | 0.0  | 0.0       | 34.02 | 34.02 | 0.0        | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240501      | 67.44           | 33.43         | 0.59     | 0.0  | 0.0       | 34.02 | 34.02 | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20240601     |                  | 33.81           | 33.63         | 0.39     | 0.0  | 0.0       | 34.02 | 0.0   | 0.0        | 0.0  | 34.02       |
      | 6  | 30   | 20240701     |                  | 0.0             | 33.81         | 0.2      | 0.0  | 0.0       | 34.01 | 0.0   | 0.0        | 0.0  | 34.01       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 200.0         | 4.11     | 0.0  | 0.0       | 204.11 | 136.08 | 0.0        | 0.0  | 68.03       |
    When Admin sets the business date to "20240601"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240601" with 34.02 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 167.15          | 32.85         | 1.17     | 0.0  | 0.0       | 34.02 | 34.02 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 134.11          | 33.04         | 0.98     | 0.0  | 0.0       | 34.02 | 34.02 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401    | 100.87          | 33.24         | 0.78     | 0.0  | 0.0       | 34.02 | 34.02 | 0.0        | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240501      | 67.44           | 33.43         | 0.59     | 0.0  | 0.0       | 34.02 | 34.02 | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20240601     | 20240601     | 33.81           | 33.63         | 0.39     | 0.0  | 0.0       | 34.02 | 34.02 | 0.0        | 0.0  | 0.0         |
      | 6  | 30   | 20240701     |                  | 0.0             | 33.81         | 0.2      | 0.0  | 0.0       | 34.01 | 0.0   | 0.0        | 0.0  | 34.01       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 200.0         | 4.11     | 0.0  | 0.0       | 204.11 | 170.1 | 0.0        | 0.0  | 34.01       |
    When Admin sets the business date to "20240701"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240701" with 34.01 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 167.15          | 32.85         | 1.17     | 0.0  | 0.0       | 34.02 | 34.02 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 134.11          | 33.04         | 0.98     | 0.0  | 0.0       | 34.02 | 34.02 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401    | 100.87          | 33.24         | 0.78     | 0.0  | 0.0       | 34.02 | 34.02 | 0.0        | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240501      | 67.44           | 33.43         | 0.59     | 0.0  | 0.0       | 34.02 | 34.02 | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20240601     | 20240601     | 33.81           | 33.63         | 0.39     | 0.0  | 0.0       | 34.02 | 34.02 | 0.0        | 0.0  | 0.0         |
      | 6  | 30   | 20240701     | 20240701     | 0.0             | 33.81         | 0.2      | 0.0  | 0.0       | 34.01 | 34.01 | 0.0        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 200.0         | 4.11     | 0.0  | 0.0       | 204.11 | 204.11 | 0.0        | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
      | 20240101  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Repayment        | 34.02  | 32.85     | 1.17     | 0.0  | 0.0       | 167.15       | false    | false    |
      | 20240201 | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual Activity | 1.17   | 0.0       | 1.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual          | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Repayment        | 34.02  | 33.04     | 0.98     | 0.0  | 0.0       | 134.11       | false    | false    |
      | 20240301    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.98   | 0.0       | 0.98     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Repayment        | 34.02  | 33.24     | 0.78     | 0.0  | 0.0       | 100.87       | false    | false    |
      | 20240401    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Accrual Activity | 0.78   | 0.0       | 0.78     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240402    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240403    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240404    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240405    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240406    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240407    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240408    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240409    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240410    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240411    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240412    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240413    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240414    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240415    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240416    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240417    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240418    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240419    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240420    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240421    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240422    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240423    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240424    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240425    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240426    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240427    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240428    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240429    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240430    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Repayment        | 34.02  | 33.43     | 0.59     | 0.0  | 0.0       | 67.44        | false    | false    |
      | 20240501      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Accrual Activity | 0.59   | 0.0       | 0.59     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240502      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240503      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240504      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240505      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240506      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240507      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240508      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240509      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240510      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240511      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240512      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240513      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240514      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240515      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240516      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240517      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240518      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240519      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240520      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240521      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240522      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240523      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240524      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240525      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240526      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240527      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240528      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240529      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240530      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240531      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240601     | Repayment        | 34.02  | 33.63     | 0.39     | 0.0  | 0.0       | 33.81        | false    | false    |
      | 20240601     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240601     | Accrual Activity | 0.39   | 0.0       | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240601     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240603     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240604     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240606     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240607     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240609     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240610     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240612     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240613     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240615     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240616     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240618     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240620     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240621     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240623     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240624     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240626     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240627     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240629     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240630     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240701     | Repayment        | 34.01  | 33.81     | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240701     | Accrual Activity | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3523
  Scenario: Verify that interestRecognitionOnDisbursementDate setting is taking into account by apply periodic accrual job - early repayment
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_RECOGNITION_DISBURSEMENT_DAILY_EMI_360_30_ACCRUAL_ACTIVITY | 20240101   | 2000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    Then Loan Product response contains interestRecognitionOnDisbursementDate flag with value "true"
    And Admin successfully approves the loan on "20240101" with "2000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "2000" EUR transaction amount
    #run COB for 01st of Jan 2024
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 2000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 1671.5          | 328.5         | 11.67    | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
      | 2  | 29   | 20240301    |           | 1341.08         | 330.42        | 9.75     | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
      | 3  | 31   | 20240401    |           | 1008.73         | 332.35        | 7.82     | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
      | 4  | 30   | 20240501      |           | 674.44          | 334.29        | 5.88     | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
      | 5  | 31   | 20240601     |           | 338.2           | 336.24        | 3.93     | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
      | 6  | 30   | 20240701     |           | 0.0             | 338.2         | 1.97     | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 2000.0        | 41.02    | 0.0  | 0.0       | 2041.02 | 0.0  | 0.0        | 0.0  | 2041.02     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 2000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 2000.0       | false    | false    |
    When Admin sets the business date to "20240115"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240115" with 340.17 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 2000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 | 20240115 | 1665.1          | 334.9         | 5.27     | 0.0  | 0.0       | 340.17 | 340.17 | 340.17     | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                 | 1339.97         | 325.13        | 15.04    | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 3  | 31   | 20240401    |                 | 1007.62         | 332.35        | 7.82     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 4  | 30   | 20240501      |                 | 673.33          | 334.29        | 5.88     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 5  | 31   | 20240601     |                 | 337.09          | 336.24        | 3.93     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 6  | 30   | 20240701     |                 | 0.0             | 337.09        | 1.97     | 0.0  | 0.0       | 339.06 | 0.0    | 0.0        | 0.0  | 339.06      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 2000.0        | 39.91    | 0.0  | 0.0       | 2039.91 | 340.17 | 340.17     | 0.0  | 1699.74     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 2000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 2000.0       | false    | false    |
      | 20240101  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual          | 0.37   | 0.0       | 0.37     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.37   | 0.0       | 0.37     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.37   | 0.0       | 0.37     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual          | 0.37   | 0.0       | 0.37     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual          | 0.37   | 0.0       | 0.37     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Repayment        | 340.17 | 334.9     | 5.27     | 0.0  | 0.0       | 1665.1       | false    | false    |
     #move date to first period due - beginning of Feb 2024
    When Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    When Admin sets the business date to "20240301"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240301" with 340.17 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 2000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 | 20240115 | 1665.1          | 334.9         | 5.27     | 0.0  | 0.0       | 340.17 | 340.17 | 340.17     | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301   | 1339.97         | 325.13        | 15.04    | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    |                 | 1007.62         | 332.35        | 7.82     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 4  | 30   | 20240501      |                 | 673.33          | 334.29        | 5.88     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 5  | 31   | 20240601     |                 | 337.09          | 336.24        | 3.93     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 6  | 30   | 20240701     |                 | 0.0             | 337.09        | 1.97     | 0.0  | 0.0       | 339.06 | 0.0    | 0.0        | 0.0  | 339.06      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 2000.0        | 39.91    | 0.0  | 0.0       | 2039.91 | 680.34 | 340.17     | 0.0  | 1359.57     |
    When Admin sets the business date to "20240401"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240401" with 340.17 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 2000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 | 20240115 | 1665.1          | 334.9         | 5.27     | 0.0  | 0.0       | 340.17 | 340.17 | 340.17     | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301   | 1339.97         | 325.13        | 15.04    | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401   | 1007.62         | 332.35        | 7.82     | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 4  | 30   | 20240501      |                 | 673.33          | 334.29        | 5.88     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 5  | 31   | 20240601     |                 | 337.09          | 336.24        | 3.93     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 6  | 30   | 20240701     |                 | 0.0             | 337.09        | 1.97     | 0.0  | 0.0       | 339.06 | 0.0    | 0.0        | 0.0  | 339.06      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 2000.0        | 39.91    | 0.0  | 0.0       | 2039.91 | 1020.51 | 340.17     | 0.0  | 1019.4      |
    When Admin sets the business date to "20240501"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240501" with 340.17 EUR transaction amount
    #And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 2000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 | 20240115 | 1665.1          | 334.9         | 5.27     | 0.0  | 0.0       | 340.17 | 340.17 | 340.17     | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301   | 1339.97         | 325.13        | 15.04    | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401   | 1007.62         | 332.35        | 7.82     | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240501     | 673.33          | 334.29        | 5.88     | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20240601     |                 | 337.09          | 336.24        | 3.93     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 6  | 30   | 20240701     |                 | 0.0             | 337.09        | 1.97     | 0.0  | 0.0       | 339.06 | 0.0    | 0.0        | 0.0  | 339.06      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 2000.0        | 39.91    | 0.0  | 0.0       | 2039.91 | 1360.68 | 340.17     | 0.0  | 679.23      |
    When Admin sets the business date to "20240601"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240601" with 340.17 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 2000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 | 20240115 | 1665.1          | 334.9         | 5.27     | 0.0  | 0.0       | 340.17 | 340.17 | 340.17     | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301   | 1339.97         | 325.13        | 15.04    | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401   | 1007.62         | 332.35        | 7.82     | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240501     | 673.33          | 334.29        | 5.88     | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20240601     | 20240601    | 337.09          | 336.24        | 3.93     | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 6  | 30   | 20240701     |                 | 0.0             | 337.09        | 1.97     | 0.0  | 0.0       | 339.06 | 0.0    | 0.0        | 0.0  | 339.06      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 2000.0        | 39.91    | 0.0  | 0.0       | 2039.91 | 1700.85 | 340.17     | 0.0  | 339.06      |
    When Admin sets the business date to "20240701"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240701" with 340.17 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 2000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 | 20240115 | 1665.1          | 334.9         | 5.27     | 0.0  | 0.0       | 340.17 | 340.17 | 340.17     | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301   | 1339.97         | 325.13        | 15.04    | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401   | 1007.62         | 332.35        | 7.82     | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240501     | 673.33          | 334.29        | 5.88     | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20240601     | 20240601    | 337.09          | 336.24        | 3.93     | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 6  | 30   | 20240701     | 20240701    | 0.0             | 337.09        | 1.97     | 0.0  | 0.0       | 339.06 | 339.06 | 0.0        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 2000.0        | 39.91    | 0.0  | 0.0       | 2039.91 | 2039.91 | 340.17     | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 2000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 2000.0       | false    | false    |
      | 20240101  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual          | 0.37   | 0.0       | 0.37     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.37   | 0.0       | 0.37     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.37   | 0.0       | 0.37     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual          | 0.37   | 0.0       | 0.37     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual          | 0.37   | 0.0       | 0.37     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Repayment        | 340.17 | 334.9     | 5.27     | 0.0  | 0.0       | 1665.1       | false    | false    |
      | 20240115  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual Activity | 5.27   | 0.0       | 5.27     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Repayment        | 340.17 | 325.13    | 15.04    | 0.0  | 0.0       | 1339.97      | false    | false    |
      | 20240301    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 15.04  | 0.0       | 15.04    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual          | 0.26   | 0.0       | 0.26     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual          | 0.26   | 0.0       | 0.26     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual          | 0.26   | 0.0       | 0.26     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual          | 0.26   | 0.0       | 0.26     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual          | 0.26   | 0.0       | 0.26     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual          | 0.26   | 0.0       | 0.26     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual          | 0.26   | 0.0       | 0.26     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Repayment        | 340.17 | 332.35    | 7.82     | 0.0  | 0.0       | 1007.62      | false    | false    |
      | 20240401    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Accrual Activity | 7.82   | 0.0       | 7.82     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240402    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240403    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240404    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240405    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240406    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240407    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240408    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240409    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240410    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240411    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240412    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240413    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240414    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240415    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240416    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240417    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240418    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240419    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240420    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240421    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240422    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240423    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240424    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240425    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240426    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240427    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240428    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240429    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240430    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Repayment        | 340.17 | 334.29    | 5.88     | 0.0  | 0.0       | 673.33       | false    | false    |
      | 20240501      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Accrual Activity | 5.88   | 0.0       | 5.88     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240502      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240503      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240504      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240505      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240506      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240507      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240508      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240509      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240510      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240511      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240512      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240513      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240514      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240515      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240516      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240517      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240518      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240519      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240520      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240521      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240522      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240523      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240524      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240525      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240526      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240527      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240528      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240529      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240530      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240531      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240601     | Repayment        | 340.17 | 336.24    | 3.93     | 0.0  | 0.0       | 337.09       | false    | false    |
      | 20240601     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240601     | Accrual Activity | 3.93   | 0.0       | 3.93     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240602     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240603     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240604     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240605     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240606     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240607     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240608     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240609     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240610     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240611     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240612     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240613     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240614     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240615     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240616     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240617     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240618     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240619     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240620     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240621     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240622     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240623     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240624     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240625     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240626     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240627     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240628     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240629     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240630     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240701     | Repayment        | 340.17 | 337.09    | 1.97     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240701     | Accrual Activity | 1.97   | 0.0       | 1.97     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3524
  Scenario: Verify that interestRecognitionOnDisbursementDate setting is taking into account by apply periodic accrual job - early repayment on disbursement date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_RECOGNITION_DISBURSEMENT_DAILY_EMI_360_30_ACCRUAL_ACTIVITY | 20240101   | 2000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    Then Loan Product response contains interestRecognitionOnDisbursementDate flag with value "true"
    And Admin successfully approves the loan on "20240101" with "2000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "2000" EUR transaction amount
    #run COB for 01st of Jan 2024
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 2000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 1671.5          | 328.5         | 11.67    | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
      | 2  | 29   | 20240301    |           | 1341.08         | 330.42        | 9.75     | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
      | 3  | 31   | 20240401    |           | 1008.73         | 332.35        | 7.82     | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
      | 4  | 30   | 20240501      |           | 674.44          | 334.29        | 5.88     | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
      | 5  | 31   | 20240601     |           | 338.2           | 336.24        | 3.93     | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
      | 6  | 30   | 20240701     |           | 0.0             | 338.2         | 1.97     | 0.0  | 0.0       | 340.17 | 0.0  | 0.0        | 0.0  | 340.17      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 2000.0        | 41.02    | 0.0  | 0.0       | 2041.02 | 0.0  | 0.0        | 0.0  | 2041.02     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 2000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 2000.0       | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20240101" with 340.17 EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 2000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 | 20240101 | 1659.83         | 340.17        | 0.0      | 0.0  | 0.0       | 340.17 | 340.17 | 340.17     | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                 | 1339.02         | 320.81        | 19.36    | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 3  | 31   | 20240401    |                 | 1006.66         | 332.36        | 7.81     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 4  | 30   | 20240501      |                 | 672.36          | 334.3         | 5.87     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 5  | 31   | 20240601     |                 | 336.11          | 336.25        | 3.92     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 6  | 30   | 20240701     |                 | 0.0             | 336.11        | 1.96     | 0.0  | 0.0       | 338.07 | 0.0    | 0.0        | 0.0  | 338.07      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 2000.0        | 38.92    | 0.0  | 0.0       | 2038.92 | 340.17 | 340.17     | 0.0  | 1698.75     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 2000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 2000.0       | false    | false    |
      | 20240101  | Repayment        | 340.17 | 340.17    | 0.0      | 0.0  | 0.0       | 1659.83      | false    | false    |
     #move date to first period due - beginning of Feb 2024
    When Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    When Admin sets the business date to "20240301"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240301" with 340.17 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 2000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 | 20240101 | 1659.83         | 340.17        | 0.0      | 0.0  | 0.0       | 340.17 | 340.17 | 340.17     | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301   | 1339.02         | 320.81        | 19.36    | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    |                 | 1006.66         | 332.36        | 7.81     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 4  | 30   | 20240501      |                 | 672.36          | 334.3         | 5.87     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 5  | 31   | 20240601     |                 | 336.11          | 336.25        | 3.92     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 6  | 30   | 20240701     |                 | 0.0             | 336.11        | 1.96     | 0.0  | 0.0       | 338.07 | 0.0    | 0.0        | 0.0  | 338.07      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 2000.0        | 38.92    | 0.0  | 0.0       | 2038.92 | 680.34 | 340.17     | 0.0  | 1358.58     |
    When Admin sets the business date to "20240401"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240401" with 340.17 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 2000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 | 20240101 | 1659.83         | 340.17        | 0.0      | 0.0  | 0.0       | 340.17 | 340.17 | 340.17     | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301   | 1339.02         | 320.81        | 19.36    | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401   | 1006.66         | 332.36        | 7.81     | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 4  | 30   | 20240501      |                 | 672.36          | 334.3         | 5.87     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 5  | 31   | 20240601     |                 | 336.11          | 336.25        | 3.92     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 6  | 30   | 20240701     |                 | 0.0             | 336.11        | 1.96     | 0.0  | 0.0       | 338.07 | 0.0    | 0.0        | 0.0  | 338.07      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 2000.0        | 38.92    | 0.0  | 0.0       | 2038.92 | 1020.51 | 340.17     | 0.0  | 1018.41     |
    When Admin sets the business date to "20240501"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240501" with 340.17 EUR transaction amount
    #And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 2000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 | 20240101 | 1659.83         | 340.17        | 0.0      | 0.0  | 0.0       | 340.17 | 340.17 | 340.17     | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301   | 1339.02         | 320.81        | 19.36    | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401   | 1006.66         | 332.36        | 7.81     | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240501     | 672.36          | 334.3         | 5.87     | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20240601     |                 | 336.11          | 336.25        | 3.92     | 0.0  | 0.0       | 340.17 | 0.0    | 0.0        | 0.0  | 340.17      |
      | 6  | 30   | 20240701     |                 | 0.0             | 336.11        | 1.96     | 0.0  | 0.0       | 338.07 | 0.0    | 0.0        | 0.0  | 338.07      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 2000.0        | 38.92    | 0.0  | 0.0       | 2038.92 | 1360.68 | 340.17     | 0.0  | 678.24      |
    When Admin sets the business date to "20240601"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240601" with 340.17 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 2000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 | 20240101 | 1659.83         | 340.17        | 0.0      | 0.0  | 0.0       | 340.17 | 340.17 | 340.17     | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301   | 1339.02         | 320.81        | 19.36    | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401   | 1006.66         | 332.36        | 7.81     | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240501     | 672.36          | 334.3         | 5.87     | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20240601     | 20240601    | 336.11          | 336.25        | 3.92     | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 6  | 30   | 20240701     |                 | 0.0             | 336.11        | 1.96     | 0.0  | 0.0       | 338.07 | 0.0    | 0.0        | 0.0  | 338.07      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 2000.0        | 38.92    | 0.0  | 0.0       | 2038.92 | 1700.85 | 340.17     | 0.0  | 338.07      |
    When Admin sets the business date to "20240701"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240701" with 340.17 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 2000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 | 20240101 | 1659.83         | 340.17        | 0.0      | 0.0  | 0.0       | 340.17 | 340.17 | 340.17     | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301   | 1339.02         | 320.81        | 19.36    | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401   | 1006.66         | 332.36        | 7.81     | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240501     | 672.36          | 334.3         | 5.87     | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20240601     | 20240601    | 336.11          | 336.25        | 3.92     | 0.0  | 0.0       | 340.17 | 340.17 | 0.0        | 0.0  | 0.0         |
      | 6  | 30   | 20240701     | 20240701    | 0.0             | 336.11        | 1.96     | 0.0  | 0.0       | 338.07 | 338.07 | 0.0        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 2000.0        | 38.92    | 0.0  | 0.0       | 2038.92 | 2038.92 | 340.17     | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 2000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 2000.0       | false    | false    |
      | 20240101  | Repayment        | 340.17 | 340.17    | 0.0      | 0.0  | 0.0       | 1659.83      | false    | false    |
      | 20240101  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual          | 0.34   | 0.0       | 0.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Repayment        | 340.17 | 320.81    | 19.36    | 0.0  | 0.0       | 1339.02      | false    | false    |
      | 20240301    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 19.36  | 0.0       | 19.36    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual          | 0.26   | 0.0       | 0.26     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual          | 0.26   | 0.0       | 0.26     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual          | 0.26   | 0.0       | 0.26     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual          | 0.26   | 0.0       | 0.26     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual          | 0.26   | 0.0       | 0.26     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual          | 0.26   | 0.0       | 0.26     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual          | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Repayment        | 340.17 | 332.36    | 7.81     | 0.0  | 0.0       | 1006.66      | false    | false    |
      | 20240401    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Accrual Activity | 7.81   | 0.0       | 7.81     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240402    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240403    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240404    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240405    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240406    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240407    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240408    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240409    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240410    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240411    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240412    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240413    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240414    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240415    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240416    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240417    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240418    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240419    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240420    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240421    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240422    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240423    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240424    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240425    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240426    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240427    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240428    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240429    | Accrual          | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240430    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Repayment        | 340.17 | 334.3     | 5.87     | 0.0  | 0.0       | 672.36       | false    | false    |
      | 20240501      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Accrual Activity | 5.87   | 0.0       | 5.87     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240502      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240503      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240504      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240505      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240506      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240507      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240508      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240509      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240510      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240511      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240512      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240513      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240514      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240515      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240516      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240517      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240518      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240519      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240520      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240521      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240522      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240523      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240524      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240525      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240526      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240527      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240528      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240529      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240530      | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240531      | Accrual          | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240601     | Repayment        | 340.17 | 336.25    | 3.92     | 0.0  | 0.0       | 336.11       | false    | false    |
      | 20240601     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240601     | Accrual Activity | 3.92   | 0.0       | 3.92     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240602     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240603     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240604     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240605     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240606     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240607     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240608     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240609     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240610     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240611     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240612     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240613     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240614     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240615     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240616     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240617     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240618     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240619     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240620     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240621     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240622     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240623     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240624     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240625     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240626     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240627     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240628     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240629     | Accrual          | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240630     | Accrual          | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240701     | Repayment        | 340.17 | 336.11    | 1.96     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240701     | Accrual Activity | 1.96   | 0.0       | 1.96     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3525
  Scenario: Verify accrual activity behavior in case of backdated repayment - UC1
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_ACCRUAL_ACTIVITY | 20250101   | 800            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "800" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "800" EUR transaction amount
    And Admin sets the business date to "20250202"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 800.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 668.6           | 131.4         | 4.67     | 0.0  | 0.0       | 136.07 | 0.0  | 0.0        | 0.0  | 136.07      |
      | 2  | 28   | 20250301    |           | 536.46          | 132.14        | 3.93     | 0.0  | 0.0       | 136.07 | 0.0  | 0.0        | 0.0  | 136.07      |
      | 3  | 31   | 20250401    |           | 403.52          | 132.94        | 3.13     | 0.0  | 0.0       | 136.07 | 0.0  | 0.0        | 0.0  | 136.07      |
      | 4  | 30   | 20250501      |           | 269.8           | 133.72        | 2.35     | 0.0  | 0.0       | 136.07 | 0.0  | 0.0        | 0.0  | 136.07      |
      | 5  | 31   | 20250601     |           | 135.3           | 134.5         | 1.57     | 0.0  | 0.0       | 136.07 | 0.0  | 0.0        | 0.0  | 136.07      |
      | 6  | 30   | 20250701     |           | 0.0             | 135.3         | 0.79     | 0.0  | 0.0       | 136.09 | 0.0  | 0.0        | 0.0  | 136.09      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 800.00        | 16.44    | 0.0  | 0.0       | 816.44 | 0.0  | 0.0        | 0.0  | 816.44      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20250201 | Accrual          | 4.67   | 0.0       | 4.67     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Accrual Activity | 4.67   | 0.0       | 4.67     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Save external ID of "Accrual Activity" transaction made on "20250201" as "saved-external-id"
    When Customer makes "AUTOPAY" repayment on "20250131" with 900 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101  |                 | 800.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250201 | 20250131 | 668.45          | 131.55        | 4.52     | 0.0  | 0.0       | 136.07 | 136.07 | 136.07     | 0.0  | 0.0         |
      | 2  | 28   | 20250301    | 20250131 | 532.38          | 136.07        | 0.0      | 0.0  | 0.0       | 136.07 | 136.07 | 136.07     | 0.0  | 0.0         |
      | 3  | 31   | 20250401    | 20250131 | 396.31          | 136.07        | 0.0      | 0.0  | 0.0       | 136.07 | 136.07 | 136.07     | 0.0  | 0.0         |
      | 4  | 30   | 20250501      | 20250131 | 260.24          | 136.07        | 0.0      | 0.0  | 0.0       | 136.07 | 136.07 | 136.07     | 0.0  | 0.0         |
      | 5  | 31   | 20250601     | 20250131 | 124.17          | 136.07        | 0.0      | 0.0  | 0.0       | 136.07 | 136.07 | 136.07     | 0.0  | 0.0         |
      | 6  | 30   | 20250701     | 20250131 | 0.0             | 124.17        | 0.0      | 0.0  | 0.0       | 124.17 | 124.17 | 124.17     | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 800.00        | 4.52     | 0.0  | 0.0       | 804.52 | 804.52 | 804.52     | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement       | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20250131  | Accrual Activity   | 4.52   | 0.0       | 4.52     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20250131  | Repayment          | 900.0  | 800.0     | 4.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Accrual            | 4.67   | 0.0       | 4.67     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250202 | Accrual Adjustment | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
    And "Accrual Activity" transaction on "20250131" got reverse-replayed on "20250202"
    And LoanAccrualAdjustmentTransactionBusinessEvent is raised on "20250202"
    And External ID of replayed "Accrual Activity" on "20250131" is matching with "saved-external-id"

  @TestRailId:C3526
  Scenario: Verify accrual activity behavior in case of repayment reversal on an overpaid loan - UC2
    When Admin sets the business date to "20250225"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_ACCRUAL_ACTIVITY | 20250225  | 75.71          | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250225" with "75.71" amount and expected disbursement date on "20250225"
    And Admin successfully disburse the loan on "20250225" with "75.71" EUR transaction amount
    And Admin sets the business date to "20250310"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250225 |           | 75.71           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 28   | 20250325    |           | 63.27           | 12.44         | 0.44     | 0.0  | 0.0       | 12.88 | 0.0  | 0.0        | 0.0  | 12.88       |
      | 2  | 31   | 20250425    |           | 50.76           | 12.51         | 0.37     | 0.0  | 0.0       | 12.88 | 0.0  | 0.0        | 0.0  | 12.88       |
      | 3  | 30   | 20250525      |           | 38.18           | 12.58         | 0.3      | 0.0  | 0.0       | 12.88 | 0.0  | 0.0        | 0.0  | 12.88       |
      | 4  | 31   | 20250625     |           | 25.52           | 12.66         | 0.22     | 0.0  | 0.0       | 12.88 | 0.0  | 0.0        | 0.0  | 12.88       |
      | 5  | 30   | 20250725     |           | 12.79           | 12.73         | 0.15     | 0.0  | 0.0       | 12.88 | 0.0  | 0.0        | 0.0  | 12.88       |
      | 6  | 31   | 20250825   |           | 0.0             | 12.79         | 0.07     | 0.0  | 0.0       | 12.86 | 0.0  | 0.0        | 0.0  | 12.86       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 75.71         | 1.55     | 0.0  | 0.0       | 77.26 | 0.0  | 0.0        | 0.0  | 77.26       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250225 | Disbursement     | 75.71  | 0.0       | 0.0      | 0.0  | 0.0       | 75.71        | false    | false    |
      | 20250309    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Customer makes "AUTOPAY" repayment on "20250310" with 80 EUR transaction amount
    And Admin sets the business date to "20250328"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250225 |               | 75.71           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 28   | 20250325    | 20250310 | 63.04           | 12.67         | 0.21     | 0.0  | 0.0       | 12.88 | 12.88 | 12.88      | 0.0  | 0.0         |
      | 2  | 31   | 20250425    | 20250310 | 50.16           | 12.88         | 0.0      | 0.0  | 0.0       | 12.88 | 12.88 | 12.88      | 0.0  | 0.0         |
      | 3  | 30   | 20250525      | 20250310 | 37.28           | 12.88         | 0.0      | 0.0  | 0.0       | 12.88 | 12.88 | 12.88      | 0.0  | 0.0         |
      | 4  | 31   | 20250625     | 20250310 | 24.4            | 12.88         | 0.0      | 0.0  | 0.0       | 12.88 | 12.88 | 12.88      | 0.0  | 0.0         |
      | 5  | 30   | 20250725     | 20250310 | 11.52           | 12.88         | 0.0      | 0.0  | 0.0       | 12.88 | 12.88 | 12.88      | 0.0  | 0.0         |
      | 6  | 31   | 20250825   | 20250310 | 0.0             | 11.52         | 0.0      | 0.0  | 0.0       | 11.52 | 11.52 | 11.52      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 75.71         | 0.21     | 0.0  | 0.0       | 75.92 | 75.92 | 75.92      | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250225 | Disbursement     | 75.71  | 0.0       | 0.0      | 0.0  | 0.0       | 75.71        | false    | false    |
      | 20250309    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250310    | Repayment        | 80.0   | 75.71     | 0.21     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250310    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250310    | Accrual Activity | 0.21   | 0.0       | 0.21     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Save external ID of "Accrual Activity" transaction made on "20250310" as "saved-external-id"
    When Customer undo "1"th "Repayment" transaction made on "20250310"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250225 |           | 75.71           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 28   | 20250325    |           | 63.27           | 12.44         | 0.44     | 0.0  | 0.0       | 12.88 | 0.0  | 0.0        | 0.0  | 12.88       |
      | 2  | 31   | 20250425    |           | 50.77           | 12.5          | 0.38     | 0.0  | 0.0       | 12.88 | 0.0  | 0.0        | 0.0  | 12.88       |
      | 3  | 30   | 20250525      |           | 38.19           | 12.58         | 0.3      | 0.0  | 0.0       | 12.88 | 0.0  | 0.0        | 0.0  | 12.88       |
      | 4  | 31   | 20250625     |           | 25.53           | 12.66         | 0.22     | 0.0  | 0.0       | 12.88 | 0.0  | 0.0        | 0.0  | 12.88       |
      | 5  | 30   | 20250725     |           | 12.8            | 12.73         | 0.15     | 0.0  | 0.0       | 12.88 | 0.0  | 0.0        | 0.0  | 12.88       |
      | 6  | 31   | 20250825   |           | 0.0             | 12.8          | 0.07     | 0.0  | 0.0       | 12.87 | 0.0  | 0.0        | 0.0  | 12.87       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 75.71         | 1.56     | 0.0  | 0.0       | 77.27 | 0.0  | 0.0        | 0.0  | 77.27       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250225 | Disbursement     | 75.71  | 0.0       | 0.0      | 0.0  | 0.0       | 75.71        | false    | false    |
      | 20250309    | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250310    | Repayment        | 80.0   | 75.71     | 0.21     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20250310    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250325    | Accrual Activity | 0.44   | 0.0       | 0.44     | 0.0  | 0.0       | 0.0          | false    | true     |
    And "Accrual Activity" transaction on "20250325" got reverse-replayed on "20250328"
    And External ID of replayed "Accrual Activity" on "20250325" is matching with "saved-external-id"

