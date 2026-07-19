@AccountTransfer
Feature: AccountTransfer

  @TestRailId:C80937
  Scenario: Transfer from savings to linked loan then undo it
    When Admin sets the business date to "20260513"
    And Admin creates a client with random data
    And Admin creates a EUR savings product
    And Client creates a new EUR savings account with "20260501" submitted on date
    And Approve EUR savings account on "20260501" date
    And Activate EUR savings account on "20260501" date
    And Client successfully deposits 1000 EUR to the savings account on "20260501" date
    Then Savings Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Balance |
      | 20260501      | Deposit          | 1000.0 | 1000.0  |
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                             | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30 | 20260501       | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260501" with "1000" amount and expected disbursement date on "20260501"
    When Admin successfully disburse the loan on "20260501" with "1000" EUR transaction amount
    When Initiate account transfer from savings to loan on "20260502" for 10
    Then Savings Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Balance |
      | 20260501      | Deposit          | 1000.0 | 1000.0  |
      | 20260502      | Withdrawal       | 10.0   | 990.0   |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260501      | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20260502      | Repayment        | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 990.0        | false    | false    |
    When Undo the last account transfer
    Then Savings Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Balance | Reverted |
      | 20260501      | Deposit          | 1000.0 | 1000.0  | false    |
      | 20260502      | Withdrawal       | 10.0   | 0.0     | true     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260501      | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20260502      | Repayment        | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 990.0        | true     | false    |
    When Undo the last account transfer it fails with error: it is already reverted

  @TestRailId:C80967
  Scenario: Transfer between savings accounts
    When Admin sets the business date to "20260513"
    And Admin creates a client with random data
    And Admin creates a EUR savings product
    And Client creates a "PRIMARY" new EUR savings account with "20260501" submitted on date
    And Approve "PRIMARY" EUR savings account on "20260501" date
    And Activate "PRIMARY" EUR savings account on "20260501" date
    And Client successfully deposits 1000 EUR to the "PRIMARY" savings account on "20260501" date
    Then "PRIMARY" Savings Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Balance |
      | 20260501      | Deposit          | 1000.0 | 1000.0  |
    And Client creates a "SECONDARY" new EUR savings account with "20260501" submitted on date
    And Approve "SECONDARY" EUR savings account on "20260501" date
    And Activate "SECONDARY" EUR savings account on "20260501" date
    And Client successfully deposits 1000 EUR to the "SECONDARY" savings account on "20260501" date
    Then "SECONDARY" Savings Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Balance |
      | 20260501      | Deposit          | 1000.0 | 1000.0  |
    When Initiate account transfer from savings "PRIMARY" to savings "SECONDARY" on "20260502" for 10
    Then "PRIMARY" Savings Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Balance |
      | 20260501      | Deposit          | 1000.0 | 1000.0  |
      | 20260502      | Withdrawal       | 10.0   | 990.0   |
    Then "SECONDARY" Savings Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Balance |
      | 20260501      | Deposit          | 1000.0 | 1000.0  |
      | 20260502      | Deposit          | 10.0   | 1010.0  |
    When Undo the last account transfer
    Then "PRIMARY" Savings Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Balance | Reverted |
      | 20260501      | Deposit          | 1000.0 | 1000.0  | false    |
      | 20260502      | Withdrawal       | 10.0   | 0.0     | true     |
    Then "SECONDARY" Savings Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Balance | Reverted |
      | 20260501      | Deposit          | 1000.0 | 1000.0  | false    |
      | 20260502      | Deposit          | 10.0   | 0.0     | true     |
    When Undo the last account transfer it fails with error: it is already reverted
