@LoanAccrualFeature
Feature: LoanAccrualTransaction

  @TestRailId:C2647
  Scenario: Verify that after COB job Accrual event is raised when loan has a fee-charge on disbursal date
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230101" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230102"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has a transaction with date: "20230101", and with the following data:
      | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20230101"

  @TestRailId:C2648
  Scenario: Verify that after COB job Accrual event is raised when loan has a fee-charge on disbursal date with partial repayment
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230101" due date and 10 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230101" with 500 EUR transaction amount
    When Admin sets the business date to "20230102"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has a transaction with date: "20230101", and with the following data:
      | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20230101"

  @TestRailId:C2649
  Scenario: Verify that after COB job Accrual event is raised when loan has a fee-charge on disbursal date with full repayment and loan is closed
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230101" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230102"
    And Customer makes "AUTOPAY" repayment on "20230102" with 1010 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Transactions tab has a transaction with date: "20230102", and with the following data:
      | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20230102"

  @TestRailId:C2650
  Scenario: Verify that after COB job Accrual event is raised when loan has a fee-charge added with chargeback
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230102"
    And Customer makes "AUTOPAY" repayment on "20230102" with 250 EUR transaction amount
    When Admin sets the business date to "20230103"
    And Customer makes "AUTOPAY" repayment on "20230103" with 250 EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230104" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230104"
    And Admin runs inline COB job for Loan
    When Admin sets the business date to "20230105"
    And Customer makes "AUTOPAY" repayment on "20230105" with 510 EUR transaction amount
    Then Loan has 0 outstanding amount
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20230105"
    Then Loan Transactions tab has a transaction with date: "20230105", and with the following data:
      | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
    And Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 250 EUR transaction amount for Payment nr. 2
    Then Loan has 250 outstanding amount

  @TestRailId:C2651
  Scenario: Verify that after periodic accrual transaction job accrual event is raised when loan has a fee-charge added with waive charge and undo waive charge
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    And Admin successfully creates a new customised Loan submitted on date: "20230101", with Principal: "750", a loanTermFrequency: 3 months, and numberOfRepayments: 3
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
    When Admin sets the business date to "20230408"
    And Admin makes waive undone for charge
    Then Loan status will be "ACTIVE"
    Then Loan has 260 outstanding amount
    And Admin runs the Add Periodic Accrual Transactions job
    Then Loan Transactions tab has a transaction with date: "20230405", and with the following data:
      | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | Accrual          | 10.0   | 0.0       | 0.0      | 0.0  | 10.0      | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20230405"

  @TestRailId:C2652
  Scenario: Verify that after periodic accrual transaction job accrual event is raised when loan has a fee-charge added when loan is closed
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230102"
    And Customer makes "AUTOPAY" repayment on "20230102" with 1000 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230102" due date and 10 EUR transaction amount
    And Admin runs the Add Periodic Accrual Transactions job
    Then Loan Transactions tab has a transaction with date: "20230102", and with the following data:
      | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20230102"

  @TestRailId:C2653
  Scenario: Verify that after disbursement and COB job Accrual event is raised when loan has a interest recalculation
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_DAILY_RECALCULATION_COMPOUNDING_NONE | 20230101   | 5000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230101" with "5000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "5000" EUR transaction amount
    When Admin sets the business date to "20230102"
    When Admin runs the Add Periodic Accrual Transactions job
    Then Loan Transactions tab has a transaction with date: "20230102", and with the following data:
      | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | Accrual          | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20230102"

  @TestRailId:C2654
  Scenario: Verify that after loan is closed accrual event is raised when loan has a interest recalculation
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_DAILY_RECALCULATION_COMPOUNDING_NONE | 20230101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230102"
    And Customer makes "AUTOPAY" repayment on "20230102" with 1000.33 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Transactions tab has a transaction with date: "20230102", and with the following data:
      | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20230102"

  @TestRailId:C2683
  Scenario: Verify that the final accrual is created when the loan goes to overpaid state
    When Admin sets the business date to "20230701"
    When Admin creates a client with random data
    And Admin successfully creates a new customised Loan submitted on date: "20230701", with Principal: "5000", a loanTermFrequency: 1 months, and numberOfRepayments: 1
    And Admin successfully approves the loan on "20230701" with "5000" amount and expected disbursement date on "20230701"
    And Admin successfully disburse the loan on "20230701" with "5000" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230710" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230706"
    And Customer makes "AUTOPAY" repayment on "20230706" with 5011 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230701   |              | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230801 | 20230706 | 0.0             | 5000.0        | 0.0      | 10.0 | 0.0       | 5010.0 | 5010.0 | 5010.0     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 5000          | 0        | 10   | 0         | 5010 | 5010 | 5010       | 0    | 0           |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230701     | Disbursement     | 5000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       |
      | 20230706     | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230706     | Repayment        | 5011.0 | 5000.0    | 0.0      | 10.0 | 0.0       | 0.0          |

  @TestRailId:C2684
  Scenario: Verify that the accrual transaction correctly created in case a CBR is applied on the loan
    When Admin sets the business date to "20230701"
    When Admin creates a client with random data
    And Admin successfully creates a new customised Loan submitted on date: "20230701", with Principal: "5000", a loanTermFrequency: 1 months, and numberOfRepayments: 1
    And Admin successfully approves the loan on "20230701" with "5000" amount and expected disbursement date on "20230701"
    And Admin successfully disburse the loan on "20230701" with "5000" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230710" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230706"
    And Customer makes "AUTOPAY" repayment on "20230706" with 5011 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230701   |              | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230801 | 20230706 | 0.0             | 5000.0        | 0.0      | 10.0 | 0.0       | 5010.0 | 5010.0 | 5010.0     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 5000          | 0        | 10   | 0         | 5010 | 5010 | 5010       | 0    | 0           |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230701     | Disbursement     | 5000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       |
      | 20230706     | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230706     | Repayment        | 5011.0 | 5000.0    | 0.0      | 10.0 | 0.0       | 0.0          |
    When Admin makes Credit Balance Refund transaction on "20230706" with 1 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230701   |              | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230801 | 20230706 | 0.0             | 5000.0        | 0.0      | 10.0 | 0.0       | 5010.0 | 5010.0 | 5010.0     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 5000          | 0        | 10   | 0         | 5010 | 5010 | 5010       | 0    | 0           |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type      | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230701     | Disbursement          | 5000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       |
      | 20230706     | Accrual               | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230706     | Repayment             | 5011.0 | 5000.0    | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230706     | Credit Balance Refund | 1.0    | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          |

  @TestRailId:C2685
  Scenario: Verify that the accrual transaction correctly created (overpay, undo repayment, overpay)
    When Admin sets the business date to "20230701"
    When Admin creates a client with random data
    And Admin successfully creates a new customised Loan submitted on date: "20230701", with Principal: "5000", a loanTermFrequency: 1 months, and numberOfRepayments: 1
    And Admin successfully approves the loan on "20230701" with "5000" amount and expected disbursement date on "20230701"
    And Admin successfully disburse the loan on "20230701" with "5000" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230710" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230705"
    And Customer makes "AUTOPAY" repayment on "20230705" with 1000 EUR transaction amount
    When Admin sets the business date to "20230706"
    And Customer makes "AUTOPAY" repayment on "20230706" with 4011 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230701   |              | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230801 | 20230706 | 0.0             | 5000.0        | 0.0      | 10.0 | 0.0       | 5010.0 | 5010.0 | 5010.0     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 5000          | 0        | 10   | 0         | 5010 | 5010 | 5010       | 0    | 0           |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230701     | Disbursement     | 5000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       |
      | 20230705     | Repayment        | 1000.0 | 990.0     | 0.0      | 10.0 | 0.0       | 4010.0       |
      | 20230706     | Repayment        | 4011.0 | 4010.0    | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20230706     | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
    And Customer makes a repayment undo on "20230706"
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20230707"
    And Customer makes "AUTOPAY" repayment on "20230707" with 4011 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230701   |              | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230801 | 20230707 | 0.0             | 5000.0        | 0.0      | 10.0 | 0.0       | 5010.0 | 5010.0 | 5010.0     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 5000          | 0        | 10   | 0         | 5010 | 5010 | 5010       | 0    | 0           |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230701     | Disbursement     | 5000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       |
      | 20230705     | Repayment        | 1000.0 | 990.0     | 0.0      | 10.0 | 0.0       | 4010.0       |
      | 20230706     | Repayment        | 4011.0 | 4010.0    | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20230706     | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230707     | Repayment        | 4011.0 | 4010.0    | 0.0      | 0.0  | 0.0       | 0.0          |

  @TestRailId:C2686
  Scenario: Verify that the accrual transaction correctly created (overpay, undo repayment, add charge, overpay)
    When Admin sets the business date to "20230701"
    When Admin creates a client with random data
    And Admin successfully creates a new customised Loan submitted on date: "20230701", with Principal: "5000", a loanTermFrequency: 1 months, and numberOfRepayments: 1
    And Admin successfully approves the loan on "20230701" with "5000" amount and expected disbursement date on "20230701"
    And Admin successfully disburse the loan on "20230701" with "5000" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230710" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230705"
    And Customer makes "AUTOPAY" repayment on "20230705" with 1000 EUR transaction amount
    When Admin sets the business date to "20230706"
    And Customer makes "AUTOPAY" repayment on "20230706" with 4011 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230701   |              | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230801 | 20230706 | 0.0             | 5000.0        | 0.0      | 10.0 | 0.0       | 5010.0 | 5010.0 | 5010.0     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 5000          | 0        | 10   | 0         | 5010 | 5010 | 5010       | 0    | 0           |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230701     | Disbursement     | 5000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       |
      | 20230705     | Repayment        | 1000.0 | 990.0     | 0.0      | 10.0 | 0.0       | 4010.0       |
      | 20230706     | Repayment        | 4011.0 | 4010.0    | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20230706     | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
    And Customer makes a repayment undo on "20230706"
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20230707"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230720" due date and 50 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230707" with 4061 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230701   |              | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230801 | 20230707 | 0.0             | 5000.0        | 0.0      | 60.0 | 0.0       | 5060.0 | 5060.0 | 5060.0     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 5000          | 0        | 60   | 0         | 5060 | 5060 | 5060       | 0    | 0           |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230701     | Disbursement     | 5000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       |
      | 20230705     | Repayment        | 1000.0 | 940.0     | 0.0      | 60.0 | 0.0       | 4060.0       |
      | 20230706     | Repayment        | 4011.0 | 4010.0    | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20230706     | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230707     | Repayment        | 4061.0 | 4060.0    | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20230707     | Accrual          | 50.0   | 0.0       | 0.0      | 50.0 | 0.0       | 0.0          |

  @TestRailId:C2707
  Scenario: Verify that the accrual transaction is not reversed when multi disbursement happens
    When Admin sets the business date to "20230426"
    When Admin creates a client with random data
    And Admin successfully creates a new customised Loan submitted on date: "20230426", with Principal: "1000", a loanTermFrequency: 1 months, and numberOfRepayments: 1
    And Admin successfully approves the loan on "20230426" with "1000" amount and expected disbursement date on "20230501"
    And Admin successfully disburse the loan on "20230426" with "1000" EUR transaction amount
    Then Loan has 1000 outstanding amount
    When Admin sets the business date to "20230427"
    And Admin successfully disburse the loan on "20230427" with "30" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230427" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230428"
    And  Admin runs COB job
    And Admin successfully disburse the loan on "20230428" with "20" EUR transaction amount
    When Admin sets the business date to "20230429"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230426 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20230427 |           | 30.0            |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20230428 |           | 20.0            |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230526   |           | 0.0             | 1050.0        | 0.0      | 10.0 | 0.0       | 1060.0 | 0.0  | 0.0        | 0.0  | 1060.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1050          | 0        | 10   | 0         | 1060 | 0    | 0          | 0    | 1060        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230426    | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230427    | Disbursement     | 30.0   | 0.0       | 0.0      | 0.0  | 0.0       | 1030.0       |
      | 20230427    | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230428    | Disbursement     | 20.0   | 0.0       | 0.0      | 0.0  | 0.0       | 1050.0       |

  @TestRailId:C2708
  Scenario: Verify that the accrual is correct when it is on the installment start date
    When Admin sets the business date to "20230501"
    When Admin creates a client with random data
    And Admin successfully creates a new customised Loan submitted on date: "20230501", with Principal: "1000", a loanTermFrequency: 1 months, and numberOfRepayments: 1
    And Admin successfully approves the loan on "20230501" with "1000" amount and expected disbursement date on "20230501"
    And Admin successfully disburse the loan on "20230501" with "1000" EUR transaction amount
    Then Loan has 1000 outstanding amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230501" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230502"
    And Admin runs inline COB job for Loan
    When Admin sets the business date to "20230508"
    And Admin successfully disburse the loan on "20230508" with "20" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230501  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20230508  |           | 20.0            |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20230601 |           | 0.0             | 1020.0        | 0.0      | 10.0 | 0.0       | 1030.0 | 0.0  | 0.0        | 0.0  | 1030.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1020          | 0        | 10   | 0         | 1030 | 0    | 0          | 0    | 1030        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230501      | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230501      | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230508      | Disbursement     | 20.0   | 0.0       | 0.0      | 0.0  | 0.0       | 1020.0       |

  @TestRailId:C2709
  Scenario:Verify that the accrual transaction is created for disbursement fee
    When Admin sets the business date to "20230501"
    When Admin creates a client with random data
    And Admin successfully creates a new customised Loan submitted on date: "20230501", with Principal: "1000", a loanTermFrequency: 1 months, and numberOfRepayments: 1
    And Admin successfully approves the loan on "20230501" with "1000" amount and expected disbursement date on "20230501"
    When Admin adds "LOAN_DISBURSEMENT_PERCENTAGE_FEE" charge with 1 % of transaction amount
    And Admin successfully disburse the loan on "20230501" with "1000" EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                    | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230501      | Disbursement                        | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230501      | Repayment (at time of disbursement) | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 1000.0       |

  @TestRailId:C2710 @Specific
  Scenario: Verify global config charge-accrual-date function: single installment loan, charge-accrual-date = submitted-date, multiple charges with different submitted date
    When Global config "charge-accrual-date" value set to "submitted-date"
    When Admin sets the business date to "20230201"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230201"
    And Admin successfully approves the loan on "20230201" with "1000" amount and expected disbursement date on "20230201"
    When Admin successfully disburse the loan on "20230201" with "1000" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230206" due date and 10 EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230216" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230202"
    When Admin runs inline COB job for Loan
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230206 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
      | Snooze fee | false     | Specified due date | 20230216 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230201 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230201 | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230201 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230303    |           | 0.0             | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 0.0  | 0.0        | 0.0  | 1020.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 0         | 1020 | 0    | 0          | 0    | 1020        |
    When Global config "charge-accrual-date" value set to "due-date"

  @TestRailId:C2711
  Scenario: Verify global config charge-accrual-date function: single installment loan, charge-accrual-date = due-date, multiple charges with different submitted date
    When Global config "charge-accrual-date" value set to "due-date"
    When Admin sets the business date to "20230201"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230201"
    And Admin successfully approves the loan on "20230201" with "1000" amount and expected disbursement date on "20230201"
    When Admin successfully disburse the loan on "20230201" with "1000" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230206" due date and 10 EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230216" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230207"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230217"
    When Admin runs inline COB job for Loan
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230206 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
      | Snooze fee | false     | Specified due date | 20230216 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230201 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230206 | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230216 | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230201 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230303    |           | 0.0             | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 0.0  | 0.0        | 0.0  | 1020.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 0         | 1020 | 0    | 0          | 0    | 1020        |
    When Global config "charge-accrual-date" value set to "due-date"

  @TestRailId:C2712 @Specific
  Scenario: Verify global config charge-accrual-date function: multiple installment loan, charge-accrual-date = submitted-date, multiple charges with different submitted date, due dates in same repayment period
    When Global config "charge-accrual-date" value set to "submitted-date"
    When Admin sets the business date to "20230201"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1         | 20230201   | 3000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230201" with "3000" amount and expected disbursement date on "20230201"
    When Admin successfully disburse the loan on "20230201" with "3000" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230206" due date and 10 EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230216" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230202"
    When Admin runs inline COB job for Loan
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230206 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
      | Snooze fee | false     | Specified due date | 20230216 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230201 | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230201 | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230201 |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 28   | 20230301    |           | 2000.0          | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 0.0  | 0.0        | 0.0  | 1020.0      |
      | 2  | 31   | 20230401    |           | 1000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 3  | 30   | 20230501      |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 20   | 0         | 3020 | 0    | 0          | 0    | 3020        |
    When Global config "charge-accrual-date" value set to "due-date"

  @TestRailId:C2713
  Scenario: Verify global config charge-accrual-date function: multiple installment loan, charge-accrual-date = due-date, multiple charges with different submitted date, due dates in same repayment period
    When Global config "charge-accrual-date" value set to "due-date"
    When Admin sets the business date to "20230201"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1         | 20230201   | 3000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230201" with "3000" amount and expected disbursement date on "20230201"
    When Admin successfully disburse the loan on "20230201" with "3000" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230206" due date and 10 EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230216" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230207"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230217"
    When Admin runs inline COB job for Loan
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230206 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
      | Snooze fee | false     | Specified due date | 20230216 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230201 | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230206 | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230216 | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230201 |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 28   | 20230301    |           | 2000.0          | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 0.0  | 0.0        | 0.0  | 1020.0      |
      | 2  | 31   | 20230401    |           | 1000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 3  | 30   | 20230501      |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 20   | 0         | 3020 | 0    | 0          | 0    | 3020        |
    When Global config "charge-accrual-date" value set to "due-date"

  @TestRailId:C2714 @Specific
  Scenario: Verify global config charge-accrual-date function: multiple installment loan, charge-accrual-date = submitted-date, multiple charges with different submitted date, due dates in different repayment periods
    When Global config "charge-accrual-date" value set to "submitted-date"
    When Admin sets the business date to "20230201"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1         | 20230201   | 3000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230201" with "3000" amount and expected disbursement date on "20230201"
    When Admin successfully disburse the loan on "20230201" with "3000" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230206" due date and 10 EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230306" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230202"
    When Admin runs inline COB job for Loan
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230206 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
      | Snooze fee | false     | Specified due date | 20230306    | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230201 | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230201 | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230201 | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230201 |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 28   | 20230301    |           | 2000.0          | 1000.0        | 0.0      | 10.0 | 0.0       | 1010.0 | 0.0  | 0.0        | 0.0  | 1010.0      |
      | 2  | 31   | 20230401    |           | 1000.0          | 1000.0        | 0.0      | 10.0 | 0.0       | 1010.0 | 0.0  | 0.0        | 0.0  | 1010.0      |
      | 3  | 30   | 20230501      |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 20   | 0         | 3020 | 0    | 0          | 0    | 3020        |
    When Global config "charge-accrual-date" value set to "due-date"

  @TestRailId:C2715
  Scenario: Verify global config charge-accrual-date function: multiple installment loan, charge-accrual-date = due-date, multiple charges with different submitted date, due dates in different repayment periods
    When Global config "charge-accrual-date" value set to "due-date"
    When Admin sets the business date to "20230201"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1         | 20230201   | 3000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230201" with "3000" amount and expected disbursement date on "20230201"
    When Admin successfully disburse the loan on "20230201" with "3000" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230206" due date and 10 EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230306" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230207"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230307"
    When Admin runs inline COB job for Loan
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230206 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
      | Snooze fee | false     | Specified due date | 20230306    | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230201 | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230206 | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230306    | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230201 |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 28   | 20230301    |           | 2000.0          | 1000.0        | 0.0      | 10.0 | 0.0       | 1010.0 | 0.0  | 0.0        | 0.0  | 1010.0      |
      | 2  | 31   | 20230401    |           | 1000.0          | 1000.0        | 0.0      | 10.0 | 0.0       | 1010.0 | 0.0  | 0.0        | 0.0  | 1010.0      |
      | 3  | 30   | 20230501      |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 20   | 0         | 3020 | 0    | 0          | 0    | 3020        |
    When Global config "charge-accrual-date" value set to "due-date"

  @TestRailId:C2716 @Specific
  Scenario: Verify global config charge-accrual-date function: single installment loan, charge-accrual-date = submitted-date, multi disbursement
    When Global config "charge-accrual-date" value set to "submitted-date"
    When Admin sets the business date to "20230201"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230201"
    And Admin successfully approves the loan on "20230201" with "1000" amount and expected disbursement date on "20230201"
    When Admin successfully disburse the loan on "20230201" with "500" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230206" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230202"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230204"
    When Admin successfully disburse the loan on "20230204" with "500" EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230206 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230201 | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230201 | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230204 | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230204 |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20230201 |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230303    |           | 0.0             | 1000.0        | 0.0      | 10.0 | 0.0       | 1010.0 | 0.0  | 0.0        | 0.0  | 1010.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 10   | 0         | 1010 | 0    | 0          | 0    | 1010        |
    When Global config "charge-accrual-date" value set to "due-date"

  @TestRailId:C2717 @Specific
  Scenario: Verify global config charge-accrual-date function: single installment loan, charge-accrual-date = submitted-date, repayment reversal
    When Global config "charge-accrual-date" value set to "submitted-date"
    When Admin sets the business date to "20230201"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230201"
    And Admin successfully approves the loan on "20230201" with "1000" amount and expected disbursement date on "20230201"
    When Admin successfully disburse the loan on "20230201" with "1000" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230206" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230202"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230204"
    And Customer makes "AUTOPAY" repayment on "20230204" with 500 EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230205"
    When Customer undo "1"th "Repayment" transaction made on "20230204"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230206"
    When Admin runs inline COB job for Loan
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230206 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230201 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230201 | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230204 | Repayment        | 500.0  | 490.0     | 0.0      | 10.0 | 0.0       | 510.0        |
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230204" is reverted
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230201 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230303    |           | 0.0             | 1000.0        | 0.0      | 10.0 | 0.0       | 1010.0 | 0.0  | 0.0        | 0.0  | 1010.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 10   | 0         | 1010 | 0    | 0          | 0    | 1010        |
    When Global config "charge-accrual-date" value set to "due-date"

  @TestRailId:C2718 @Specific
  Scenario: Verify global config charge-accrual-date function: single installment loan, charge-accrual-date = submitted-date, waive charge, undo waive
    When Global config "charge-accrual-date" value set to "submitted-date"
    When Admin sets the business date to "20230201"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230201"
    And Admin successfully approves the loan on "20230201" with "1000" amount and expected disbursement date on "20230201"
    When Admin successfully disburse the loan on "20230201" with "1000" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230206" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230202"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230204"
    And Admin waives due date charge
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230205"
    And Admin makes waive undone for charge
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230206"
    When Admin runs inline COB job for Loan
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230206 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230201 | Disbursement       | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230201 | Accrual            | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230204 | Waive loan charges | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 1000.0       |
    Then On Loan Transactions tab the "Waive loan charges" Transaction with date "20230204" is reverted
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230201 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230303    |           | 0.0             | 1000.0        | 0.0      | 10.0 | 0.0       | 1010.0 | 0.0  | 0.0        | 0.0  | 1010.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 10   | 0         | 1010 | 0    | 0          | 0    | 1010        |
    When Global config "charge-accrual-date" value set to "due-date"

  @TestRailId:C2719 @Specific
  Scenario: Verify global config charge-accrual-date function: multiple installment loan, charge-accrual-date = submitted-date, multi disbursement
    When Global config "charge-accrual-date" value set to "submitted-date"
    When Admin sets the business date to "20230201"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1         | 20230201   | 3000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230201" with "3000" amount and expected disbursement date on "20230201"
    When Admin successfully disburse the loan on "20230201" with "2000" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230306" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230202"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230204"
    When Admin successfully disburse the loan on "20230204" with "1000" EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of     | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230306 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230201 | Disbursement     | 2000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 2000.0       |
      | 20230201 | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230204 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230201 |           | 2000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20230204 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 28   | 20230301    |           | 2000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 2  | 31   | 20230401    |           | 1000.0          | 1000.0        | 0.0      | 10.0 | 0.0       | 1010.0 | 0.0  | 0.0        | 0.0  | 1010.0      |
      | 3  | 30   | 20230501      |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 10   | 0         | 3010 | 0    | 0          | 0    | 3010        |
    When Global config "charge-accrual-date" value set to "due-date"

  @TestRailId:C2720 @Specific
  Scenario: Verify global config charge-accrual-date function: multiple installment loan, charge-accrual-date = submitted-date, repayment reversal
    When Global config "charge-accrual-date" value set to "submitted-date"
    When Admin sets the business date to "20230201"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1         | 20230201   | 3000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230201" with "3000" amount and expected disbursement date on "20230201"
    When Admin successfully disburse the loan on "20230201" with "3000" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230306" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230202"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230204"
    And Customer makes "AUTOPAY" repayment on "20230204" with 500 EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230205"
    When Customer undo "1"th "Repayment" transaction made on "20230204"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230206"
    When Admin runs inline COB job for Loan
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of     | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230306 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230201 | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230201 | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230204 | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 2500.0       |
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230204" is reverted
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230201 |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 28   | 20230301    |           | 2000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 2  | 31   | 20230401    |           | 1000.0          | 1000.0        | 0.0      | 10.0 | 0.0       | 1010.0 | 0.0  | 0.0        | 0.0  | 1010.0      |
      | 3  | 30   | 20230501      |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 10   | 0         | 3010 | 0    | 0          | 0    | 3010        |
    When Global config "charge-accrual-date" value set to "due-date"

  @TestRailId:C2721 @Specific
  Scenario: Verify global config charge-accrual-date function: multiple installment loan, charge-accrual-date = submitted-date, waive charge, undo waive
    When Global config "charge-accrual-date" value set to "submitted-date"
    When Admin sets the business date to "20230201"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1         | 20230201   | 3000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230201" with "3000" amount and expected disbursement date on "20230201"
    When Admin successfully disburse the loan on "20230201" with "3000" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230306" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230202"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230204"
    And Admin waives due date charge
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230205"
    And Admin makes waive undone for charge
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230206"
    When Admin runs inline COB job for Loan
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of     | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230306 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230201 | Disbursement       | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230201 | Accrual            | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230204 | Waive loan charges | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 3000.0       |
    Then On Loan Transactions tab the "Waive loan charges" Transaction with date "20230204" is reverted
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230201 |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 28   | 20230301    |           | 2000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 2  | 31   | 20230401    |           | 1000.0          | 1000.0        | 0.0      | 10.0 | 0.0       | 1010.0 | 0.0  | 0.0        | 0.0  | 1010.0      |
      | 3  | 30   | 20230501      |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 10   | 0         | 3010 | 0    | 0          | 0    | 3010        |
    When Global config "charge-accrual-date" value set to "due-date"


  @TestRailId:C2789 @Specific
  Scenario: Verify accrual transaction for new fee for loan with accrued snooze fee and schedule adjustment
    When Global config "charge-accrual-date" value set to "submitted-date"
    When Admin sets the business date to "20230519"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1         | 20230519       | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230519" with "1000" amount and expected disbursement date on "20230519"
    When Admin successfully disburse the loan on "20230519" with "1000" EUR transaction amount
    When Admin sets the business date to "20230612"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230718" due date and 10 EUR transaction amount
    When Batch API call with steps: rescheduleLoan from "20230618" to "20230718" submitted on date: "20230519", approveReschedule on date: "20230519" runs with enclosingTransaction: "true"
    When Admin sets the business date to "20230613"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has a transaction with date: "20230612", and with the following data:
      | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
    When Admin sets the business date to "20230718"
    And Customer makes "AUTOPAY" repayment on "20230718" with 1010 EUR transaction amount
    When Admin sets the business date to "20230719"
    When Customer makes a repayment undo on "20230719"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230719" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230720"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has a transaction with date: "20230719", and with the following data:
      | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | Accrual          | 10.0   | 0.0       | 0.0      | 0.0  | 10.0      | 0.0          |
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230519  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 60   | 20230718 |           | 0.0             | 1000.0        | 0.0      | 10.0 | 0.0       | 1010.0 | 0.0  | 0.0        | 0.0  | 1010.0      |
      | 2  | 1    | 20230719 |           | 0.0             | 0.0           | 0.0      | 0.0  | 10.0      | 10.0   | 0.0  | 0.0        | 0.0  | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 10   | 10        | 1020 | 0    | 0          | 0    | 1020        |
    When Global config "charge-accrual-date" value set to "due-date"

  @TestRailId:C3128
  Scenario: Verify that the final accrual calculation is correct when multiple Charges are added and waived
    When Admin sets the business date to "20240417"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240417     | 750            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240417" with "750" amount and expected disbursement date on "20240417"
    When Admin successfully disburse the loan on "20240417" with "750" EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240417" due date and 20 EUR transaction amount
    When Admin sets the business date to "20240418"
    When Admin runs inline COB job for Loan
    And Admin waives due date charge
    When Admin sets the business date to "20240419"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240419" due date and 55 EUR transaction amount
    When Admin sets the business date to "20240420"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240420" with 55 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240420" due date and 60 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20240420" with 810 EUR transaction amount
    Then Loan Charges tab has a given charge with the following data:
      | Name    | isPenalty | Payment due at     | Due as of     | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20240420 | Flat             | 60.0 | 60.0 | 0.0    | 0.0         |
      | NSF fee | true      | Specified due date | 20240419 | Flat             | 55.0 | 55.0 | 0.0    | 0.0         |
      | NSF fee | true      | Specified due date | 20240417 | Flat             | 20.0 | 0.0  | 20.0   | 0.0         |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Waived | Outstanding |
      |    |      | 20240417 |               | 750.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |        |             |
      | 1  | 0    | 20240417 | 20240420 | 562.5           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 187.5 | 0.0        | 187.5 | 0.0    | 0.0         |
      | 2  | 15   | 20240502   | 20240420 | 375.0           | 187.5         | 0.0      | 0.0  | 135.0     | 322.5 | 302.5 | 302.5      | 0.0   | 20.0   | 0.0         |
      | 3  | 15   | 20240517   | 20240420 | 187.5           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 187.5 | 187.5      | 0.0   | 0.0    | 0.0         |
      | 4  | 15   | 20240601  | 20240420 | 0.0             | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 187.5 | 187.5      | 0.0   | 0.0    | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Waived | Outstanding |
      | 750.0         | 0.0      | 0.0  | 135.0     | 885.0 | 865.0 | 677.5      | 187.5 | 20.0   | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240417    | Disbursement       | 750.0  | 0.0       | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20240417    | Accrual            | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          |
      | 20240417    | Waive loan charges | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 750.0        |
      | 20240419    | Accrual            | 55.0   | 0.0       | 0.0      | 0.0  | 55.0      | 0.0          |
      | 20240420    | Repayment          | 55.0   | 55.0      | 0.0      | 0.0  | 0.0       | 695.0        |
      | 20240420    | Repayment          | 810.0  | 695.0     | 0.0      | 0.0  | 115.0     | 0.0          |
      | 20240420    | Accrual            | 60.0   | 0.0       | 0.0      | 0.0  | 60.0      | 0.0          |

  @TestRailId:C3139
  Scenario: Verify global config charge-accrual-date function: multiple installment loan, charge-accrual-date = submitted-date, multi disbursement, periodic accrual
    When Global config "charge-accrual-date" value set to "submitted-date"
    When Admin sets the business date to "20240401"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_SAR_RECALCULATION_SAME_AS_REPAYMENT_COMPOUNDING_NONE_MULTIDISB | 20240401     | 1000           | 12                     | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20240401" with "1000" amount and expected disbursement date on "20240405"
    When Admin sets the business date to "20240405"
    When Admin successfully disburse the loan on "20240405" with "500" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240405 |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 15   | 20240420 |           | 334.47          | 165.53        | 2.47     | 0.0  | 0.0       | 168.0  | 0.0  | 0.0        | 0.0  | 168.0       |
      | 2  | 15   | 20240505   |           | 168.12          | 166.35        | 1.65     | 0.0  | 0.0       | 168.0  | 0.0  | 0.0        | 0.0  | 168.0       |
      | 3  | 15   | 20240520   |           | 0.0             | 168.12        | 0.83     | 0.0  | 0.0       | 168.95 | 0.0  | 0.0        | 0.0  | 168.95      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240405    | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 500.0         | 4.95     | 0.0  | 0.0       | 504.95 | 0.0  | 0.0        | 0.0  | 504.95      |
    When Admin sets the business date to "20240425"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240405 |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 15   | 20240420 |           | 334.47          | 165.53        | 2.47     | 0.0  | 0.0       | 168.0  | 0.0  | 0.0        | 0.0  | 168.0       |
      | 2  | 15   | 20240505   |           | 168.94          | 165.53        | 2.47     | 0.0  | 0.0       | 168.0  | 0.0  | 0.0        | 0.0  | 168.0       |
      | 3  | 15   | 20240520   |           | 0.0             | 168.94        | 0.83     | 0.0  | 0.0       | 169.77 | 0.0  | 0.0        | 0.0  | 169.77      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240405    | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20240420    | Accrual          | 2.47   | 0.0       | 2.47     | 0.0  | 0.0       | 0.0          |
      | 20240424    | Accrual          | 0.66   | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 500.0         | 5.77     | 0.0  | 0.0       | 505.77 | 0.0  | 0.0        | 0.0  | 505.77      |
    When Admin sets the business date to "20240426"
    And Admin successfully disburse the loan on "20240426" with "500" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240405 |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 15   | 20240420 |           | 165.47          | 334.53        | 2.47     | 0.0  | 0.0       | 337.0  | 0.0  | 0.0        | 0.0  | 337.0       |
      |    |      | 20240426 |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 2  | 15   | 20240505   |           | 332.42          | 333.05        | 3.95     | 0.0  | 0.0       | 337.0  | 0.0  | 0.0        | 0.0  | 337.0       |
      | 3  | 15   | 20240520   |           | 0.0             | 332.42        | 1.64     | 0.0  | 0.0       | 334.06 | 0.0  | 0.0        | 0.0  | 334.06      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240405    | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20240420    | Accrual          | 2.47   | 0.0       | 2.47     | 0.0  | 0.0       | 0.0          |
      | 20240424    | Accrual          | 1.05   | 0.0       | 1.05     | 0.0  | 0.0       | 0.0          |
      | 20240426    | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 8.06     | 0.0  | 0.0       | 1008.06 | 0.0  | 0.0        | 0.0  | 1008.06     |
    When Global config "charge-accrual-date" value set to "due-date"

  @TestRailId:C3416
  Scenario: Verify the accrual activity creation in case of full repayment on maturity date
    When Admin sets the business date to "20240809"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_AUTO_DOWNPAYMENT_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20240809    | 200            | 9.9                    | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240809" with "200" amount and expected disbursement date on "20240809"
    And Admin successfully disburse the loan on "20240809" with "200" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240809    |                | 200.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240809    | 20240809 | 150.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 50.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240909 |                | 112.98          | 37.02         | 1.26     | 0.0  | 0.0       | 38.28 | 0.0  | 0.0        | 0.0  | 38.28       |
      | 3  | 30   | 20241009   |                | 75.62           | 37.36         | 0.92     | 0.0  | 0.0       | 38.28 | 0.0  | 0.0        | 0.0  | 38.28       |
      | 4  | 31   | 20241109  |                | 37.97           | 37.65         | 0.63     | 0.0  | 0.0       | 38.28 | 0.0  | 0.0        | 0.0  | 38.28       |
      | 5  | 30   | 20241209  |                | 0.0             | 37.97         | 0.31     | 0.0  | 0.0       | 38.28 | 0.0  | 0.0        | 0.0  | 38.28       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 200.0         | 3.12     | 0.0  | 0.0       | 203.12 | 50.0 | 0.0        | 0.0  | 153.12      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240809   | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
      | 20240809   | Down Payment     | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
    When Admin sets the business date to "20241209"
    And Customer makes "AUTOPAY" repayment on "20241209" with 153.12 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240809    |                  | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20240809    | 20240809   | 150.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 50.0  | 0.0        | 0.0   | 0.0         |
      | 2  | 31   | 20240909 | 20241209 | 112.98          | 37.02         | 1.26     | 0.0  | 0.0       | 38.28 | 38.28 | 0.0        | 38.28 | 0.0         |
      | 3  | 30   | 20241009   | 20241209 | 75.62           | 37.36         | 0.92     | 0.0  | 0.0       | 38.28 | 38.28 | 0.0        | 38.28 | 0.0         |
      | 4  | 31   | 20241109  | 20241209 | 37.97           | 37.65         | 0.63     | 0.0  | 0.0       | 38.28 | 38.28 | 0.0        | 38.28 | 0.0         |
      | 5  | 30   | 20241209  | 20241209 | 0.0             | 37.97         | 0.31     | 0.0  | 0.0       | 38.28 | 38.28 | 0.0        | 0.0   | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      | 200.0         | 3.12     | 0.0  | 0.0       | 203.12 | 203.12 | 0.0        | 114.84 | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240809    | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
      | 20240809    | Down Payment     | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240909 | Accrual Activity | 1.26   | 0.0       | 1.26     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241009   | Accrual Activity | 0.92   | 0.0       | 0.92     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241109  | Accrual Activity | 0.63   | 0.0       | 0.63     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241209  | Repayment        | 153.12 | 150.0     | 3.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241209  | Accrual          | 3.12   | 0.0       | 3.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241209  | Accrual Activity | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3531
  Scenario: Verify the accrual activity creation in case of full repayment on maturity date - absence of negative numbers  with mid range interest rate and small principal
    When Admin sets the business date to "20250219"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_AUTO_DOWNPAYMENT_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20250219  | 50             | 19.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 12                | MONTHS                | 1              | MONTHS                 | 12                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250219" with "50" amount and expected disbursement date on "20250219"
    And Admin successfully disburse the loan on "20250219" with "50" EUR transaction amount
    Then Loan Repayment schedule has 13 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20250219  |                  | 50.0            |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 0    | 20250219  | 20250219 | 37.5            | 12.5          | 0.0      | 0.0  | 0.0       | 12.5 | 12.5 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250319     |                  | 34.61           | 2.89          | 0.58     | 0.0  | 0.0       | 3.47 | 0.0  | 0.0        | 0.0  | 3.47        |
      | 3  | 31   | 20250419     |                  | 31.73           | 2.88          | 0.59     | 0.0  | 0.0       | 3.47 | 0.0  | 0.0        | 0.0  | 3.47        |
      | 4  | 30   | 20250519       |                  | 28.78           | 2.95          | 0.52     | 0.0  | 0.0       | 3.47 | 0.0  | 0.0        | 0.0  | 3.47        |
      | 5  | 31   | 20250619      |                  | 25.8            | 2.98          | 0.49     | 0.0  | 0.0       | 3.47 | 0.0  | 0.0        | 0.0  | 3.47        |
      | 6  | 30   | 20250719      |                  | 22.75           | 3.05          | 0.42     | 0.0  | 0.0       | 3.47 | 0.0  | 0.0        | 0.0  | 3.47        |
      | 7  | 31   | 20250819    |                  | 19.67           | 3.08          | 0.39     | 0.0  | 0.0       | 3.47 | 0.0  | 0.0        | 0.0  | 3.47        |
      | 8  | 31   | 20250919 |                  | 16.53           | 3.14          | 0.33     | 0.0  | 0.0       | 3.47 | 0.0  | 0.0        | 0.0  | 3.47        |
      | 9  | 30   | 20251019   |                  | 13.33           | 3.2           | 0.27     | 0.0  | 0.0       | 3.47 | 0.0  | 0.0        | 0.0  | 3.47        |
      | 10 | 31   | 20251119  |                  | 10.09           | 3.24          | 0.23     | 0.0  | 0.0       | 3.47 | 0.0  | 0.0        | 0.0  | 3.47        |
      | 11 | 30   | 20251219  |                  | 6.79            | 3.3           | 0.17     | 0.0  | 0.0       | 3.47 | 0.0  | 0.0        | 0.0  | 3.47        |
      | 12 | 31   | 20260119   |                  | 3.44            | 3.35          | 0.12     | 0.0  | 0.0       | 3.47 | 0.0  | 0.0        | 0.0  | 3.47        |
      | 13 | 31   | 20260219  |                  | 0.0             | 3.44          | 0.06     | 0.0  | 0.0       | 3.5  | 0.0  | 0.0        | 0.0  | 3.5         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 50.0          | 4.17     | 0.0  | 0.0       | 54.17 | 12.5 | 0.0        | 0.0  | 41.67       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250219 | Disbursement     | 50.0   | 0.0       | 0.0      | 0.0  | 0.0       | 50.0         | false    | false    |
      | 20250219 | Down Payment     | 12.5   | 12.5      | 0.0      | 0.0  | 0.0       | 37.5         | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20250219" with 3.47 EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 13 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20250219  |                  | 50.0            |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 0    | 20250219  | 20250219 | 37.5            | 12.5          | 0.0      | 0.0  | 0.0       | 12.5 | 12.5 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250319     | 20250219 | 34.61           | 2.89          | 0.58     | 0.0  | 0.0       | 3.47 | 3.47 | 3.47       | 0.0  | 0.0         |
      | 3  | 31   | 20250419     |                  | 31.73           | 2.88          | 0.59     | 0.0  | 0.0       | 3.47 | 0.0  |  0.0       | 0.0  | 3.47        |
      | 4  | 30   | 20250519       |                  | 28.78           | 2.95          | 0.52     | 0.0  | 0.0       | 3.47 | 0.0  | 0.0        | 0.0  | 3.47        |
      | 5  | 31   | 20250619      |                  | 25.8            | 2.98          | 0.49     | 0.0  | 0.0       | 3.47 | 0.0  | 0.0        | 0.0  | 3.47        |
      | 6  | 30   | 20250719      |                  | 22.75           | 3.05          | 0.42     | 0.0  | 0.0       | 3.47 | 0.0  | 0.0        | 0.0  | 3.47        |
      | 7  | 31   | 20250819    |                  | 19.67           | 3.08          | 0.39     | 0.0  | 0.0       | 3.47 | 0.0  | 0.0        | 0.0  | 3.47        |
      | 8  | 31   | 20250919 |                  | 16.53           | 3.14          | 0.33     | 0.0  | 0.0       | 3.47 | 0.0  | 0.0        | 0.0  | 3.47        |
      | 9  | 30   | 20251019   |                  | 13.33           | 3.2           | 0.27     | 0.0  | 0.0       | 3.47 | 0.0  | 0.0        | 0.0  | 3.47        |
      | 10 | 31   | 20251119  |                  | 10.09           | 3.24          | 0.23     | 0.0  | 0.0       | 3.47 | 0.0  | 0.0        | 0.0  | 3.47        |
      | 11 | 30   | 20251219  |                  | 6.79            | 3.3           | 0.17     | 0.0  | 0.0       | 3.47 | 0.0  | 0.0        | 0.0  | 3.47        |
      | 12 | 31   | 20260119   |                  | 3.44            | 3.35          | 0.12     | 0.0  | 0.0       | 3.47 | 0.0  | 0.0        | 0.0  | 3.47        |
      | 13 | 31   | 20260219  |                  | 0.0             | 3.44          | 0.06     | 0.0  | 0.0       | 3.5  | 0.0  | 0.0        | 0.0  | 3.5         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 50.0          | 4.17     | 0.0  | 0.0       | 54.17 | 15.97 | 3.47       | 0.0  | 38.2        |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250219 | Disbursement      | 50.0   | 0.0       | 0.0      | 0.0  | 0.0       | 50.0         | false    | false    |
      | 20250219 | Down Payment      | 12.5   | 12.5      | 0.0      | 0.0  | 0.0       | 37.5         | false    | false    |
      | 20250219 | Repayment         | 3.47   | 2.89      | 0.58     | 0.0  | 0.0       | 34.61        | false    | false    |
    When Admin sets the business date to "20250220"
    When Admin makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250220" with 17.35 EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 13 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20250219  |                  | 50.0            |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 0    | 20250219  | 20250219 | 37.5            | 12.5          | 0.0      | 0.0  | 0.0       | 12.5 | 12.5 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250319     | 20250219 | 34.61           | 2.89          | 0.58     | 0.0  | 0.0       | 3.47 | 3.47 | 3.47       | 0.0  | 0.0         |
      | 3  | 31   | 20250419     |                  | 31.73           | 2.88          | 0.59     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 4  | 30   | 20250519       |                  | 28.78           | 2.95          | 0.52     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 5  | 31   | 20250619      |                  | 25.8            | 2.98          | 0.49     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 6  | 30   | 20250719      |                  | 22.75           | 3.05          | 0.42     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 7  | 31   | 20250819    |                  | 19.67           | 3.08          | 0.39     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 8  | 31   | 20250919 |                  | 16.53           | 3.14          | 0.33     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 9  | 30   | 20251019   |                  | 13.33           | 3.2           | 0.27     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 10 | 31   | 20251119  |                  | 10.09           | 3.24          | 0.23     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 11 | 30   | 20251219  |                  | 6.79            | 3.3           | 0.17     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 12 | 31   | 20260119   |                  | 3.44            | 3.35          | 0.12     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 13 | 31   | 20260219  |                  | 0.0             | 3.44          | 0.06     | 0.0  | 0.0       | 3.5  | 1.55 | 1.55       | 0.0  | 1.95        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 50.00         | 4.17     | 0.0  | 0.0       | 54.17 | 33.32 | 20.82      | 0.0  | 20.85       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250219 | Disbursement            | 50.0   | 0.0       | 0.0      | 0.0  | 0.0       | 50.0         | false    | false    |
      | 20250219 | Down Payment            | 12.5   | 12.5      | 0.0      | 0.0  | 0.0       | 37.5         | false    | false    |
      | 20250219 | Repayment               | 3.47   | 2.89      | 0.58     | 0.0  | 0.0       | 34.61        | false    | false    |
      | 20250220 | Merchant Issued Refund  | 17.35  | 17.35     | 0.0      | 0.0  | 0.0       | 17.26        | false    | false    |
    When Admin sets the business date to "20250221"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 13 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20250219  |                  | 50.0            |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 0    | 20250219  | 20250219 | 37.5            | 12.5          | 0.0      | 0.0  | 0.0       | 12.5 | 12.5 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250319     | 20250219 | 34.61           | 2.89          | 0.58     | 0.0  | 0.0       | 3.47 | 3.47 | 3.47       | 0.0  | 0.0         |
      | 3  | 31   | 20250419     |                  | 31.73           | 2.88          | 0.59     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 4  | 30   | 20250519       |                  | 28.78           | 2.95          | 0.52     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 5  | 31   | 20250619      |                  | 25.8            | 2.98          | 0.49     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 6  | 30   | 20250719      |                  | 22.75           | 3.05          | 0.42     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 7  | 31   | 20250819    |                  | 19.67           | 3.08          | 0.39     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 8  | 31   | 20250919 |                  | 16.53           | 3.14          | 0.33     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 9  | 30   | 20251019   |                  | 13.33           | 3.2           | 0.27     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 10 | 31   | 20251119  |                  | 10.09           | 3.24          | 0.23     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 11 | 30   | 20251219  |                  | 6.79            | 3.3           | 0.17     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 12 | 31   | 20260119   |                  | 3.44            | 3.35          | 0.12     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 13 | 31   | 20260219  |                  | 0.0             | 3.44          | 0.06     | 0.0  | 0.0       | 3.5  | 1.55 | 1.55       | 0.0  | 1.95        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 50.00         | 4.17     | 0.0  | 0.0       | 54.17 | 33.32 | 20.82      | 0.0  | 20.85       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250219 | Disbursement            | 50.0   | 0.0       | 0.0      | 0.0  | 0.0       | 50.0         | false    | false    |
      | 20250219 | Down Payment            | 12.5   | 12.5      | 0.0      | 0.0  | 0.0       | 37.5         | false    | false    |
      | 20250219 | Repayment               | 3.47   | 2.89      | 0.58     | 0.0  | 0.0       | 34.61        | false    | false    |
      | 20250220 | Merchant Issued Refund  | 17.35  | 17.35     | 0.0      | 0.0  | 0.0       | 17.26        | false    | false    |
      | 20250220 | Accrual                 | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20250222"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 13 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20250219  |                  | 50.0            |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 0    | 20250219  | 20250219 | 37.5            | 12.5          | 0.0      | 0.0  | 0.0       | 12.5 | 12.5 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250319     | 20250219 | 34.61           | 2.89          | 0.58     | 0.0  | 0.0       | 3.47 | 3.47 | 3.47       | 0.0  | 0.0         |
      | 3  | 31   | 20250419     |                  | 31.73           | 2.88          | 0.59     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 4  | 30   | 20250519       |                  | 28.78           | 2.95          | 0.52     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 5  | 31   | 20250619      |                  | 25.8            | 2.98          | 0.49     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 6  | 30   | 20250719      |                  | 22.75           | 3.05          | 0.42     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 7  | 31   | 20250819    |                  | 19.67           | 3.08          | 0.39     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 8  | 31   | 20250919 |                  | 16.53           | 3.14          | 0.33     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 9  | 30   | 20251019   |                  | 13.33           | 3.2           | 0.27     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 10 | 31   | 20251119  |                  | 10.09           | 3.24          | 0.23     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 11 | 30   | 20251219  |                  | 6.79            | 3.3           | 0.17     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 12 | 31   | 20260119   |                  | 3.44            | 3.35          | 0.12     | 0.0  | 0.0       | 3.47 | 1.58 | 1.58       | 0.0  | 1.89        |
      | 13 | 31   | 20260219  |                  | 0.0             | 3.44          | 0.06     | 0.0  | 0.0       | 3.5  | 1.55 | 1.55       | 0.0  | 1.95        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 50.00         | 4.17     | 0.0  | 0.0       | 54.17 | 33.32 | 20.82      | 0.0  | 20.85       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250219 | Disbursement            | 50.0   | 0.0       | 0.0      | 0.0  | 0.0       | 50.0         | false    | false    |
      | 20250219 | Down Payment            | 12.5   | 12.5      | 0.0      | 0.0  | 0.0       | 37.5         | false    | false    |
      | 20250219 | Repayment               | 3.47   | 2.89      | 0.58     | 0.0  | 0.0       | 34.61        | false    | false    |
      | 20250220 | Merchant Issued Refund  | 17.35  | 17.35     | 0.0      | 0.0  | 0.0       | 17.26        | false    | false    |
      | 20250220 | Accrual                 | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250221 | Accrual                 | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3535
  Scenario: Verify the accrual activity creation in case of full repayment on maturity date - absence of negative numbers with low interest rate and small principal
    When Admin sets the business date to "20250219"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_AUTO_DOWNPAYMENT_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20250219  | 10.01          | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 12                | MONTHS                | 1              | MONTHS                 | 12                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250219" with "10.01" amount and expected disbursement date on "20250219"
    And Admin successfully disburse the loan on "20250219" with "10.01" EUR transaction amount
    Then Loan Repayment schedule has 13 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20250219  |                  | 10.01           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 0    | 20250219  | 20250219 | 7.51            | 2.5           | 0.0      | 0.0  | 0.0       | 2.5  | 2.5  | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250319     |                  | 6.91            | 0.6           | 0.07     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 3  | 31   | 20250419     |                  | 6.31            | 0.6           | 0.07     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 4  | 30   | 20250519       |                  | 5.7             | 0.61          | 0.06     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 5  | 31   | 20250619      |                  | 5.09            | 0.61          | 0.06     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 6  | 30   | 20250719      |                  | 4.47            | 0.62          | 0.05     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 7  | 31   | 20250819    |                  | 3.85            | 0.62          | 0.05     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 8  | 31   | 20250919 |                  | 3.22            | 0.63          | 0.04     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 9  | 30   | 20251019   |                  | 2.58            | 0.64          | 0.03     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 10 | 31   | 20251119  |                  | 1.94            | 0.64          | 0.03     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 11 | 30   | 20251219  |                  | 1.29            | 0.65          | 0.02     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 12 | 31   | 20260119   |                  | 0.63            | 0.66          | 0.01     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 13 | 31   | 20260219  |                  | 0.0             | 0.63          | 0.01     | 0.0  | 0.0       | 0.64 | 0.0  | 0.0        | 0.0  | 0.64        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 10.01         | 0.5      | 0.0  | 0.0       | 10.51 | 2.5  | 0.0        | 0.0  | 8.01        |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250219 | Disbursement     | 10.01  | 0.0       | 0.0      | 0.0  | 0.0       | 10.01        | false    | false    |
      | 20250219 | Down Payment     | 2.5    | 2.5       | 0.0      | 0.0  | 0.0       | 7.51         | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20250219" with 0.67 EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 13 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20250219  |                  | 10.01           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 0    | 20250219  | 20250219 | 7.51            | 2.5           | 0.0      | 0.0  | 0.0       | 2.5  | 2.5  | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250319     | 20250219 | 6.91            | 0.6           | 0.07     | 0.0  | 0.0       | 0.67 | 0.67 | 0.67       | 0.0  | 0.0         |
      | 3  | 31   | 20250419     |                  | 6.31            | 0.6           | 0.07     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 4  | 30   | 20250519       |                  | 5.7             | 0.61          | 0.06     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 5  | 31   | 20250619      |                  | 5.09            | 0.61          | 0.06     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 6  | 30   | 20250719      |                  | 4.47            | 0.62          | 0.05     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 7  | 31   | 20250819    |                  | 3.85            | 0.62          | 0.05     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 8  | 31   | 20250919 |                  | 3.22            | 0.63          | 0.04     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 9  | 30   | 20251019   |                  | 2.58            | 0.64          | 0.03     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 10 | 31   | 20251119  |                  | 1.94            | 0.64          | 0.03     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 11 | 30   | 20251219  |                  | 1.29            | 0.65          | 0.02     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 12 | 31   | 20260119   |                  | 0.63            | 0.66          | 0.01     | 0.0  | 0.0       | 0.67 | 0.0  | 0.0        | 0.0  | 0.67        |
      | 13 | 31   | 20260219  |                  | 0.0             | 0.63          | 0.01     | 0.0  | 0.0       | 0.64 | 0.0  | 0.0        | 0.0  | 0.64        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 10.01         | 0.5      | 0.0  | 0.0       | 10.51 | 3.17 | 0.67       | 0.0  | 7.34        |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250219 | Disbursement     | 10.01  | 0.0       | 0.0      | 0.0  | 0.0       | 10.01        | false    | false    |
      | 20250219 | Down Payment     | 2.5    | 2.5       | 0.0      | 0.0  | 0.0       | 7.51         | false    | false    |
      | 20250219 | Repayment        | 0.67   | 0.6       | 0.07     | 0.0  | 0.0       | 6.91         | false    | false    |
    When Admin sets the business date to "20250220"
    When Admin makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250220" with 3.35 EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 13 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20250219  |                  | 10.01           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 0    | 20250219  | 20250219 | 7.51            | 2.5           | 0.0      | 0.0  | 0.0       | 2.5  | 2.5  | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250319     | 20250219 | 6.91            | 0.6           | 0.07     | 0.0  | 0.0       | 0.67 | 0.67 | 0.67       | 0.0  | 0.0         |
      | 3  | 31   | 20250419     |                  | 6.31            | 0.6           | 0.07     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 4  | 30   | 20250519       |                  | 5.7             | 0.61          | 0.06     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 5  | 31   | 20250619      |                  | 5.09            | 0.61          | 0.06     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 6  | 30   | 20250719      |                  | 4.47            | 0.62          | 0.05     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 7  | 31   | 20250819    |                  | 3.85            | 0.62          | 0.05     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 8  | 31   | 20250919 |                  | 3.22            | 0.63          | 0.04     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 9  | 30   | 20251019   |                  | 2.58            | 0.64          | 0.03     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 10 | 31   | 20251119  |                  | 1.94            | 0.64          | 0.03     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 11 | 30   | 20251219  |                  | 1.29            | 0.65          | 0.02     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 12 | 31   | 20260119   |                  | 0.63            | 0.66          | 0.01     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 13 | 31   | 20260219  |                  | 0.0             | 0.63          | 0.01     | 0.0  | 0.0       | 0.64 | 0.35 | 0.35       | 0.0  | 0.29        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 10.01         | 0.5      | 0.0  | 0.0       | 10.51 | 6.52 | 4.02       | 0.0  | 3.99        |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250219 | Disbursement           | 10.01  | 0.0       | 0.0      | 0.0  | 0.0       | 10.01        | false    | false    |
      | 20250219 | Down Payment           | 2.5    | 2.5       | 0.0      | 0.0  | 0.0       | 7.51         | false    | false    |
      | 20250219 | Repayment              | 0.67   | 0.6       | 0.07     | 0.0  | 0.0       | 6.91         | false    | false    |
      | 20250220 | Merchant Issued Refund | 3.35   | 3.35      | 0.0      | 0.0  | 0.0       | 3.56         | false    | false    |
    When Admin sets the business date to "20250221"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 13 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20250219  |                  | 10.01           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 0    | 20250219  | 20250219 | 7.51            | 2.5           | 0.0      | 0.0  | 0.0       | 2.5  | 2.5  | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250319     | 20250219 | 6.91            | 0.6           | 0.07     | 0.0  | 0.0       | 0.67 | 0.67 | 0.67       | 0.0  | 0.0         |
      | 3  | 31   | 20250419     |                  | 6.31            | 0.6           | 0.07     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 4  | 30   | 20250519       |                  | 5.7             | 0.61          | 0.06     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 5  | 31   | 20250619      |                  | 5.09            | 0.61          | 0.06     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 6  | 30   | 20250719      |                  | 4.47            | 0.62          | 0.05     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 7  | 31   | 20250819    |                  | 3.85            | 0.62          | 0.05     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 8  | 31   | 20250919 |                  | 3.22            | 0.63          | 0.04     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 9  | 30   | 20251019   |                  | 2.58            | 0.64          | 0.03     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 10 | 31   | 20251119  |                  | 1.94            | 0.64          | 0.03     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 11 | 30   | 20251219  |                  | 1.29            | 0.65          | 0.02     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 12 | 31   | 20260119   |                  | 0.63            | 0.66          | 0.01     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 13 | 31   | 20260219  |                  | 0.0             | 0.63          | 0.01     | 0.0  | 0.0       | 0.64 | 0.35 | 0.35       | 0.0  | 0.29        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 10.01         | 0.5      | 0.0  | 0.0       | 10.51 | 6.52 | 4.02       | 0.0  | 3.99        |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250219 | Disbursement           | 10.01  | 0.0       | 0.0      | 0.0  | 0.0       | 10.01        | false    | false    |
      | 20250219 | Down Payment           | 2.5    | 2.5       | 0.0      | 0.0  | 0.0       | 7.51         | false    | false    |
      | 20250219 | Repayment              | 0.67   | 0.6       | 0.07     | 0.0  | 0.0       | 6.91         | false    | false    |
      | 20250220 | Merchant Issued Refund | 3.35   | 3.35      | 0.0      | 0.0  | 0.0       | 3.56         | false    | false    |
    When Admin sets the business date to "20250222"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 13 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20250219  |                  | 10.01           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 0    | 20250219  | 20250219 | 7.51            | 2.5           | 0.0      | 0.0  | 0.0       | 2.5  | 2.5  | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250319     | 20250219 | 6.91            | 0.6           | 0.07     | 0.0  | 0.0       | 0.67 | 0.67 | 0.67       | 0.0  | 0.0         |
      | 3  | 31   | 20250419     |                  | 6.31            | 0.6           | 0.07     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 4  | 30   | 20250519       |                  | 5.7             | 0.61          | 0.06     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 5  | 31   | 20250619      |                  | 5.09            | 0.61          | 0.06     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 6  | 30   | 20250719      |                  | 4.47            | 0.62          | 0.05     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 7  | 31   | 20250819    |                  | 3.85            | 0.62          | 0.05     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 8  | 31   | 20250919 |                  | 3.22            | 0.63          | 0.04     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 9  | 30   | 20251019   |                  | 2.58            | 0.64          | 0.03     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 10 | 31   | 20251119  |                  | 1.94            | 0.64          | 0.03     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 11 | 30   | 20251219  |                  | 1.29            | 0.65          | 0.02     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 12 | 31   | 20260119   |                  | 0.63            | 0.66          | 0.01     | 0.0  | 0.0       | 0.67 | 0.3  | 0.3        | 0.0  | 0.37        |
      | 13 | 31   | 20260219  |                  | 0.0             | 0.63          | 0.01     | 0.0  | 0.0       | 0.64 | 0.35 | 0.35       | 0.0  | 0.29        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 10.01         | 0.5      | 0.0  | 0.0       | 10.51 | 6.52 | 4.02       | 0.0  | 3.99        |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250219 | Disbursement           | 10.01  | 0.0       | 0.0      | 0.0  | 0.0       | 10.01        | false    | false    |
      | 20250219 | Down Payment           | 2.5    | 2.5       | 0.0      | 0.0  | 0.0       | 7.51         | false    | false    |
      | 20250219 | Repayment              | 0.67   | 0.6       | 0.07     | 0.0  | 0.0       | 6.91         | false    | false    |
      | 20250220 | Merchant Issued Refund | 3.35   | 3.35      | 0.0      | 0.0  | 0.0       | 3.56         | false    | false    |

  @TestRailId:C3536
  Scenario: Verify the accrual activity creation in case of full repayment on maturity date - absence of negative numbers with high interest rate and large principal
    When Admin sets the business date to "20250219"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_AUTO_DOWNPAYMENT_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20250219  | 9999.99        | 60                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 12                | MONTHS                | 1              | MONTHS                 | 12                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250219" with "9999.99" amount and expected disbursement date on "20250219"
    And Admin successfully disburse the loan on "20250219" with "9999.99" EUR transaction amount
    Then Loan Repayment schedule has 13 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250219  |                  | 9999.99         |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 0    | 20250219  | 20250219 | 7499.99         | 2500.0        | 0.0      | 0.0  | 0.0       | 2500.0 | 2500.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250319     |                  | 7000.98         | 499.01        | 345.21   | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 3  | 31   | 20250419     |                  | 6513.52         | 487.46        | 356.76   | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 4  | 30   | 20250519       |                  | 5990.51         | 523.01        | 321.21   | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 5  | 31   | 20250619      |                  | 5451.56         | 538.95        | 305.27   | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 6  | 30   | 20250719      |                  | 4876.18         | 575.38        | 268.84   | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 7  | 31   | 20250819    |                  | 4280.44         | 595.74        | 248.48   | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 8  | 31   | 20250919 |                  | 3654.35         | 626.09        | 218.13   | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 9  | 30   | 20251019   |                  | 2990.34         | 664.01        | 180.21   | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 10 | 31   | 20251119  |                  | 2298.5          | 691.84        | 152.38   | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 11 | 30   | 20251219  |                  | 1567.63         | 730.87        | 113.35   | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 12 | 31   | 20260119   |                  | 803.29          | 764.34        | 79.88    | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 13 | 31   | 20260219  |                  | 0.0             | 803.29        | 40.93    | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due      | Paid    | In advance | Late | Outstanding |
      | 9999.99       | 2630.65  | 0.0  | 0.0       | 12630.64 | 2500.00 | 0.0        | 0.0  | 10130.64    |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250219 | Disbursement     | 9999.99 | 0.0       | 0.0      | 0.0  | 0.0       | 9999.99      | false    | false    |
      | 20250219 | Down Payment     | 2500.0  | 2500.0    | 0.0      | 0.0  | 0.0       | 7499.99      | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20250219" with 844.22 EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 13 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250219  |                  | 9999.99         |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 0    | 20250219  | 20250219 | 7499.99         | 2500.0        | 0.0      | 0.0  | 0.0       | 2500.0 | 2500.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250319     | 20250219 | 7000.98         | 499.01        | 345.21   | 0.0  | 0.0       | 844.22 | 844.22 | 844.22     | 0.0  | 0.0         |
      | 3  | 31   | 20250419     |                  | 6513.52         | 487.46        | 356.76   | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 4  | 30   | 20250519       |                  | 5990.51         | 523.01        | 321.21   | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 5  | 31   | 20250619      |                  | 5451.56         | 538.95        | 305.27   | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 6  | 30   | 20250719      |                  | 4876.18         | 575.38        | 268.84   | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 7  | 31   | 20250819    |                  | 4280.44         | 595.74        | 248.48   | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 8  | 31   | 20250919 |                  | 3654.35         | 626.09        | 218.13   | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 9  | 30   | 20251019   |                  | 2990.34         | 664.01        | 180.21   | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 10 | 31   | 20251119  |                  | 2298.5          | 691.84        | 152.38   | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 11 | 30   | 20251219  |                  | 1567.63         | 730.87        | 113.35   | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 12 | 31   | 20260119   |                  | 803.29          | 764.34        | 79.88    | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
      | 13 | 31   | 20260219  |                  | 0.0             | 803.29        | 40.93    | 0.0  | 0.0       | 844.22 | 0.0    | 0.0        | 0.0  | 844.22      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due      | Paid    | In advance | Late | Outstanding |
      | 9999.99       | 2630.65  | 0.0  | 0.0       | 12630.64 | 3344.22 | 844.22     | 0.0  | 9286.42    |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250219 | Disbursement     | 9999.99 | 0.0       | 0.0      | 0.0  | 0.0       | 9999.99      | false    | false    |
      | 20250219 | Down Payment     | 2500.0  | 2500.0    | 0.0      | 0.0  | 0.0       | 7499.99      | false    | false    |
      | 20250219 | Repayment        | 844.22  | 499.01    | 345.21   | 0.0  | 0.0       | 7000.98      | false    | false    |
    When Admin sets the business date to "20250220"
    When Admin makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250220" with 4221.1 EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 13 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250219  |                  | 9999.99         |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 0    | 20250219  | 20250219 | 7499.99         | 2500.0        | 0.0      | 0.0  | 0.0       | 2500.0 | 2500.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250319     | 20250219 | 7000.98         | 499.01        | 345.21   | 0.0  | 0.0       | 844.22 | 844.22 | 844.22     | 0.0  | 0.0         |
      | 3  | 31   | 20250419     |                  | 6513.52         | 487.46        | 356.76   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 4  | 30   | 20250519       |                  | 5990.51         | 523.01        | 321.21   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 5  | 31   | 20250619      |                  | 5451.56         | 538.95        | 305.27   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 6  | 30   | 20250719      |                  | 4876.18         | 575.38        | 268.84   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 7  | 31   | 20250819    |                  | 4280.44         | 595.74        | 248.48   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 8  | 31   | 20250919 |                  | 3654.35         | 626.09        | 218.13   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 9  | 30   | 20251019   |                  | 2990.34         | 664.01        | 180.21   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 10 | 31   | 20251119  |                  | 2298.5          | 691.84        | 152.38   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 11 | 30   | 20251219  |                  | 1567.63         | 730.87        | 113.35   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 12 | 31   | 20260119   |                  | 803.29          | 764.34        | 79.88    | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 13 | 31   | 20260219  |                  | 0.0             | 803.29        | 40.93    | 0.0  | 0.0       | 844.22 | 383.7  | 383.7      | 0.0  | 460.52      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due      | Paid    | In advance | Late | Outstanding |
      | 9999.99       | 2630.65  | 0.0  | 0.0       | 12630.64 | 7565.32 | 5065.32    | 0.0  | 5065.32     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250219 | Disbursement           | 9999.99 | 0.0       | 0.0      | 0.0  | 0.0       | 9999.99      | false    | false    |
      | 20250219 | Down Payment           | 2500.0  | 2500.0    | 0.0      | 0.0  | 0.0       | 7499.99      | false    | false    |
      | 20250219 | Repayment              | 844.22  | 499.01    | 345.21   | 0.0  | 0.0       | 7000.98      | false    | false    |
      | 20250220 | Merchant Issued Refund | 4221.1  | 4221.1    | 0.0      | 0.0  | 0.0       | 2779.88      | false    | false    |
    When Admin sets the business date to "20250221"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 13 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250219  |                  | 9999.99         |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 0    | 20250219  | 20250219 | 7499.99         | 2500.0        | 0.0      | 0.0  | 0.0       | 2500.0 | 2500.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250319     | 20250219 | 7000.98         | 499.01        | 345.21   | 0.0  | 0.0       | 844.22 | 844.22 | 844.22     | 0.0  | 0.0         |
      | 3  | 31   | 20250419     |                  | 6513.52         | 487.46        | 356.76   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 4  | 30   | 20250519       |                  | 5990.51         | 523.01        | 321.21   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 5  | 31   | 20250619      |                  | 5451.56         | 538.95        | 305.27   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 6  | 30   | 20250719      |                  | 4876.18         | 575.38        | 268.84   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 7  | 31   | 20250819    |                  | 4280.44         | 595.74        | 248.48   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 8  | 31   | 20250919 |                  | 3654.35         | 626.09        | 218.13   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 9  | 30   | 20251019   |                  | 2990.34         | 664.01        | 180.21   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 10 | 31   | 20251119  |                  | 2298.5          | 691.84        | 152.38   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 11 | 30   | 20251219  |                  | 1567.63         | 730.87        | 113.35   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 12 | 31   | 20260119   |                  | 803.29          | 764.34        | 79.88    | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 13 | 31   | 20260219  |                  | 0.0             | 803.29        | 40.93    | 0.0  | 0.0       | 844.22 | 383.7  | 383.7      | 0.0  | 460.52      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due      | Paid    | In advance | Late | Outstanding |
      | 9999.99       | 2630.65  | 0.0  | 0.0       | 12630.64 | 7565.32 | 5065.32    | 0.0  | 5065.32     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250219 | Disbursement           | 9999.99 | 0.0       | 0.0      | 0.0  | 0.0       | 9999.99      | false    | false    |
      | 20250219 | Down Payment           | 2500.0  | 2500.0    | 0.0      | 0.0  | 0.0       | 7499.99      | false    | false    |
      | 20250219 | Repayment              | 844.22  | 499.01    | 345.21   | 0.0  | 0.0       | 7000.98      | false    | false    |
      | 20250220 | Merchant Issued Refund | 4221.1  | 4221.1    | 0.0      | 0.0  | 0.0       | 2779.88      | false    | false    |
      | 20250220 | Accrual                | 12.33   | 0.0       | 12.33    | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20250222"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 13 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250219  |                  | 9999.99         |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 0    | 20250219  | 20250219 | 7499.99         | 2500.0        | 0.0      | 0.0  | 0.0       | 2500.0 | 2500.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250319     | 20250219 | 7000.98         | 499.01        | 345.21   | 0.0  | 0.0       | 844.22 | 844.22 | 844.22     | 0.0  | 0.0         |
      | 3  | 31   | 20250419     |                  | 6513.52         | 487.46        | 356.76   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 4  | 30   | 20250519       |                  | 5990.51         | 523.01        | 321.21   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 5  | 31   | 20250619      |                  | 5451.56         | 538.95        | 305.27   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 6  | 30   | 20250719      |                  | 4876.18         | 575.38        | 268.84   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 7  | 31   | 20250819    |                  | 4280.44         | 595.74        | 248.48   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 8  | 31   | 20250919 |                  | 3654.35         | 626.09        | 218.13   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 9  | 30   | 20251019   |                  | 2990.34         | 664.01        | 180.21   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 10 | 31   | 20251119  |                  | 2298.5          | 691.84        | 152.38   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 11 | 30   | 20251219  |                  | 1567.63         | 730.87        | 113.35   | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 12 | 31   | 20260119   |                  | 803.29          | 764.34        | 79.88    | 0.0  | 0.0       | 844.22 | 383.74 | 383.74     | 0.0  | 460.48      |
      | 13 | 31   | 20260219  |                  | 0.0             | 803.29        | 40.93    | 0.0  | 0.0       | 844.22 | 383.7  | 383.7      | 0.0  | 460.52      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due      | Paid    | In advance | Late | Outstanding |
      | 9999.99       | 2630.65  | 0.0  | 0.0       | 12630.64 | 7565.32 | 5065.32    | 0.0  | 5065.32     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250219 | Disbursement           | 9999.99 | 0.0       | 0.0      | 0.0  | 0.0       | 9999.99      | false    | false    |
      | 20250219 | Down Payment           | 2500.0  | 2500.0    | 0.0      | 0.0  | 0.0       | 7499.99      | false    | false    |
      | 20250219 | Repayment              | 844.22  | 499.01    | 345.21   | 0.0  | 0.0       | 7000.98      | false    | false    |
      | 20250220 | Merchant Issued Refund | 4221.1  | 4221.1    | 0.0      | 0.0  | 0.0       | 2779.88      | false    | false    |
      | 20250220 | Accrual                | 12.33   | 0.0       | 12.33    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250220 | Accrual                | 12.33   | 0.0       | 12.33    | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3537
  Scenario: Verify the accrual activity creation in case of full repayment on maturity date - absence of negative numbers with mid-range interest rate and mid-range principal
    When Admin sets the business date to "20250219"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_AUTO_DOWNPAYMENT_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20250219  | 5000           | 36                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 12                | MONTHS                | 1              | MONTHS                 | 12                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250219" with "5000" amount and expected disbursement date on "20250219"
    And Admin successfully disburse the loan on "20250219" with "5000" EUR transaction amount
    Then Loan Repayment schedule has 13 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250219  |                  | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 0    | 20250219  | 20250219 | 3750.0          | 1250.0        | 0.0      | 0.0  | 0.0       | 1250.0 | 1250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250319     |                  | 3477.35         | 272.65        | 103.56   | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 3  | 31   | 20250419     |                  | 3207.46         | 269.89        | 106.32   | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 4  | 30   | 20250519       |                  | 2926.16         | 281.3         | 94.91    | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 5  | 31   | 20250619      |                  | 2639.42         | 286.74        | 89.47    | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 6  | 30   | 20250719      |                  | 2341.31         | 298.11        | 78.1     | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 7  | 31   | 20250819    |                  | 2036.69         | 304.62        | 71.59    | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 8  | 31   | 20250919 |                  | 1722.75         | 313.94        | 62.27    | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 9  | 30   | 20251019   |                  | 1397.51         | 325.24        | 50.97    | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 10 | 31   | 20251119  |                  | 1064.03         | 333.48        | 42.73    | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 11 | 30   | 20251219  |                  | 719.3           | 344.73        | 31.48    | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 12 | 31   | 20260119   |                  | 365.08          | 354.22        | 21.99    | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 13 | 31   | 20260219  |                  | 0.0             | 365.08        | 11.16    | 0.0  | 0.0       | 376.24 | 0.0    | 0.0        | 0.0  | 376.24      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 5000.0        | 764.55   | 0.0  | 0.0       | 5764.55 | 1250.0 | 0.0        | 0.0  | 4514.55     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250219 | Disbursement     | 5000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       | false    | false    |
      | 20250219 | Down Payment     | 1250.0 | 1250.0    | 0.0      | 0.0  | 0.0       | 3750.0       | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20250219" with 376.21 EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 13 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250219  |                  | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 0    | 20250219  | 20250219 | 3750.0          | 1250.0        | 0.0      | 0.0  | 0.0       | 1250.0 | 1250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250319     | 20250219 | 3477.35         | 272.65        | 103.56   | 0.0  | 0.0       | 376.21 | 376.21 | 376.21     | 0.0  | 0.0         |
      | 3  | 31   | 20250419     |                  | 3207.46         | 269.89        | 106.32   | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 4  | 30   | 20250519       |                  | 2926.16         | 281.3         | 94.91    | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 5  | 31   | 20250619      |                  | 2639.42         | 286.74        | 89.47    | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 6  | 30   | 20250719      |                  | 2341.31         | 298.11        | 78.1     | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 7  | 31   | 20250819    |                  | 2036.69         | 304.62        | 71.59    | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 8  | 31   | 20250919 |                  | 1722.75         | 313.94        | 62.27    | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 9  | 30   | 20251019   |                  | 1397.51         | 325.24        | 50.97    | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 10 | 31   | 20251119  |                  | 1064.03         | 333.48        | 42.73    | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 11 | 30   | 20251219  |                  | 719.3           | 344.73        | 31.48    | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 12 | 31   | 20260119   |                  | 365.08          | 354.22        | 21.99    | 0.0  | 0.0       | 376.21 | 0.0    | 0.0        | 0.0  | 376.21      |
      | 13 | 31   | 20260219  |                  | 0.0             | 365.08        | 11.16    | 0.0  | 0.0       | 376.24 | 0.0    | 0.0        | 0.0  | 376.24      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 5000.0        | 764.55   | 0.0  | 0.0       | 5764.55 | 1626.21 | 376.21     | 0.0  | 4138.34     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250219 | Disbursement     | 5000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       | false    | false    |
      | 20250219 | Down Payment     | 1250.0 | 1250.0    | 0.0      | 0.0  | 0.0       | 3750.0       | false    | false    |
      | 20250219 | Repayment        | 376.21 | 272.65    | 103.56   | 0.0  | 0.0       | 3477.35      | false    | false    |
    When Admin sets the business date to "20250220"
    When Admin makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250220" with 1881.05 EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 13 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250219  |                  | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 0    | 20250219  | 20250219 | 3750.0          | 1250.0        | 0.0      | 0.0  | 0.0       | 1250.0 | 1250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250319     | 20250219 | 3477.35         | 272.65        | 103.56   | 0.0  | 0.0       | 376.21 | 376.21 | 376.21     | 0.0  | 0.0         |
      | 3  | 31   | 20250419     |                  | 3207.46         | 269.89        | 106.32   | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 4  | 30   | 20250519       |                  | 2926.16         | 281.3         | 94.91    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 5  | 31   | 20250619      |                  | 2639.42         | 286.74        | 89.47    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 6  | 30   | 20250719      |                  | 2341.31         | 298.11        | 78.1     | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 7  | 31   | 20250819    |                  | 2036.69         | 304.62        | 71.59    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 8  | 31   | 20250919 |                  | 1722.75         | 313.94        | 62.27    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 9  | 30   | 20251019   |                  | 1397.51         | 325.24        | 50.97    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 10 | 31   | 20251119  |                  | 1064.03         | 333.48        | 42.73    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 11 | 30   | 20251219  |                  | 719.3           | 344.73        | 31.48    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 12 | 31   | 20260119   |                  | 365.08          | 354.22        | 21.99    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 13 | 31   | 20260219  |                  | 0.0             | 365.08        | 11.16    | 0.0  | 0.0       | 376.24 | 171.05 | 171.05     | 0.0  | 205.19      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 5000.0        | 764.55   | 0.0  | 0.0       | 5764.55 | 3507.26 | 2257.26    | 0.0  | 2257.29     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250219 | Disbursement           | 5000.0  | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       | false    | false    |
      | 20250219 | Down Payment           | 1250.0  | 1250.0    | 0.0      | 0.0  | 0.0       | 3750.0       | false    | false    |
      | 20250219 | Repayment              | 376.21  | 272.65    | 103.56   | 0.0  | 0.0       | 3477.35      | false    | false    |
      | 20250220 | Merchant Issued Refund | 1881.05 | 1881.05   | 0.0      | 0.0  | 0.0       | 1596.3       | false    | false    |
    When Admin sets the business date to "20250221"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 13 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250219  |                  | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 0    | 20250219  | 20250219 | 3750.0          | 1250.0        | 0.0      | 0.0  | 0.0       | 1250.0 | 1250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250319     | 20250219 | 3477.35         | 272.65        | 103.56   | 0.0  | 0.0       | 376.21 | 376.21 | 376.21     | 0.0  | 0.0         |
      | 3  | 31   | 20250419     |                  | 3207.46         | 269.89        | 106.32   | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 4  | 30   | 20250519       |                  | 2926.16         | 281.3         | 94.91    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 5  | 31   | 20250619      |                  | 2639.42         | 286.74        | 89.47    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 6  | 30   | 20250719      |                  | 2341.31         | 298.11        | 78.1     | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 7  | 31   | 20250819    |                  | 2036.69         | 304.62        | 71.59    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 8  | 31   | 20250919 |                  | 1722.75         | 313.94        | 62.27    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 9  | 30   | 20251019   |                  | 1397.51         | 325.24        | 50.97    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 10 | 31   | 20251119  |                  | 1064.03         | 333.48        | 42.73    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 11 | 30   | 20251219  |                  | 719.3           | 344.73        | 31.48    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 12 | 31   | 20260119   |                  | 365.08          | 354.22        | 21.99    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 13 | 31   | 20260219  |                  | 0.0             | 365.08        | 11.16    | 0.0  | 0.0       | 376.24 | 171.05 | 171.05     | 0.0  | 205.19      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 5000.0        | 764.55   | 0.0  | 0.0       | 5764.55 | 3507.26 | 2257.26    | 0.0  | 2257.29     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250219 | Disbursement           | 5000.0  | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       | false    | false    |
      | 20250219 | Down Payment           | 1250.0  | 1250.0    | 0.0      | 0.0  | 0.0       | 3750.0       | false    | false    |
      | 20250219 | Repayment              | 376.21  | 272.65    | 103.56   | 0.0  | 0.0       | 3477.35      | false    | false    |
      | 20250220 | Merchant Issued Refund | 1881.05 | 1881.05   | 0.0      | 0.0  | 0.0       | 1596.3       | false    | false    |
      | 20250220 | Accrual                | 3.7     | 0.0       | 3.7      | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20250222"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 13 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250219  |                  | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 0    | 20250219  | 20250219 | 3750.0          | 1250.0        | 0.0      | 0.0  | 0.0       | 1250.0 | 1250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250319     | 20250219 | 3477.35         | 272.65        | 103.56   | 0.0  | 0.0       | 376.21 | 376.21 | 376.21     | 0.0  | 0.0         |
      | 3  | 31   | 20250419     |                  | 3207.46         | 269.89        | 106.32   | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 4  | 30   | 20250519       |                  | 2926.16         | 281.3         | 94.91    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 5  | 31   | 20250619      |                  | 2639.42         | 286.74        | 89.47    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 6  | 30   | 20250719      |                  | 2341.31         | 298.11        | 78.1     | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 7  | 31   | 20250819    |                  | 2036.69         | 304.62        | 71.59    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 8  | 31   | 20250919 |                  | 1722.75         | 313.94        | 62.27    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 9  | 30   | 20251019   |                  | 1397.51         | 325.24        | 50.97    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 10 | 31   | 20251119  |                  | 1064.03         | 333.48        | 42.73    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 11 | 30   | 20251219  |                  | 719.3           | 344.73        | 31.48    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 12 | 31   | 20260119   |                  | 365.08          | 354.22        | 21.99    | 0.0  | 0.0       | 376.21 | 171.0  | 171.0      | 0.0  | 205.21      |
      | 13 | 31   | 20260219  |                  | 0.0             | 365.08        | 11.16    | 0.0  | 0.0       | 376.24 | 171.05 | 171.05     | 0.0  | 205.19      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 5000.0        | 764.55   | 0.0  | 0.0       | 5764.55 | 3507.26 | 2257.26    | 0.0  | 2257.29     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250219 | Disbursement           | 5000.0  | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       | false    | false    |
      | 20250219 | Down Payment           | 1250.0  | 1250.0    | 0.0      | 0.0  | 0.0       | 3750.0       | false    | false    |
      | 20250219 | Repayment              | 376.21  | 272.65    | 103.56   | 0.0  | 0.0       | 3477.35      | false    | false    |
      | 20250220 | Merchant Issued Refund | 1881.05 | 1881.05   | 0.0      | 0.0  | 0.0       | 1596.3       | false    | false    |
      | 20250220 | Accrual                | 3.7     | 0.0       | 3.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250221 | Accrual                | 3.7     | 0.0       | 3.7      | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3733
  Scenario: Accruals on accounts where charge adjustments and refunds are done on the same day should not cause duplicate journal entries
    When Admin sets the business date to "20250512"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_360_30_INTEREST_RECALCULATION_ZERO_INTEREST_CHARGE_OFF_ACCRUAL_ACTIVITY | 20250512       | 50             | 12.19                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250512" with "50" amount and expected disbursement date on "20250512"
    And Admin successfully disburse the loan on "20250512" with "48.25" EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20250512" due date and 1.30 EUR transaction amount
    And Admin makes a charge adjustment for the last "LOAN_NSF_FEE" type charge which is due on "20250512" with 1.30 EUR transaction amount and externalId ""
    When Admin makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20250512" with 48.25 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250512      | Disbursement       | 48.25  | 0.0       | 0.0      | 0.0  | 0.0       | 48.25        |
      | 20250512      | Charge Adjustment  | 1.3    | 0.0       | 0.0      | 0.0  | 1.3       | 48.25        |
      | 20250512      | Payout Refund      | 48.25  | 48.25     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20250512      | Accrual            | 1.3    | 0.0       | 0.0      | 0.0  | 1.3       | 0.0          |
      | 20250512      | Accrual Activity   | 1.3    | 0.0       | 0.0      | 0.0  | 1.3       | 0.0          |
    Then Loan Transactions tab has a "ACCRUAL" transaction with date "20250512" which has the following Journal entries:
      | Type   | Account code | Account name            | Debit | Credit |
      | ASSET  | 112603       | Interest/Fee Receivable | 1.3   |        |
      | INCOME | 404007       | Fee Income              |       | 1.3    |

  @TestRailId:C4516
  Scenario: Verify Interest recalculation - EARLY repayment, adjust LAST installment - UC5: 360/30, interest and accruals are correctly calculated till and after maturity date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_ACCRUAL_ACTIVITY_POSTING" loan product "MERCHANT_ISSUED_REFUND" transaction type to "LAST_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_ACCRUAL_ACTIVITY_POSTING | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
#    --- Early repayment with 17.01 EUR on 15 Jan ---
    When Admin sets the business date to "20240115"
    When Call Internal API to remove progressive loan model by loan Id
    When Admin makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240115" with 17.01 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |                 | 83.52           | 16.48         | 0.53     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |                 | 66.9            | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                 | 50.18           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                 | 33.36           | 16.82         | 0.19     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                 | 17.01           | 16.35         | 0.1      | 0.0  | 0.0       | 16.45 | 0.0   | 0.0        | 0.0  | 16.45       |
      | 6  | 30   | 20240701     | 20240115 | 0.0             | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.5      | 0.0  | 0.0       | 101.5 | 17.01 | 17.01      | 0.0  | 84.49       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement           | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240115  | Merchant Issued Refund | 17.01  | 17.01     | 0.0      | 0.0  | 0.0       | 82.99        | false    | false    |
    When Admin sets the business date to "20240601"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |                 | 83.52           | 16.48         | 0.53     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |                 | 66.99           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                 | 50.46           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                 | 33.93           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                 | 17.01           | 16.92         | 0.48     | 0.0  | 0.0       | 17.4  | 0.0   | 0.0        | 0.0  | 17.4        |
      | 6  | 30   | 20240701     | 20240115 | 0.0             | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.45     | 0.0  | 0.0       | 102.45 | 17.01 | 17.01      | 0.0  | 85.44       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240115  | Merchant Issued Refund    | 17.01  | 17.01     | 0.0      | 0.0  | 0.0       | 82.99        | false    | false    |
      | 20240201 | Accrual Activity          | 0.53   |  0.0      | 0.53     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240301    | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240401    | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240501      | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240531      | Accrual                   | 1.87   |  0.0      | 1.87     | 0.0  | 0.0       |  0.0         | false    | false    |
    When Admin sets the business date to "20240602"
    When Call Internal API to remove progressive loan model by loan Id
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |                 | 83.52           | 16.48         | 0.53     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |                 | 66.99           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                 | 50.46           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                 | 33.93           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                 | 17.01           | 16.92         | 0.5      | 0.0  | 0.0       | 17.42 | 0.0   | 0.0        | 0.0  | 17.42       |
      | 6  | 30   | 20240701     | 20240115 | 0.0             | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.47     | 0.0  | 0.0       | 102.47 | 17.01 | 17.01      | 0.0  | 85.46       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240115  | Merchant Issued Refund    | 17.01  | 17.01     | 0.0      | 0.0  | 0.0       | 82.99        | false    | false    |
      | 20240201 | Accrual Activity          | 0.53   |  0.0      | 0.53     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240301    | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240401    | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240501      | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240531      | Accrual                   | 1.87   |  0.0      | 1.87     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240601     | Accrual                   | 0.58   |  0.0      | 0.58     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240601     | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
    When Admin sets the business date to "20240701"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |                 | 83.52           | 16.48         | 0.53     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |                 | 66.99           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                 | 50.46           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                 | 33.93           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                 | 17.01           | 16.92         | 0.96     | 0.0  | 0.0       | 17.88 | 0.0   | 0.0        | 0.0  | 17.88       |
      | 6  | 30   | 20240701     | 20240115 | 0.0             | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.93     | 0.0  | 0.0       | 102.93 | 17.01 | 17.01      | 0.0  | 85.92       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240115  | Merchant Issued Refund    | 17.01  | 17.01     | 0.0      | 0.0  | 0.0       | 82.99        | false    | false    |
      | 20240201 | Accrual Activity          | 0.53   |  0.0      | 0.53     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240301    | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240401    | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240501      | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240531      | Accrual                   | 1.87   |  0.0      | 1.87     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240601     | Accrual                   | 0.58   |  0.0      | 0.58     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240601     | Accrual Activity          | 0.95   |  0.0      | 0.95     | 0.0  | 0.0       |  0.0         | false    | true     |
      | 20240602     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240603     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240604     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240605     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240606     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240607     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240608     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240609     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240610     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240611     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240612     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240613     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240614     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240615     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240616     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240617     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240618     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240619     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240620     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240621     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240622     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240623     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240624     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240625     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240626     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240627     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240628     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240629     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240630     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
    When Admin sets the business date to "20240702"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |                 | 83.52           | 16.48         | 0.53     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |                 | 66.99           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                 | 50.46           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                 | 33.93           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                 | 17.01           | 16.92         | 0.96     | 0.0  | 0.0       | 17.88 | 0.0   | 0.0        | 0.0  | 17.88       |
      | 6  | 30   | 20240701     | 20240115 | 0.0             | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.93     | 0.0  | 0.0       | 102.93 | 17.01 | 17.01      | 0.0  | 85.92       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240115  | Merchant Issued Refund    | 17.01  | 17.01     | 0.0      | 0.0  | 0.0       | 82.99        | false    | false    |
      | 20240201 | Accrual Activity          | 0.53   |  0.0      | 0.53     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240301    | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240401    | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240501      | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240531      | Accrual                   | 1.87   |  0.0      | 1.87     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240601     | Accrual                   | 0.58   |  0.0      | 0.58     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240601     | Accrual Activity          | 0.96   |  0.0      | 0.96     | 0.0  | 0.0       |  0.0         | false    | true     |
      | 20240602     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240603     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240604     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240605     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240606     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240607     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240608     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240609     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240610     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240611     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240612     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240613     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240614     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240615     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240616     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240617     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240618     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240619     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240620     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240621     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240622     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240623     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240624     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240625     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240626     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240627     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240628     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240629     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240630     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240701     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
    When Admin sets the business date to "20240703"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |                 | 83.52           | 16.48         | 0.53     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |                 | 66.99           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                 | 50.46           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                 | 33.93           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                 | 17.01           | 16.92         | 0.96     | 0.0  | 0.0       | 17.88 | 0.0   | 0.0        | 0.0  | 17.88       |
      | 6  | 30   | 20240701     | 20240115 | 0.0             | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.93     | 0.0  | 0.0       | 102.93 | 17.01 | 17.01      | 0.0  | 85.92       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240115  | Merchant Issued Refund    | 17.01  | 17.01     | 0.0      | 0.0  | 0.0       | 82.99        | false    | false    |
      | 20240201 | Accrual Activity          | 0.53   |  0.0      | 0.53     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240301    | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240401    | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240501      | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240531      | Accrual                   | 1.87   |  0.0      | 1.87     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240601     | Accrual                   | 0.58   |  0.0      | 0.58     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240601     | Accrual Activity          | 0.96   |  0.0      | 0.96     | 0.0  | 0.0       |  0.0         | false    | true     |
      | 20240602     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240603     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240604     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240605     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240606     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240607     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240608     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240609     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240610     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240611     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240612     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240613     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240614     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240615     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240616     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240617     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240618     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240619     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240620     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240621     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240622     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240623     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240624     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240625     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240626     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240627     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240628     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240629     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240630     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240701     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
    When Admin sets the business date to "20240801"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |                 | 83.52           | 16.48         | 0.53     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |                 | 66.99           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                 | 50.46           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                 | 33.93           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                 | 17.01           | 16.92         | 0.96     | 0.0  | 0.0       | 17.88 | 0.0   | 0.0        | 0.0  | 17.88       |
      | 6  | 30   | 20240701     | 20240115 | 0.0             | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.93     | 0.0  | 0.0       | 102.93 | 17.01 | 17.01      | 0.0  | 85.92       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240115  | Merchant Issued Refund    | 17.01  | 17.01     | 0.0      | 0.0  | 0.0       | 82.99        | false    | false    |
      | 20240201 | Accrual Activity          | 0.53   |  0.0      | 0.53     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240301    | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240401    | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240501      | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240531      | Accrual                   | 1.87   |  0.0      | 1.87     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240601     | Accrual                   | 0.58   |  0.0      | 0.58     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240601     | Accrual Activity          | 0.96   |  0.0      | 0.96     | 0.0  | 0.0       |  0.0         | false    | true     |
      | 20240602     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240603     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240604     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240605     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240606     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240607     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240608     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240609     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240610     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240611     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240612     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240613     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240614     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240615     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240616     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240617     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240618     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240619     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240620     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240621     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240622     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240623     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240624     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240625     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240626     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240627     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240628     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240629     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240630     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240701     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
    When Admin sets the business date to "20240802"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |                 | 83.52           | 16.48         | 0.53     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |                 | 66.99           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                 | 50.46           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                 | 33.93           | 16.53         | 0.48     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                 | 17.01           | 16.92         | 0.96     | 0.0  | 0.0       | 17.88 | 0.0   | 0.0        | 0.0  | 17.88       |
      | 6  | 30   | 20240701     | 20240115 | 0.0             | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.93     | 0.0  | 0.0       | 102.93 | 17.01 | 17.01      | 0.0  | 85.92       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240115  | Merchant Issued Refund    | 17.01  | 17.01     | 0.0      | 0.0  | 0.0       | 82.99        | false    | false    |
      | 20240201 | Accrual Activity          | 0.53   |  0.0      | 0.53     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240301    | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240401    | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240501      | Accrual Activity          | 0.48   |  0.0      | 0.48     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240531      | Accrual                   | 1.87   |  0.0      | 1.87     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240601     | Accrual                   | 0.58   |  0.0      | 0.58     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240601     | Accrual Activity          | 0.96   |  0.0      | 0.96     | 0.0  | 0.0       |  0.0         | false    | true     |
      | 20240602     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240603     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240604     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240605     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240606     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240607     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240608     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240609     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240610     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240611     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240612     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240613     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240614     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240615     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240616     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240617     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240618     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240619     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240620     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240621     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240622     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240623     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240624     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240625     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240626     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240627     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240628     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240629     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240630     | Accrual                   | 0.02   |  0.0      | 0.02     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20240701     | Accrual                   | 0.01   |  0.0      | 0.01     | 0.0  | 0.0       |  0.0         | false    | false    |
    When Loan Pay-off is made on "20240701"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    When Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_ACCRUAL_ACTIVITY_POSTING" loan product "MERCHANT_ISSUED_REFUND" transaction type to "REAMORTIZATION" future installment allocation rule

  @TestRailId:C4627
  Scenario: Verify accrual date matches charge creation date when repayment happens before COB run
    When Admin sets the business date to "20251117"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20251117  | 100            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20251117" with "100" amount and expected disbursement date on "20251117"
    When Admin successfully disburse the loan on "20251117" with "100" EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20251117" due date and 10 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20251117 | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
  #   --- Date changes to next day (post-midnight but before COB) ---
    When Admin sets the business date to "20251118"
  #   --- Full repayment made before COB runs ---
    When Admin creates new user with "NO_BYPASS_AUTOTEST" username, "NO_BYPASS_AUTOTEST_ROLE" role name and given permissions:
      | REPAYMENT_LOAN |
    And Created user makes "AUTOPAY" repayment on "20251118" with 110 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
  #   --- Expected: Accrual transaction date should be 20251117 (charge creation date) ---
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20251117 | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20251118 | Repayment        | 110.0  | 100.0     | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20251117 | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20251118 | Accrual Activity | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
    Then LoanAccrualTransactionCreatedBusinessEvent is raised on "20251117"
    Then LoanTransactionAccrualActivityPostBusinessEvent is raised on "20251118"
