@LoanChargesProgressiveLoanFeature
Feature: LoanChargesProgressiveLoan

  @TestRailId:C2910
  Scenario: Verify that adding charge on a closed loan after maturity date is creating an N+1 installment - LP2 auto payment enabled
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    And Customer makes "AUTOPAY" repayment on "20231016" with 250 EUR transaction amount
    When Admin sets the business date to "20231031"
    And Customer makes "AUTOPAY" repayment on "20231031" with 250 EUR transaction amount
    When Admin sets the business date to "20231115"
    And Customer makes "AUTOPAY" repayment on "20231115" with 250 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Admin sets the business date to "20231116"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231116" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  | 20231016  | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231031  | 20231031  | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20231115 | 20231115 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 5  | 1    | 20231116 |                  | 0.0             | 0.0           | 0.0      | 20.0 | 0.0       | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 0        | 20   | 0         | 1020.0 | 1000.0 | 0          | 0    | 20          |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20231001  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20231016  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231031  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 250.0        |
      | 20231115 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231116 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    When Loan Pay-off is made on "20231116"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2911
  Scenario: Verify that adding charge on a closed loan after maturity date is creating an N+1 installment - LP2 auto payment disabled
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20231001" with 250 EUR transaction amount
    When Admin sets the business date to "20231016"
    And Customer makes "AUTOPAY" repayment on "20231016" with 250 EUR transaction amount
    When Admin sets the business date to "20231031"
    And Customer makes "AUTOPAY" repayment on "20231031" with 250 EUR transaction amount
    When Admin sets the business date to "20231115"
    And Customer makes "AUTOPAY" repayment on "20231115" with 250 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Admin sets the business date to "20231116"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231116" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  | 20231016  | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231031  | 20231031  | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20231115 | 20231115 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 5  | 1    | 20231116 |                  | 0.0             | 0.0           | 0.0      | 20.0 | 0.0       | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 0        | 20   | 0         | 1020.0 | 1000.0 | 0          | 0    | 20          |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20231001  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20231016  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231031  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 250.0        |
      | 20231115 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231116 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    When Loan Pay-off is made on "20231116"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2912 @AdvancedPaymentAllocation
  Scenario: Verify that adding charge on a closed loan after maturity date is creating an N+1 installment - LP2 advanced payment allocation product
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    And Customer makes "AUTOPAY" repayment on "20231016" with 250 EUR transaction amount
    When Admin sets the business date to "20231031"
    And Customer makes "AUTOPAY" repayment on "20231031" with 250 EUR transaction amount
    When Admin sets the business date to "20231115"
    And Customer makes "AUTOPAY" repayment on "20231115" with 250 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Admin sets the business date to "20231116"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231116" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  | 20231016  | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231031  | 20231031  | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20231115 | 20231115 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 5  | 1    | 20231116 |                  | 0.0             | 0.0           | 0.0      | 20.0 | 0.0       | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 0        | 20   | 0         | 1020.0 | 1000.0 | 0          | 0    | 20          |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20231001  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20231016  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231031  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 250.0        |
      | 20231115 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231116 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    When Loan Pay-off is made on "20231116"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2914
  Scenario: Verify that adding charge on a active loan / partial repayment after maturity date is creating an N+1 installment - LP1 product
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20231001"
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231031"
    And Customer makes "AUTOPAY" repayment on "20231031" with 800 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan has 200 outstanding amount
    When Admin sets the business date to "20231101"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231101" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20231031  |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 800.0 | 0.0        | 0.0  | 200.0       |
      | 2  | 1    | 20231101 |           | 0.0             | 0.0           | 0.0      | 20.0 | 0.0       | 20.0   | 0.0   | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20.0 | 0         | 1020.0 | 800  | 0          | 0    | 220.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20231031  | Repayment        | 800.0  | 800.0     | 0.0      | 0.0  | 0.0       | 200.0        |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231101 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    When Loan Pay-off is made on "20231101"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2915
  Scenario: Verify that adding charge on a active loan / partial repayment after maturity date is creating an N+1 installment - LP2 auto payment enabled
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    And Customer makes "AUTOPAY" repayment on "20231016" with 250 EUR transaction amount
    When Admin sets the business date to "20231031"
    And Customer makes "AUTOPAY" repayment on "20231031" with 250 EUR transaction amount
    When Admin sets the business date to "20231115"
    And Customer makes "AUTOPAY" repayment on "20231115" with 100 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan has 150 outstanding amount
    When Admin sets the business date to "20231116"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231116" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  | 20231016 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231031  | 20231031 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20231115 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 100.0 | 0.0        | 0.0  | 150.0       |
      | 5  | 1    | 20231116 |                 | 0.0             | 0.0           | 0.0      | 20.0 | 0.0       | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 20   | 0         | 1020.0 | 850.0 | 0          | 0    | 170         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20231001  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20231016  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231031  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 250.0        |
      | 20231115 | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 150.0        |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231116 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    When Loan Pay-off is made on "20231116"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2916
  Scenario: Verify that adding charge on a active loan / partial repayment after maturity date is creating an N+1 installment - LP2 auto payment disabled
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20231001" with 250 EUR transaction amount
    When Admin sets the business date to "20231016"
    And Customer makes "AUTOPAY" repayment on "20231016" with 250 EUR transaction amount
    When Admin sets the business date to "20231031"
    And Customer makes "AUTOPAY" repayment on "20231031" with 250 EUR transaction amount
    When Admin sets the business date to "20231115"
    And Customer makes "AUTOPAY" repayment on "20231115" with 100 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan has 150 outstanding amount
    When Admin sets the business date to "20231116"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231116" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  | 20231016 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231031  | 20231031 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20231115 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 100.0 | 0.0        | 0.0  | 150.0       |
      | 5  | 1    | 20231116 |                 | 0.0             | 0.0           | 0.0      | 20.0 | 0.0       | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 20   | 0         | 1020.0 | 850.0 | 0          | 0    | 170         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20231001  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20231016  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231031  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 250.0        |
      | 20231115 | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 150.0        |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231116 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    When Loan Pay-off is made on "20231116"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2917 @AdvancedPaymentAllocation
  Scenario: Verify that adding charge on an active loan / partial repayment after maturity date is creating an N+1 installment - LP2 advanced payment allocation product
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    And Customer makes "AUTOPAY" repayment on "20231016" with 250 EUR transaction amount
    When Admin sets the business date to "20231031"
    And Customer makes "AUTOPAY" repayment on "20231031" with 250 EUR transaction amount
    When Admin sets the business date to "20231115"
    And Customer makes "AUTOPAY" repayment on "20231115" with 100 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan has 150 outstanding amount
    When Admin sets the business date to "20231116"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231116" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  | 20231016 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231031  | 20231031 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20231115 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 100.0 | 0.0        | 0.0  | 150.0       |
      | 5  | 1    | 20231116 |                 | 0.0             | 0.0           | 0.0      | 20.0 | 0.0       | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 20   | 0         | 1020.0 | 850.0 | 0          | 0    | 170         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20231001  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20231016  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231031  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 250.0        |
      | 20231115 | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 150.0        |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231116 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    When Loan Pay-off is made on "20231116"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2918
  Scenario: Verify that adding charge on a active loan / no repayment made, after maturity date is creating an N+1 installment - LP1 product
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20231001"
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan has 1000 outstanding amount
    When Admin sets the business date to "20231101"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231101" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20231001  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20231031  |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 2  | 1    | 20231101 |           | 0.0             | 0.0           | 0.0      | 20.0 | 0.0       | 20.0   | 0.0  | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20.0 | 0         | 1020.0 | 0    | 0          | 0    | 1020.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231101 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    When Loan Pay-off is made on "20231101"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2919
  Scenario: Verify that adding charge on a active loan / no repayment made, after maturity date is creating an N+1 installment - LP2 auto payment enabled
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan has 750 outstanding amount
    When Admin sets the business date to "20231116"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231116" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20231031  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231115 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 5  | 1    | 20231116 |                 | 0.0             | 0.0           | 0.0      | 20.0 | 0.0       | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 20   | 0         | 1020.0 | 250.0 | 0          | 0    | 770         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20231001  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231116 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    When Loan Pay-off is made on "20231116"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2920
  Scenario: Verify that adding charge on a active loan / no repayment made, after maturity date is creating an N+1 installment - LP2 auto payment disabled
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan has 1000 outstanding amount
    When Admin sets the business date to "20231116"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231116" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20231001  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20231001  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 15   | 20231016  |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20231031  |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231115 |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 5  | 1    | 20231116 |           | 0.0             | 0.0           | 0.0      | 20.0 | 0.0       | 20.0  | 0.0  | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 20   | 0         | 1020.0 | 0.0  | 0          | 0    | 1020        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231116 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    When Loan Pay-off is made on "20231116"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2921 @AdvancedPaymentAllocation
  Scenario: Verify that adding charge on an active loan / no repayment made, after maturity date is creating an N+1 installment - LP2 advanced payment allocation product
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan has 750 outstanding amount
    When Admin sets the business date to "20231116"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231116" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20231031  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231115 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 5  | 1    | 20231116 |                 | 0.0             | 0.0           | 0.0      | 20.0 | 0.0       | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 20   | 0         | 1020.0 | 250.0 | 0          | 0    | 770         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20231001  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231116 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    When Loan Pay-off is made on "20231116"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2923 @AdvancedPaymentAllocation
  Scenario: Verify Loan charge reverse-replaying logic for LP2 advanced payment allocation product - UC1
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231010"
    And Customer makes "AUTOPAY" repayment on "20231010" with 300 EUR transaction amount
    When Admin sets the business date to "20231020"
    And Customer makes "AUTOPAY" repayment on "20231020" with 250 EUR transaction amount
    When Admin sets the business date to "20231110"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231009" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  | 20231010 | 500.0           | 250.0         | 0.0      | 20.0 | 0.0       | 270.0 | 270.0 | 270.0      | 0.0  | 0.0         |
      | 3  | 15   | 20231031  | 20231020 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 4  | 15   | 20231115 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 30.0  | 30.0       | 0.0  | 220.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 800.0 | 550.0      | 0.0  | 220.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20231001  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20231010  | Repayment        | 300.0  | 280.0     | 0.0      | 20.0 | 0.0       | 470.0        |
      | 20231020  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 220.0        |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231009 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    When Loan Pay-off is made on "20231110"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2924 @AdvancedPaymentAllocation
  Scenario: Verify Loan charge reverse-replaying logic for LP2 advanced payment allocation product - UC2
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231010"
    And Customer makes "AUTOPAY" repayment on "20231010" with 300 EUR transaction amount
    When Admin sets the business date to "20231020"
    And Customer makes "AUTOPAY" repayment on "20231020" with 250 EUR transaction amount
    When Admin sets the business date to "20231110"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231010" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  | 20231020 | 500.0           | 250.0         | 0.0      | 20.0 | 0.0       | 270.0 | 270.0 | 250.0      | 20.0 | 0.0         |
      | 3  | 15   | 20231031  | 20231020 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 4  | 15   | 20231115 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 30.0  | 30.0       | 0.0  | 220.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 800.0 | 530.0      | 20.0 | 220.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20231001  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20231010  | Repayment        | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 450.0        |
      | 20231020  | Repayment        | 250.0  | 230.0     | 0.0      | 20.0 | 0.0       | 220.0        |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231010 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    When Loan Pay-off is made on "20231110"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2925 @AdvancedPaymentAllocation
  Scenario: Verify Loan charge reverse-replaying logic for LP2 advanced payment allocation product - UC3
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231010"
    And Customer makes "AUTOPAY" repayment on "20231010" with 300 EUR transaction amount
    When Admin sets the business date to "20231020"
    And Customer makes "AUTOPAY" repayment on "20231020" with 250 EUR transaction amount
    When Admin sets the business date to "20231110"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231011" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  | 20231020 | 500.0           | 250.0         | 0.0      | 20.0 | 0.0       | 270.0 | 270.0 | 250.0      | 20.0 | 0.0         |
      | 3  | 15   | 20231031  | 20231020 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 4  | 15   | 20231115 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 30.0  | 30.0       | 0.0  | 220.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 800.0 | 530.0      | 20.0 | 220.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20231001  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20231010  | Repayment        | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 450.0        |
      | 20231020  | Repayment        | 250.0  | 230.0     | 0.0      | 20.0 | 0.0       | 220.0        |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231011 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    When Loan Pay-off is made on "20231110"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2926 @AdvancedPaymentAllocation
  Scenario: Verify Loan charge reverse-replaying logic for LP2 advanced payment allocation product - UC4
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231010"
    And Customer makes "AUTOPAY" repayment on "20231010" with 300 EUR transaction amount
    When Admin sets the business date to "20231020"
    And Customer makes "AUTOPAY" repayment on "20231020" with 250 EUR transaction amount
    When Admin sets the business date to "20231110"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231016" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  | 20231020 | 500.0           | 250.0         | 0.0      | 20.0 | 0.0       | 270.0 | 270.0 | 250.0      | 20.0 | 0.0         |
      | 3  | 15   | 20231031  | 20231020 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 4  | 15   | 20231115 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 30.0  | 30.0       | 0.0  | 220.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 800.0 | 530.0      | 20.0 | 220.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20231001  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20231010  | Repayment        | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 450.0        |
      | 20231020  | Repayment        | 250.0  | 230.0     | 0.0      | 20.0 | 0.0       | 220.0        |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231016 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    When Loan Pay-off is made on "20231110"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2927 @AdvancedPaymentAllocation
  Scenario: Verify Loan charge reverse-replaying logic for LP2 advanced payment allocation product - UC5
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231010"
    And Customer makes "AUTOPAY" repayment on "20231010" with 300 EUR transaction amount
    When Admin sets the business date to "20231020"
    And Customer makes "AUTOPAY" repayment on "20231020" with 250 EUR transaction amount
    When Admin sets the business date to "20231110"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231017" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  | 20231010 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 3  | 15   | 20231031  | 20231020 | 250.0           | 250.0         | 0.0      | 20.0 | 0.0       | 270.0 | 270.0 | 270.0      | 0.0  | 0.0         |
      | 4  | 15   | 20231115 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 30.0  | 30.0       | 0.0  | 220.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 800.0 | 550.0      | 0.0  | 220.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20231001  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20231010  | Repayment        | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 450.0        |
      | 20231020  | Repayment        | 250.0  | 230.0     | 0.0      | 20.0 | 0.0       | 220.0        |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231017 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    When Loan Pay-off is made on "20231110"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2928 @AdvancedPaymentAllocation
  Scenario: Verify Loan charge reverse-replaying logic for LP2 advanced payment allocation product - UC6
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    And Customer makes "AUTOPAY" repayment on "20231016" with 300 EUR transaction amount
    When Admin sets the business date to "20231110"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231010" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  | 20231016 | 500.0           | 250.0         | 0.0      | 20.0 | 0.0       | 270.0 | 270.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231031  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 30.0  | 30.0       | 0.0  | 220.0       |
      | 4  | 15   | 20231115 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 550.0 | 30.0       | 0.0  | 470.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20231001  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20231016  | Repayment        | 300.0  | 280.0     | 0.0      | 20.0 | 0.0       | 470.0        |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231010 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    When Loan Pay-off is made on "20231110"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2929 @AdvancedPaymentAllocation
  Scenario: Verify Loan charge reverse-replaying logic for LP2 advanced payment allocation product - UC7
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    And Customer makes "AUTOPAY" repayment on "20231016" with 300 EUR transaction amount
    When Admin sets the business date to "20231110"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231016" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  |                 | 500.0           | 250.0         | 0.0      | 20.0 | 0.0       | 270.0 | 250.0 | 0.0        | 0.0  | 20.0        |
      | 3  | 15   | 20231031  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 50.0  | 50.0       | 0.0  | 200.0       |
      | 4  | 15   | 20231115 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 550.0 | 50.0       | 0.0  | 470.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20231001  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20231016  | Repayment        | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 450.0        |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231016 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    When Loan Pay-off is made on "20231110"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2930 @AdvancedPaymentAllocation
  Scenario: Verify Loan charge reverse-replaying logic for LP2 advanced payment allocation product - UC8
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    And Customer makes "AUTOPAY" repayment on "20231016" with 300 EUR transaction amount
    When Admin sets the business date to "20231110"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231017" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  | 20231016 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231031  |                 | 250.0           | 250.0         | 0.0      | 20.0 | 0.0       | 270.0 | 50.0  | 50.0       | 0.0  | 220.0       |
      | 4  | 15   | 20231115 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 550.0 | 50.0       | 0.0  | 470.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20231001  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20231016  | Repayment        | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 450.0        |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231017 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    When Loan Pay-off is made on "20231110"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2931 @AdvancedPaymentAllocation
  Scenario: Verify Loan charge reverse-replaying logic for LP2 advanced payment allocation product - UC9
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    And Customer makes "AUTOPAY" repayment on "20231016" with 300 EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231016" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  |                 | 500.0           | 250.0         | 0.0      | 20.0 | 0.0       | 270.0 | 250.0 | 0.0        | 0.0  | 20.0        |
      | 3  | 15   | 20231031  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 50.0  | 50.0       | 0.0  | 200.0       |
      | 4  | 15   | 20231115 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 550.0 | 50.0       | 0.0  | 470.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20231001  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20231016  | Repayment        | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 450.0        |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231016 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    When Loan Pay-off is made on "20231016"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2932 @AdvancedPaymentAllocation
  Scenario: Verify Loan charge reverse-replaying logic for LP2 advanced payment allocation product - UC10
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231016" due date and 20 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20231016" with 300 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  | 20231016 | 500.0           | 250.0         | 0.0      | 20.0 | 0.0       | 270.0 | 270.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231031  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 30.0  | 30.0       | 0.0  | 220.0       |
      | 4  | 15   | 20231115 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 550.0 | 30.0       | 0.0  | 470.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20231001  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20231016  | Repayment        | 300.0  | 280.0     | 0.0      | 20.0 | 0.0       | 470.0        |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231016 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    When Loan Pay-off is made on "20231016"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2933 @AdvancedPaymentAllocation
  Scenario: Verify Loan charge reverse-replaying logic for LP2 advanced payment allocation product - UC11
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231015"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231015" due date and 20 EUR transaction amount
    When Admin sets the business date to "20231016"
    And Customer makes "AUTOPAY" repayment on "20231016" with 300 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  | 20231016 | 500.0           | 250.0         | 0.0      | 20.0 | 0.0       | 270.0 | 270.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231031  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 30.0  | 30.0       | 0.0  | 220.0       |
      | 4  | 15   | 20231115 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 550.0 | 30.0       | 0.0  | 470.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20231001  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20231016  | Repayment        | 300.0  | 280.0     | 0.0      | 20.0 | 0.0       | 470.0        |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20231015 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    When Loan Pay-off is made on "20231016"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2993
  Scenario: Waive charge on LP2 cumulative loan product
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230101   | 750            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230101" with "750" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "750" EUR transaction amount
    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 250 EUR transaction amount
    When Admin sets the business date to "20230301"
    And Customer makes "AUTOPAY" repayment on "20230301" with 250 EUR transaction amount
    When Admin sets the business date to "20230401"
    And Customer makes "AUTOPAY" repayment on "20230401" with 250 EUR transaction amount
    When Customer makes a repayment undo on "20230401"
    When Admin sets the business date to "20230405"
    And Admin adds an NSF fee because of payment bounce with "20230405" transaction date
    When Admin sets the business date to "20230407"
    And Admin waives charge
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of     | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20230405 | Flat             | 10.0 | 0.0  | 10.0   | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement       | 750.0  | 0.0       | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230101  | Down Payment       | 188.0  | 188.0     | 0.0      | 0.0  | 0.0       | 562.0        |
      | 20230201 | Repayment          | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 312.0        |
      | 20230301    | Repayment          | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 62.0         |
      | 20230401    | Repayment          | 250.0  | 62.0      | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20230405    | Waive loan charges | 10.0   | 0.0       | 0.0      | 0.0  | 0.0       | 62.0         |
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230401" is reverted
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Waived | Outstanding |
      |    |      | 20230101  |                  | 750.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |        |             |
      | 1  | 0    | 20230101  | 20230101  | 562.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 188.0 | 0.0        | 0.0   | 0.0    | 0.0         |
      | 2  | 15   | 20230116  | 20230201 | 375.0           | 187.0         | 0.0      | 0.0  | 0.0       | 187.0 | 187.0 | 0.0        | 187.0 | 0.0    | 0.0         |
      | 3  | 15   | 20230131  | 20230301    | 188.0           | 187.0         | 0.0      | 0.0  | 0.0       | 187.0 | 187.0 | 0.0        | 187.0 | 0.0    | 0.0         |
      | 4  | 15   | 20230215 |                  | 0.0             | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 126.0 | 0.0        | 126.0 | 0.0    | 62.0        |
      | 5  | 49   | 20230405    | 20230405    | 0.0             | 0.0           | 0.0      | 0.0  | 10.0      | 10.0  | 0.0   | 0.0        | 0.0   | 10.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due | Paid  | In advance | Late | Waived | Outstanding |
      | 750           | 0        | 0    | 10        | 760 | 688.0 | 0          | 500  | 10     | 62.0        |
    When Loan Pay-off is made on "20230407"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2994
  Scenario: Waive charge on LP2 progressive loan
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20230101   | 750            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230101" with "750" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "750" EUR transaction amount
    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 250 EUR transaction amount
    When Admin sets the business date to "20230301"
    And Customer makes "AUTOPAY" repayment on "20230301" with 250 EUR transaction amount
    When Admin sets the business date to "20230401"
    And Customer makes "AUTOPAY" repayment on "20230401" with 250 EUR transaction amount
    When Customer makes a repayment undo on "20230401"
    When Admin sets the business date to "20230405"
    And Admin adds an NSF fee because of payment bounce with "20230405" transaction date
    When Admin sets the business date to "20230407"
    And Admin waives charge
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of     | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20230405 | Flat             | 10.0 | 0.0  | 10.0   | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement       | 750.0  | 0.0       | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230201 | Repayment          | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230301    | Repayment          | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 250.0        |
      | 20230401    | Repayment          | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20230405    | Waive loan charges | 10.0   | 0.0       | 0.0      | 0.0  | 0.0       | 250.0        |
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230401" is reverted
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Waived | Outstanding |
      |    |      | 20230101  |                  | 750.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |        |             |
      | 1  | 0    | 20230101  | 20230201 | 562.5           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 187.5 | 0.0        | 187.5 | 0.0    | 0.0         |
      | 2  | 15   | 20230116  | 20230301    | 375.0           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 187.5 | 0.0        | 187.5 | 0.0    | 0.0         |
      | 3  | 15   | 20230131  |                  | 187.5           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 125.0 | 0.0        | 125.0 | 0.0    | 62.5        |
      | 4  | 15   | 20230215 |                  | 0.0             | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 0.0   | 0.0        | 0.0   | 0.0    | 187.5       |
      | 5  | 49   | 20230405    | 20230405    | 0.0             | 0.0           | 0.0      | 0.0  | 10.0      | 10.0  | 0.0   | 0.0        | 0.0   | 10.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Waived | Outstanding |
      | 750           | 0        | 0    | 10        | 760 | 500  | 0          | 500  | 10     | 250         |
    When Loan Pay-off is made on "20230407"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C2995
  Scenario: Verify that when a charge added after maturity had been waived the added N+1 installment will be paid with a paid by date (obligations met date) of the transaction date of the waive charge transaction
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20230101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230222"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230222" due date and 100 EUR transaction amount
    When Admin sets the business date to "20230331"
    And Admin waives due date charge
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Waived | Outstanding |
      |    |      | 20230101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |        |             |
      | 1  | 0    | 20230101  |                  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 0.0    | 250.0       |
      | 2  | 15   | 20230116  |                  | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 0.0    | 250.0       |
      | 3  | 15   | 20230131  |                  | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 0.0    | 250.0       |
      | 4  | 15   | 20230215 |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 0.0    | 250.0       |
      | 5  | 7    | 20230222 | 20230222 | 0.0             | 0.0           | 0.0      | 0.0  | 100.0     | 100.0 | 0.0  | 0.0        | 0.0  | 100.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Waived | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 100.0     | 1100.0 | 0.0  | 0.0        | 0.0  | 100.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement       | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230222 | Waive loan charges | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of        | Calculation type | Due   | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20230222 | Flat             | 100.0 | 0.0  | 100.0  | 0.0         |
    When Loan Pay-off is made on "20230331"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4014
  Scenario: Verify Loan Charge together with paid installments with amounts zero - UC1
    When Admin sets the business date to "20250411"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250411     | 1001           | 12.25                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250411" with "209.72" amount and expected disbursement date on "20250411"
    And Admin successfully disburse the loan on "20250411" with "209.72" EUR transaction amount
    And Admin sets the business date to "20250511"
    And Customer makes "AUTOPAY" repayment on "20250511" with 9.9 EUR transaction amount
    And Admin sets the business date to "20250611"
    And Customer makes "AUTOPAY" repayment on "20250611" with 9.9 EUR transaction amount
    And Admin sets the business date to "20250711"
    And Customer makes "AUTOPAY" repayment on "20250711" with 9.9 EUR transaction amount
    And Admin sets the business date to "20250811"
    And Customer makes "AUTOPAY" repayment on "20250811" with 9.9 EUR transaction amount
    And Admin sets the business date to "20250813"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250813" with 188.8 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid  | In advance | Late | Outstanding |
      | 1  | 30   | 20250511       | 20250511    | 201.96          | 7.76          | 2.14     | 0.0  | 0.0       | 9.9  | 9.9   | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250611      | 20250611   | 194.12          | 7.84          | 2.06     | 0.0  | 0.0       | 9.9  | 9.9  | 0.0        | 0.0  | 0.0         |
      | 3  | 30   | 20250711      | 20250711   | 186.2           | 7.92          | 1.98     | 0.0  | 0.0       | 9.9  | 9.9  | 0.0        | 0.0  | 0.0         |
      | 4  | 31   | 20250811    | 20250811 | 178.2           | 8.0           | 1.9      | 0.0  | 0.0       | 9.9  | 9.9  | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20250911 | 20250813 | 178.2           | 0.0           | 0.12     | 0.0  | 0.0       | 0.12 | 0.12 | 0.12       | 0.0  | 0.0         |
      | 6  | 30   | 20251011   | 20250813 | 178.2           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 7  | 31   | 20251111  | 20250813 | 168.3           | 9.9           | 0.0      | 0.0  | 0.0       | 9.9  | 9.9  | 9.9        | 0.0  | 0.0         |
      | 8  | 30   | 20251211  | 20250813 | 158.4           | 9.9           | 0.0      | 0.0  | 0.0       | 9.9  | 9.9  | 9.9        | 0.0  | 0.0         |
      | 9  | 31   | 20260111   | 20250813 | 148.5           | 9.9           | 0.0      | 0.0  | 0.0       | 9.9  | 9.9  | 9.9        | 0.0  | 0.0         |
      | 10 | 31   | 20260211  | 20250813 | 138.6           | 9.9           | 0.0      | 0.0  | 0.0       | 9.9  | 9.9  | 9.9        | 0.0  | 0.0         |
      | 11 | 28   | 20260311     | 20250813 | 128.7           | 9.9           | 0.0      | 0.0  | 0.0       | 9.9  | 9.9  | 9.9        | 0.0  | 0.0         |
      | 12 | 31   | 20260411     | 20250813 | 118.8           | 9.9           | 0.0      | 0.0  | 0.0       | 9.9  | 9.9  | 9.9        | 0.0  | 0.0         |
      | 13 | 30   | 20260511       | 20250813 | 108.9           | 9.9           | 0.0      | 0.0  | 0.0       | 9.9  | 9.9  | 9.9        | 0.0  | 0.0         |
      | 14 | 31   | 20260611      | 20250813 | 99.0            | 9.9           | 0.0      | 0.0  | 0.0       | 9.9  | 9.9  | 9.9        | 0.0  | 0.0         |
      | 15 | 30   | 20260711      | 20250813 | 89.1            | 9.9           | 0.0      | 0.0  | 0.0       | 9.9  | 9.9  | 9.9        | 0.0  | 0.0         |
      | 16 | 31   | 20260811    | 20250813 | 79.2            | 9.9           | 0.0      | 0.0  | 0.0       | 9.9  | 9.9  | 9.9        | 0.0  | 0.0         |
      | 17 | 31   | 20260911 | 20250813 | 69.3            | 9.9           | 0.0      | 0.0  | 0.0       | 9.9  | 9.9  | 9.9        | 0.0  | 0.0         |
      | 18 | 30   | 20261011   | 20250813 | 59.4            | 9.9           | 0.0      | 0.0  | 0.0       | 9.9  | 9.9  | 9.9        | 0.0  | 0.0         |
      | 19 | 31   | 20261111  | 20250813 | 49.5            | 9.9           | 0.0      | 0.0  | 0.0       | 9.9  | 9.9  | 9.9        | 0.0  | 0.0         |
      | 20 | 30   | 20261211  | 20250813 | 39.6            | 9.9           | 0.0      | 0.0  | 0.0       | 9.9  | 9.9  | 9.9        | 0.0  | 0.0         |
      | 21 | 31   | 20270111   | 20250813 | 29.7            | 9.9           | 0.0      | 0.0  | 0.0       | 9.9  | 9.9  | 9.9        | 0.0  | 0.0         |
      | 22 | 31   | 20270211  | 20250813 | 19.8            | 9.9           | 0.0      | 0.0  | 0.0       | 9.9  | 9.9  | 9.9        | 0.0  | 0.0         |
      | 23 | 28   | 20270311     | 20250813 | 9.9             | 9.9           | 0.0      | 0.0  | 0.0       | 9.9  | 9.9  | 9.9        | 0.0  | 0.0         |
      | 24 | 31   | 20270411     | 20250813 | 0.0             | 9.9           | 0.0      | 0.0  | 0.0       | 9.9  | 9.9  | 9.9        | 0.0  | 0.0         |
    When Admin sets the business date to "20250815"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20250815" due date and 35 EUR transaction amount
    When Loan Pay-off is made on "20250815"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4018
  Scenario: Verify early repayment with MIR and charge afterwards for 24m progressive loan - UC2
    When Admin sets the business date to "20250411"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250411     | 209.72         | 12.25                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250411" with "209.72" amount and expected disbursement date on "20250411"
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250411        |                  | 209.72          |               |          | 0.0  |           | 0.0   |       |            |      | 0.0         |
      | 1  | 30   | 20250511          |                  | 201.96          |  7.76         |  2.14    | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 2  | 31   | 20250611         |                  | 194.12          |  7.84         |  2.06    | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 3  | 30   | 20250711         |                  | 186.2           |  7.92         |  1.98    | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 4  | 31   | 20250811       |                  | 178.2           |  8.0          |  1.9     | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 5  | 31   | 20250911    |                  | 170.12          |  8.08         |  1.82    | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 6  | 30   | 20251011      |                  | 161.96          |  8.16         |  1.74    | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 7  | 31   | 20251111     |                  | 153.71          |  8.25         |  1.65    | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 8  | 30   | 20251211     |                  | 145.38          |  8.33         |  1.57    | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 9  | 31   | 20260111      |                  | 136.96          |  8.42         |  1.48    | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 10 | 31   | 20260211     |                  | 128.46          |  8.5          |  1.4     | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 11 | 28   | 20260311        |                  | 119.87          |  8.59         |  1.31    | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 12 | 31   | 20260411        |                  | 111.19          |  8.68         |  1.22    | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 13 | 30   | 20260511          |                  | 102.43          |  8.76         |  1.14    | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 14 | 31   | 20260611         |                  |  93.58          |  8.85         |  1.05    | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 15 | 30   | 20260711         |                  |  84.64          |  8.94         |  0.96    | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 16 | 31   | 20260811       |                  |  75.6           |  9.04         |  0.86    | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 17 | 31   | 20260911    |                  |  66.47          |  9.13         |  0.77    | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 18 | 30   | 20261011      |                  |  57.25          |  9.22         |  0.68    | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 19 | 31   | 20261111     |                  |  47.93          |  9.32         |  0.58    | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 20 | 30   | 20261211     |                  |  38.52          |  9.41         |  0.49    | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 21 | 31   | 20270111      |                  |  29.01          |  9.51         |  0.39    | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 22 | 31   | 20270211     |                  |  19.41          |  9.6          |  0.3     | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 23 | 28   | 20270311        |                  |   9.71          |  9.7          |  0.2     | 0.0  | 0.0       | 9.9   | 0.0   | 0.0        | 0.0  | 9.9         |
      | 24 | 31   | 20270411        |                  |   0.0           |  9.71         |  0.1     | 0.0  | 0.0       | 9.81  | 0.0   | 0.0        | 0.0  | 9.81        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 209.72        | 27.79    | 0.0  | 0.0       | 237.51 |  0.0 | 0.0        | 0.0  | 237.51      |

    When Admin successfully disburse the loan on "20250411" with "209.72" EUR transaction amount
    When Admin sets the business date to "20250511"
    And Customer makes "AUTOPAY" repayment on "20250511" with 9.9 EUR transaction amount
    When Admin sets the business date to "20250611"
    And Customer makes "AUTOPAY" repayment on "20250611" with 9.9 EUR transaction amount
    When Admin sets the business date to "20250711"
    And Customer makes "AUTOPAY" repayment on "20250711" with 9.9 EUR transaction amount
    When Admin sets the business date to "20250811"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20250811" with 9.9 EUR transaction amount
    When Admin sets the business date to "20250813"
    When Admin runs inline COB job for Loan
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250813" with 188.8 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20250815"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250411        |                  | 209.72          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20250511          | 20250511      | 201.96          |  7.76         |  2.14    | 0.0  | 0.0       | 9.9   | 9.9   | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250611         | 20250611     | 194.12          |  7.84         |  2.06    | 0.0  | 0.0       | 9.9   | 9.9   | 0.0        | 0.0  | 0.0         |
      | 3  | 30   | 20250711         | 20250711     | 186.2           |  7.92         |  1.98    | 0.0  | 0.0       | 9.9   | 9.9   | 0.0        | 0.0  | 0.0         |
      | 4  | 31   | 20250811       | 20250811   | 178.2           |  8.0          |  1.9     | 0.0  | 0.0       | 9.9   | 9.9   | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20250911    | 20250813   | 178.2           |  0.0          |  0.12    | 0.0  | 0.0       | 0.12  | 0.12  | 0.12       | 0.0  | 0.0         |
      | 6  | 30   | 20251011      | 20250813   | 178.2           |  0.0          |  0.0     | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 7  | 31   | 20251111     | 20250813   | 168.3           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 8  | 30   | 20251211     | 20250813   | 158.4           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 9  | 31   | 20260111      | 20250813   | 148.5           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 10 | 31   | 20260211     | 20250813   | 138.6           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 11 | 28   | 20260311        | 20250813   | 128.7           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 12 | 31   | 20260411        | 20250813   | 118.8           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 13 | 30   | 20260511          | 20250813   | 108.9           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 14 | 31   | 20260611         | 20250813   |  99.0           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 15 | 30   | 20260711         | 20250813   |  89.1           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 16 | 31   | 20260811       | 20250813   |  79.2           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 17 | 31   | 20260911    | 20250813   |  69.3           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 18 | 30   | 20261011      | 20250813   |  59.4           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 19 | 31   | 20261111     | 20250813   |  49.5           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 20 | 30   | 20261211     | 20250813   |  39.6           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 21 | 31   | 20270111      | 20250813   |  29.7           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 22 | 31   | 20270211     | 20250813   |  19.8           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 23 | 28   | 20270311        | 20250813   |   9.9           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 24 | 31   | 20270411        | 20250813   |   0.0           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 209.72        | 8.2      | 0.0  | 0.0       | 217.92 | 217.92 | 178.32     | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount  | Principal | Interest | Fees | Penalties | Loan Balance  | Reverted | Replayed |
      | 20250411    | Disbursement           | 209.72  | 0.0       | 0.0      | 0.0  | 0.0       | 209.72        | false    | false    |
      | 20250511      | Repayment              | 9.9     | 7.76      | 2.14     | 0.0  | 0.0       | 201.96        | false    | false    |
      | 20250511      | Accrual Activity       | 2.14    | 0.0       | 2.14     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250611     | Repayment              | 9.9     | 7.84      | 2.06     | 0.0  | 0.0       | 194.12        | false    | false    |
      | 20250611     | Accrual Activity       | 2.06    | 0.0       | 2.06     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250711     | Repayment              | 9.9     | 7.92      | 1.98     | 0.0  | 0.0       | 186.2         | false    | false    |
      | 20250711     | Accrual Activity       | 1.98    | 0.0       | 1.98     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250810   | Accrual                | 8.02    | 0.0       | 8.02     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250811   | Repayment              | 9.9     | 8.0       | 1.9      | 0.0  | 0.0       | 178.2         | false    | false    |
      | 20250811   | Accrual                | 0.06    | 0.0       | 0.06     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250811   | Accrual Activity       | 1.9     | 0.0       | 1.9      | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250812   | Accrual                | 0.06    | 0.0       | 0.06     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250813   | Merchant Issued Refund | 188.8   | 178.2     | 0.12     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250813   | Interest Refund        | 7.87    | 0.0       | 0.0      | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250813   | Accrual                | 0.06    | 0.0       | 0.06     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250813   | Accrual Activity       | 0.12    | 0.0       | 0.12     | 0.0  | 0.0       | 0.0           | false    | false    |

# --- make this reversal of repayment --- #
    When Customer undo "1"th "Repayment" transaction made on "20250811"
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250815" due date and 10 EUR transaction amount
    When Admin sets the business date to "20250816"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250411        |                  | 209.72          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20250511          | 20250511      | 201.96          |  7.76         |  2.14    | 0.0  | 0.0       | 9.9   | 9.9   | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250611         | 20250611     | 194.12          |  7.84         |  2.06    | 0.0  | 0.0       | 9.9   | 9.9   | 0.0        | 0.0  | 0.0         |
      | 3  | 30   | 20250711         | 20250711     | 186.2           |  7.92         |  1.98    | 0.0  | 0.0       | 9.9   | 9.9   | 0.0        | 0.0  | 0.0         |
      | 4  | 31   | 20250811       | 20250813   | 178.2           |  8.0          |  1.9     | 0.0  | 0.0       | 9.9   | 9.9   | 0.0        | 9.9  | 0.0         |
      | 5  | 31   | 20250911    |                  | 178.2           |  0.0          |  0.12    | 0.0  | 10.0      | 10.12 | 8.57  | 8.57       | 0.0  | 1.55        |
      | 6  | 30   | 20251011      | 20250813   | 178.2           |  0.0          |  0.0     | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 7  | 31   | 20251111     | 20250813   | 168.3           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 8  | 30   | 20251211     | 20250813   | 158.4           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 9  | 31   | 20260111      | 20250813   | 148.5           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 10 | 31   | 20260211     | 20250813   | 138.6           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 11 | 28   | 20260311        | 20250813   | 128.7           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 12 | 31   | 20260411        | 20250813   | 118.8           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 13 | 30   | 20260511          | 20250813   | 108.9           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 14 | 31   | 20260611         | 20250813   |  99.0           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 15 | 30   | 20260711         | 20250813   |  89.1           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 16 | 31   | 20260811       | 20250813   |  79.2           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 17 | 31   | 20260911    | 20250813   |  69.3           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 18 | 30   | 20261011      | 20250813   |  59.4           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 19 | 31   | 20261111     | 20250813   |  49.5           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 20 | 30   | 20261211     | 20250813   |  39.6           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 21 | 31   | 20270111      | 20250813   |  29.7           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 22 | 31   | 20270211     | 20250813   |  19.8           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 23 | 28   | 20270311        | 20250813   |   9.9           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
      | 24 | 31   | 20270411        | 20250813   |   0.0           |  9.9          |  0.0     | 0.0  | 0.0       | 9.9   | 9.9   | 9.9        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 209.72        | 8.2      | 0.0  | 10.0      | 227.92 | 226.37 | 186.77     | 9.9  | 1.55        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount  | Principal | Interest | Fees | Penalties | Loan Balance  | Reverted | Replayed |
      | 20250411    | Disbursement           | 209.72  | 0.0       | 0.0      | 0.0  | 0.0       | 209.72        | false    | false    |
      | 20250511      | Repayment              | 9.9     | 7.76      | 2.14     | 0.0  | 0.0       | 201.96        | false    | false    |
      | 20250511      | Accrual Activity       | 2.14    | 0.0       | 2.14     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250611     | Repayment              | 9.9     | 7.84      | 2.06     | 0.0  | 0.0       | 194.12        | false    | false    |
      | 20250611     | Accrual Activity       | 2.06    | 0.0       | 2.06     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250711     | Repayment              | 9.9     | 7.92      | 1.98     | 0.0  | 0.0       | 186.2         | false    | false    |
      | 20250711     | Accrual Activity       | 1.98    | 0.0       | 1.98     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250810   | Accrual                | 8.02    | 0.0       | 8.02     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250811   | Repayment              | 9.9     | 8.0       | 1.9      | 0.0  | 0.0       | 178.2         | true     | false    |
      | 20250811   | Accrual                | 0.06    | 0.0       | 0.06     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250811   | Accrual Activity       | 1.9     | 0.0       | 1.9      | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250812   | Accrual                | 0.06    | 0.0       | 0.06     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250813   | Accrual                | 0.06    | 0.0       | 0.06     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250813   | Merchant Issued Refund | 188.8   | 186.2     | 1.9      | 0.0  | 0.7       | 0.0           | false    | true     |
      | 20250813   | Interest Refund        | 7.87    | 0.0       | 0.12     | 0.0  | 7.75      | 0.0           | false    | true     |
      | 20250815   | Accrual                | 10.0    | 0.0       | 0.0      | 0.0  | 10.0      | 0.0           | false    | false    |
    When Loan Pay-off is made on "20250816"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4678 @AdvancedPaymentAllocation
  Scenario: Verify changedTerms value for LoanDisbursalTransactionBusinessEvent with n+1 trm for interest bearing multidisb loan - 2nd disb with charge with due date after maturity date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSE | 20240101   | 200            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 90                | DAYS                  | 15             | DAYS                   | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    When Admin disburses the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 15   | 20240116  |           | 83.45           | 16.55         | 0.29     | 0.0  | 0.0       | 16.84 | 0.0  | 0.0        | 0.0  | 16.84       |
      | 2  | 15   | 20240131  |           | 66.85           | 16.6          | 0.24     | 0.0  | 0.0       | 16.84 | 0.0  | 0.0        | 0.0  | 16.84       |
      | 3  | 15   | 20240215 |           | 50.2            | 16.65         | 0.19     | 0.0  | 0.0       | 16.84 | 0.0  | 0.0        | 0.0  | 16.84       |
      | 4  | 15   | 20240301    |           | 33.51           | 16.69         | 0.15     | 0.0  | 0.0       | 16.84 | 0.0  | 0.0        | 0.0  | 16.84       |
      | 5  | 15   | 20240316    |           | 16.77           | 16.74         | 0.1      | 0.0  | 0.0       | 16.84 | 0.0  | 0.0        | 0.0  | 16.84       |
      | 6  | 15   | 20240331    |           | 0.0             | 16.77         | 0.05     | 0.0  | 0.0       | 16.82 | 0.0  | 0.0        | 0.0  | 16.82       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.02     | 0.0  | 0.0       | 101.02 | 0.0  | 0.0        | 0.0  | 101.02      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
    Then LoanDisbursalTransactionBusinessEvent has changedTerms "false"
    When Admin sets the business date to "20240116"
    And Customer makes "AUTOPAY" repayment on "20240116" with 16.98 EUR transaction amount
    When Admin sets the business date to "20240120"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240818" due date and 10 EUR transaction amount
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at       | Due as of      | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date   | 20240818 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 15   | 20240116  | 20240116 | 83.45           | 16.55         | 0.29     | 0.0  | 0.0       | 16.84 | 16.84 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240131  |                 | 66.85           | 16.6          | 0.24     | 0.0  | 0.0       | 16.84 | 0.14  | 0.14       | 0.0  | 16.7        |
      | 3  | 15   | 20240215 |                 | 50.2            | 16.65         | 0.19     | 0.0  | 0.0       | 16.84 | 0.0   | 0.0        | 0.0  | 16.84       |
      | 4  | 15   | 20240301    |                 | 33.51           | 16.69         | 0.15     | 0.0  | 0.0       | 16.84 | 0.0   | 0.0        | 0.0  | 16.84       |
      | 5  | 15   | 20240316    |                 | 16.77           | 16.74         | 0.1      | 0.0  | 0.0       | 16.84 | 0.0   | 0.0        | 0.0  | 16.84       |
      | 6  | 15   | 20240331    |                 | 0.0             | 16.77         | 0.05     | 0.0  | 0.0       | 16.82 | 0.0   | 0.0        | 0.0  | 16.82       |
      | 7  | 140  | 20240818   |                 | 0.0             | 0.0           | 0.0      | 10.0 | 0.0       | 10.0  | 0.0   | 0.0        | 0.0  | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.02     | 10.0 | 0.0       | 111.02 | 16.98 | 0.14       | 0.0  | 94.04       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240116  | Repayment        | 16.98  | 16.69     | 0.29     | 0.0  | 0.0       | 83.31        | false    | false    |
# --- add 2nd disbursement --- #
    When Admin sets the business date to "20240301"
    When Admin disburses the loan on "20240301" with "100" EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 15   | 20240116  | 20240116 | 83.45           | 16.55         | 0.29     | 0.0  | 0.0       | 16.84 | 16.84 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240131  |                 | 66.85           | 16.6          | 0.24     | 0.0  | 0.0       | 16.84 | 0.14  | 0.14       | 0.0  | 16.7        |
      | 3  | 15   | 20240215 |                 | 50.25           | 16.6          | 0.24     | 0.0  | 0.0       | 16.84 | 0.0   | 0.0        | 0.0  | 16.84       |
      | 4  | 15   | 20240301    |                 | 33.65           | 16.6          | 0.24     | 0.0  | 0.0       | 16.84 | 0.0   | 0.0        | 0.0  | 16.84       |
      |    |      | 20240301    |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 5  | 15   | 20240316    |                 | 66.99           | 66.66         | 0.39     | 0.0  | 0.0       | 67.05 | 0.0   | 0.0        | 0.0  | 67.05       |
      | 6  | 15   | 20240331    |                 | 0.0             | 66.99         | 0.2      | 0.0  | 0.0       | 67.19 | 0.0   | 0.0        | 0.0  | 67.19       |
      | 7  | 140  | 20240818   |                 | 0.0             | 0.0           | 0.0      | 10.0 | 0.0       | 10.0  | 0.0   | 0.0        | 0.0  | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 200.0         | 1.6      | 10.0 | 0.0       | 211.6  | 16.98 | 0.14       | 0.0  | 194.62      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240116  | Repayment        | 16.98  | 16.69     | 0.29     | 0.0  | 0.0       | 83.31        | false    | false    |
      | 20240301    | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 183.31       | false    | false    |
    Then LoanDisbursalTransactionBusinessEvent has changedTerms "false"
    When Loan Pay-off is made on "20240301"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4689
  Scenario: Verify that loan modification recalculates percentage charge based on new interest, not accumulate old and new interest
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INSTALLMENT_FEE_PERCENT_AMOUNT_CHARGES | 20260101   | 100            | 10                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
#   --- 10% Processing fee added ---
    And Admin adds a 10 % Processing charge to the loan with "en" locale on date: "20260106" - no event
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees  | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260101  |           | 100.0           |               |          | 0.0   |           | 0.0   |      |            |      | 0.0         |
      | 1  | 31   | 20260201 |           | 83.85           | 16.15         | 0.85     | 10.29 | 0.0       | 27.29 | 0.0  | 0.0        | 0.0  | 27.29       |
      | 2  | 28   | 20260301    |           | 67.49           | 16.36         | 0.64     | 0.0   | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 3  | 31   | 20260401    |           | 51.06           | 16.43         | 0.57     | 0.0   | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 4  | 30   | 20260501      |           | 34.48           | 16.58         | 0.42     | 0.0   | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 5  | 31   | 20260601     |           | 17.77           | 16.71         | 0.29     | 0.0   | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 6  | 30   | 20260701     |           | 0.0             | 17.77         | 0.15     | 0.0   | 0.0       | 17.92 | 0.0  | 0.0        | 0.0  | 17.92       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees  | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.92     | 10.29 | 0.0       | 113.21 | 0.0  | 0.0        | 0.0  | 113.21      |
    And Loan Charges tab has the following data:
      | Name             | isPenalty | Payment due at     | Due as of       | Calculation type         | Due   | Paid | Waived | Outstanding |
      | % Processing fee | false     | Specified due date | 20260106 | % Loan Amount + Interest | 10.29 | 0.0  | 0.0    | 10.29       |
#   --- Approve and undo Approval ---
    When Admin successfully approves the loan on "20260101" with "100" amount and expected disbursement date on "20260101"
    And Admin can successfully undone the loan approval
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees  | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260101  |           | 100.0           |               |          | 0.0   |           | 0.0   |      |            |      | 0.0         |
      | 1  | 31   | 20260201 |           | 83.85           | 16.15         | 0.85     | 10.29 | 0.0       | 27.29 | 0.0  | 0.0        | 0.0  | 27.29       |
      | 2  | 28   | 20260301    |           | 67.49           | 16.36         | 0.64     | 0.0   | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 3  | 31   | 20260401    |           | 51.06           | 16.43         | 0.57     | 0.0   | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 4  | 30   | 20260501      |           | 34.48           | 16.58         | 0.42     | 0.0   | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 5  | 31   | 20260601     |           | 17.77           | 16.71         | 0.29     | 0.0   | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 6  | 30   | 20260701     |           | 0.0             | 17.77         | 0.15     | 0.0   | 0.0       | 17.92 | 0.0  | 0.0        | 0.0  | 17.92       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees  | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.92     | 10.29 | 0.0       | 113.21 | 0.0  | 0.0        | 0.0  | 113.21      |
    And Loan Charges tab has the following data:
      | Name             | isPenalty | Payment due at     | Due as of       | Calculation type         | Due   | Paid | Waived | Outstanding |
      | % Processing fee | false     | Specified due date | 20260106 | % Loan Amount + Interest | 10.29 | 0.0  | 0.0    | 10.29       |
#   --- Modify interest rate ---
    When Admin modifies the loan and changes the ANNUAL interest rate to "9"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees  | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260101  |           | 100.0           |               |          | 0.0   |           | 0.0   |      |            |      | 0.0         |
      | 1  | 31   | 20260201 |           | 83.76           | 16.24         | 0.76     | 10.26 | 0.0       | 27.26 | 0.0  | 0.0        | 0.0  | 27.26       |
      | 2  | 28   | 20260301    |           | 67.34           | 16.42         | 0.58     | 0.0   | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 3  | 31   | 20260401    |           | 50.85           | 16.49         | 0.51     | 0.0   | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 4  | 30   | 20260501      |           | 34.23           | 16.62         | 0.38     | 0.0   | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 5  | 31   | 20260601     |           | 17.49           | 16.74         | 0.26     | 0.0   | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
      | 6  | 30   | 20260701     |           | 0.0             | 17.49         | 0.13     | 0.0   | 0.0       | 17.62 | 0.0  | 0.0        | 0.0  | 17.62       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees  | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.62     | 10.26 | 0.0       | 112.88 | 0.0  | 0.0        | 0.0  | 112.88      |
    And Loan Charges tab has the following data:
      | Name             | isPenalty | Payment due at     | Due as of       | Calculation type         | Due   | Paid | Waived | Outstanding |
      | % Processing fee | false     | Specified due date | 20260106 | % Loan Amount + Interest | 10.26 | 0.0  | 0.0    | 10.26       |
    Then Loan status will be "SUBMITTED_AND_PENDING_APPROVAL"

  @TestRailId:C3260
  Scenario: Verify that there are no payable interest and fee after charge adjustment made on the same date for progressive loan with custom payment allocation order
    When Admin sets the business date to "20240927"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240927       | 100            | 9.99                   | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240927" with "40" amount and expected disbursement date on "20240927"
    When Admin successfully disburse the loan on "20240927" with "40" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240927 |           | 40.0            |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20241027   |           | 0.0             | 40.0          | 0.33     | 0.0  | 0.0       | 40.33 | 0.0  | 0.0        | 0.0  | 40.33       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 40.0          | 0.33     | 0.0  | 0.0       | 40.33 | 0.0  | 0.0        | 0.0  | 40.33       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240927 | Disbursement     | 40.0   | 0.0       | 0.0      | 0.0  | 0.0       | 40.0         |
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240927" due date and 1 EUR transaction amount
    When Admin makes a charge adjustment for the last "LOAN_NSF_FEE" type charge which is due on "20240927" with 1 EUR transaction amount and externalId ""
    Then Loan has 40.32 outstanding amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240927 |           | 40.0            |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20241027   |           | 0.0             | 40.0          | 0.32     | 0.0  | 1.0       | 41.32 | 1.0  | 1.0        | 0.0  | 40.32       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 40.0          | 0.32     | 0.0  | 1.0       | 41.32 | 1.0  | 1.0        | 0.0  | 40.32       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240927 | Disbursement      | 40.0   | 0.0       | 0.0      | 0.0  | 0.0       | 40.0         |
      | 20240927 | Charge Adjustment | 1.0    | 1.0       | 0.0      | 0.0  | 0.0       | 39.0         |
    When Loan Pay-off is made on "20240927"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3319
  Scenario: Verify enhance the existing implementation to create accruals as part of Charge Creation post maturity with immediate charge accrual and non-zero interest rate
    Given Global configuration "enable-immediate-charge-accrual-post-maturity" is enabled
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 0.0             | 1000.0        | 5.83     | 0.0  | 0.0       | 1005.83 | 0.0  | 0.0        | 0.0  | 1005.83     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 5.83     | 0.0  | 0.0       | 1005.83 | 0.0  | 0.0        | 0.0  | 1005.83     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20240205"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240205" due date and 25 EUR transaction amount
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20240205 | Flat             | 25.0 | 0.0  | 0.0    | 25.0        |
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 0.0             | 1000.0        | 5.83     | 0.0  | 0.0       | 1005.83 | 0.0  | 0.0        | 0.0  | 1005.83     |
      | 2  | 4    | 20240205 |           | 0.0             | 0.0           | 0.0      | 0.0  | 25.0      | 25.0    | 0.0  | 0.0        | 0.0  | 25.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 5.83     | 0.0  | 25.0      | 1030.83 | 0.0  | 0.0        | 0.0  | 1030.83     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240205 | Accrual          | 25.0   | 0.0       | 0.0      | 0.0  | 25.0      | 0.0          |
    Given Global configuration "enable-immediate-charge-accrual-post-maturity" is disabled
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240205"
    When Loan Pay-off is made on "20240205"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3320
  Scenario: Verify enhance the existing implementation to create accruals as part of Charge Creation post maturity with immediate charge accrual and zero interest rate
    Given Global configuration "enable-immediate-charge-accrual-post-maturity" is enabled
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 1000           | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20240205"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240205" due date and 25 EUR transaction amount
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20240205 | Flat             | 25.0 | 0.0  | 0.0    | 25.0        |
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 2  | 4    | 20240205 |           | 0.0             | 0.0           | 0.0      | 0.0  | 25.0      | 25.0   | 0.0  | 0.0        | 0.0  | 25.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 25.0      | 1025.0 | 0.0  | 0.0        | 0.0  | 1025.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240205 | Accrual          | 25.0   | 0.0       | 0.0      | 0.0  | 25.0      | 0.0          |
    Given Global configuration "enable-immediate-charge-accrual-post-maturity" is disabled
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240205"
    When Loan Pay-off is made on "20240205"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:С3335
  Scenario: Verify enhance the existing implementation to create accruals as part of Charge Creation post maturity with inline COB run and non-zero interest rate
    Given Global configuration "enable-immediate-charge-accrual-post-maturity" is disabled
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 0.0             | 1000.0        | 5.83     | 0.0  | 0.0       | 1005.83 | 0.0  | 0.0        | 0.0  | 1005.83     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 5.83     | 0.0  | 0.0       | 1005.83 | 0.0  | 0.0        | 0.0  | 1005.83     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20240205"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240205" due date and 25 EUR transaction amount
    When Admin sets the business date to "20240206"
    And Admin runs inline COB job for Loan
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20240205 | Flat             | 25.0 | 0.0  | 0.0    | 25.0        |
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 0.0             | 1000.0        | 5.83     | 0.0  | 0.0       | 1005.83 | 0.0  | 0.0        | 0.0  | 1005.83     |
      | 2  | 4    | 20240205 |           | 0.0             | 0.0           | 0.0      | 0.0  | 25.0      | 25.0    | 0.0  | 0.0        | 0.0  | 25.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 5.83     | 0.0  | 25.0      | 1030.83 | 0.0  | 0.0        | 0.0  | 1030.83     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240205 | Accrual          | 30.83  | 0.0       | 5.83     | 0.0  | 25.0      | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240205"
    When Loan Pay-off is made on "20240206"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3321
  Scenario: Verify enhance the existing implementation to create accruals as part of Charge Creation post maturity with inline COB run and zero interest rate
    Given Global configuration "enable-immediate-charge-accrual-post-maturity" is disabled
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 1000           | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20240205"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240205" due date and 25 EUR transaction amount
    When Admin sets the business date to "20240206"
    And Admin runs inline COB job for Loan
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20240205 | Flat             | 25.0 | 0.0  | 0.0    | 25.0        |
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 2  | 4    | 20240205 |           | 0.0             | 0.0           | 0.0      | 0.0  | 25.0      | 25.0   | 0.0  | 0.0        | 0.0  | 25.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 25.0      | 1025.0 | 0.0  | 0.0        | 0.0  | 1025.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240205 | Accrual          | 25.0   | 0.0       | 0.0      | 0.0  | 25.0      | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240205"
    When Loan Pay-off is made on "20240206"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3336
  Scenario: Verify enhance the existing implementation to create accruals as part of Charge Creation post maturity with immediate charge accrual with inline COB run and non-zero interest rate
    Given Global configuration "enable-immediate-charge-accrual-post-maturity" is enabled
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 0.0             | 1000.0        | 5.83     | 0.0  | 0.0       | 1005.83 | 0.0  | 0.0        | 0.0  | 1005.83     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 5.83     | 0.0  | 0.0       | 1005.83 | 0.0  | 0.0        | 0.0  | 1005.83     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20240205"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240205" due date and 25 EUR transaction amount
    When Admin sets the business date to "20240206"
    And Admin runs inline COB job for Loan
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20240205 | Flat             | 25.0 | 0.0  | 0.0    | 25.0        |
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 0.0             | 1000.0        | 5.83     | 0.0  | 0.0       | 1005.83 | 0.0  | 0.0        | 0.0  | 1005.83     |
      | 2  | 4    | 20240205 |           | 0.0             | 0.0           | 0.0      | 0.0  | 25.0      | 25.0    | 0.0  | 0.0        | 0.0  | 25.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 5.83     | 0.0  | 25.0      | 1030.83 | 0.0  | 0.0        | 0.0  | 1030.83     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240205 | Accrual          | 25.0   | 0.0       | 0.0      | 0.0  | 25.0      | 0.0          |
      | 20240205 | Accrual          | 5.83   | 0.0       | 5.83     | 0.0  | 0.0       | 0.0          |
    Given Global configuration "enable-immediate-charge-accrual-post-maturity" is disabled
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20240205"
    When Loan Pay-off is made on "20240206"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3425
  Scenario: Verify that charge paid is populated for interest bearing products after charge adjustment is being posted
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 100            | 7.0                    | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 75.21           | 24.79         | 0.58     | 0.0  | 0.0       | 25.37 | 0.0  | 0.0        | 0.0  | 25.37       |
      | 2  | 29   | 20240301    |           | 50.28           | 24.93         | 0.44     | 0.0  | 0.0       | 25.37 | 0.0  | 0.0        | 0.0  | 25.37       |
      | 3  | 31   | 20240401    |           | 25.2            | 25.08         | 0.29     | 0.0  | 0.0       | 25.37 | 0.0  | 0.0        | 0.0  | 25.37       |
      | 4  | 30   | 20240501      |           | 0.0             | 25.2          | 0.15     | 0.0  | 0.0       | 25.35 | 0.0  | 0.0        | 0.0  | 25.35       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100           | 1.46     | 0.0  | 0.0       | 101.46 | 0.0  | 0.0        | 0.0  | 101.46      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
    When Admin sets the business date to "20240201"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240201" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 75.21           | 24.79         | 0.58     | 0.0  | 20.0      | 45.37 | 0.0  | 0.0        | 0.0  | 45.37       |
      | 2  | 29   | 20240301    |           | 50.28           | 24.93         | 0.44     | 0.0  | 0.0       | 25.37 | 0.0  | 0.0        | 0.0  | 25.37       |
      | 3  | 31   | 20240401    |           | 25.2            | 25.08         | 0.29     | 0.0  | 0.0       | 25.37 | 0.0  | 0.0        | 0.0  | 25.37       |
      | 4  | 30   | 20240501      |           | 0.0             | 25.2          | 0.15     | 0.0  | 0.0       | 25.35 | 0.0  | 0.0        | 0.0  | 25.35       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100           | 1.46     | 0.0  | 20.0      | 121.46 | 0.0  | 0.0        | 0.0  | 121.46      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
    Then Loan Charges tab has a given charge with the following data:
      | Name    | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20240201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
  #   --- Backdated repayment with 60 EUR ---
    And Customer makes "AUTOPAY" repayment on "20240101" with 60 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |                 | 74.63           | 25.37         | 0.0      | 0.0  | 20.0      | 45.37 | 25.37 | 25.37      | 0.0  | 20.0        |
      | 2  | 29   | 20240301    | 20240101 | 49.26           | 25.37         | 0.0      | 0.0  | 0.0       | 25.37 | 25.37 | 25.37      | 0.0  | 0.0         |
      | 3  | 31   | 20240401    |                 | 24.58           | 24.68         | 0.69     | 0.0  | 0.0       | 25.37 | 9.26  | 9.26       | 0.0  | 16.11       |
      | 4  | 30   | 20240501      |                 | 0.0             | 24.58         | 0.14     | 0.0  | 0.0       | 24.72 | 0.0   | 0.0        | 0.0  | 24.72       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100           | 0.83     | 0.0  | 20.0      | 120.83 | 60.0 | 60.0       | 0.0  | 60.83       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240101  | Repayment        | 60.0   | 60.0      | 0.0      | 0.0  | 0.0       | 40.0         |
    Then Loan Charges tab has a given charge with the following data:
      | Name    | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20240201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    When Admin makes a charge adjustment for the last "LOAN_NSF_FEE" type charge which is due on "20240201" with 20 EUR transaction amount and externalId ""
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 74.63           | 25.37         | 0.0      | 0.0  | 20.0      | 45.37 | 45.37 | 25.37      | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240101  | 49.26           | 25.37         | 0.0      | 0.0  | 0.0       | 25.37 | 25.37 | 25.37      | 0.0  | 0.0         |
      | 3  | 31   | 20240401    |                  | 24.58           | 24.68         | 0.69     | 0.0  | 0.0       | 25.37 | 9.26  | 9.26       | 0.0  | 16.11       |
      | 4  | 30   | 20240501      |                  | 0.0             | 24.58         | 0.14     | 0.0  | 0.0       | 24.72 | 0.0   | 0.0        | 0.0  | 24.72       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100           | 0.83     | 0.0  | 20.0      | 120.83 | 80.0 | 60.0       | 0.0  | 40.83       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement      | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240101  | Repayment         | 60.0   | 60.0      | 0.0      | 0.0  | 0.0       | 40.0         |
      | 20240201 | Charge Adjustment | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 40.0         |
    And LoanChargeAdjustmentPostBusinessEvent is raised on "20240201"
    When Loan Pay-off is made on "20240201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3501
  Scenario: Verify repayment schedule amounts after large charge amount added - UC1
    When Admin sets the business date to "20250220"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20241220  | 800            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20241220" with "800" amount and expected disbursement date on "20241220"
    When Admin successfully disburse the loan on "20241220" with "800" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due      | Paid | In advance | Late | Outstanding |
      |    |      | 20241220 |           | 800.0           |               |          | 0.0  |           | 0.0      | 0.0  |            |      |             |
      | 1  | 31   | 20250120  |           | 600.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0    | 0.0  | 0.0        | 0.0  | 200.0       |
      | 2  | 31   | 20250220 |           | 400.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0    | 0.0  | 0.0        | 0.0  | 200.0       |
      | 3  | 28   | 20250320    |           | 200.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0    | 0.0  | 0.0        | 0.0  | 200.0       |
      | 4  | 31   | 20250420    |           | 0.0             | 200.0         | 0.0      | 0.0  | 0.0       | 200.0    | 0.0  | 0.0        | 0.0  | 200.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 800.0         | 0.0      | 0.0  | 0.0       | 800.0 | 0.0  | 0.0        | 0.0  | 800.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241220 | Disbursement     | 800.0   | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
    And Admin adds "LOAN_NSF_FEE" due date charge with "20241225" due date and 123456789012.12 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties       | Due             | Paid | In advance | Late | Outstanding     |
      |    |      | 20241220 |           | 800.0           |               |          | 0.0  |                 | 0.0             | 0.0  |            |      |                 |
      | 1  | 31   | 20250120  |           | 600.0           | 200.0         | 0.0      | 0.0  | 123456789012.12 | 123456789212.12 | 0.0  | 0.0        | 0.0  | 123456789212.12 |
      | 2  | 31   | 20250220 |           | 400.0           | 200.0         | 0.0      | 0.0  | 0.0             | 200.0           | 0.0  | 0.0        | 0.0  | 200.0           |
      | 3  | 28   | 20250320    |           | 200.0           | 200.0         | 0.0      | 0.0  | 0.0             | 200.0           | 0.0  | 0.0        | 0.0  | 200.0           |
      | 4  | 31   | 20250420    |           | 0.0             | 200.0         | 0.0      | 0.0  | 0.0             | 200.0           | 0.0  | 0.0        | 0.0  | 200.0           |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties       | Due             | Paid | In advance | Late | Outstanding     |
      | 800.0         | 0.0      | 0.0  | 123456789012.12 | 123456789812.12 | 0.0  | 0.0        | 0.0  | 123456789812.12 |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241220 | Disbursement     | 800.0   | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
    Then Loan Charges tab has a given charge with the following data:
      | Name    | isPenalty | Payment due at     | Due as of        | Calculation type | Due             | Paid | Waived | Outstanding     |
      | NSF fee | true      | Specified due date | 20241225 | Flat             | 123456789012.12 | 0.0  | 0.0    | 123456789012.12 |
    When Loan Pay-off is made on "20250220"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3502
  Scenario: Verify repayment schedule amounts after a few large charges amount added - UC2
    When Admin sets the business date to "20250220"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20241220  | 800            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20241220" with "800" amount and expected disbursement date on "20241220"
    When Admin successfully disburse the loan on "20241220" with "800" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due      | Paid | In advance | Late | Outstanding |
      |    |      | 20241220 |           | 800.0           |               |          | 0.0  |           | 0.0      | 0.0  |            |      |             |
      | 1  | 31   | 20250120  |           | 600.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0    | 0.0  | 0.0        | 0.0  | 200.0       |
      | 2  | 31   | 20250220 |           | 400.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0    | 0.0  | 0.0        | 0.0  | 200.0       |
      | 3  | 28   | 20250320    |           | 200.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0    | 0.0  | 0.0        | 0.0  | 200.0       |
      | 4  | 31   | 20250420    |           | 0.0             | 200.0         | 0.0      | 0.0  | 0.0       | 200.0    | 0.0  | 0.0        | 0.0  | 200.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 800.0         | 0.0      | 0.0  | 0.0       | 800.0 | 0.0  | 0.0        | 0.0  | 800.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241220 | Disbursement     | 800.0   | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
    And Admin adds "LOAN_NSF_FEE" due date charge with "20241225" due date and 123456789012.12 EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20241228" due date and 1003456789012.12 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20250131" due date and 5503456789012.12 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20250223" due date and 1003456789012.12 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20250403" due date and 1503456789012.12 EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20250409" due date and 103456789037.12 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees             | Penalties        | Due              | Paid | In advance | Late | Outstanding      |
      |    |      | 20241220 |           | 800.0           |               |          | 0.0              |                  | 0.0              | 0.0  |            |      |                  |
      | 1  | 31   | 20250120  |           | 600.0           | 200.0         | 0.0      | 1003456789012.12 | 123456789012.12  | 1126913578224.24 | 0.0  | 0.0        | 0.0  | 1126913578224.24 |
      | 2  | 31   | 20250220 |           | 400.0           | 200.0         | 0.0      | 0.0              | 5503456789012.12 | 5503456789212.12 | 0.0  | 0.0        | 0.0  | 5503456789212.12 |
      | 3  | 28   | 20250320    |           | 200.0           | 200.0         | 0.0      | 0.0              | 1003456789012.12 | 1003456789212.12 | 0.0  | 0.0        | 0.0  | 1003456789212.12 |
      | 4  | 31   | 20250420    |           | 0.0             | 200.0         | 0.0      | 103456789037.12  | 1503456789012.12 | 1606913578249.24 | 0.0  | 0.0        | 0.0  | 1606913578249.24 |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees             | Penalties        | Due              | Paid | In advance | Late | Outstanding      |
      | 800.0         | 0.0      | 1106913578049.24 | 8133827156048.48 | 9240740734897.72 | 0.0  | 0.0        | 0.0  | 9240740734897.72 |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241220 | Disbursement     | 800.0   | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
    Then Loan Charges tab has a given charge with the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due              | Paid | Waived | Outstanding      |
      | NSF fee    | true      | Specified due date | 20241225 | Flat             | 123456789012.12  | 0.0  | 0.0    | 123456789012.12  |
      | Snooze fee | false     | Specified due date | 20241228 | Flat             | 1003456789012.12 | 0.0  | 0.0    | 1003456789012.12 |
      | NSF fee    | true      | Specified due date | 20250131  | Flat             | 5503456789012.12 | 0.0  | 0.0    | 5503456789012.12 |
      | NSF fee    | true      | Specified due date | 20250223 | Flat             | 1003456789012.12 | 0.0  | 0.0    | 1003456789012.12 |
      | NSF fee    | true      | Specified due date | 20250403    | Flat             | 1503456789012.12 | 0.0  | 0.0    | 1503456789012.12 |
      | Snooze fee | false     | Specified due date | 20250409    | Flat             | 103456789037.12  | 0.0  | 0.0    | 103456789037.12  |
    When Loan Pay-off is made on "20250220"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3543
  Scenario: Check that subResourceExternalId present in charge adjustment response after loan is charged off, accounting none
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_ACCOUNTING_RULE_NONE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100           | 2.05     | 0    | 0         | 102.05 | 0    | 0          | 0    | 102.05      |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    When Admin sets the business date to "20240301"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240301" due date and 5 EUR transaction amount
    And Admin does charge-off the loan on "20240301"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.14           | 16.43         | 0.58     | 5.0  | 0.0       | 22.01 | 0.0  | 0.0        | 0.0  | 22.01       |
      | 3  | 31   | 20240401    |           | 50.52           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.8            | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 16.99           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.99         | 0.1      | 0.0  | 0.0       | 17.09 | 0.0  | 0.0        | 0.0  | 17.09       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement       | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240301    | Charge-off         | 107.14 | 100.0     | 2.14     | 5.0  | 0.0       | 0.0          | false    | false    |
    When Admin makes a charge adjustment for the last "LOAN_SNOOZE_FEE" type charge which is due on "20240301" with 5 EUR transaction amount and externalId ""
    Then Charge adjustment response has the subResourceExternalId
    Then Loan has 1 "CHARGE_ADJUSTMENT" transactions on Transactions tab
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement       | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240301    | Charge-off         | 107.14 | 100.0     | 2.14     | 5.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Charge Adjustment  | 5.0    | 5.0       | 0.0      | 0.0  | 0.0       | 95.0         | false    | false    |
    When Loan Pay-off is made on "20240301"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3544
  Scenario: Check that subResourceExternalId present in charge adjustment response after loan is charged off, accrual activity
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_ACCRUAL_ACTIVITY | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100           | 2.05     | 0    | 0         | 102.05 | 0    | 0          | 0    | 102.05      |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    When Admin sets the business date to "20240301"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240301" due date and 5 EUR transaction amount
    And Admin does charge-off the loan on "20240301"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.14           | 16.43         | 0.58     | 5.0  | 0.0       | 22.01 | 0.0  | 0.0        | 0.0  | 22.01       |
      | 3  | 31   | 20240401    |           | 50.52           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.8            | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 16.99           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.99         | 0.1      | 0.0  | 0.0       | 17.09 | 0.0  | 0.0        | 0.0  | 17.09       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240301    | Accrual          | 1.16   | 0.0       | 1.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Charge-off       | 107.14 | 100.0     | 2.14     | 5.0  | 0.0       | 0.0          | false    | false    |
    When Admin makes a charge adjustment for the last "LOAN_SNOOZE_FEE" type charge which is due on "20240301" with 5 EUR transaction amount and externalId ""
    Then Charge adjustment response has the subResourceExternalId
    Then Loan has 1 "CHARGE_ADJUSTMENT" transactions on Transactions tab
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement      | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240301    | Accrual           | 1.16   | 0.0       | 1.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Charge-off        | 107.14 | 100.0     | 2.14     | 5.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Charge Adjustment | 5.0    | 5.0       | 0.0      | 0.0  | 0.0       | 95.0         | false    | false    |
    When Loan Pay-off is made on "20240301"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3571
  Scenario: Charge adjustment on account with zero principal balance should not create accrual transactions without journal entries
    When Admin sets the business date to "20250325"
    When Admin creates a client with random data
    And Admin successfully creates a new customised Loan submitted on date: "20250325", with Principal: "800", a loanTermFrequency: 1 months, and numberOfRepayments: 1
    And Admin successfully approves the loan on "20250325" with "800" amount and expected disbursement date on "20250325"
    When Admin successfully disburse the loan on "20250325" with "800" EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20250325" with 800 EUR transaction amount
    And Admin adds an NSF fee because of payment bounce with "20250325" transaction date
    When Admin makes a charge adjustment for the last "LOAN_NSF_FEE" type charge which is due on "20250325" with 10 EUR transaction amount and externalId ""
    Then Loan Transactions tab has a "CHARGE_ADJUSTMENT" transaction with date "20250325" which has the following Journal entries:
      | Type   | Account code | Account name     | Debit | Credit |
      | ASSET  | 112601       | Loans Receivable |       | 10.0   |
      | INCOME | 404007       | Fee Income       | 10.0  |        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250325    | Disbursement      | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        |
      | 20250325    | Repayment         | 800.0  | 790.0     | 0.0      | 0.0  | 10.0      | 10.0         |
      | 20250325    | Charge Adjustment | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20250325    | Accrual           | 10.0   | 0.0       | 0.0      | 0.0  | 10.0      | 0.0          |
    Then Loan Transactions tab has a "ACCRUAL" transaction with date "20250325" which has the following Journal entries:
      | Type   | Account code | Account name            | Debit | Credit |
      | ASSET  | 112603       | Interest/Fee Receivable | 10.0  |        |
      | INCOME | 404007       | Fee Income              |       | 10.0   |
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met


  @TestRailId:C3613
  Scenario: Verify immediate charge accrual post maturity for Progressive loans
    Given Global configuration "enable-immediate-charge-accrual-post-maturity" is enabled
    When Admin sets the business date to "20250225"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL | 20250225  | 1000           | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250225" with "1000" amount and expected disbursement date on "20250225"
    When Admin successfully disburse the loan on "20250225" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250225 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 28   | 20250325    |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250225 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20250328"
    And Admin runs inline COB job for Loan
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20250328" due date and 25 EUR transaction amount
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of     | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20250328 | Flat             | 25.0 | 0.0  | 0.0    | 25.0        |
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250225 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 28   | 20250325    |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 2  | 3    | 20250328    |           | 0.0             | 0.0           | 0.0      | 25.0 | 0.0       | 25.0   | 0.0  | 0.0        | 0.0  | 25.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 25.0 | 0.0       | 1025.0 | 0.0  | 0.0        | 0.0  | 1025.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250225 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20250328    | Accrual          | 25.0   | 0.0       | 0.0      | 25.0 | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20250328"
    Given Global configuration "enable-immediate-charge-accrual-post-maturity" is disabled
    When Loan Pay-off is made on "20250328"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

