@LoanDownPaymentFeature
Feature: Loan DownPayment - Part1

  @TestRailId:C2812
  Scenario: Single disbursement normal flow - auto enabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20220101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    When Admin sets the business date to "20220201"
    And Customer makes "AUTOPAY" repayment on "20220201" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 | 20220201 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 28   | 20220301    |                  | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 500.0 | 0          | 0    | 500         |
    When Admin sets the business date to "20230215"
    And Customer makes "AUTOPAY" repayment on "20220215" with 400 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 | 20220201 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 28   | 20220301    | 20220215 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 4  | 31   | 20220401    |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 150.0 | 150.0      | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 900.0 | 400        | 0    | 100         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220201 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20220215 | Repayment        | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 100.0        |
# --- close loan --- #
    When Loan Pay-off is made on "20220201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2813
  Scenario: Single disbursement normal flow - auto disabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20220101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20220201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 0.0  | 0          | 0    | 1000        |
    And Customer makes "DOWN_PAYMENT" repayment on "20220101" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    When Admin sets the business date to "20220201"
    And Customer makes "AUTOPAY" repayment on "20220201" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 | 20220201 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 28   | 20220301    |                  | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 500.0 | 0          | 0    | 500         |
    When Admin sets the business date to "20230215"
    And Customer makes "AUTOPAY" repayment on "20220215" with 400 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 | 20220201 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 28   | 20220301    | 20220215 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 4  | 31   | 20220401    |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 150.0 | 150.0      | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 900.0 | 400        | 0    | 100         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220201 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20220215 | Repayment        | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 100.0        |
# --- close loan --- #
    When Loan Pay-off is made on "20230215"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2814
  Scenario: Single disbursement charge flow - auto enabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20220101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20220101" due date and 50 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 250.0 | 0          | 0    | 800         |
    When Admin sets the business date to "20220201"
    And Customer makes "AUTOPAY" repayment on "20220201" with 300 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 | 20220201 | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 300.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 28   | 20220301    |                  | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 550.0 | 0          | 0    | 500         |
    When Admin sets the business date to "20230215"
    And Customer makes "AUTOPAY" repayment on "20220215" with 400 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 | 20220201 | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 300.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 28   | 20220301    | 20220215 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 4  | 31   | 20220401    |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 150.0 | 150.0      | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 950.0 | 400        | 0    | 100         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220201 | Repayment        | 300.0  | 250.0     | 0.0      | 0.0  | 50.0      | 500.0        |
      | 20220215 | Repayment        | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 100.0        |
# --- close loan --- #
    When Loan Pay-off is made on "20230215"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2815
  Scenario: Single disbursement charge flow - auto disabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20220101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20220101" due date and 50 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20220201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
      | 3  | 28   | 20220301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 0.0  | 0          | 0    | 1050        |
    And Customer makes "DOWN_PAYMENT" repayment on "20220101" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 250.0 | 0          | 0    | 800         |
    When Admin sets the business date to "20220201"
    And Customer makes "AUTOPAY" repayment on "20220201" with 300 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 | 20220201 | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 300.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 28   | 20220301    |                  | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 550.0 | 0          | 0    | 500         |
    When Admin sets the business date to "20230215"
    And Customer makes "AUTOPAY" repayment on "20220215" with 400 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 | 20220201 | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 300.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 28   | 20220301    | 20220215 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 4  | 31   | 20220401    |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 150.0 | 150.0      | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 950.0 | 400        | 0    | 100         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220201 | Repayment        | 300.0  | 250.0     | 0.0      | 0.0  | 50.0      | 500.0        |
      | 20220215 | Repayment        | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 100.0        |
# --- close loan --- #
    When Loan Pay-off is made on "20230215"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2816
  Scenario: Double disbursement different day - auto enabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20220101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "2000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20220101" due date and 50 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 250.0 | 0          | 0    | 800         |
    When Admin sets the business date to "20220110"
    When Admin successfully disburse the loan on "20220110" with "400" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220110  |                 | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220110  | 20220110 | 1050.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20220201 |                 | 700.0           | 350.0         | 0.0      | 0.0  | 50.0      | 400.0 | 0.0   | 0.0        | 0.0  | 400.0       |
      | 4  | 28   | 20220301    |                 | 350.0           | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1400.0        | 0        | 0    | 50        | 1450.0 | 350.0 | 0          | 0    | 1100        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220110  | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1150.0       |
      | 20220110  | Down Payment     | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1050.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220110"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2817
  Scenario: Double disbursement different day - auto disabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20220101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20220101" due date and 50 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20220201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
      | 3  | 28   | 20220301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 0.0  | 0          | 0    | 1050        |
    And Customer makes "DOWN_PAYMENT" repayment on "20220101" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 250.0 | 0          | 0    | 800         |
    When Admin sets the business date to "20220110"
    When Admin successfully disburse the loan on "20220110" with "400" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220110  |                 | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220110  |                 | 1050.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 3  | 31   | 20220201 |                 | 700.0           | 350.0         | 0.0      | 0.0  | 50.0      | 400.0 | 0.0   | 0.0        | 0.0  | 400.0       |
      | 4  | 28   | 20220301    |                 | 350.0           | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1400.0        | 0        | 0    | 50        | 1450.0 | 250.0 | 0          | 0    | 1200        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220110  | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1150.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220110"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2818
  Scenario: Double disbursement on installment day - auto enabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20220101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20220101" due date and 50 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 250.0 | 0          | 0    | 800         |
    When Admin sets the business date to "20220201"
    When Admin successfully disburse the loan on "20220201" with "400" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220201 |                  | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220201 | 20220201 | 1050.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20220201 |                  | 700.0           | 350.0         | 0.0      | 0.0  | 50.0      | 400.0 | 0.0   | 0.0        | 0.0  | 400.0       |
      | 4  | 28   | 20220301    |                  | 350.0           | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
      | 5  | 31   | 20220401    |                  | 0.0             | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1400.0        | 0        | 0    | 50        | 1450.0 | 350.0 | 0          | 0    | 1100        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220201 | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1150.0       |
      | 20220201 | Down Payment     | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1050.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2819
  Scenario: Double disbursement on installment day - auto disabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20220101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20220101" due date and 50 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20220201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
      | 3  | 28   | 20220301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 0.0  | 0          | 0    | 1050        |
    And Customer makes "DOWN_PAYMENT" repayment on "20220101" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 250.0 | 0          | 0    | 800         |
    When Admin sets the business date to "20220201"
    When Admin successfully disburse the loan on "20220201" with "400" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220201 |                 | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220201 |                 | 1050.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 3  | 31   | 20220201 |                 | 700.0           | 350.0         | 0.0      | 0.0  | 50.0      | 400.0 | 0.0   | 0.0        | 0.0  | 400.0       |
      | 4  | 28   | 20220301    |                 | 350.0           | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1400.0        | 0        | 0    | 50        | 1450.0 | 250.0 | 0          | 0    | 1200        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220201 | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1150.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2820
  Scenario: Downpayment with loan adjustment - auto enabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20220101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20220101" due date and 50 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 250.0 | 0          | 0    | 800         |
    When Admin sets the business date to "20220110"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20220201   | 20220110 | 20220401   |                  |                 |            |                 |
    When Admin sets the business date to "20220401"
    When Admin successfully disburse the loan on "20220401" with "400" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101 |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101 | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220401   |                 | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220401   | 20220401   | 1050.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 90   | 20220401   |                 | 700.0           | 350.0         | 0.0      | 0.0  | 50.0      | 400.0 | 0.0   | 0.0        | 0.0  | 400.0       |
      | 4  | 30   | 20220501     |                 | 350.0           | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
      | 5  | 31   | 20220601    |                 | 0.0             | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1400.0        | 0        | 0    | 50        | 1450.0 | 350.0 | 0          | 0    | 1100        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220401    | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1150.0       |
      | 20220401    | Down Payment     | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1050.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2821
  Scenario: Downpayment with loan adjustment - auto disabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20220101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20220101" due date and 50 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20220201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
      | 3  | 28   | 20220301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 0.0  | 0          | 0    | 1050        |
    And Customer makes "DOWN_PAYMENT" repayment on "20220101" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 250.0 | 0          | 0    | 800         |
    When Admin sets the business date to "20220110"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20220201   | 20220110 | 20220401   |                  |                 |            |                 |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101 |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101 | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 90   | 20220401   |                 | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 3  | 30   | 20220501     |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220601    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 250.0 | 0          | 0    | 800         |
    When Admin sets the business date to "20220401"
    When Admin successfully disburse the loan on "20220401" with "400" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101 |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101 | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220401   |                 | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220401   |                 | 1050.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 3  | 90   | 20220401   |                 | 700.0           | 350.0         | 0.0      | 0.0  | 50.0      | 400.0 | 0.0   | 0.0        | 0.0  | 400.0       |
      | 4  | 30   | 20220501     |                 | 350.0           | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
      | 5  | 31   | 20220601    |                 | 0.0             | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1400.0        | 0        | 0    | 50        | 1450.0 | 250.0 | 0          | 0    | 1200        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220401    | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1150.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2822
  Scenario: Downpayment creation date - auto enabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20220101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20230110"
    When Admin sets the business date to "20220110"
    When Admin successfully disburse the loan on "20220110" with "1000" EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20220110" due date and 50 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220110  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220110  | 20220110 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220210 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 3  | 28   | 20220310    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220410    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 250.0 | 0          | 0    | 800         |
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20220210   | 20220110 | 20220410   |                  |                 |            |                 |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220110 |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220110 | 20220110 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 90   | 20220410   |                 | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 3  | 30   | 20220510     |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220610    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 250.0 | 0          | 0    | 800         |
    When Admin sets the business date to "20220401"
    When Admin successfully disburse the loan on "20220401" with "400" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220110 |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220110 | 20220110 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220401   |                 | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220401   | 20220401   | 1050.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 90   | 20220410   |                 | 700.0           | 350.0         | 0.0      | 0.0  | 50.0      | 400.0 | 0.0   | 0.0        | 0.0  | 400.0       |
      | 4  | 30   | 20220510     |                 | 350.0           | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
      | 5  | 31   | 20220610    |                 | 0.0             | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1400.0        | 0        | 0    | 50        | 1450.0 | 350.0 | 0          | 0    | 1100        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220110  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220110  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220401    | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1150.0       |
      | 20220401    | Down Payment     | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1050.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2823
  Scenario: Downpayment creation date - auto disabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20220101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20230110"
    When Admin sets the business date to "20220110"
    When Admin successfully disburse the loan on "20220110" with "1000" EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20220110" due date and 50 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220110  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220110  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20220210 |           | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
      | 3  | 28   | 20220310    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220410    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 0.0  | 0          | 0    | 1050        |
    And Customer makes "DOWN_PAYMENT" repayment on "20220110" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220110  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220110  | 20220110 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220210 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 3  | 28   | 20220310    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220410    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 250.0 | 0          | 0    | 800         |
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20220210   | 20220110 | 20220410   |                  |                 |            |                 |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220110 |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220110 | 20220110 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 90   | 20220410   |                 | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 3  | 30   | 20220510     |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220610    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 250.0 | 0          | 0    | 800         |
    When Admin sets the business date to "20220401"
    When Admin successfully disburse the loan on "20220401" with "400" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220110 |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220110 | 20220110 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220401   |                 | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220401   |                 | 1050.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 3  | 90   | 20220410   |                 | 700.0           | 350.0         | 0.0      | 0.0  | 50.0      | 400.0 | 0.0   | 0.0        | 0.0  | 400.0       |
      | 4  | 30   | 20220510     |                 | 350.0           | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
      | 5  | 31   | 20220610    |                 | 0.0             | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1400.0        | 0        | 0    | 50        | 1450.0 | 250.0 | 0          | 0    | 1200        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220110  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220110  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220401    | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1150.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2824
  Scenario: Double disbursement normal flow - auto enabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20220101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "2000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    When Admin sets the business date to "20220115"
    When Admin successfully disburse the loan on "20220115" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220115  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220115  | 20220115 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20220201 |                 | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 4  | 28   | 20220301    |                 | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 500.0 | 0          | 0    | 1500        |
    When Admin sets the business date to "20220201"
    And Customer makes "AUTOPAY" repayment on "20220201" with 500 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220115  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220115  | 20220115  | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20220201 | 20220201 | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 500.0 | 0.0        | 0.0  | 0.0         |
      | 4  | 28   | 20220301    |                  | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                  | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 1000.0 | 0          | 0    | 1000        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220115  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1750.0       |
      | 20220115  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1500.0       |
      | 20220201 | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 1000.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2825
  Scenario: Double disbursement normal flow - auto disabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20220101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "2000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20220201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 0.0  | 0          | 0    | 1000        |
    And Customer makes "AUTOPAY" repayment on "20220101" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    When Admin sets the business date to "20220115"
    When Admin successfully disburse the loan on "20220115" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220115  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220115  |                 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 31   | 20220201 |                 | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 4  | 28   | 20220301    |                 | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 250.0 | 0          | 0    | 1750        |
    When Admin sets the business date to "20220201"
    And Customer makes "AUTOPAY" repayment on "20220201" with 500 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      |    |      | 20220115  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 2  | 0    | 20220115  | 20220201 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 3  | 31   | 20220201 |                  | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 250.0 | 0.0        | 0.0   | 250.0       |
      | 4  | 28   | 20220301    |                  | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0   | 500.0       |
      | 5  | 31   | 20220401    |                  | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0   | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 750.0 | 0          | 250  | 1250        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220115  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1750.0       |
      | 20220201 | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 1250.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2826
  Scenario: Double disbursement same day - auto enabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20220101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "2000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    When Admin sets the business date to "20220115"
    When Admin successfully disburse the loan on "20220115" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220115  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220115  | 20220115 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20220201 |                 | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 4  | 28   | 20220301    |                 | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 500.0 | 0          | 0    | 1500        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220115  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1750.0       |
      | 20220115  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1500.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220115"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2827
  Scenario: Double disbursement same day - auto disabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20220101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "2000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20220201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 0    | 0          | 0    | 1000        |
    And Customer makes "AUTOPAY" repayment on "20220101" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    When Admin sets the business date to "20220115"
    When Admin successfully disburse the loan on "20220115" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220115  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220115  |                 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 31   | 20220201 |                 | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 4  | 28   | 20220301    |                 | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 250.0 | 0          | 0    | 1750        |
    And Customer makes "AUTOPAY" repayment on "20220115" with 250 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220115  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220115  | 20220115 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20220201 |                 | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 4  | 28   | 20220301    |                 | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 500.0 | 0          | 0    | 1500        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220115  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1750.0       |
      | 20220115  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1500.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220115"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2828
  Scenario: Double disbursement partial overpayment - auto enabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20220101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "2000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    When Admin sets the business date to "20220115"
    When Admin successfully disburse the loan on "20220115" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220115  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220115  | 20220115 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20220201 |                 | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 4  | 28   | 20220301    |                 | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 500.0 | 0          | 0    | 1500        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220115  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1750.0       |
      | 20220115  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1500.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220115"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2829
  Scenario: Double disbursement partial overpayment - auto disabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20220101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "2000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20220201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 0    | 0          | 0    | 1000        |
    And Customer makes "AUTOPAY" repayment on "20220101" with 400 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 150.0 | 150.0      | 0.0  | 100.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 400.0 | 150        | 0    | 600         |
    When Admin sets the business date to "20220115"
    When Admin successfully disburse the loan on "20220115" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220115  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220115  |                 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 150.0 | 150.0      | 0.0  | 100.0       |
      | 3  | 31   | 20220201 |                 | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 4  | 28   | 20220301    |                 | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 400.0 | 150        | 0    | 1600        |
    And Customer makes "AUTOPAY" repayment on "20220115" with 250 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220115  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220115  | 20220115 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 150.0      | 0.0  | 0.0         |
      | 3  | 31   | 20220201 |                 | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 150.0 | 150.0      | 0.0  | 350.0       |
      | 4  | 28   | 20220301    |                 | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 650.0 | 300        | 0    | 1350        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Repayment        | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 600.0        |
      | 20220115  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1600.0       |
      | 20220115  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1350.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220115"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2830
  Scenario: Double disbursement full overpayment - auto enabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20220101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "2000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    And Customer makes "AUTOPAY" repayment on "20220101" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 | 20220101 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 500.0 | 250        | 0    | 500         |
    When Admin sets the business date to "20220115"
    When Admin successfully disburse the loan on "20220115" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220115  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220115  | 20220101 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 3  | 31   | 20220201 |                 | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 250.0 | 250.0      | 0.0  | 250.0       |
      | 4  | 28   | 20220301    |                 | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 750.0 | 500        | 0    | 1250        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20220115  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       |
      | 20220115  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1250.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220115"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2831
  Scenario: Double disbursement full overpayment - auto disabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20220101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "2000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20220201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 0    | 0          | 0    | 1000        |
    And Customer makes "AUTOPAY" repayment on "20220101" with 500 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 | 20220101 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 500.0 | 250        | 0    | 500         |
    When Admin sets the business date to "20220115"
    When Admin successfully disburse the loan on "20220115" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220115  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220115  | 20220101 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 3  | 31   | 20220201 |                 | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 4  | 28   | 20220301    |                 | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 500.0 | 250        | 0    | 1500        |
    And Customer makes "AUTOPAY" repayment on "20220115" with 250 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220115  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220115  | 20220101 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 3  | 31   | 20220201 |                 | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 250.0 | 250.0      | 0.0  | 250.0       |
      | 4  | 28   | 20220301    |                 | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 750.0 | 500        | 0    | 1250        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20220115  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       |
      | 20220115  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1250.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220115"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2832
  Scenario: Double disbursement after installment overdue - auto enabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20220101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "2000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    When Admin sets the business date to "20220215"
    When Admin successfully disburse the loan on "20220215" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 31   | 20220201 |                  | 250.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 250.0 | 0.0        | 250.0 | 250.0       |
      |    |      | 20220215 |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 3  | 0    | 20220215 |                  | 1000.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 4  | 28   | 20220301    |                  | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0   | 500.0       |
      | 5  | 31   | 20220401    |                  | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0   | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 500.0 | 0          | 250  | 1500        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220215 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1750.0       |
      | 20220215 | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1500.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220215"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2833
  Scenario: Double disbursement after installment overdue - auto disabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20220101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "2000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20220201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 0    | 0          | 0    | 1000        |
    And Customer makes "AUTOPAY" repayment on "20220101" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    When Admin sets the business date to "20220215"
    When Admin successfully disburse the loan on "20220215" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 250.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      |    |      | 20220215 |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 3  | 0    | 20220215 |                 | 1000.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 28   | 20220301    |                 | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 250.0 | 0          | 0    | 1750        |
    And Customer makes "AUTOPAY" repayment on "20220215" with 250 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 31   | 20220201 |                  | 250.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 250.0 | 0.0        | 250.0 | 250.0       |
      |    |      | 20220215 |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 3  | 0    | 20220215 |                  | 1000.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 4  | 28   | 20220301    |                  | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0   | 500.0       |
      | 5  | 31   | 20220401    |                  | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0   | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 500.0 | 0          | 250  | 1500        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220215 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1750.0       |
      | 20220215 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1500.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220215"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2834
  Scenario: Double disbursement after installment 2 - auto enabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20220101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "2000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    When Admin sets the business date to "20220201"
    And Customer makes "AUTOPAY" repayment on "20220201" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 | 20220201 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 28   | 20220301    |                  | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 500.0 | 0          | 0    | 500         |
    When Admin sets the business date to "20220215"
    When Admin successfully disburse the loan on "20220215" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 | 20220215 | 250.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 500.0 | 0.0        | 250.0| 0.0         |
      |    |      | 20220215 |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 3  | 0    | 20220215 |                  | 1000.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 28   | 20220301    |                  | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                  | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 750.0 | 0          | 250.0| 1250        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220201 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20220215 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       |
      | 20220215 | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1250.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220215"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2835
  Scenario: Double disbursement after installment 2 - auto disabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20220101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "2000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20220201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 0    | 0          | 0    | 1000        |
    And Customer makes "AUTOPAY" repayment on "20220101" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    When Admin sets the business date to "20220201"
    And Customer makes "AUTOPAY" repayment on "20220201" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 | 20220201 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 28   | 20220301    |                  | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 500.0 | 0          | 0    | 500         |
    When Admin sets the business date to "20220215"
    When Admin successfully disburse the loan on "20220215" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                  | 250.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 250.0 | 0.0        | 0.0  | 250.0       |
      |    |      | 20220215 |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 3  | 0    | 20220215 |                  | 1000.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 28   | 20220301    |                  | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                  | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 500.0 | 0          | 0    | 1500        |
    And Customer makes "AUTOPAY" repayment on "20220215" with 250 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 | 20220215 | 250.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 500.0 | 0.0        | 250.0| 0.0         |
      |    |      | 20220215 |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 3  | 0    | 20220215 |                  | 1000.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 28   | 20220301    |                  | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                  | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 750.0 | 0          | 250.0| 1250        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220201 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20220215 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       |
      | 20220215 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1250.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220215"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2836
  Scenario: Double disbursement normal overdue - auto enabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20220101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "2000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250  | 0          | 0    | 750         |
    When Admin sets the business date to "20220115"
    When Admin successfully disburse the loan on "20220115" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220115  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220115  | 20220115 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20220201 |                 | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 4  | 28   | 20220301    |                 | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 500  | 0          | 0    | 1500        |
    And Customer makes "AUTOPAY" repayment on "20220115" with 250 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220115  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220115  | 20220115 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20220201 |                 | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 250.0 | 250.0      | 0.0  | 250.0       |
      | 4  | 28   | 20220301    |                 | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 750  | 250        | 0    | 1250        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220115  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1750.0       |
      | 20220115  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1500.0       |
      | 20220115  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1250.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220115"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2837
  Scenario: Double disbursement normal overdue - auto disabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20220101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "2000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20220201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 0    | 0          | 0    | 1000        |
    When Admin sets the business date to "20220115"
    When Admin successfully disburse the loan on "20220115" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      |    |      | 20220115  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 2  | 0    | 20220115  |           | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 31   | 20220201 |           | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0  | 0.0        | 0.0  | 500.0       |
      | 4  | 28   | 20220301    |           | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0  | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |           | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0  | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 0    | 0          | 0    | 2000        |
    And Customer makes "AUTOPAY" repayment on "20220115" with 250 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20220101  | 20220115 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      |    |      | 20220115  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 2  | 0    | 20220115  |                 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 3  | 31   | 20220201 |                 | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0   | 500.0       |
      | 4  | 28   | 20220301    |                 | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0   | 500.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0   | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 250  | 0          | 250  | 1750        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220115  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 2000.0       |
      | 20220115  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1750.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220115"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2838
  Scenario: Double disbursement on Duedate - auto enabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20220101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "2000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    When Admin sets the business date to "20220201"
    When Admin successfully disburse the loan on "20220201" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220201 |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220201 | 20220201 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20220201 |                  | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 4  | 28   | 20220301    |                  | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                  | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 500  | 0          | 0    | 1500        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220201 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1750.0       |
      | 20220201 | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1500.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2839
  Scenario: Double disbursement on Duedate - auto disabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20220101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "2000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20220201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 0    | 0          | 0    | 1000        |
    And Customer makes "AUTOPAY" repayment on "20220101" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    When Admin sets the business date to "20220201"
    When Admin successfully disburse the loan on "20220201" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220201 |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220201 |                 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 31   | 20220201 |                 | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 4  | 28   | 20220301    |                 | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 250  | 0          | 0    | 1750        |
    And Customer makes "AUTOPAY" repayment on "20220201" with 250 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220201 |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220201 | 20220201 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20220201 |                  | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 4  | 28   | 20220301    |                  | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                  | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 500  | 0          | 0    | 1500        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220201 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1750.0       |
      | 20220201 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1500.0       |
# --- close loan --- #
    When Loan Pay-off is made on "20220201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2852
  Scenario: Single disbursement with interest - auto disabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct              | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_INTEREST | 20220101   | 1000           | 10                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20220201 |           | 500.33          | 249.67        | 8.33     | 0.0  | 0.0       | 258.0 | 0.0  | 0.0        | 0.0  | 258.0       |
      | 3  | 28   | 20220301    |           | 250.66          | 249.67        | 8.33     | 0.0  | 0.0       | 258.0 | 0.0  | 0.0        | 0.0  | 258.0       |
      | 4  | 31   | 20220401    |           | 0.0             | 250.66        | 8.34     | 0.0  | 0.0       | 259.0 | 0.0  | 0.0        | 0.0  | 259.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 25       | 0    | 0         | 1025.0 | 0.0  | 0          | 0    | 1025        |
    # --- close loan --- #
    When Loan Pay-off is made on "20220101"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2853
  Scenario: Single disbursement delinquency - auto disabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct              | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_INTEREST | 20220101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20220201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 0.0  | 0          | 0    | 1000        |
    When Admin sets the business date to "20220105"
    When Admin runs COB job
    Then Admin checks that delinquency range is: "RANGE_1" and has delinquentDate "2022-01-04"
# --- close loan --- #
    When Loan Pay-off is made on "20220105"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2854
  Scenario: Single disbursement with undo disbursement when auto downpayment is enabled without manual transaction after last downpayment
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20220101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
    When Admin successfully undo disbursal
    Then Loan status has changed to "Approved"
# --- undo approval --- #
    Then Admin can successfully undone the loan approval
    Then Loan status will be "SUBMITTED_AND_PENDING_APPROVAL"

  @TestRailId:C2855
  Scenario: Single disbursement with undo disbursement when auto downpayment is disabled without manual transaction after last downpayment
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20220101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20220201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 0.0  | 0          | 0    | 1000        |
    And Customer makes "DOWN_PAYMENT" repayment on "20220101" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
    When Admin successfully undo disbursal
    Then Loan status has changed to "Approved"
# --- undo approval --- #
    Then Admin can successfully undone the loan approval
    Then Loan status will be "SUBMITTED_AND_PENDING_APPROVAL"

  @TestRailId:C2856
  Scenario: Single disbursement with undo disbursement when auto downpayment is disabled with manual transaction after last downpayment
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20220101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20220201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 0.0  | 0          | 0    | 1000        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    And Customer makes "DOWN_PAYMENT" repayment on "20220101" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
    When Admin sets the business date to "20220201"
    And Customer makes "AUTOPAY" repayment on "20220201" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 | 20220201 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 28   | 20220301    |                  | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 500.0 | 0          | 0    | 500         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220201 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
    When Admin sets the business date to "20230215"
    And Customer makes "AUTOPAY" repayment on "20220215" with 400 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 | 20220201 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 28   | 20220301    | 20220215 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 4  | 31   | 20220401    |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 150.0 | 150.0      | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 900.0 | 400        | 0    | 100         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220201 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20220215 | Repayment        | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 100.0        |
    When Admin successfully undo disbursal
    Then Loan status has changed to "Approved"
# --- undo approval --- #
    Then Admin can successfully undone the loan approval
    Then Loan status will be "SUBMITTED_AND_PENDING_APPROVAL"

  @TestRailId:C2857
  Scenario: Single disbursement with undo disbursement when auto downpayment is enabled with manual transaction after last downpayment
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20220101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    When Admin sets the business date to "20220201"
    And Customer makes "AUTOPAY" repayment on "20220201" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 | 20220201 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 28   | 20220301    |                  | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 500.0 | 0          | 0    | 500         |
    When Admin sets the business date to "20230215"
    And Customer makes "AUTOPAY" repayment on "20220215" with 400 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 | 20220201 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 28   | 20220301    | 20220215 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 4  | 31   | 20220401    |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 150.0 | 150.0      | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 900.0 | 400        | 0    | 100         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220201 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20220215 | Repayment        | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 100.0        |
    When Admin successfully undo disbursal
    Then Loan status has changed to "Approved"
# --- undo approval --- #
    Then Admin can successfully undone the loan approval
    Then Loan status will be "SUBMITTED_AND_PENDING_APPROVAL"

  @TestRailId:C2858
  Scenario: Multi disbursement with undo last disbursement when auto downpayment is enabled without manual transaction after last downpayment
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20220101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "2000" amount and expected disbursement date on "20220101"
    When Admin disburses the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250  | 0          | 0    | 750         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
    Then LoanDisbursalTransactionBusinessEvent has changedTerms "false"
    When Admin sets the business date to "20220115"
    When Admin disburses the loan on "20220115" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220115  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220115  | 20220115 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20220201 |                 | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 4  | 28   | 20220301    |                 | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 500  | 0          | 0    | 1500        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220115  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1750.0       |
      | 20220115  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1500.0       |
    Then LoanDisbursalTransactionBusinessEvent has changedTerms "false"
    When Admin successfully undo last disbursal
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250  | 0          | 0    | 750         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
# --- close the loan --- #
    When Loan Pay-off is made on "20220115"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2859
  Scenario: Multi disbursement with undo last disbursement when auto downpayment is disabled without manual transaction after last downpayment
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20220101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "2000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20220201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 0.0  | 0          | 0    | 1000        |
    And Customer makes "AUTOPAY" repayment on "20220101" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    When Admin sets the business date to "20220115"
    When Admin successfully disburse the loan on "20220115" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220115  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220115  |                 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 31   | 20220201 |                 | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 4  | 28   | 20220301    |                 | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 250.0 | 0          | 0    | 1750        |
    And Customer makes "AUTOPAY" repayment on "20220115" with 250 EUR transaction amount
    When Admin successfully undo last disbursal
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
# --- close the loan --- #
    When Loan Pay-off is made on "20220115"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2866
  Scenario: Verify backdated disbursement - after down payment, before first installment due date, installment start date calculated by loan disbursement date
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20230101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20230101" with "2000" amount and expected disbursement date on "20230101"
    When Admin sets the business date to "20230105"
    When Admin successfully disburse the loan on "20230105" with "1000" EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230105" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230105  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230105  | 20230105 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20230205 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20230305    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20230405    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230105  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230105  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
    When Admin sets the business date to "20230108"
    When Admin successfully disburse the loan on "20230102" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230102  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230102  | 20230105 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      |    |      | 20230105  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 2  | 0    | 20230105  |                 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 3  | 31   | 20230202 |                 | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0   | 500.0       |
      | 4  | 28   | 20230302    |                 | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0   | 500.0       |
      | 5  | 31   | 20230402    |                 | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0   | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 250.0 | 0          | 250  | 1750        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230102  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230105  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 2000.0       |
      | 20230105  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1750.0       |
# --- close the loan --- #
    When Loan Pay-off is made on "20230108"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2867
  Scenario: Verify backdated disbursement - second disbursement placed on after down payment, after first installment paid on due date, and takes place before first installment due date
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20230101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20230101" with "2000" amount and expected disbursement date on "20230101"
    When Admin sets the business date to "20230105"
    When Admin successfully disburse the loan on "20230105" with "1000" EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230105" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230105  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230105  | 20230105 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20230205 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20230305    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20230405    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230105  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230105  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
    When Admin sets the business date to "20230205"
    And Customer makes "AUTOPAY" repayment on "20230205" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230105  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230105  | 20230105  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20230205 | 20230205 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 28   | 20230305    |                  | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20230405    |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 500.0 | 0          | 0    | 500         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230105  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230105  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230205 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
    When Admin sets the business date to "20230210"
    When Admin successfully disburse the loan on "20230201" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230105  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230105  | 20230105  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      |    |      | 20230201 |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 2  | 0    | 20230201 | 20230205 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 3  | 31   | 20230205 |                  | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0   | 500.0       |
      | 4  | 28   | 20230305    |                  | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0   | 500.0       |
      | 5  | 31   | 20230405    |                  | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0   | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 500.0 | 0          | 250  | 1500        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230105  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230105  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230201 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1750.0       |
      | 20230205 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1500.0       |
# --- close the loan --- #
    When Loan Pay-off is made on "20230210"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2868
  Scenario: Verify backdated disbursement - after down payment, before first installment due date, installment start date calculated by loan submitted on date
    When Admin sets repaymentStartDateType for "LP2_DOWNPAYMENT" loan product to "SUBMITTED_ON_DATE"
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20230101   | 2000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20230101" with "2000" amount and expected disbursement date on "20230101"
    When Admin sets the business date to "20230105"
    When Admin successfully disburse the loan on "20230105" with "1000" EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230105" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230105  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230105  | 20230105 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20230201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20230301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20230401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 250.0 | 0          | 0    | 750         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230105  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230105  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
    When Admin sets the business date to "20230108"
    When Admin successfully disburse the loan on "20230102" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230102  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230102  | 20230105 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      |    |      | 20230105  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 2  | 0    | 20230105  |                 | 1500.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 3  | 31   | 20230201 |                 | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0   | 500.0       |
      | 4  | 28   | 20230301    |                 | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0   | 500.0       |
      | 5  | 31   | 20230401    |                 | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0   | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 2000.0        | 0        | 0    | 0         | 2000.0 | 250.0 | 0          | 250  | 1750        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230102  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230105  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 2000.0       |
      | 20230105  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1750.0       |
    When Admin sets repaymentStartDateType for "LP2_DOWNPAYMENT" loan product to "DISBURSEMENT_DATE"
# --- close the loan --- #
    When Loan Pay-off is made on "20230108"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2869
  Scenario: Verify correct Loan Repayment EMI Amount is calculated and is rounded off if loan product installmentAmountInMultiplesOf is set
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20220101   | 1250           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1250" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1250" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1250.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 938.0           | 312.0         | 0.0      | 0.0  | 0.0       | 312.0 | 0.0  | 0.0        | 0.0  | 312.0       |
      | 2  | 31   | 20220201 |           | 625.0           | 313.0         | 0.0      | 0.0  | 0.0       | 313.0 | 0.0  | 0.0        | 0.0  | 313.0       |
      | 3  | 28   | 20220301    |           | 312.0           | 313.0         | 0.0      | 0.0  | 0.0       | 313.0 | 0.0  | 0.0        | 0.0  | 313.0       |
      | 4  | 31   | 20220401    |           | 0.0             | 312.0         | 0.0      | 0.0  | 0.0       | 312.0 | 0.0  | 0.0        | 0.0  | 312.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1250.0        | 0        | 0    | 0         | 1250.0 | 0.0  | 0          | 0    | 1250        |
# --- close the loan --- #
    When Loan Pay-off is made on "20220101"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2882
  Scenario: Verify Loan Repayment Due and Overdue events for downpayment
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20220101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment Due Business Event is created
    When Admin sets the business date to "20220104"
    When Admin runs inline COB job for Loan
    Then Loan Repayment Overdue Business Event is created
# --- close the loan --- #
    When Loan Pay-off is made on "20220104"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2883
  Scenario: Verify that with multiple disbursement when last disbursement is reverted, downpayment will be reverted too - autopayment disabled
    When Admin sets the business date to "20230901"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20230901 | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20230901" with "1000" amount and expected disbursement date on "20230901"
    When Admin successfully disburse the loan on "20230901" with "1000" EUR transaction amount
    When Admin sets the business date to "20230905"
    And Customer makes "AUTOPAY" repayment on "20230905" with 500 EUR transaction amount
    When Admin sets the business date to "20230911"
    When Admin successfully disburse the loan on "20230911" with "500" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230901 | 20230905 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      |    |      | 20230911 |                   | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 2  | 0    | 20230911 | 20230905 | 1125.0          | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 125.0      | 0.0   | 0.0         |
      | 3  | 15   | 20230916 |                   | 750.0           | 375.0         | 0.0      | 0.0  | 0.0       | 375.0 | 125.0 | 125.0      | 0.0   | 250.0       |
      | 4  | 15   | 20231001   |                   | 375.0           | 375.0         | 0.0      | 0.0  | 0.0       | 375.0 | 0.0   | 0.0        | 0.0   | 375.0       |
      | 5  | 15   | 20231016   |                   | 0.0             | 375.0         | 0.0      | 0.0  | 0.0       | 375.0 | 0.0   | 0.0        | 0.0   | 375.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1500.0        | 0        | 0.0  | 0         | 1500.0 | 500.0 | 250.0      | 250.0 | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230905 | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230911 | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin successfully undo last disbursal
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230901 | 20230905 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 15   | 20230916 | 20230905 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0   | 0.0         |
      | 3  | 15   | 20231001   |                   | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0        | 0.0  | 0         | 1000.0 | 500.0 | 250.0      | 250.0 | 500.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230905 | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 500.0        |
# --- close the loan --- #
    When Loan Pay-off is made on "20230911"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2884
  Scenario: Verify that with multiple disbursement when last disbursement is reverted, downpayment will be reverted too - autopayment enabled
    When Admin sets the business date to "20230901"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20230901 | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20230901" with "1000" amount and expected disbursement date on "20230901"
    When Admin successfully disburse the loan on "20230901" with "1000" EUR transaction amount
    When Admin sets the business date to "20230905"
    And Customer makes "AUTOPAY" repayment on "20230905" with 500 EUR transaction amount
    When Admin sets the business date to "20230911"
    When Admin successfully disburse the loan on "20230911" with "500" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20230911 |                   | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20230911 | 20230905 | 1125.0          | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 125.0      | 0.0  | 0.0         |
      | 3  | 15   | 20230916 | 20230905 | 750.0           | 375.0         | 0.0      | 0.0  | 0.0       | 375.0 | 375.0 | 375.0      | 0.0  | 0.0         |
      | 4  | 15   | 20231001   |                   | 375.0           | 375.0         | 0.0      | 0.0  | 0.0       | 375.0 | 125.0 | 125.0      | 0.0  | 250.0       |
      | 5  | 15   | 20231016   |                   | 0.0             | 375.0         | 0.0      | 0.0  | 0.0       | 375.0 | 0.0   | 0.0        | 0.0  | 375.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1500.0        | 0        | 0.0  | 0         | 1500.0 | 875.0 | 625.0      | 0.0  | 625.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230905 | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 250.0        |
      | 20230911 | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230911 | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 625.0        |
    When Admin successfully undo last disbursal
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230905 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 3  | 15   | 20231001   | 20230905 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0.0  | 0         | 1000.0 | 750.0 | 500.0      | 0.0  | 250.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230905 | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 250.0        |
# --- close the loan --- #
    When Loan Pay-off is made on "20230911"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2913
  @AdvancedPaymentAllocation
  Scenario: Verify that down-payment Installments are available in the repayment schedule for CREATED, APPROVED and DISBURSED states of the loan account
    When Admin sets the business date to "20230901"
    And Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230901 | 400            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230901 |           | 400.0           |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 0    | 20230901 |           | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0  | 0.0        | 0.0  | 100.0       |
      | 2  | 15   | 20230916 |           | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0  | 0.0        | 0.0  | 100.0       |
      | 3  | 15   | 20231001   |           | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0  | 0.0        | 0.0  | 100.0       |
      | 4  | 15   | 20231016   |           | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0  | 0.0        | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 400.0         | 0        | 0.0  | 0         | 400.0 | 0.0  | 0.0        | 0.0  | 400.0       |
    When Admin sets the business date to "20230902"
    And Admin successfully approves the loan on "20230902" with "400" amount and expected disbursement date on "20230902"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230902 |           | 400.0           |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 0    | 20230902 |           | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0  | 0.0        | 0.0  | 100.0       |
      | 2  | 15   | 20230917 |           | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0  | 0.0        | 0.0  | 100.0       |
      | 3  | 15   | 20231002   |           | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0  | 0.0        | 0.0  | 100.0       |
      | 4  | 15   | 20231017   |           | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0  | 0.0        | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 400.0         | 0        | 0.0  | 0         | 400.0 | 0.0  | 0.0        | 0.0  | 400.0       |
    When Admin sets the business date to "20230903"
    And Admin successfully disburse the loan on "20230903" with "400" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230903 |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230903 | 20230903 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230918 |                   | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 3  | 15   | 20231003   |                   | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 4  | 15   | 20231018   |                   | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 400.0         | 0        | 0.0  | 0         | 400.0 | 100.0 | 0.0        | 0.0  | 300.0       |
    When Admin sets the business date to "20230904"
    And Admin successfully disburse the loan on "20230904" with "200" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230903 |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230903 | 20230903 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20230904 |                   | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20230904 | 20230904 | 450.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 50.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20230918 |                   | 300.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0   | 0.0        | 0.0  | 150.0       |
      | 4  | 15   | 20231003   |                   | 150.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0   | 0.0        | 0.0  | 150.0       |
      | 5  | 15   | 20231018   |                   | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0   | 0.0        | 0.0  | 150.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 600.0         | 0        | 0.0  | 0         | 600.0 | 150.0 | 0.0        | 0.0  | 450.0       |
# --- close the loan --- #
    When Loan Pay-off is made on "20230904"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2938
  Scenario: Multiple disbursements on same day - auto enabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20220101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20220101" due date and 50 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 250.0 | 0          | 0    | 800         |
    When Admin sets the business date to "20220201"
    When Admin successfully disburse the loan on "20220201" with "200" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220201 |                  | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220201 | 20220201 | 900.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 50.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20220201 |                  | 600.0           | 300.0         | 0.0      | 0.0  | 50.0      | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
      | 4  | 28   | 20220301    |                  | 300.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 5  | 31   | 20220401    |                  | 0.0             | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1200.0        | 0        | 0    | 50        | 1250.0 | 300.0 | 0          | 0    | 950         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220201 | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 950.0        |
      | 20220201 | Down Payment     | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 900.0        |
    When Admin successfully disburse the loan on "20220201" with "200" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220201 |                  | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20220201 |                  | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220201 | 20220201 | 1100.0          | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 50.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 0    | 20220201 | 20220201 | 1050.0          | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 50.0  | 0.0        | 0.0  | 0.0         |
      | 4  | 31   | 20220201 |                  | 700.0           | 350.0         | 0.0      | 0.0  | 50.0      | 400.0 | 0.0   | 0.0        | 0.0  | 400.0       |
      | 5  | 28   | 20220301    |                  | 350.0           | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
      | 6  | 31   | 20220401    |                  | 0.0             | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1400.0        | 0        | 0    | 50        | 1450.0 | 350.0 | 0          | 0    | 1100        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220201 | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 950.0        |
      | 20220201 | Down Payment     | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 900.0        |
      | 20220201 | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1100.0       |
      | 20220201 | Down Payment     | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 1050.0       |
# --- close the loan --- #
    When Loan Pay-off is made on "20220201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2939
  Scenario: Multiple disbursements on same day - auto disabled
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20220101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20220101" due date and 50 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20220101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20220101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20220201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
      | 3  | 28   | 20220301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 0.0  | 0          | 0    | 1050        |
    And Customer makes "DOWN_PAYMENT" repayment on "20220101" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20220201 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 50.0      | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 3  | 28   | 20220301    |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20220401    |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 50        | 1050.0 | 250.0 | 0          | 0    | 800         |
    When Admin sets the business date to "20220201"
    When Admin successfully disburse the loan on "20220201" with "200" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220201 |                 | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220201 |                 | 900.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 0.0   | 0.0        | 0.0  | 50.0        |
      | 3  | 31   | 20220201 |                 | 600.0           | 300.0         | 0.0      | 0.0  | 50.0      | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
      | 4  | 28   | 20220301    |                 | 300.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 5  | 31   | 20220401    |                 | 0.0             | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1200.0        | 0        | 0    | 50        | 1250.0 | 250.0 | 0          | 0    | 1000        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220201 | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 950.0        |
    When Admin successfully disburse the loan on "20220201" with "200" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20220101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20220101  | 20220101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20220201 |                 | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20220201 |                 | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20220201 |                 | 1100.0          | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 0.0   | 0.0        | 0.0  | 50.0        |
      | 3  | 0    | 20220201 |                 | 1050.0          | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 0.0   | 0.0        | 0.0  | 50.0        |
      | 4  | 31   | 20220201 |                 | 700.0           | 350.0         | 0.0      | 0.0  | 50.0      | 400.0 | 0.0   | 0.0        | 0.0  | 400.0       |
      | 5  | 28   | 20220301    |                 | 350.0           | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
      | 6  | 31   | 20220401    |                 | 0.0             | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1400.0        | 0        | 0    | 50        | 1450.0 | 250.0 | 0          | 0    | 1200        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20220101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20220101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20220201 | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 950.0        |
      | 20220201 | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1150.0       |
# --- close the loan --- #
    When Loan Pay-off is made on "20220201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3017
  Scenario: Verify that repayment schedule is managed properly in case of LP2 product with two disbursement on the same day
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "100" EUR transaction amount
    When Admin successfully disburse the loan on "20231001" with "900" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20231001  |                 | 900.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 975.0           | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 0    | 20231001  | 20231001 | 750.0           | 225.0         | 0.0      | 0.0  | 0.0       | 225.0 | 225.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231016  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231031  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 5  | 15   | 20231115 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20231001  | Down Payment     | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         |
      | 20231001  | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 975.0        |
      | 20231001  | Down Payment     | 225.0  | 225.0     | 0.0      | 0.0  | 0.0       | 750.0        |
# --- close the loan --- #
    When Loan Pay-off is made on "20231001"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3031
  Scenario: Verify that in case of auto downpayment Loan details / summary.totalRepaymentTransaction has the downpayment amount
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    Then Loan details has the downpayment amount "250" in summary.totalRepaymentTransaction
# --- close the loan --- #
    When Loan Pay-off is made on "20231001"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3061 @AdvancedPaymentAllocation
  Scenario: Verify enhanced auto downpayment for overpaid loans - UC1: overpaid amount > second disbursement amount AND overpaid amount > related downpayment amount
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240201" with "1000" amount and expected disbursement date on "20240201"
    When Admin successfully disburse the loan on "20240201" with "500" EUR transaction amount
    When Admin sets the business date to "20240216"
    And Customer makes "AUTOPAY" repayment on "20240216" with 1000 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 625 overpaid amount
    When Admin sets the business date to "20240220"
    When Admin successfully disburse the loan on "20240220" with "400" EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 225 overpaid amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240201 |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240201 | 20240201 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240216 | 20240216 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20240220 |                  | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 3  | 0    | 20240220 | 20240220 | 550.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240302    | 20240220 | 275.0           | 275.0         | 0.0      | 0.0  | 0.0       | 275.0 | 275.0 | 275.0      | 0.0  | 0.0         |
      | 5  | 15   | 20240317    | 20240220 | 0.0             | 275.0         | 0.0      | 0.0  | 0.0       | 275.0 | 275.0 | 275.0      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 900.0         | 0.0      | 0.0  | 0.0       | 900.0 | 900.0 | 550.0      | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240201 | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20240201 | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20240216 | Repayment        | 1000.0 | 375.0     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20240220 | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          |
# --- close the loan --- #
    When Admin makes Credit Balance Refund transaction on "20240220" with 225 EUR transaction amount
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3062 @AdvancedPaymentAllocation
  Scenario: Verify enhanced auto downpayment for overpaid loans - UC2: overpaid amount = second disbursement amount AND overpaid amount > related downpayment amount
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240201" with "1000" amount and expected disbursement date on "20240201"
    When Admin successfully disburse the loan on "20240201" with "500" EUR transaction amount
    When Admin sets the business date to "20240216"
    And Customer makes "AUTOPAY" repayment on "20240216" with 1000 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 625 overpaid amount
    When Admin sets the business date to "20240220"
    When Admin successfully disburse the loan on "20240220" with "625" EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240201 |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240201 | 20240201 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240216 | 20240216 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20240220 |                  | 625.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 3  | 0    | 20240220 | 20240220 | 719.0           | 156.0         | 0.0      | 0.0  | 0.0       | 156.0 | 156.0 | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240302    | 20240220 | 359.0           | 360.0         | 0.0      | 0.0  | 0.0       | 360.0 | 360.0 | 360.0      | 0.0  | 0.0         |
      | 5  | 15   | 20240317    | 20240220 | 0.0             | 359.0         | 0.0      | 0.0  | 0.0       | 359.0 | 359.0 | 359.0      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 0.0       | 1125.0 | 1125.0 | 719.0      | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240201 | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20240201 | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20240216 | Repayment        | 1000.0 | 375.0     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20240220 | Disbursement     | 625.0  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          |

