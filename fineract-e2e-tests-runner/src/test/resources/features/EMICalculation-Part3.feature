@Emi
Feature: EMI calculation and repayment schedule checks for interest bearing loans - Part3

  @TestRailId:C3302
  Scenario: UC18-2 - In case of repayment reversal the Interest Refund transaction needs to be recalculated
    # using 2021 for the test since as per UC - non-leap year with 365 days should be used
    When Admin sets the business date to "20210101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_REFUND_FULL | 20210101   | 1000           | 9.9                    | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20210101" with "1000" amount and expected disbursement date on "20210101"
    When Admin successfully disburse the loan on "20210101" with "1000" EUR transaction amount
    When Admin sets the business date to "20210110"
    And Customer makes "AUTOPAY" repayment on "20210110" with 85.63 EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20210101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20210201 |           | 0.0             | 1000.0        | 7.9      | 0.0  | 0.0       | 1007.9 | 85.63 | 85.63      | 0.0  | 922.27      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 7.9      | 0.0  | 0.0       | 1007.9 | 85.63 | 85.63      | 0.0  | 922.27      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20210101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20210110  | Repayment        | 85.63  | 85.63     | 0.0      | 0.0  | 0.0       | 914.37       | false    | false    |
    When Admin sets the business date to "20210122"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20210122" with 1000 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      |    |      | 20210101  |                 | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0     |            |      |             |
      | 1  | 31   | 20210201 | 20210122 | 0.0             | 1000.0        | 5.42     | 0.0  | 0.0       | 1005.42 | 1005.42 | 1005.42    | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 1000.0        | 5.42     | 0.0  | 0.0       | 1005.42 | 1005.42 | 1005.42    | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20210101  | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20210110  | Repayment              | 85.63  | 85.63     | 0.0      | 0.0  | 0.0       | 914.37       | false    | false    |
      | 20210122  | Merchant Issued Refund | 1000.0 | 914.37    | 5.42     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20210122  | Interest Refund        | 5.42   | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20210122  | Accrual                | 5.42   | 0.0       | 5.42     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20210123"
    And Admin makes Credit Balance Refund transaction on "20210123" with 85.63 EUR transaction amount
    When Customer undo "1"th "Repayment" transaction made on "20210110"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      |    |      | 20210101  |           | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0    |            |      |             |
      | 1  | 31   | 20210201 |           | 0.0             | 1085.63       | 5.9      | 0.0  | 0.0       | 1091.53 | 1005.7 | 1005.7     | 0.0  | 85.83       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1085.63       | 5.9      | 0.0  | 0.0       | 1091.53 | 1005.7 | 1005.7     | 0.0  | 85.83       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20210101  | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20210110  | Repayment              | 85.63  | 85.63     | 0.0      | 0.0  | 0.0       | 914.37       | true     | false    |
      | 20210122  | Merchant Issued Refund | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20210122  | Interest Refund        | 5.7    | 0.0       | 5.7      | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20210123  | Credit Balance Refund  | 85.63  | 85.63     | 0.0      | 0.0  | 0.0       | 85.63        | false    | true     |
      | 20210122  | Accrual                | 5.42   | 0.0       | 5.42     | 0.0  | 0.0       | 0.0          | false    | false    |
    And In Loan Transactions the "2"th Transaction has Transaction type="Repayment" and is reverted
    When Admin sets the business date to "20210201"
    When Loan Pay-off is made on "20210201"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3303
  Scenario: UC18-3 - In case of refund reversal the Interest Refund transaction needs to be recalculated
 # using 2021 for the test since as per UC - non-leap year with 365 days should be used
    When Admin sets the business date to "20210101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_REFUND_FULL | 20210101   | 1000           | 9.9                    | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20210101" with "1000" amount and expected disbursement date on "20210101"
    When Admin successfully disburse the loan on "20210101" with "1000" EUR transaction amount
    When Admin sets the business date to "20210122"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20210122" with 1000 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20210101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20210201 | 20210122 | 0.0             | 1000.0        | 5.7      | 0.0  | 0.0       | 1005.7 | 1005.7 | 1005.7     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 5.7      | 0.0  | 0.0       | 1005.7 | 1005.7 | 1005.7     | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20210101  | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20210122  | Merchant Issued Refund | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20210122  | Interest Refund        | 5.7    | 0.0       | 5.7      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20210122  | Accrual                | 5.7    | 0.0       | 5.7      | 0.0  | 0.0       | 0.0          | false    | false    |
    When Customer undo "1"th "Merchant Issued Refund" transaction made on "20210122"
    When Admin sets the business date to "20210123"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20210101  |           | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20210201 |           | 0.0             | 1000.0        | 8.41     | 0.0  | 0.0       | 1008.41 | 0.0  | 0.0        | 0.0  | 1008.41     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 8.41     | 0.0  | 0.0       | 1008.41 | 0.0  | 0.0        | 0.0  | 1008.41     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20210101  | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20210122  | Merchant Issued Refund | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20210122  | Interest Refund        | 5.7    | 0.0       | 5.7      | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20210122  | Accrual                | 5.7    | 0.0       | 5.7      | 0.0  | 0.0       | 0.0          | false    | false    |
    Then In Loan Transactions the "2"th Transaction has Transaction type="Merchant Issued Refund" and is reverted
    Then In Loan Transactions the "3"th Transaction has Transaction type="Interest Refund" and is reverted
    When Admin sets the business date to "20210201"
    When Loan Pay-off is made on "20210201"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3313
  Scenario: Verify that due date charges after maturity date is recognized on repayment schedule
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 75.21           | 24.79         | 0.58     | 0.0  | 0.0       | 25.37 | 0.0  | 0.0        | 0.0  | 25.37       |
      | 2  | 29   | 20240301    |           | 50.28           | 24.93         | 0.44     | 0.0  | 0.0       | 25.37 | 0.0  | 0.0        | 0.0  | 25.37       |
      | 3  | 31   | 20240401    |           | 25.2            | 25.08         | 0.29     | 0.0  | 0.0       | 25.37 | 0.0  | 0.0        | 0.0  | 25.37       |
      | 4  | 30   | 20240501      |           | 0.0             | 25.2          | 0.15     | 0.0  | 0.0       | 25.35 | 0.0  | 0.0        | 0.0  | 25.35       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.46     | 0.0  | 0.0       | 101.46 | 0.0  | 0.0        | 0.0  | 101.46      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
    When Admin sets the business date to "20240420"
    And Admin runs inline COB job for Loan
    When Admin sets the business date to "20240515"
    And Admin runs inline COB job for Loan
    And Admin adds "LOAN_NSF_FEE" due date charge with "20240515" due date and 10 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 75.21           | 24.79         | 0.58     | 0.0  | 0.0       | 25.37 | 0.0  | 0.0        | 0.0  | 25.37       |
      | 2  | 29   | 20240301    |           | 50.42           | 24.79         | 0.58     | 0.0  | 0.0       | 25.37 | 0.0  | 0.0        | 0.0  | 25.37       |
      | 3  | 31   | 20240401    |           | 25.63           | 24.79         | 0.58     | 0.0  | 0.0       | 25.37 | 0.0  | 0.0        | 0.0  | 25.37       |
      | 4  | 30   | 20240501      |           | 0.0             | 25.63         | 0.58     | 0.0  | 0.0       | 26.21 | 0.0  | 0.0        | 0.0  | 26.21       |
      | 5  | 14   | 20240515      |           | 0.0             | 0.0           | 0.0      | 0.0  | 10.0      | 10.0  | 0.0  | 0.0        | 0.0  | 10.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.32     | 0.0  | 10.0      | 112.32 | 0.0  | 0.0        | 0.0  | 112.32      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240419    | Accrual          | 1.66   | 0.0       | 1.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240420    | Accrual          | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240421    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240422    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240423    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240424    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240425    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240426    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240427    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240428    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240429    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240430    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20240515 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    When Loan Pay-off is made on "20240515"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3333
  Scenario: Verify that due date charges after maturity date with inline COB run is recognized on repayment schedule
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 0.0             | 100.0         | 0.58     | 0.0  | 0.0       | 100.58 | 0.0  | 0.0        | 0.0  | 100.58      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.58     | 0.0  | 0.0       | 100.58 | 0.0  | 0.0        | 0.0  | 100.58      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
    When Admin sets the business date to "20240215"
    And Admin adds "LOAN_NSF_FEE" due date charge with "20240215" due date and 10 EUR transaction amount
    When Admin sets the business date to "20240216"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 0.0             | 100.0         | 0.58     | 0.0  | 0.0       | 100.58 | 0.0  | 0.0        | 0.0  | 100.58      |
      | 2  | 14   | 20240215 |           | 0.0             | 0.0           | 0.0      | 0.0  | 10.0      | 10.0   | 0.0  | 0.0        | 0.0  | 10.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.58     | 0.0  | 10.0      | 110.58 | 0.0  | 0.0        | 0.0  | 110.58      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240102  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 10.0   | 0.0       | 0.0      | 0.0  | 10.0      | 0.0          | false    | false    |
    And Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20240215 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    When Loan Pay-off is made on "20240215"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3314
  Scenario: Verify that interest refund transaction won't be created and displayed when Merchant issued refund happens on disbursement date
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    And Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE" loan product "MERCHANT_ISSUED_REFUND" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 75.21           | 24.79         | 0.58     | 0.0  | 0.0       | 25.37 | 0.0  | 0.0        | 0.0  | 25.37       |
      | 2  | 29   | 20240301    |           | 50.28           | 24.93         | 0.44     | 0.0  | 0.0       | 25.37 | 0.0  | 0.0        | 0.0  | 25.37       |
      | 3  | 31   | 20240401    |           | 25.2            | 25.08         | 0.29     | 0.0  | 0.0       | 25.37 | 0.0  | 0.0        | 0.0  | 25.37       |
      | 4  | 30   | 20240501      |           | 0.0             | 25.2          | 0.15     | 0.0  | 0.0       | 25.35 | 0.0  | 0.0        | 0.0  | 25.35       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.46     | 0.0  | 0.0       | 101.46 | 0.0  | 0.0        | 0.0  | 101.46      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
    When Admin makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240101" with 100 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240101 | 74.63           | 25.37         | 0.0      | 0.0  | 0.0       | 25.37 | 25.37 | 25.37      | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240101 | 49.26           | 25.37         | 0.0      | 0.0  | 0.0       | 25.37 | 25.37 | 25.37      | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240101 | 23.89           | 25.37         | 0.0      | 0.0  | 0.0       | 25.37 | 25.37 | 25.37      | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240101 | 0.0             | 23.89         | 0.0      | 0.0  | 0.0       | 23.89 | 23.89 | 23.89      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 100.0      | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement           | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Merchant Issued Refund | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    And Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE" loan product "MERCHANT_ISSUED_REFUND" transaction type to "REAMORTIZATION" future installment allocation rule
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3322
  Scenario: Verify accrual activity with amend rate factor after calculated interest for period was rounded - UC1: Preclose, with full disbursement at first day, accrual activity after month
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
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
#    --- Accrual activity ---
    When Admin sets the business date to "20240202"
    When Admin runs inline COB job for Loan
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
      | 20240102  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240107  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240108  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240109  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240110  | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          |
      | 20240111  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240112  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240113  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240114  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240115  | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          |
      | 20240116  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240117  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240118  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240119  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240120  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240121  | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          |
      | 20240122  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240123  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240124  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240125  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240126  | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          |
      | 20240127  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240128  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240129  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240130  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240131  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240201 | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          |
    When Loan Pay-off is made on "20240202"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3323
  Scenario: Verify accrual activity with amend rate factor after calculated interest for period was rounded - UC2: Preclose, with multi disbursements, accrual activity after month
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE | 20240101   | 2000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "2000" amount and expected disbursement date on "20240101"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 2000.0          |               |          | 0.0  |           | 0.0     |      |            |      | 0.0         |
      | 1  | 31   | 20240201 |           | 0.0             | 2000.0        | 11.67    | 0.0  | 0.0       | 2011.67 | 0.0  | 0.0        | 0.0  | 2011.67     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 2000.0        | 11.67    | 0.0  | 0.0       | 2011.67 | 0.0  | 0.0        | 0.0  | 2011.67     |
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
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
#    --- Accrual activity after first disbursement ---
    When Admin sets the business date to "20240115"
    When Admin runs inline COB job for Loan
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
      | 20240102  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240107  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240108  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240109  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240110  | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          |
      | 20240111  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240112  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240113  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240114  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
#    --- Accrual activity after second disbursement ---
    When Admin successfully disburse the loan on "20240115" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      |    |      | 20240115  |           | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 0.0             | 2000.0        | 9.03     | 0.0  | 0.0       | 2009.03 | 0.0  | 0.0        | 0.0  | 2009.03     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 2000.0        | 9.03     | 0.0  | 0.0       | 2009.03 | 0.0  | 0.0        | 0.0  | 2009.03     |
    When Admin sets the business date to "20240202"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      |    |      | 20240115  |           | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 0.0             | 2000.0        | 9.03     | 0.0  | 0.0       | 2009.03 | 0.0  | 0.0        | 0.0  | 2009.03     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 2000.0        | 9.03     | 0.0  | 0.0       | 2009.03 | 0.0  | 0.0        | 0.0  | 2009.03     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240102  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240103  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240104  | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          |
      | 20240105  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240106  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240107  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240108  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240109  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240110  | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          |
      | 20240111  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240112  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240113  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240114  | Accrual          | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 0.0          |
      | 20240115  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 2000.0       |
      | 20240115  | Accrual          | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          |
      | 20240116  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          |
      | 20240117  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          |
      | 20240118  | Accrual          | 0.37   | 0.0       | 0.37     | 0.0  | 0.0       | 0.0          |
      | 20240119  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          |
      | 20240120  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          |
      | 20240121  | Accrual          | 0.37   | 0.0       | 0.37     | 0.0  | 0.0       | 0.0          |
      | 20240122  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          |
      | 20240123  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          |
      | 20240124  | Accrual          | 0.37   | 0.0       | 0.37     | 0.0  | 0.0       | 0.0          |
      | 20240125  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          |
      | 20240126  | Accrual          | 0.37   | 0.0       | 0.37     | 0.0  | 0.0       | 0.0          |
      | 20240127  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          |
      | 20240128  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          |
      | 20240129  | Accrual          | 0.37   | 0.0       | 0.37     | 0.0  | 0.0       | 0.0          |
      | 20240130  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          |
      | 20240131  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          |
      | 20240201 | Accrual          | 0.37   | 0.0       | 0.37     | 0.0  | 0.0       | 0.0          |
    When Loan Pay-off is made on "20240202"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3327
  Scenario: Verify accruals isn't reversed and replayed in COB for loan with disabled auto repayment for down payment
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_RECALCULATION_DAILY_EMI_360_30_MULTIDISBURSE_DOWNPAYMENT | 20240101   | 800            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "800" amount and expected disbursement date on "20240101"
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 800.0           |               |          | 0.0  |           | 0.0    |      |            |      | 0.0         |
      | 1  | 0    | 20240101  |           | 600.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0  | 0.0  | 0.0        | 0.0  | 200.0       |
      | 2  | 31   | 20240201 |           | 451.31          | 148.69        | 3.5      | 0.0  | 0.0       | 152.19 | 0.0  | 0.0        | 0.0  | 152.19      |
      | 3  | 29   | 20240301    |           | 301.75          | 149.56        | 2.63     | 0.0  | 0.0       | 152.19 | 0.0  | 0.0        | 0.0  | 152.19      |
      | 4  | 31   | 20240401    |           | 151.32          | 150.43        | 1.76     | 0.0  | 0.0       | 152.19 | 0.0  | 0.0        | 0.0  | 152.19      |
      | 5  | 30   | 20240501      |           | 0.0             | 151.32        | 0.88     | 0.0  | 0.0       | 152.2  | 0.0  | 0.0        | 0.0  | 152.2       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 800.0         | 8.77     | 0.0  | 0.0       | 808.77 | 0.0  | 0.0        | 0.0  | 808.77      |
    When Admin sets the business date to "20240105"
    And Admin successfully disburse the loan on "20240103" with "800" EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20240103" with 200 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240103  |                 | 800.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 0    | 20240103  | 20240103 | 600.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0  | 200.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240203 |                 | 451.31          | 148.69        | 3.5      | 0.0  | 0.0       | 152.19 | 0.0   | 0.0        | 0.0  | 152.19      |
      | 3  | 29   | 20240303    |                 | 301.75          | 149.56        | 2.63     | 0.0  | 0.0       | 152.19 | 0.0   | 0.0        | 0.0  | 152.19      |
      | 4  | 31   | 20240403    |                 | 151.32          | 150.43        | 1.76     | 0.0  | 0.0       | 152.19 | 0.0   | 0.0        | 0.0  | 152.19      |
      | 5  | 30   | 20240503      |                 | 0.0             | 151.32        | 0.88     | 0.0  | 0.0       | 152.2  | 0.0   | 0.0        | 0.0  | 152.2       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 800.0         | 8.77     | 0.0  | 0.0       | 808.77 | 200.0 | 0.0        | 0.0  | 608.77      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240103  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20240103  | Repayment        | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 600.0        | false    | false    |
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240103  |                 | 800.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 0    | 20240103  | 20240103 | 600.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0  | 200.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240203 |                 | 451.31          | 148.69        | 3.5      | 0.0  | 0.0       | 152.19 | 0.0   | 0.0        | 0.0  | 152.19      |
      | 3  | 29   | 20240303    |                 | 301.75          | 149.56        | 2.63     | 0.0  | 0.0       | 152.19 | 0.0   | 0.0        | 0.0  | 152.19      |
      | 4  | 31   | 20240403    |                 | 151.32          | 150.43        | 1.76     | 0.0  | 0.0       | 152.19 | 0.0   | 0.0        | 0.0  | 152.19      |
      | 5  | 30   | 20240503      |                 | 0.0             | 151.32        | 0.88     | 0.0  | 0.0       | 152.2  | 0.0   | 0.0        | 0.0  | 152.2       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 800.0         | 8.77     | 0.0  | 0.0       | 808.77 | 200.0 | 0.0        | 0.0  | 608.77      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240103  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20240103  | Repayment        | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 600.0        | false    | false    |
      | 20240104  | Accrual          | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240503"
    When Loan Pay-off is made on "20240503"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3328
  Scenario: Verify accruals isn't reversed and replayed in COB for loan with enabled auto repayment for down payment
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_RECALCULATION_DAILY_EMI_360_30_MULTIDISBURSE_AUTO_DOWNPAYMENT | 20240101   | 800            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "800" amount and expected disbursement date on "20240101"
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 800.0           |               |          | 0.0  |           | 0.0    |      |            |      | 0.0         |
      | 1  | 0    | 20240101  |           | 600.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0  | 0.0  | 0.0        | 0.0  | 200.0       |
      | 2  | 31   | 20240201 |           | 451.31          | 148.69        | 3.5      | 0.0  | 0.0       | 152.19 | 0.0  | 0.0        | 0.0  | 152.19      |
      | 3  | 29   | 20240301    |           | 301.75          | 149.56        | 2.63     | 0.0  | 0.0       | 152.19 | 0.0  | 0.0        | 0.0  | 152.19      |
      | 4  | 31   | 20240401    |           | 151.32          | 150.43        | 1.76     | 0.0  | 0.0       | 152.19 | 0.0  | 0.0        | 0.0  | 152.19      |
      | 5  | 30   | 20240501      |           | 0.0             | 151.32        | 0.88     | 0.0  | 0.0       | 152.2  | 0.0  | 0.0        | 0.0  | 152.2       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 800.0         | 8.77     | 0.0  | 0.0       | 808.77 | 0.0  | 0.0        | 0.0  | 808.77      |
    When Admin sets the business date to "20240105"
    And Admin successfully disburse the loan on "20240103" with "800" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240103  |                 | 800.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 0    | 20240103  | 20240103 | 600.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0  | 200.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240203 |                 | 451.31          | 148.69        | 3.5      | 0.0  | 0.0       | 152.19 | 0.0   | 0.0        | 0.0  | 152.19      |
      | 3  | 29   | 20240303    |                 | 301.75          | 149.56        | 2.63     | 0.0  | 0.0       | 152.19 | 0.0   | 0.0        | 0.0  | 152.19      |
      | 4  | 31   | 20240403    |                 | 151.32          | 150.43        | 1.76     | 0.0  | 0.0       | 152.19 | 0.0   | 0.0        | 0.0  | 152.19      |
      | 5  | 30   | 20240503      |                 | 0.0             | 151.32        | 0.88     | 0.0  | 0.0       | 152.2  | 0.0   | 0.0        | 0.0  | 152.2       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 800.0         | 8.77     | 0.0  | 0.0       | 808.77 | 200.0 | 0.0        | 0.0  | 608.77      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240103  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20240103  | Down Payment     | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 600.0        | false    | false    |
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240103  |                 | 800.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 0    | 20240103  | 20240103 | 600.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0  | 200.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240203 |                 | 451.31          | 148.69        | 3.5      | 0.0  | 0.0       | 152.19 | 0.0   | 0.0        | 0.0  | 152.19      |
      | 3  | 29   | 20240303    |                 | 301.75          | 149.56        | 2.63     | 0.0  | 0.0       | 152.19 | 0.0   | 0.0        | 0.0  | 152.19      |
      | 4  | 31   | 20240403    |                 | 151.32          | 150.43        | 1.76     | 0.0  | 0.0       | 152.19 | 0.0   | 0.0        | 0.0  | 152.19      |
      | 5  | 30   | 20240503      |                 | 0.0             | 151.32        | 0.88     | 0.0  | 0.0       | 152.2  | 0.0   | 0.0        | 0.0  | 152.2       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 800.0         | 8.77     | 0.0  | 0.0       | 808.77 | 200.0 | 0.0        | 0.0  | 608.77      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240103  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20240103  | Down Payment     | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 600.0        | false    | false    |
      | 20240104  | Accrual          | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240503"
    When Loan Pay-off is made on "20240503"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3329
  Scenario: Verify interest rate should not be calculated on past due principle amount for progressive loans - case when lesser than EMI amount was paid
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_NO_CALC_ON_PAST_DUE_TILL_PRECLOSE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    #    --- 1st installment overdue ---
    When Admin sets the business date to "20240202"
    When Admin runs inline COB job for Loan
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
      | 20240201 | Accrual          | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
    #    --- late payment comes in lesser than EMI amount ---
    When Admin sets the business date to "20240215"
    And Customer makes "AUTOPAY" repayment on "20240215" with 15.0 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 15.0 | 0.0        | 15.0 | 2.01        |
      | 2  | 29   | 20240301    |           | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 15.0 | 0.0        | 15.0 | 87.05       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Accrual          | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Repayment        | 15.0   | 15.0      | 0.0      | 0.0  | 0.0       | 85.0         | false    | false    |
    When Admin sets the business date to "20240701"
    When Loan Pay-off is made on "20240701"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3330
  Scenario: Verify interest rate should not be calculated on past due principle amount for progressive loans - case when full EMI amount was paid
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_NO_CALC_ON_PAST_DUE_TILL_PRECLOSE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    #    --- 1st installment overdue ---
    When Admin sets the business date to "20240202"
    When Admin runs inline COB job for Loan
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
      | 20240201 | Accrual          | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
    #    --- late payment comes with correct EMI amount ---
    When Admin sets the business date to "20240215"
    And Customer makes "AUTOPAY" repayment on "20240215" with 17.01 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20240201 | 20240215 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 17.01 | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0   | 17.01       |
      | 3  | 31   | 20240401    |                  | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0   | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0   | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0   | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0   | 0.0        | 0.0   | 17.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 17.01 | 0.0        | 17.01 | 85.04       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Accrual          | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
    When Admin sets the business date to "20240701"
    When Loan Pay-off is made on "20240701"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3331
  Scenario: Verify interest rate should not be calculated on past due principle amount for progressive loans - case when excess EMI amount was paid
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_NO_CALC_ON_PAST_DUE_TILL_PRECLOSE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    #    --- 1st installment overdue ---
    When Admin sets the business date to "20240202"
    When Admin runs inline COB job for Loan
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
      | 20240201 | Accrual          | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
    #    --- late payment comes in with excess EMI amount ---
    When Admin sets the business date to "20240215"
    And Customer makes "AUTOPAY" repayment on "20240215" with 34.02 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20240201 | 20240215 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 17.01 | 0.0         |
      | 2  | 29   | 20240301    | 20240215 | 66.8            | 16.77         | 0.24     | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0   | 0.0         |
      | 3  | 31   | 20240401    |                  | 50.38           | 16.42         | 0.59     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0   | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.66           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0   | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.85           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0   | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.85         | 0.1      | 0.0  | 0.0       | 16.95 | 0.0   | 0.0        | 0.0   | 16.95       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 100.0         | 2.0      | 0.0  | 0.0       | 102.0 | 34.02 | 17.01      | 17.01 | 67.98       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Accrual          | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Repayment        | 34.02  | 33.2      | 0.82     | 0.0  | 0.0       | 66.8         | false    | false    |
    When Admin sets the business date to "20240701"
    When Loan Pay-off is made on "20240701"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3332
  Scenario: Verify interest rate should not be calculated on past due principle amount for progressive loans - case when multiple disbursal occurred with full EMI amount was paid
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PAYMENT_ALLOC_INTEREST_RECALCULATION_DAILY_NO_CALC_ON_PAST_DUE_EMI_360_30_MULTIDISBURSE | 20240101   | 200            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
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
    #    --- 2nd disbursement ---
    When Admin sets the business date to "20240210"
    And Admin successfully disburse the loan on "20240210" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      |    |      | 20240210 |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 2  | 29   | 20240301    |           | 147.14          | 36.43         | 0.89     | 0.0  | 0.0       | 37.32 | 0.0  | 0.0        | 0.0  | 37.32       |
      | 3  | 31   | 20240401    |           | 110.68          | 36.46         | 0.86     | 0.0  | 0.0       | 37.32 | 0.0  | 0.0        | 0.0  | 37.32       |
      | 4  | 30   | 20240501      |           | 74.01           | 36.67         | 0.65     | 0.0  | 0.0       | 37.32 | 0.0  | 0.0        | 0.0  | 37.32       |
      | 5  | 31   | 20240601     |           | 37.12           | 36.89         | 0.43     | 0.0  | 0.0       | 37.32 | 0.0  | 0.0        | 0.0  | 37.32       |
      | 6  | 30   | 20240701     |           | 0.0             | 37.12         | 0.22     | 0.0  | 0.0       | 37.34 | 0.0  | 0.0        | 0.0  | 37.34       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 200.0         | 3.63     | 0.0  | 0.0       | 203.63 | 0.0  | 0.0        | 0.0  | 203.63      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240210 | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
    #    --- late payment comes with full amount ---
    When Admin sets the business date to "20240315"
    And Customer makes "AUTOPAY" repayment on "20240315" with 54.33 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |               | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20240201 | 20240315 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 17.01 | 0.0         |
      |    |      | 20240210 |               | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 2  | 29   | 20240301    | 20240315 | 147.14          | 36.43         | 0.89     | 0.0  | 0.0       | 37.32 | 37.32 | 0.0        | 37.32 | 0.0         |
      | 3  | 31   | 20240401    |               | 110.68          | 36.46         | 0.86     | 0.0  | 0.0       | 37.32 | 0.0   | 0.0        | 0.0   | 37.32       |
      | 4  | 30   | 20240501      |               | 74.01           | 36.67         | 0.65     | 0.0  | 0.0       | 37.32 | 0.0   | 0.0        | 0.0   | 37.32       |
      | 5  | 31   | 20240601     |               | 37.12           | 36.89         | 0.43     | 0.0  | 0.0       | 37.32 | 0.0   | 0.0        | 0.0   | 37.32       |
      | 6  | 30   | 20240701     |               | 0.0             | 37.12         | 0.22     | 0.0  | 0.0       | 37.34 | 0.0   | 0.0        | 0.0   | 37.34       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 200.0         | 3.63     | 0.0  | 0.0       | 203.63 | 54.33 | 0.0        | 54.33 | 149.3       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240210 | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
      | 20240315    | Repayment        | 54.33  | 52.86     | 1.47     | 0.0  | 0.0       | 147.14       | false    | false    |
    When Admin sets the business date to "20240701"
    When Loan Pay-off is made on "20240701"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3334
  Scenario: Verify that COB works properly while creating accruals for a overpaid account (accruals created on COB not when charge is created)
    When Admin sets the business date to "20241020"
    And Admin creates a client with random data
    And Admin set "LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "LAST_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20241020   | 100            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20241020" with "100" amount and expected disbursement date on "20241020"
    And Admin successfully disburse the loan on "20241020" with "100" EUR transaction amount
    And Admin runs inline COB job for Loan
    And Admin sets the business date to "20241021"
    And Admin runs inline COB job for Loan
    And Admin sets the business date to "20241022"
    And Customer makes "AUTOPAY" repayment on "20241022" with 102 EUR transaction amount
    Then Loan status will be "OVERPAID"
    And Loan has 2 overpaid amount
    When Admin sets the business date to "20241023"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20241020  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20241119 | 20241022 | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 100.0      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 100.0      | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241020  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20241022  | Repayment        | 102.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin adds "LOAN_NSF_FEE" due date charge with "20241023" due date and 20 EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20241020  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20241119 |           | 0.0             | 100.0         | 0.0      | 0.0  | 20.0      | 120.0 | 102.0 | 102.0      | 0.0  | 18.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 0.0      | 0.0  | 20.0      | 120.0 | 102.0 | 102.0      | 0.0  | 18.0        |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241020  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20241022  | Repayment        | 102.0  | 100.0     | 0.0      | 0.0  | 2.0       | 0.0          | false    | true     |
    And Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20241023 | Flat             | 20.0 | 2.0  | 0.0    | 18.0        |
    When Admin sets the business date to "20241024"
    And Admin runs inline COB job for Loan
    Then Loan status will be "ACTIVE"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20241020  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20241119 |           | 0.0             | 100.0         | 0.0      | 0.0  | 20.0      | 120.0 | 102.0 | 102.0      | 0.0  | 18.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 0.0      | 0.0  | 20.0      | 120.0 | 102.0 | 102.0      | 0.0  | 18.0        |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241020  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20241022  | Repayment        | 102.0  | 100.0     | 0.0      | 0.0  | 2.0       | 0.0          | false    | true     |
      | 20241023  | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          | false    | false    |
    And Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20241023 | Flat             | 20.0 | 2.0  | 0.0    | 18.0        |
    When Admin set "LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Loan Pay-off is made on "20241024"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3384
  Scenario: Verify the repayment schedule in case of interest bearing loan, interest recalculation enabled, 12 months loan, Merchant issued refund (next installment) on disbursement date
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE_PMT_ALLOC_1" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    And Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE_PMT_ALLOC_1" loan product "MERCHANT_ISSUED_REFUND" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE_PMT_ALLOC_1 | 20250101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 12                | MONTHS                | 1              | MONTHS                 | 12                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 12 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201  |           | 919.3           | 80.7          | 5.83     | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 2  | 28   | 20250301     |           | 838.13          | 81.17         | 5.36     | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 3  | 31   | 20250401     |           | 756.49          | 81.64         | 4.89     | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 4  | 30   | 20250501       |           | 674.37          | 82.12         | 4.41     | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 5  | 31   | 20250601      |           | 591.77          | 82.6          | 3.93     | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 6  | 30   | 20250701      |           | 508.69          | 83.08         | 3.45     | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 7  | 31   | 20250801    |           | 425.13          | 83.56         | 2.97     | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 8  | 31   | 20250901 |           | 341.08          | 84.05         | 2.48     | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 9  | 30   | 20251001   |           | 256.54          | 84.54         | 1.99     | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 10 | 31   | 20251101  |           | 171.51          | 85.03         | 1.5      | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 11 | 30   | 20251201  |           | 85.98           | 85.53         | 1.0      | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 12 | 31   | 20260101   |           | 0.0             | 85.98         | 0.5      | 0.0  | 0.0       | 86.48 | 0.0  | 0.0        | 0.0  | 86.48       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 38.31    | 0.0  | 0.0       | 1038.31 | 0.0  | 0.0        | 0.0  | 1038.31     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250101" with 1000 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 12 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250101   |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20250201  | 20250101 | 913.47          | 86.53         | 0.0      | 0.0  | 0.0       | 86.53 | 86.53 | 86.53      | 0.0  | 0.0         |
      | 2  | 28   | 20250301     | 20250101 | 826.94          | 86.53         | 0.0      | 0.0  | 0.0       | 86.53 | 86.53 | 86.53      | 0.0  | 0.0         |
      | 3  | 31   | 20250401     | 20250101 | 740.41          | 86.53         | 0.0      | 0.0  | 0.0       | 86.53 | 86.53 | 86.53      | 0.0  | 0.0         |
      | 4  | 30   | 20250501       | 20250101 | 653.88          | 86.53         | 0.0      | 0.0  | 0.0       | 86.53 | 86.53 | 86.53      | 0.0  | 0.0         |
      | 5  | 31   | 20250601      | 20250101 | 567.35          | 86.53         | 0.0      | 0.0  | 0.0       | 86.53 | 86.53 | 86.53      | 0.0  | 0.0         |
      | 6  | 30   | 20250701      | 20250101 | 480.82          | 86.53         | 0.0      | 0.0  | 0.0       | 86.53 | 86.53 | 86.53      | 0.0  | 0.0         |
      | 7  | 31   | 20250801    | 20250101 | 394.29          | 86.53         | 0.0      | 0.0  | 0.0       | 86.53 | 86.53 | 86.53      | 0.0  | 0.0         |
      | 8  | 31   | 20250901 | 20250101 | 307.76          | 86.53         | 0.0      | 0.0  | 0.0       | 86.53 | 86.53 | 86.53      | 0.0  | 0.0         |
      | 9  | 30   | 20251001   | 20250101 | 221.23          | 86.53         | 0.0      | 0.0  | 0.0       | 86.53 | 86.53 | 86.53      | 0.0  | 0.0         |
      | 10 | 31   | 20251101  | 20250101 | 134.7           | 86.53         | 0.0      | 0.0  | 0.0       | 86.53 | 86.53 | 86.53      | 0.0  | 0.0         |
      | 11 | 30   | 20251201  | 20250101 | 48.17           | 86.53         | 0.0      | 0.0  | 0.0       | 86.53 | 86.53 | 86.53      | 0.0  | 0.0         |
      | 12 | 31   | 20260101   | 20250101 | 0.0             | 48.17         | 0.0      | 0.0  | 0.0       | 48.17 | 48.17 | 48.17      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 1000.0 | 1000.0     | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20250101  | Merchant Issued Refund | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    And Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE_PMT_ALLOC_1" loan product "MERCHANT_ISSUED_REFUND" transaction type to "REAMORTIZATION" future installment allocation rule
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3385
  Scenario: Verify the repayment schedule in case of interest bearing loan, interest recalculation enabled, 12 months loan, Merchant issued refund (reamortization) on disbursement date
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE_PMT_ALLOC_1" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    And Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE_PMT_ALLOC_1" loan product "MERCHANT_ISSUED_REFUND" transaction type to "REAMORTIZATION" future installment allocation rule
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE_PMT_ALLOC_1 | 20250101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 12                | MONTHS                | 1              | MONTHS                 | 12                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 12 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201  |           | 919.3           | 80.7          | 5.83     | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 2  | 28   | 20250301     |           | 838.13          | 81.17         | 5.36     | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 3  | 31   | 20250401     |           | 756.49          | 81.64         | 4.89     | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 4  | 30   | 20250501       |           | 674.37          | 82.12         | 4.41     | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 5  | 31   | 20250601      |           | 591.77          | 82.6          | 3.93     | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 6  | 30   | 20250701      |           | 508.69          | 83.08         | 3.45     | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 7  | 31   | 20250801    |           | 425.13          | 83.56         | 2.97     | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 8  | 31   | 20250901 |           | 341.08          | 84.05         | 2.48     | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 9  | 30   | 20251001   |           | 256.54          | 84.54         | 1.99     | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 10 | 31   | 20251101  |           | 171.51          | 85.03         | 1.5      | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 11 | 30   | 20251201  |           | 85.98           | 85.53         | 1.0      | 0.0  | 0.0       | 86.53 | 0.0  | 0.0        | 0.0  | 86.53       |
      | 12 | 31   | 20260101   |           | 0.0             | 85.98         | 0.5      | 0.0  | 0.0       | 86.48 | 0.0  | 0.0        | 0.0  | 86.48       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 38.31    | 0.0  | 0.0       | 1038.31 | 0.0  | 0.0        | 0.0  | 1038.31     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250101" with 1000 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 12 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250101   |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20250201  | 20250101 | 916.67          | 83.33         | 0.0      | 0.0  | 0.0       | 83.33 | 83.33 | 83.33      | 0.0  | 0.0         |
      | 2  | 28   | 20250301     | 20250101 | 833.34          | 83.33         | 0.0      | 0.0  | 0.0       | 83.33 | 83.33 | 83.33      | 0.0  | 0.0         |
      | 3  | 31   | 20250401     | 20250101 | 750.01          | 83.33         | 0.0      | 0.0  | 0.0       | 83.33 | 83.33 | 83.33      | 0.0  | 0.0         |
      | 4  | 30   | 20250501       | 20250101 | 666.68          | 83.33         | 0.0      | 0.0  | 0.0       | 83.33 | 83.33 | 83.33      | 0.0  | 0.0         |
      | 5  | 31   | 20250601      | 20250101 | 583.35          | 83.33         | 0.0      | 0.0  | 0.0       | 83.33 | 83.33 | 83.33      | 0.0  | 0.0         |
      | 6  | 30   | 20250701      | 20250101 | 500.02          | 83.33         | 0.0      | 0.0  | 0.0       | 83.33 | 83.33 | 83.33      | 0.0  | 0.0         |
      | 7  | 31   | 20250801    | 20250101 | 416.69          | 83.33         | 0.0      | 0.0  | 0.0       | 83.33 | 83.33 | 83.33      | 0.0  | 0.0         |
      | 8  | 31   | 20250901 | 20250101 | 333.36          | 83.33         | 0.0      | 0.0  | 0.0       | 83.33 | 83.33 | 83.33      | 0.0  | 0.0         |
      | 9  | 30   | 20251001   | 20250101 | 250.03          | 83.33         | 0.0      | 0.0  | 0.0       | 83.33 | 83.33 | 83.33      | 0.0  | 0.0         |
      | 10 | 31   | 20251101  | 20250101 | 166.7           | 83.33         | 0.0      | 0.0  | 0.0       | 83.33 | 83.33 | 83.33      | 0.0  | 0.0         |
      | 11 | 30   | 20251201  | 20250101 | 83.37           | 83.33         | 0.0      | 0.0  | 0.0       | 83.33 | 83.33 | 83.33      | 0.0  | 0.0         |
      | 12 | 31   | 20260101   | 20250101 | 0.0             | 83.37         | 0.0      | 0.0  | 0.0       | 83.37 | 83.37 | 83.37      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 1000.0 | 1000.0     | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20250101  | Merchant Issued Refund | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3387
  Scenario: Verify that no negative amount is calculated for Accruals
    When Admin sets the business date to "20241209"
    And Admin creates a client with random data
    And Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20241209  | 800            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20241209" with "800" amount and expected disbursement date on "20241209"
    And Admin successfully disburse the loan on "20241209" with "800" EUR transaction amount
    And Admin runs inline COB job for Loan
    And Admin sets the business date to "20241210"
    And Admin runs inline COB job for Loan
    And Admin sets the business date to "20241211"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20241209 |           | 800.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250109  |           | 668.69          | 131.31        | 4.75     | 0.0  | 0.0       | 136.06 | 0.0  | 0.0        | 0.0  | 136.06      |
      | 2  | 31   | 20250209 |           | 536.61          | 132.08        | 3.98     | 0.0  | 0.0       | 136.06 | 0.0  | 0.0        | 0.0  | 136.06      |
      | 3  | 28   | 20250309    |           | 403.43          | 133.18        | 2.88     | 0.0  | 0.0       | 136.06 | 0.0  | 0.0        | 0.0  | 136.06      |
      | 4  | 31   | 20250409    |           | 269.77          | 133.66        | 2.4      | 0.0  | 0.0       | 136.06 | 0.0  | 0.0        | 0.0  | 136.06      |
      | 5  | 30   | 20250509      |           | 135.26          | 134.51        | 1.55     | 0.0  | 0.0       | 136.06 | 0.0  | 0.0        | 0.0  | 136.06      |
      | 6  | 31   | 20250609     |           | 0.0             | 135.26        | 0.8      | 0.0  | 0.0       | 136.06 | 0.0  | 0.0        | 0.0  | 136.06      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 800.0         | 16.36    | 0.0  | 0.0       | 816.36 | 0.0  | 0.0        | 0.0  | 816.36      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241209 | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20241210 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20250108"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20241209 |           | 800.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250109  |           | 668.69          | 131.31        | 4.75     | 0.0  | 0.0       | 136.06 | 0.0  | 0.0        | 0.0  | 136.06      |
      | 2  | 31   | 20250209 |           | 536.61          | 132.08        | 3.98     | 0.0  | 0.0       | 136.06 | 0.0  | 0.0        | 0.0  | 136.06      |
      | 3  | 28   | 20250309    |           | 403.43          | 133.18        | 2.88     | 0.0  | 0.0       | 136.06 | 0.0  | 0.0        | 0.0  | 136.06      |
      | 4  | 31   | 20250409    |           | 269.77          | 133.66        | 2.4      | 0.0  | 0.0       | 136.06 | 0.0  | 0.0        | 0.0  | 136.06      |
      | 5  | 30   | 20250509      |           | 135.26          | 134.51        | 1.55     | 0.0  | 0.0       | 136.06 | 0.0  | 0.0        | 0.0  | 136.06      |
      | 6  | 31   | 20250609     |           | 0.0             | 135.26        | 0.8      | 0.0  | 0.0       | 136.06 | 0.0  | 0.0        | 0.0  | 136.06      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 800.0         | 16.36    | 0.0  | 0.0       | 816.36 | 0.0  | 0.0        | 0.0  | 816.36      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241209 | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20241210 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241211 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241212 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241213 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241214 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241215 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241216 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241217 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241218 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241219 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241220 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241221 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241222 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241223 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241224 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241225 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241226 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241227 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241228 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241229 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241230 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241231 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250101  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250102  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20250109"
    And Customer makes "AUTOPAY" repayment on "20250109" with 136.06 EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20241209 |                 | 800.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250109  | 20250109 | 668.69          | 131.31        | 4.75     | 0.0  | 0.0       | 136.06 | 136.06 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250209 |                 | 536.61          | 132.08        | 3.98     | 0.0  | 0.0       | 136.06 | 0.0    | 0.0        | 0.0  | 136.06      |
      | 3  | 28   | 20250309    |                 | 403.43          | 133.18        | 2.88     | 0.0  | 0.0       | 136.06 | 0.0    | 0.0        | 0.0  | 136.06      |
      | 4  | 31   | 20250409    |                 | 269.77          | 133.66        | 2.4      | 0.0  | 0.0       | 136.06 | 0.0    | 0.0        | 0.0  | 136.06      |
      | 5  | 30   | 20250509      |                 | 135.26          | 134.51        | 1.55     | 0.0  | 0.0       | 136.06 | 0.0    | 0.0        | 0.0  | 136.06      |
      | 6  | 31   | 20250609     |                 | 0.0             | 135.26        | 0.8      | 0.0  | 0.0       | 136.06 | 0.0    | 0.0        | 0.0  | 136.06      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 800.0         | 16.36    | 0.0  | 0.0       | 816.36 | 136.06 | 0.0        | 0.0  | 680.3       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241209 | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20241210 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241211 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241212 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241213 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241214 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241215 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241216 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241217 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241218 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241219 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241220 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241221 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241222 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241223 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241224 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241225 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241226 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241227 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241228 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241229 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241230 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241231 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250101  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250102  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Repayment        | 136.06 | 131.31    | 4.75     | 0.0  | 0.0       | 668.69       | false    | false    |
    When Admin sets the business date to "20250110"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20241209 |                 | 800.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250109  | 20250109 | 668.69          | 131.31        | 4.75     | 0.0  | 0.0       | 136.06 | 136.06 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250209 |                 | 536.61          | 132.08        | 3.98     | 0.0  | 0.0       | 136.06 | 0.0    | 0.0        | 0.0  | 136.06      |
      | 3  | 28   | 20250309    |                 | 403.43          | 133.18        | 2.88     | 0.0  | 0.0       | 136.06 | 0.0    | 0.0        | 0.0  | 136.06      |
      | 4  | 31   | 20250409    |                 | 269.77          | 133.66        | 2.4      | 0.0  | 0.0       | 136.06 | 0.0    | 0.0        | 0.0  | 136.06      |
      | 5  | 30   | 20250509      |                 | 135.26          | 134.51        | 1.55     | 0.0  | 0.0       | 136.06 | 0.0    | 0.0        | 0.0  | 136.06      |
      | 6  | 31   | 20250609     |                 | 0.0             | 135.26        | 0.8      | 0.0  | 0.0       | 136.06 | 0.0    | 0.0        | 0.0  | 136.06      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 800.0         | 16.36    | 0.0  | 0.0       | 816.36 | 136.06 | 0.0        | 0.0  | 680.3       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241209 | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20241210 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241211 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241212 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241213 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241214 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241215 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241216 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241217 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241218 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241219 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241220 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241221 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241222 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241223 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241224 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241225 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241226 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241227 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241228 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241229 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241230 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241231 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250101  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250102  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Repayment        | 136.06 | 131.31    | 4.75     | 0.0  | 0.0       | 668.69       | false    | false    |
      | 20250109  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual Activity | 4.75   | 0.0       | 4.75     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20250110"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20241209 |                 | 800.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250109  | 20250109 | 668.69          | 131.31        | 4.75     | 0.0  | 0.0       | 136.06 | 136.06 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250209 |                 | 536.61          | 132.08        | 3.98     | 0.0  | 0.0       | 136.06 | 0.0    | 0.0        | 0.0  | 136.06      |
      | 3  | 28   | 20250309    |                 | 403.43          | 133.18        | 2.88     | 0.0  | 0.0       | 136.06 | 0.0    | 0.0        | 0.0  | 136.06      |
      | 4  | 31   | 20250409    |                 | 269.77          | 133.66        | 2.4      | 0.0  | 0.0       | 136.06 | 0.0    | 0.0        | 0.0  | 136.06      |
      | 5  | 30   | 20250509      |                 | 135.26          | 134.51        | 1.55     | 0.0  | 0.0       | 136.06 | 0.0    | 0.0        | 0.0  | 136.06      |
      | 6  | 31   | 20250609     |                 | 0.0             | 135.26        | 0.8      | 0.0  | 0.0       | 136.06 | 0.0    | 0.0        | 0.0  | 136.06      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 800.0         | 16.36    | 0.0  | 0.0       | 816.36 | 136.06 | 0.0        | 0.0  | 680.3       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241209 | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20241210 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241211 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241212 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241213 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241214 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241215 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241216 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241217 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241218 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241219 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241220 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241221 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241222 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241223 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241224 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241225 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241226 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241227 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241228 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241229 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241230 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241231 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250101  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250102  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Repayment        | 136.06 | 131.31    | 4.75     | 0.0  | 0.0       | 668.69       | false    | false    |
      | 20250109  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual Activity | 4.75   | 0.0       | 4.75     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20250111"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20241209 |                 | 800.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250109  | 20250109 | 668.69          | 131.31        | 4.75     | 0.0  | 0.0       | 136.06 | 136.06 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250209 |                 | 536.61          | 132.08        | 3.98     | 0.0  | 0.0       | 136.06 | 0.0    | 0.0        | 0.0  | 136.06      |
      | 3  | 28   | 20250309    |                 | 403.43          | 133.18        | 2.88     | 0.0  | 0.0       | 136.06 | 0.0    | 0.0        | 0.0  | 136.06      |
      | 4  | 31   | 20250409    |                 | 269.77          | 133.66        | 2.4      | 0.0  | 0.0       | 136.06 | 0.0    | 0.0        | 0.0  | 136.06      |
      | 5  | 30   | 20250509      |                 | 135.26          | 134.51        | 1.55     | 0.0  | 0.0       | 136.06 | 0.0    | 0.0        | 0.0  | 136.06      |
      | 6  | 31   | 20250609     |                 | 0.0             | 135.26        | 0.8      | 0.0  | 0.0       | 136.06 | 0.0    | 0.0        | 0.0  | 136.06      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 800.0         | 16.36    | 0.0  | 0.0       | 816.36 | 136.06 | 0.0        | 0.0  | 680.3       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241209 | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20241210 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241211 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241212 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241213 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241214 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241215 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241216 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241217 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241218 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241219 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241220 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241221 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241222 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241223 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241224 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241225 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241226 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241227 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241228 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241229 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241230 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241231 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250101  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250102  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Repayment        | 136.06 | 131.31    | 4.75     | 0.0  | 0.0       | 668.69       | false    | false    |
      | 20250109  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual Activity | 4.75   | 0.0       | 4.75     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Customer makes "AUTOPAY" repayment on "20250110" with 680.3 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20241209 |                 | 800.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250109  | 20250109 | 668.69          | 131.31        | 4.75     | 0.0  | 0.0       | 136.06 | 136.06 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250209 | 20250110 | 536.61          | 132.08        | 3.98     | 0.0  | 0.0       | 136.06 | 136.06 | 136.06     | 0.0  | 0.0         |
      | 3  | 28   | 20250309    | 20250110 | 403.43          | 133.18        | 2.88     | 0.0  | 0.0       | 136.06 | 136.06 | 136.06     | 0.0  | 0.0         |
      | 4  | 31   | 20250409    | 20250110 | 269.77          | 133.66        | 2.4      | 0.0  | 0.0       | 136.06 | 136.06 | 136.06     | 0.0  | 0.0         |
      | 5  | 30   | 20250509      | 20250110 | 135.26          | 134.51        | 1.55     | 0.0  | 0.0       | 136.06 | 136.06 | 136.06     | 0.0  | 0.0         |
      | 6  | 31   | 20250609     | 20250110 | 0.0             | 135.26        | 0.8      | 0.0  | 0.0       | 136.06 | 136.06 | 136.06     | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 800.0         | 16.36    | 0.0  | 0.0       | 816.36 | 816.36 | 680.3      | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241209 | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20241210 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241211 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241212 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241213 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241214 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241215 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241216 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241217 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241218 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241219 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241220 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241221 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241222 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241223 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241224 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241225 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241226 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241227 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241228 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241229 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241230 | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20241231 | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250101  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250102  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Repayment        | 136.06 | 131.31    | 4.75     | 0.0  | 0.0       | 668.69       | false    | false    |
      | 20250109  | Accrual          | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual Activity | 4.75   | 0.0       | 4.75     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Repayment        | 680.3  | 668.69    | 11.61    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual Activity | 11.61  | 0.0       | 11.61    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual          | 11.48  | 0.0       | 11.48    | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3433
  Scenario: Verify partial interest calculated on loan with disbursement date '20231212' and 10000 amount - UC1
    When Admin sets the business date to "20231212"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_RECALCULATION_DAILY | 20231212  | 10000          | 9.482                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231212" with "10000" amount and expected disbursement date on "20231212"
    And Admin successfully disburse the loan on "20231212" with "10000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20231212 |           | 10000.0         |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240112  |           | 8367.33         | 1632.67       | 80.45    | 0.0  | 0.0       | 1713.12 | 0.0  | 0.0        | 0.0  | 1713.12     |
      | 2  | 31   | 20240212 |           | 6721.41         | 1645.92       | 67.2     | 0.0  | 0.0       | 1713.12 | 0.0  | 0.0        | 0.0  | 1713.12     |
      | 3  | 29   | 20240312    |           | 5058.79         | 1662.62       | 50.5     | 0.0  | 0.0       | 1713.12 | 0.0  | 0.0        | 0.0  | 1713.12     |
      | 4  | 31   | 20240412    |           | 3386.3          | 1672.49       | 40.63    | 0.0  | 0.0       | 1713.12 | 0.0  | 0.0        | 0.0  | 1713.12     |
      | 5  | 30   | 20240512      |           | 1699.5          | 1686.8        | 26.32    | 0.0  | 0.0       | 1713.12 | 0.0  | 0.0        | 0.0  | 1713.12     |
      | 6  | 31   | 20240612     |           | 0.0             | 1699.5        | 13.65    | 0.0  | 0.0       | 1713.15 | 0.0  | 0.0        | 0.0  | 1713.15     |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due      | Paid | In advance | Late | Outstanding |
      | 10000.0       | 278.75   | 0.0  | 0.0       | 10278.75 | 0.0  | 0.0        | 0.0  | 10278.75    |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20231212 | Disbursement     | 10000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 10000.0      | false    | false    |
    When Admin sets the business date to "20240612"
    When Loan Pay-off is made on "20240612"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3434
  Scenario: Verify partial interest calculated on loan with disbursement date '20231212' and 331.77 amount - UC2
    When Admin sets the business date to "20231212"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_RECALCULATION_DAILY | 20231212  | 331.77         | 10.65                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 5                 | MONTHS                | 1              | MONTHS                 | 5                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231212" with "331.77" amount and expected disbursement date on "20231212"
    And Admin successfully disburse the loan on "20231212" with "331.77" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20231212 |           | 331.77          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240112  |           | 266.63          | 65.14         | 3.0      | 0.0  | 0.0       | 68.14 | 0.0  | 0.0        | 0.0  | 68.14       |
      | 2  | 31   | 20240212 |           | 200.9           | 65.73         | 2.41     | 0.0  | 0.0       | 68.14 | 0.0  | 0.0        | 0.0  | 68.14       |
      | 3  | 29   | 20240312    |           | 134.46          | 66.44         | 1.7      | 0.0  | 0.0       | 68.14 | 0.0  | 0.0        | 0.0  | 68.14       |
      | 4  | 31   | 20240412    |           | 67.53           | 66.93         | 1.21     | 0.0  | 0.0       | 68.14 | 0.0  | 0.0        | 0.0  | 68.14       |
      | 5  | 30   | 20240512      |           | 0.0             | 67.53         | 0.59     | 0.0  | 0.0       | 68.12 | 0.0  | 0.0        | 0.0  | 68.12       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 331.77        | 8.91     | 0.0  | 0.0       | 340.68 | 0.0  | 0.0        | 0.0  | 340.68      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20231212 | Disbursement     | 331.77 | 0.0       | 0.0      | 0.0  | 0.0       | 331.77       | false    | false    |
    When Admin sets the business date to "20240512"
    When Loan Pay-off is made on "20240512"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3435
  Scenario: Verify partial interest calculated on loan with disbursement date '20240723' and 15000 amount - UC3
    When Admin sets the business date to "20240723"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_RECALCULATION_DAILY | 20240723      | 15000          | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240723" with "15000" amount and expected disbursement date on "20240723"
    And Admin successfully disburse the loan on "20240723" with "15000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240723      |           | 15000.0         |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240823    |           | 11307.31        | 3692.69       | 152.46   | 0.0  | 0.0       | 3845.15 | 0.0  | 0.0        | 0.0  | 3845.15     |
      | 2  | 31   | 20240923 |           | 7577.09         | 3730.22       | 114.93   | 0.0  | 0.0       | 3845.15 | 0.0  | 0.0        | 0.0  | 3845.15     |
      | 3  | 30   | 20241023   |           | 3806.47         | 3770.62       | 74.53    | 0.0  | 0.0       | 3845.15 | 0.0  | 0.0        | 0.0  | 3845.15     |
      | 4  | 31   | 20241123  |           | 0.0             | 3806.47       | 38.69    | 0.0  | 0.0       | 3845.16 | 0.0  | 0.0        | 0.0  | 3845.16     |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due      | Paid | In advance | Late | Outstanding |
      | 15000.0       | 380.61   | 0.0  | 0.0       | 15380.61 | 0.0  | 0.0        | 0.0  | 15380.61    |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240723     | Disbursement     | 15000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 15000.0      | false    | false    |
    When Admin sets the business date to "20241123"
    When Loan Pay-off is made on "20241123"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3436
  Scenario: Verify interest calculated on loan that disbursed on 31 date with disbursement date '20231031' and 2450 amount - UC4
    When Admin sets the business date to "20231031"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_RECALCULATION_DAILY | 20231031   | 2450           | 9.99                   | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231031" with "2450" amount and expected disbursement date on "20231031"
    And Admin successfully disburse the loan on "20231031" with "2450" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20231031  |           | 2450.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20231130 |           | 2049.84         | 400.16        | 20.12    | 0.0  | 0.0       | 420.28 | 0.0  | 0.0        | 0.0  | 420.28      |
      | 2  | 31   | 20231231 |           | 1646.95         | 402.89        | 17.39    | 0.0  | 0.0       | 420.28 | 0.0  | 0.0        | 0.0  | 420.28      |
      | 3  | 31   | 20240131  |           | 1240.61         | 406.34        | 13.94    | 0.0  | 0.0       | 420.28 | 0.0  | 0.0        | 0.0  | 420.28      |
      | 4  | 29   | 20240229 |           | 830.15          | 410.46        | 9.82     | 0.0  | 0.0       | 420.28 | 0.0  | 0.0        | 0.0  | 420.28      |
      | 5  | 31   | 20240331    |           | 416.89          | 413.26        | 7.02     | 0.0  | 0.0       | 420.28 | 0.0  | 0.0        | 0.0  | 420.28      |
      | 6  | 30   | 20240430    |           | 0.0             | 416.89        | 3.41     | 0.0  | 0.0       | 420.3  | 0.0  | 0.0        | 0.0  | 420.3       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 2450.0        | 71.7     | 0.0  | 0.0       | 2521.7 | 0.0  | 0.0        | 0.0  | 2521.7      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20231031  | Disbursement     | 2450.0 | 0.0       | 0.0      | 0.0  | 0.0       | 2450.0       | false    | false    |
    When Admin sets the business date to "20240430"
    When Loan Pay-off is made on "20240430"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3437
  Scenario: Verify interest calculated on loan that disbursed on 31 date with backdated disbursement date '20231031' and 2450 amount - UC5
    When Admin sets the business date to "20250121"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_RECALCULATION_DAILY | 20231031   | 2450           | 9.99                   | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231031" with "2450" amount and expected disbursement date on "20231031"
    And Admin successfully disburse the loan on "20231031" with "2450" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20231031  |           | 2450.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20231130 |           | 2049.84         | 400.16        | 20.12    | 0.0  | 0.0       | 420.28 | 0.0  | 0.0        | 0.0  | 420.28      |
      | 2  | 31   | 20231231 |           | 1650.35         | 399.49        | 20.79    | 0.0  | 0.0       | 420.28 | 0.0  | 0.0        | 0.0  | 420.28      |
      | 3  | 31   | 20240131  |           | 1250.8          | 399.55        | 20.73    | 0.0  | 0.0       | 420.28 | 0.0  | 0.0        | 0.0  | 420.28      |
      | 4  | 29   | 20240229 |           | 849.91          | 400.89        | 19.39    | 0.0  | 0.0       | 420.28 | 0.0  | 0.0        | 0.0  | 420.28      |
      | 5  | 31   | 20240331    |           | 450.36          | 399.55        | 20.73    | 0.0  | 0.0       | 420.28 | 0.0  | 0.0        | 0.0  | 420.28      |
      | 6  | 30   | 20240430    |           | 0.0             | 450.36        | 20.06    | 0.0  | 0.0       | 470.42 | 0.0  | 0.0        | 0.0  | 470.42      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 2450.0        | 121.82   | 0.0  | 0.0       | 2571.82 | 0.0  | 0.0        | 0.0  | 2571.82     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20231031  | Disbursement     | 2450.0 | 0.0       | 0.0      | 0.0  | 0.0       | 2450.0       | false    | false    |
    When Loan Pay-off is made on "20250121"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3438
  Scenario: Verify interest calculated on loan that disbursed on 31 date with disbursement date '20231031' and 245000 amount - UC6
    When Admin sets the business date to "20231031"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_RECALCULATION_DAILY | 20231031   | 245000         | 45                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231031" with "245000" amount and expected disbursement date on "20231031"
    And Admin successfully disburse the loan on "20231031" with "245000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due      | Paid | In advance | Late | Outstanding |
      |    |      | 20231031  |           | 245000.0        |               |          | 0.0  |           | 0.0      | 0.0  |            |      |             |
      | 1  | 30   | 20231130 |           | 207718.37       | 37281.63      | 9061.64  | 0.0  | 0.0       | 46343.27 | 0.0  | 0.0        | 0.0  | 46343.27    |
      | 2  | 31   | 20231231 |           | 169313.93       | 38404.44      | 7938.83  | 0.0  | 0.0       | 46343.27 | 0.0  | 0.0        | 0.0  | 46343.27    |
      | 3  | 31   | 20240131  |           | 129424.02       | 39889.91      | 6453.36  | 0.0  | 0.0       | 46343.27 | 0.0  | 0.0        | 0.0  | 46343.27    |
      | 4  | 29   | 20240229 |           | 87695.46        | 41728.56      | 4614.71  | 0.0  | 0.0       | 46343.27 | 0.0  | 0.0        | 0.0  | 46343.27    |
      | 5  | 31   | 20240331    |           | 44694.68        | 43000.78      | 3342.49  | 0.0  | 0.0       | 46343.27 | 0.0  | 0.0        | 0.0  | 46343.27    |
      | 6  | 30   | 20240430    |           | 0.0             | 44694.68      | 1648.57  | 0.0  | 0.0       | 46343.25 | 0.0  | 0.0        | 0.0  | 46343.25    |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due      | Paid | In advance | Late | Outstanding |
      | 245000.0      | 33059.6  | 0.0  | 0.0       | 278059.6 | 0.0  | 0.0        | 0.0  | 278059.6    |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount   | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20231031  | Disbursement     | 245000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 245000.0     | false    | false    |
    When Admin sets the business date to "20240430"
    When Loan Pay-off is made on "20240430"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3439
  Scenario: Verify interest calculated on loan that disbursed on 31 date with backdated disbursement date '20231031' and 5000 amount - UC7
    When Admin sets the business date to "20250121"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_RECALCULATION_DAILY | 20231031   | 5000           | 33.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231031" with "5000" amount and expected disbursement date on "20231031"
    And Admin successfully disburse the loan on "20231031" with "5000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20231031  |           | 5000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 30   | 20231130 |           | 4222.02         | 777.98        | 139.68   | 0.0  | 0.0       | 917.66  | 0.0  | 0.0        | 0.0  | 917.66      |
      | 2  | 31   | 20231231 |           | 3448.7          | 773.32        | 144.34   | 0.0  | 0.0       | 917.66  | 0.0  | 0.0        | 0.0  | 917.66      |
      | 3  | 31   | 20240131  |           | 2674.99         | 773.71        | 143.95   | 0.0  | 0.0       | 917.66  | 0.0  | 0.0        | 0.0  | 917.66      |
      | 4  | 29   | 20240229 |           | 1891.99         | 783.0         | 134.66   | 0.0  | 0.0       | 917.66  | 0.0  | 0.0        | 0.0  | 917.66      |
      | 5  | 31   | 20240331    |           | 1118.28         | 773.71        | 143.95   | 0.0  | 0.0       | 917.66  | 0.0  | 0.0        | 0.0  | 917.66      |
      | 6  | 30   | 20240430    |           | 0.0             | 1118.28       | 139.3    | 0.0  | 0.0       | 1257.58 | 0.0  | 0.0        | 0.0  | 1257.58     |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 5000.0        | 845.88   | 0.0  | 0.0       | 5845.88 | 0.0  | 0.0        | 0.0  | 5845.88     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20231031  | Disbursement     | 5000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       | false    | false    |
    When Loan Pay-off is made on "20250121"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3440
  Scenario: Verify interest calculated on loan that disbursed on 30 date with disbursement date '20211030' and 1500 amount - UC8
    When Admin sets the business date to "20211030"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_RECALCULATION_DAILY | 20211030   | 1500           | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20211030" with "1500" amount and expected disbursement date on "20211030"
    And Admin successfully disburse the loan on "20211030" with "1500" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20211030  |           | 1500.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20211130 |           | 1255.13         | 244.87        | 12.08    | 0.0  | 0.0       | 256.95 | 0.0  | 0.0        | 0.0  | 256.95      |
      | 2  | 30   | 20211230 |           | 1007.96         | 247.17        | 9.78     | 0.0  | 0.0       | 256.95 | 0.0  | 0.0        | 0.0  | 256.95      |
      | 3  | 31   | 20220130  |           | 759.13          | 248.83        | 8.12     | 0.0  | 0.0       | 256.95 | 0.0  | 0.0        | 0.0  | 256.95      |
      | 4  | 29   | 20220228 |           | 507.9           | 251.23        | 5.72     | 0.0  | 0.0       | 256.95 | 0.0  | 0.0        | 0.0  | 256.95      |
      | 5  | 30   | 20220330    |           | 254.91          | 252.99        | 3.96     | 0.0  | 0.0       | 256.95 | 0.0  | 0.0        | 0.0  | 256.95      |
      | 6  | 31   | 20220430    |           | 0.0             | 254.91        | 2.05     | 0.0  | 0.0       | 256.96 | 0.0  | 0.0        | 0.0  | 256.96      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1500.0        | 41.71    | 0.0  | 0.0       | 1541.71 | 0.0  | 0.0        | 0.0  | 1541.71     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20211030  | Disbursement     | 1500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    | false    |
    When Admin sets the business date to "20220430"
    When Loan Pay-off is made on "20220430"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3441
  Scenario: Verify interest calculated on loan that disbursed on 29 date with disbursement date '20221029' and 5000 amount - UC9
    When Admin sets the business date to "20221029"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_RECALCULATION_DAILY | 20221029   | 5000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 12                | MONTHS                | 2              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20221029" with "5000" amount and expected disbursement date on "20221029"
    And Admin successfully disburse the loan on "20221029" with "5000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20221029  |           | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 61   | 20221229 |           | 4190.81         | 809.19        | 58.49    | 0.0  | 0.0       | 867.68 | 0.0  | 0.0        | 0.0  | 867.68      |
      | 2  | 61   | 20230228 |           | 3372.16         | 818.65        | 49.03    | 0.0  | 0.0       | 867.68 | 0.0  | 0.0        | 0.0  | 867.68      |
      | 3  | 60   | 20230429    |           | 2543.28         | 828.88        | 38.8     | 0.0  | 0.0       | 867.68 | 0.0  | 0.0        | 0.0  | 867.68      |
      | 4  | 61   | 20230629     |           | 1705.35         | 837.93        | 29.75    | 0.0  | 0.0       | 867.68 | 0.0  | 0.0        | 0.0  | 867.68      |
      | 5  | 61   | 20230829   |           | 857.62          | 847.73        | 19.95    | 0.0  | 0.0       | 867.68 | 0.0  | 0.0        | 0.0  | 867.68      |
      | 6  | 61   | 20231029  |           | 0.0             | 857.62        | 10.03    | 0.0  | 0.0       | 867.65 | 0.0  | 0.0        | 0.0  | 867.65      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 5000.0        | 206.05   | 0.0  | 0.0       | 5206.05 | 0.0  | 0.0        | 0.0  | 5206.05     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20221029  | Disbursement     | 5000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       | false    | false    |
    When Admin sets the business date to "20231029"
    When Loan Pay-off is made on "20231029"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3455
  Scenario: Verify interest calculated on backdated loan with zero interest rate  - UC1
    When Admin sets the business date to "20250214"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20250113   | 900            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250113" with "900" amount and expected disbursement date on "20250113"
    And Admin successfully disburse the loan on "20250113" with "900" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250113  |           | 900.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250213 |           | 600.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
      | 2  | 28   | 20250313    |           | 300.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
      | 3  | 31   | 20250413    |           | 0.0             | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 900.0         | 0.0      | 0.0  | 0.0       | 900.0 | 0.0  | 0.0        | 0.0  | 900.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250113  | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
    When Admin sets the business date to "20250413"
    When Loan Pay-off is made on "20250413"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3456
  Scenario: Verify interest calculated on backdated loan with zero interest rate and run COB - UC2
    When Admin sets the business date to "20250214"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20250113   | 900            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250113" with "900" amount and expected disbursement date on "20250113"
    And Admin successfully disburse the loan on "20250113" with "900" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250113  |           | 900.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250213 |           | 600.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
      | 2  | 28   | 20250313    |           | 300.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
      | 3  | 31   | 20250413    |           | 0.0             | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 900.0         | 0.0      | 0.0  | 0.0       | 900.0 | 0.0  | 0.0        | 0.0  | 900.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250113  | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
    And Admin runs inline COB job for Loan
    When Admin sets the business date to "20250215"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250113  |           | 900.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250213 |           | 600.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
      | 2  | 28   | 20250313    |           | 300.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
      | 3  | 31   | 20250413    |           | 0.0             | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 900.0         | 0.0      | 0.0  | 0.0       | 900.0 | 0.0  | 0.0        | 0.0  | 900.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250113  | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
    When Admin sets the business date to "20250413"
    When Loan Pay-off is made on "20250413"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3457
  Scenario: Verify interest calculated on backdated loan with zero interest rate and repayment - UC3
    When Admin sets the business date to "20250214"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20250113   | 900            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250113" with "900" amount and expected disbursement date on "20250113"
    And Admin successfully disburse the loan on "20250113" with "900" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250113  |           | 900.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250213 |           | 600.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
      | 2  | 28   | 20250313    |           | 300.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
      | 3  | 31   | 20250413    |           | 0.0             | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 900.0         | 0.0      | 0.0  | 0.0       | 900.0 | 0.0  | 0.0        | 0.0  | 900.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250113  | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20250120" with 300 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250113  |                 | 900.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20250213 | 20250120 | 600.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 300.0 | 300.0      | 0.0  | 0.0         |
      | 2  | 28   | 20250313    |                 | 300.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 3  | 31   | 20250413    |                 | 0.0             | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 900.0         | 0.0      | 0.0  | 0.0       | 900.0 | 300.0 | 300.0      | 0.0  | 600.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250113  | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
      | 20250120  | Repayment        | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 600.0        | false    | false    |
    When Admin sets the business date to "20250413"
    When Loan Pay-off is made on "20250413"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3458
  Scenario: Verify interest calculated on backdated loan with zero interest rate and repayment reversal - UC4
    When Admin sets the business date to "20250214"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20250113   | 900            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250113" with "900" amount and expected disbursement date on "20250113"
    And Admin successfully disburse the loan on "20250113" with "900" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250113  |           | 900.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250213 |           | 600.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
      | 2  | 28   | 20250313    |           | 300.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
      | 3  | 31   | 20250413    |           | 0.0             | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 900.0         | 0.0      | 0.0  | 0.0       | 900.0 | 0.0  | 0.0        | 0.0  | 900.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250113  | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20250214" with 300 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250113  |                  | 900.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20250213 | 20250214 | 600.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 300.0 | 0.0        | 300.0 | 0.0         |
      | 2  | 28   | 20250313    |                  | 300.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0   | 0.0        | 0.0   | 300.0       |
      | 3  | 31   | 20250413    |                  | 0.0             | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0   | 0.0        | 0.0   | 300.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 900.0         | 0.0      | 0.0  | 0.0       | 900.0 | 300.0 | 0.0        | 300.0 | 600.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250113  | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
      | 20250214 | Repayment        | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 600.0        | false    | false    |
    When Customer undo "1"th "Repayment" transaction made on "20250214"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250113  |           | 900.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250213 |           | 600.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
      | 2  | 28   | 20250313    |           | 300.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
      | 3  | 31   | 20250413    |           | 0.0             | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 900.0         | 0.0      | 0.0  | 0.0       | 900.0 | 0.0  | 0.0        | 0.0  | 900.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250113  | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
      | 20250214 | Repayment        | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 600.0        | true     | false    |
    When Admin sets the business date to "20250413"
    When Loan Pay-off is made on "20250413"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3459
  Scenario: Verify interest calculated on backdated loan with zero interest rate and pay-off - UC5
    When Admin sets the business date to "20250214"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20250113   | 900            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250113" with "900" amount and expected disbursement date on "20250113"
    And Admin successfully disburse the loan on "20250113" with "900" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250113  |           | 900.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250213 |           | 600.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
      | 2  | 28   | 20250313    |           | 300.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
      | 3  | 31   | 20250413    |           | 0.0             | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0  | 0.0        | 0.0  | 300.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 900.0         | 0.0      | 0.0  | 0.0       | 900.0 | 0.0  | 0.0        | 0.0  | 900.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250113  | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
    When Loan Pay-off is made on "20250210"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250113  |                  | 900.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20250213 | 20250210 | 600.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 300.0 | 300.0      | 0.0  | 0.0         |
      | 2  | 28   | 20250313    | 20250210 | 300.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 300.0 | 300.0      | 0.0  | 0.0         |
      | 3  | 31   | 20250413    | 20250210 | 0.0             | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 300.0 | 300.0      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 900.0         | 0.0      | 0.0  | 0.0       | 900.0 | 900.0 | 900.0      | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250113  | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
      | 20250210 | Repayment        | 900.0  | 900.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan closedon_date is "20250210"

  @TestRailId:C3538
  Scenario: Verify leap year calculation with Feb month split between periods - UC1
    When Admin sets the business date to "20231212"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_LEAP_YEAR_INTEREST_RECALCULATION_DAILY | 20231212  | 10000          | 9.482                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231212" with "10000" amount and expected disbursement date on "20231212"
    When Admin successfully disburse the loan on "20231212" with "10000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20231212 |           | 10000.0         |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240112  |           | 8367.32         | 1632.68       | 80.53    | 0.0  | 0.0       | 1713.21 | 0.0  | 0.0        | 0.0  | 1713.21     |
      | 2  | 31   | 20240212 |           | 6721.49         | 1645.83       | 67.38    | 0.0  | 0.0       | 1713.21 | 0.0  | 0.0        | 0.0  | 1713.21     |
      | 3  | 29   | 20240312    |           | 5058.78         | 1662.71       | 50.5     | 0.0  | 0.0       | 1713.21 | 0.0  | 0.0        | 0.0  | 1713.21     |
      | 4  | 31   | 20240412    |           | 3386.31         | 1672.47       | 40.74    | 0.0  | 0.0       | 1713.21 | 0.0  | 0.0        | 0.0  | 1713.21     |
      | 5  | 30   | 20240512      |           | 1699.49         | 1686.82       | 26.39    | 0.0  | 0.0       | 1713.21 | 0.0  | 0.0        | 0.0  | 1713.21     |
      | 6  | 31   | 20240612     |           | 0.0             | 1699.49       | 13.69    | 0.0  | 0.0       | 1713.18 | 0.0  | 0.0        | 0.0  | 1713.18     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due      | Paid | In advance | Late | Outstanding |
      | 10000.0       | 279.23   | 0.0  | 0.0       | 10279.23 | 0.0  | 0.0        | 0.0  | 10279.23    |
    When Admin sets the business date to "20240612"
    When Loan Pay-off is made on "20240612"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3539
  Scenario: Verify leap year calculation with no February month but leap year - UC2
    When Admin sets the business date to "20240723"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_LEAP_YEAR_INTEREST_RECALCULATION_DAILY | 20240723      | 15000          | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240723" with "15000" amount and expected disbursement date on "20240723"
    When Admin successfully disburse the loan on "20240723" with "15000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240723     |           | 15000.0         |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240823   |           | 11307.47        | 3692.53       | 152.88   | 0.0  | 0.0       | 3845.41 | 0.0  | 0.0        | 0.0  | 3845.41     |
      | 2  | 31   | 20240923|           | 7577.3          | 3730.17       | 115.24   | 0.0  | 0.0       | 3845.41 | 0.0  | 0.0        | 0.0  | 3845.41     |
      | 3  | 30   | 20241023  |           | 3806.63         | 3770.67       | 74.74    | 0.0  | 0.0       | 3845.41 | 0.0  | 0.0        | 0.0  | 3845.41     |
      | 4  | 31   | 20241123 |           | 0.0             | 3806.63       | 38.8     | 0.0  | 0.0       | 3845.43 | 0.0  | 0.0        | 0.0  | 3845.43     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due      | Paid | In advance | Late | Outstanding |
      | 15000.0       | 381.66   | 0.0  | 0.0       | 15381.66 | 0.0  | 0.0        | 0.0  | 15381.66    |
    When Admin sets the business date to "20241123"
    When Loan Pay-off is made on "20241123"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3540
  Scenario: Verify leap year calculation with February in one period - UC3
    When Admin sets the business date to "20231031"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_LEAP_YEAR_INTEREST_RECALCULATION_DAILY | 20231031   | 245000         | 45                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231031" with "245000" amount and expected disbursement date on "20231031"
    When Admin successfully disburse the loan on "20231031" with "245000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due      | Paid | In advance | Late | Outstanding |
      |    |      | 20231031  |           | 245000.0        |               |          | 0.0  |           | 0.0      | 0.0  |            |      |             |
      | 1  | 30   | 20231130 |           | 207713.25       | 37286.75      | 9061.64  | 0.0  | 0.0       | 46348.39 | 0.0  | 0.0        | 0.0  | 46348.39    |
      | 2  | 31   | 20231231 |           | 169303.49       | 38409.76      | 7938.63  | 0.0  | 0.0       | 46348.39 | 0.0  | 0.0        | 0.0  | 46348.39    |
      | 3  | 31   | 20240131  |           | 129425.74       | 39877.75      | 6470.64  | 0.0  | 0.0       | 46348.39 | 0.0  | 0.0        | 0.0  | 46348.39    |
      | 4  | 29   | 20240229 |           | 87692.12        | 41733.62      | 4614.77  | 0.0  | 0.0       | 46348.39 | 0.0  | 0.0        | 0.0  | 46348.39    |
      | 5  | 31   | 20240331    |           | 44695.25        | 42996.87      | 3351.52  | 0.0  | 0.0       | 46348.39 | 0.0  | 0.0        | 0.0  | 46348.39    |
      | 6  | 30   | 20240430    |           | 0.0             | 44695.25      | 1653.11  | 0.0  | 0.0       | 46348.36 | 0.0  | 0.0        | 0.0  | 46348.36    |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due       | Paid | In advance | Late | Outstanding |
      | 245000.0      | 33090.31 | 0.0  | 0.0       | 278090.31 | 0.0  | 0.0        | 0.0  | 278090.31   |
    When Admin sets the business date to "20240430"
    When Loan Pay-off is made on "20240430"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3541
  Scenario: Verify leap year calculation with no February month - leap and non-leap year split - UC4
    When Admin sets the business date to "20241031"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_LEAP_YEAR_INTEREST_RECALCULATION_DAILY | 20241031   | 2450           | 9.99                   | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20241031" with "2450" amount and expected disbursement date on "20241031"
    When Admin successfully disburse the loan on "20241031" with "2450" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20241031  |           | 2450.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20241130 |           | 2049.88         | 400.12        | 20.12    | 0.0  | 0.0       | 420.24 | 0.0  | 0.0        | 0.0  | 420.24      |
      | 2  | 31   | 20241231 |           | 1647.03         | 402.85        | 17.39    | 0.0  | 0.0       | 420.24 | 0.0  | 0.0        | 0.0  | 420.24      |
      | 3  | 31   | 20250131  |           | 1240.76         | 406.27        | 13.97    | 0.0  | 0.0       | 420.24 | 0.0  | 0.0        | 0.0  | 420.24      |
      | 4  | 28   | 20250228 |           | 830.03          | 410.73        | 9.51     | 0.0  | 0.0       | 420.24 | 0.0  | 0.0        | 0.0  | 420.24      |
      | 5  | 31   | 20250331    |           | 416.83          | 413.2         | 7.04     | 0.0  | 0.0       | 420.24 | 0.0  | 0.0        | 0.0  | 420.24      |
      | 6  | 30   | 20250430    |           | 0.0             | 416.83        | 3.42     | 0.0  | 0.0       | 420.25 | 0.0  | 0.0        | 0.0  | 420.25      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 2450.0        | 71.45    | 0.0  | 0.0       | 2521.45 | 0.0  | 0.0        | 0.0  | 2521.45     |
    When Admin sets the business date to "20250430"
    When Loan Pay-off is made on "20250430"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3542
  Scenario: Verify leap year calculation with no leap year - UC5
    When Admin sets the business date to "20221029"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_RECALCULATION_DAILY | 20221029   | 5000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 12                | MONTHS                | 2              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20221029" with "5000" amount and expected disbursement date on "20221029"
    When Admin successfully disburse the loan on "20221029" with "5000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20221029  |           | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 61   | 20221229 |           | 4190.81         | 809.19        | 58.49    | 0.0  | 0.0       | 867.68 | 0.0  | 0.0        | 0.0  | 867.68      |
      | 2  | 61   | 20230228 |           | 3372.16         | 818.65        | 49.03    | 0.0  | 0.0       | 867.68 | 0.0  | 0.0        | 0.0  | 867.68      |
      | 3  | 60   | 20230429    |           | 2543.28         | 828.88        | 38.8     | 0.0  | 0.0       | 867.68 | 0.0  | 0.0        | 0.0  | 867.68      |
      | 4  | 61   | 20230629     |           | 1705.35         | 837.93        | 29.75    | 0.0  | 0.0       | 867.68 | 0.0  | 0.0        | 0.0  | 867.68      |
      | 5  | 61   | 20230829   |           | 857.62          | 847.73        | 19.95    | 0.0  | 0.0       | 867.68 | 0.0  | 0.0        | 0.0  | 867.68      |
      | 6  | 61   | 20231029  |           | 0.0             | 857.62        | 10.03    | 0.0  | 0.0       | 867.65 | 0.0  | 0.0        | 0.0  | 867.65      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 5000.0        | 206.05   | 0.0  | 0.0       | 5206.05 | 0.0  | 0.0        | 0.0  | 5206.05     |
    When Admin sets the business date to "20231029"
    When Loan Pay-off is made on "20231029"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3622
  Scenario: Verify that RecalculationRestFrequencyType SameAsRepaymentPeriod work as intended in case of minimal amount (0.05 cent) of payments
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_SARP_TILL_PRECLOSE | 20250101   | 8000           | 86.42                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "8000" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "8000" EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 8000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 6887.3          | 1112.7        | 576.13   | 0.0  | 0.0       | 1688.83 | 0.0  | 0.0        | 0.0  | 1688.83     |
      | 2  | 28   | 20250301    |           | 5694.47         | 1192.83       | 496.0    | 0.0  | 0.0       | 1688.83 | 0.0  | 0.0        | 0.0  | 1688.83     |
      | 3  | 31   | 20250401    |           | 4415.74         | 1278.73       | 410.1    | 0.0  | 0.0       | 1688.83 | 0.0  | 0.0        | 0.0  | 1688.83     |
      | 4  | 30   | 20250501      |           | 3044.92         | 1370.82       | 318.01   | 0.0  | 0.0       | 1688.83 | 0.0  | 0.0        | 0.0  | 1688.83     |
      | 5  | 31   | 20250601     |           | 1575.37         | 1469.55       | 219.28   | 0.0  | 0.0       | 1688.83 | 0.0  | 0.0        | 0.0  | 1688.83     |
      | 6  | 30   | 20250701     |           | 0.0             | 1575.37       | 113.45   | 0.0  | 0.0       | 1688.82 | 0.0  | 0.0        | 0.0  | 1688.82     |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due      | Paid | In advance | Late | Outstanding |
      | 8000.0        | 2132.97  | 0.0  | 0.0       | 10132.97 | 0.0  | 0.0        | 0.0  | 10132.97    |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 8000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 8000.0       | false    | false    |
    When Admin sets the business date to "20250201"
    And Customer makes "AUTOPAY" repayment on "20250201" with 0.01 EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20250301"
    And Customer makes "AUTOPAY" repayment on "20250301" with 0.01 EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20250401"
    And Customer makes "AUTOPAY" repayment on "20250401" with 0.01 EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20250501"
    And Customer makes "AUTOPAY" repayment on "20250501" with 0.01 EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20250601"
    And Customer makes "AUTOPAY" repayment on "20250601" with 0.01 EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20250702"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 8000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 6887.3          | 1112.7        | 576.13   | 0.0  | 0.0       | 1688.83 | 0.05 | 0.0        | 0.04 | 1688.78     |
      | 2  | 28   | 20250301    |           | 5774.6          | 1112.7        | 576.13   | 0.0  | 0.0       | 1688.83 | 0.0  | 0.0        | 0.0  | 1688.83     |
      | 3  | 31   | 20250401    |           | 4661.9          | 1112.7        | 576.13   | 0.0  | 0.0       | 1688.83 | 0.0  | 0.0        | 0.0  | 1688.83     |
      | 4  | 30   | 20250501      |           | 3549.2          | 1112.7        | 576.13   | 0.0  | 0.0       | 1688.83 | 0.0  | 0.0        | 0.0  | 1688.83     |
      | 5  | 31   | 20250601     |           | 2436.5          | 1112.7        | 576.13   | 0.0  | 0.0       | 1688.83 | 0.0  | 0.0        | 0.0  | 1688.83     |
      | 6  | 30   | 20250701     |           | 0.0             | 2436.5        | 576.13   | 0.0  | 0.0       | 3012.63 | 0.0  | 0.0        | 0.0  | 3012.63     |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due      | Paid | In advance | Late | Outstanding |
      | 8000.0        | 3456.78  | 0.0  | 0.0       | 11456.78 | 0.05 | 0.0        | 0.04 | 11456.73    |
    When Loan Pay-off is made on "20250702"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3657
  Scenario: Verify tranche interest bearing progressive loan that expects two tranches with repayment and undo last disbursement - UC1
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with disbursements details and following data:
      | LoanProduct                                                                                | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            | 1st_tranche_disb_expected_date | 1st_tranche_disb_principal | 2nd_tranche_disb_expected_date | 2nd_tranche_disb_principal |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSE_EXPECT_TRANCHE | 20250101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION | 20250101                | 600.0                      | 20250201               | 200.0                      |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 600.0           |               |          | 0.0  |           | 0.0    |      |            |      | 0.0         |
      | 1  | 31   | 20250201 |           | 501.45          | 98.55         | 3.5      | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
      |    |      | 20250201 |           | 200.0           |               |          | 0.0  |           | 0.0    |      |            |      | 0.0         |
      | 2  | 28   | 20250301    |           | 562.79          | 138.66        | 4.09     | 0.0  | 0.0       | 142.75 | 0.0  | 0.0        | 0.0  | 142.75      |
      | 3  | 31   | 20250401    |           | 423.32          | 139.47        | 3.28     | 0.0  | 0.0       | 142.75 | 0.0  | 0.0        | 0.0  | 142.75      |
      | 4  | 30   | 20250501      |           | 283.04          | 140.28        | 2.47     | 0.0  | 0.0       | 142.75 | 0.0  | 0.0        | 0.0  | 142.75      |
      | 5  | 31   | 20250601     |           | 141.94          | 141.1         | 1.65     | 0.0  | 0.0       | 142.75 | 0.0  | 0.0        | 0.0  | 142.75      |
      | 6  | 30   | 20250701     |           | 0.0             | 141.94        | 0.83     | 0.0  | 0.0       | 142.77 | 0.0  | 0.0        | 0.0  | 142.77      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 800.0         | 15.82    | 0.0  | 0.0       | 815.82  | 0.0  | 0.0        | 0.0  | 815.82      |
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On    | Principal   | Net Disbursal Amount |
      | 20250101          |                 | 600.0       |                      |
      | 20250201         |                 | 200.0       |                      |
#    --- 1st disbursement - 1 January, 2025  ---
    When Admin successfully disburse the loan on "20250101" with "700" EUR transaction amount
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On    | Principal   | Net Disbursal Amount |
      | 20250101          | 20250101 | 700.0       |                      |
      | 20250201         |                 | 200.0       |                      |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 700.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 585.02          | 114.98        | 4.08     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      |    |      | 20250201 |           | 200.0           |               |          | 0.0  |           | 0.0    |      |            |      | 0.0         |
      | 2  | 28   | 20250301    |           | 669.37          | 115.65        | 3.41     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      | 3  | 31   | 20250401    |           | 553.05          | 116.32        | 2.74     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      | 4  | 30   | 20250501      |           | 436.05          | 117.0         | 2.06     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      | 5  | 31   | 20250601     |           | 318.37          | 117.68        | 1.38     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      | 6  | 30   | 20250701     |           | 200.0           | 118.37        | 0.69     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 700.0         | 14.36     | 0.0  | 0.0      | 714.36 | 0.0  | 0.0        | 0.0  | 714.36      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement       | 700.0  | 0.0       | 0.0      | 0.0  | 0.0       | 700.0        | false    | false    |
#    --- 1st repayment - 15 January, 2025  ---
    When Admin sets the business date to "20250115"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20250115" with 119.06 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101  |                  | 700.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250201 | 20250115  | 582.78          | 117.22        | 1.84     | 0.0  | 0.0       | 119.06 | 119.06 | 119.06     | 0.0  | 0.0         |
      |    |      | 20250201 |                  | 200.0           |               |          | 0.0  |           | 0.0    |      |            |      | 0.0         |
      | 2  | 28   | 20250301    |                  | 668.99          | 113.79        | 5.27     | 0.0  | 0.0       | 119.06 | 0.0    | 0.0        | 0.0  | 119.06      |
      | 3  | 31   | 20250401    |                  | 552.67          | 116.32        | 2.74     | 0.0  | 0.0       | 119.06 | 0.0    | 0.0        | 0.0  | 119.06      |
      | 4  | 30   | 20250501      |                  | 435.67          | 117.0         | 2.06     | 0.0  | 0.0       | 119.06 | 0.0    | 0.0        | 0.0  | 119.06      |
      | 5  | 31   | 20250601     |                  | 317.98          | 117.69        | 1.37     | 0.0  | 0.0       | 119.06 | 0.0    | 0.0        | 0.0  | 119.06      |
      | 6  | 30   | 20250701     |                  | 200.0           | 117.98        | 0.69     | 0.0  | 0.0       | 118.67 | 0.0    | 0.0        | 0.0  | 118.67     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 700.0         | 13.97    | 0.0  | 0.0       | 713.97 | 119.06 | 119.06     | 0.0  | 594.91      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement      | 700.0  | 0.0       | 0.0      | 0.0  | 0.0       | 700.0        | false    | false    |
      | 20250114  | Accrual           | 1.71   | 0.0       | 1.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Repayment         | 119.06 | 117.22    | 1.84     | 0.0  | 0.0       | 582.78       | false    | false    |
#    --- 2nd disbursement - 1 February, 2025  ---
    When Admin sets the business date to "20250201"
    When Admin runs inline COB job for Loan
    When Admin successfully disburse the loan on "20250201" with "300" EUR transaction amount
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On     | Principal   | Net Disbursal Amount |
      | 20250101          | 20250101  | 700.0       |                      |
      | 20250201         | 20250201 | 300.0       |                      |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101  |                  | 700.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250201 | 20250115  | 582.78          | 117.22        | 1.84     | 0.0  | 0.0       | 119.06 | 119.06 | 119.06     | 0.0  | 0.0         |
      |    |      | 20250201 |                  | 300.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 2  | 28   | 20250301    |                  | 709.69          | 173.09        | 7.02     | 0.0  | 0.0       | 180.11 | 0.0    | 0.0        | 0.0  | 180.11      |
      | 3  | 31   | 20250401    |                  | 533.72          | 175.97        | 4.14     | 0.0  | 0.0       | 180.11 | 0.0    | 0.0        | 0.0  | 180.11      |
      | 4  | 30   | 20250501      |                  | 356.72          | 177.0         | 3.11     | 0.0  | 0.0       | 180.11 | 0.0    | 0.0        | 0.0  | 180.11      |
      | 5  | 31   | 20250601     |                  | 178.69          | 178.03        | 2.08     | 0.0  | 0.0       | 180.11 | 0.0    | 0.0        | 0.0  | 180.11      |
      | 6  | 30   | 20250701     |                  | 0.0             | 178.69        | 1.04     | 0.0  | 0.0       | 179.73 | 0.0    | 0.0        | 0.0  | 179.73      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 19.23    | 0.0  | 0.0       | 1019.23 | 119.06 | 119.06     | 0.0  | 900.17    |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement      | 700.0  | 0.0       | 0.0      | 0.0  | 0.0       | 700.0        | false    | false    |
      | 20250114  | Accrual           | 1.71   | 0.0       | 1.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Repayment         | 119.06 | 117.22    | 1.84     | 0.0  | 0.0       | 582.78       | false    | false    |
      | 20250115  | Accrual           | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250116  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250117  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250118  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250119  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250120  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250121  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250122  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250123  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250124  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250125  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250126  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250127  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250128  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250129  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250130  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250131  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Disbursement      | 300.0  | 0.0       | 0.0      | 0.0  | 0.0       | 882.78       | false    | false    |
    Then Admin fails to disburse the loan on "20250201" with "100" amount due to exceed approved amount
#    --- undo last disbursement --- #
    When Admin successfully undo last disbursal
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On     | Principal   | Net Disbursal Amount |
      | 20250101          | 20250101  | 700.0       |                      |
    When Admin sets the business date to "20250202"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101  |                  | 700.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250201 | 20250115  | 582.78          | 117.22        | 1.84     | 0.0  | 0.0       | 119.06 | 119.06 | 119.06     | 0.0  | 0.0         |
      | 2  | 28   | 20250301    |                  | 468.99          | 113.79        | 5.27     | 0.0  | 0.0       | 119.06 | 0.0    | 0.0        | 0.0  | 119.06      |
      | 3  | 31   | 20250401    |                  | 352.67          | 116.32        | 2.74     | 0.0  | 0.0       | 119.06 | 0.0    | 0.0        | 0.0  | 119.06      |
      | 4  | 30   | 20250501      |                  | 235.67          | 117.0         | 2.06     | 0.0  | 0.0       | 119.06 | 0.0    | 0.0        | 0.0  | 119.06      |
      | 5  | 31   | 20250601     |                  | 117.98          | 117.69        | 1.37     | 0.0  | 0.0       | 119.06 | 0.0    | 0.0        | 0.0  | 119.06      |
      | 6  | 30   | 20250701     |                  | 0.0             | 117.98        | 0.69     | 0.0  | 0.0       | 118.67 | 0.0    | 0.0        | 0.0  | 118.67     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 700.0         | 13.97    | 0.0  | 0.0       | 713.97 | 119.06 | 119.06     | 0.0  | 594.91    |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement      | 700.0  | 0.0       | 0.0      | 0.0  | 0.0       | 700.0        | false    | false    |
      | 20250114  | Accrual           | 1.71   | 0.0       | 1.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Repayment         | 119.06 | 117.22    | 1.84     | 0.0  | 0.0       | 582.78       | false    | false    |
      | 20250115  | Accrual           | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250116  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250117  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250118  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250119  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250120  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250121  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250122  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250123  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250124  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250125  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250126  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250127  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250128  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250129  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250130  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250131  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Admin fails to disburse the loan on "20250202" with "200" amount
    When Loan Pay-off is made on "20250202"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3658
  Scenario: Verify tranche interest bearing progressive loan that expects two tranches with two repayments and undo last disbursement - UC2
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with disbursements details and following data:
      | LoanProduct                                                                                | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            | 1st_tranche_disb_expected_date |1st_tranche_disb_principal | 2nd_tranche_disb_expected_date | 2nd_tranche_disb_principal |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSE_EXPECT_TRANCHE | 20250101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 90                | DAYS                  | 15             | DAYS                   | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION | 20250101                | 700.0                     | 20250116                | 300.0                      |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 700.0           |               |          | 0.0  |           | 0.0    |      |            |      | 0.0         |
      | 1  | 15   | 20250116  |           | 584.18          | 115.82        | 2.04     | 0.0  | 0.0       | 117.86 | 0.0  | 0.0        | 0.0  | 117.86     |
      |    |      | 20250116  |           | 300.0           |               |          | 0.0  |           | 0.0    |      |            |      | 0.0         |
      | 2  | 15   | 20250131  |           | 708.37          | 175.81        | 2.58     | 0.0  | 0.0       | 178.39 | 0.0  | 0.0        | 0.0  | 178.39      |
      | 3  | 15   | 20250215 |           | 532.05          | 176.32        | 2.07     | 0.0  | 0.0       | 178.39 | 0.0  | 0.0        | 0.0  | 178.39      |
      | 4  | 15   | 20250302    |           | 355.21          | 176.84        | 1.55     | 0.0  | 0.0       | 178.39 | 0.0  | 0.0        | 0.0  | 178.39      |
      | 5  | 15   | 20250317    |           | 177.86          | 177.35        | 1.04     | 0.0  | 0.0       | 178.39 | 0.0  | 0.0        | 0.0  | 178.39      |
      | 6  | 15   | 20250401    |           | 0.0             | 177.86        | 0.52     | 0.0  | 0.0       | 178.38 | 0.0  | 0.0        | 0.0  | 178.38      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 9.8      | 0.0  | 0.0       | 1009.8  | 0.0  | 0.0        | 0.0  | 1009.8      |
#    --- 1st disbursement - 1 January, 2025  ---
    When Admin successfully disburse the loan on "20250101" with "700" EUR transaction amount
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On    | Principal   | Net Disbursal Amount |
      | 20250101          | 20250101 | 700.0       |                      |
      | 20250116          |                 | 300.0       |                      |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 700.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 15   | 20250116  |           | 584.18          | 115.82        | 2.04     | 0.0  | 0.0       | 117.86 | 0.0  | 0.0        | 0.0  | 117.86      |
      |    |      | 20250116  |           | 300.0           |               |          | 0.0  |           | 0.0    |      |            |      | 0.0         |
      | 2  | 15   | 20250131  |           | 768.02          | 116.16        | 1.7      | 0.0  | 0.0       | 117.86 | 0.0  | 0.0        | 0.0  | 117.86      |
      | 3  | 15   | 20250215 |           | 651.53          | 116.49        | 1.37     | 0.0  | 0.0       | 117.86 | 0.0  | 0.0        | 0.0  | 117.86      |
      | 4  | 15   | 20250302    |           | 534.7           | 116.83        | 1.03     | 0.0  | 0.0       | 117.86 | 0.0  | 0.0        | 0.0  | 117.86      |
      | 5  | 15   | 20250317    |           | 417.52          | 117.18        | 0.68     | 0.0  | 0.0       | 117.86 | 0.0  | 0.0        | 0.0  | 117.86      |
      | 6  | 15   | 20250401    |           | 300.0           | 117.52        | 0.34     | 0.0  | 0.0       | 117.86 | 0.0  | 0.0        | 0.0  | 117.86      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 700.0         | 7.16     | 0.0  | 0.0       | 707.16 | 0.0    | 0.0        | 0.0  | 707.16      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement       | 700.0  | 0.0       | 0.0      | 0.0  | 0.0       | 700.0        | false    | false    |
#    --- 1st repayment - 16 January, 2025  ---
    When Admin sets the business date to "20250116"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20250116" with 117.86 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101  |                 | 700.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 15   | 20250116  | 20250116 | 584.18          | 115.82        | 2.04     | 0.0  | 0.0       | 117.86 | 117.86 | 0.0        | 0.0  | 0.0         |
      |    |      | 20250116  |                 | 300.0           |               |          | 0.0  |           | 0.0    |        |            |      | 0.0         |
      | 2  | 15   | 20250131  |                 | 768.02          | 116.16        | 1.7      | 0.0  | 0.0       | 117.86 | 0.0    | 0.0        | 0.0  | 117.86      |
      | 3  | 15   | 20250215 |                 | 651.53          | 116.49        | 1.37     | 0.0  | 0.0       | 117.86 | 0.0    | 0.0        | 0.0  | 117.86      |
      | 4  | 15   | 20250302    |                 | 534.7           | 116.83        | 1.03     | 0.0  | 0.0       | 117.86 | 0.0    | 0.0        | 0.0  | 117.86      |
      | 5  | 15   | 20250317    |                 | 417.52          | 117.18        | 0.68     | 0.0  | 0.0       | 117.86 | 0.0    | 0.0        | 0.0  | 117.86      |
      | 6  | 15   | 20250401    |                 | 300.0           | 117.52        | 0.34     | 0.0  | 0.0       | 117.86 | 0.0    | 0.0        | 0.0  | 117.86      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 700.0         | 7.16     | 0.0  | 0.0       | 707.16 | 117.86 | 0.0        | 0.0  | 589.3       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement      | 700.0  | 0.0       | 0.0      | 0.0  | 0.0       | 700.0        | false    | false    |
      | 20250115  | Accrual           | 1.91   | 0.0       | 1.91     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250116  | Repayment         | 117.86 | 115.82    | 2.04     | 0.0  | 0.0       | 584.18       | false    | false    |
#    --- 2nd repayment - 31 January, 2025  ---
    When Admin sets the business date to "20250131"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20250131" with 117.86 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101  |                 | 700.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 15   | 20250116  | 20250116 | 584.18          | 115.82        | 2.04     | 0.0  | 0.0       | 117.86 | 117.86 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20250131  | 20250131 | 468.02          | 116.16        | 1.7      | 0.0  | 0.0       | 117.86 | 117.86 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20250215 |                 | 351.53          | 116.49        | 1.37     | 0.0  | 0.0       | 117.86 | 0.0    | 0.0        | 0.0  | 117.86      |
      | 4  | 15   | 20250302    |                 | 234.7           | 116.83        | 1.03     | 0.0  | 0.0       | 117.86 | 0.0    | 0.0        | 0.0  | 117.86      |
      | 5  | 15   | 20250317    |                 | 117.52          | 117.18        | 0.68     | 0.0  | 0.0       | 117.86 | 0.0    | 0.0        | 0.0  | 117.86      |
      | 6  | 15   | 20250401    |                 | 0.0             | 117.52        | 0.34     | 0.0  | 0.0       | 117.86 | 0.0    | 0.0        | 0.0  | 117.86      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 700.0         | 7.16     | 0.0  | 0.0       | 707.16 | 235.72 | 0.0        | 0.0  | 471.44      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement      | 700.0  | 0.0       | 0.0      | 0.0  | 0.0       | 700.0        | false    | false    |
      | 20250115  | Accrual           | 1.91   | 0.0       | 1.91     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250116  | Repayment         | 117.86 | 115.82    | 2.04     | 0.0  | 0.0       | 584.18       | false    | false    |
      | 20250116  | Accrual           | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250117  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250118  | Accrual           | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250119  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250120  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250121  | Accrual           | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250122  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250123  | Accrual           | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250124  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250125  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250126  | Accrual           | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250127  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250128  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250129  | Accrual           | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250130  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250131  | Repayment         | 117.86 | 116.16    | 1.7      | 0.0  | 0.0       | 468.02       | false    | false    |
#    --- 2nd disbursement - 1 February, 2025  ---
    When Admin sets the business date to "20250201"
    When Admin runs inline COB job for Loan
    When Admin successfully disburse the loan on "20250201" with "300" EUR transaction amount
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On     | Principal   | Net Disbursal Amount |
      | 20250101          | 20250101  | 700.0       |                      |
      | 20250116          | 20250201 | 300.0       |                      |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101  |                 | 700.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 15   | 20250116  | 20250116 | 584.18          | 115.82        | 2.04     | 0.0  | 0.0       | 117.86 | 117.86 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20250131  | 20250131 | 468.02          | 116.16        | 1.7      | 0.0  | 0.0       | 117.86 | 117.86 | 0.0        | 0.0  | 0.0         |
      |    |      | 20250201 |                 | 300.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 3  | 15   | 20250215 |                 | 576.81          | 191.21        | 2.18     | 0.0  | 0.0       | 193.39 | 0.0    | 0.0        | 0.0  | 193.39      |
      | 4  | 15   | 20250302    |                 | 385.1           | 191.71        | 1.68     | 0.0  | 0.0       | 193.39 | 0.0    | 0.0        | 0.0  | 193.39      |
      | 5  | 15   | 20250317    |                 | 192.83          | 192.27        | 1.12     | 0.0  | 0.0       | 193.39 | 0.0    | 0.0        | 0.0  | 193.39      |
      | 6  | 15   | 20250401    |                 | 0.0             | 192.83        | 0.56     | 0.0  | 0.0       | 193.39 | 0.0    | 0.0        | 0.0  | 193.39      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 9.28     | 0.0  | 0.0       | 1009.28 | 235.72 | 0.0        | 0.0  | 773.56      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement      | 700.0  | 0.0       | 0.0      | 0.0  | 0.0       | 700.0        | false    | false    |
      | 20250115  | Accrual           | 1.91   | 0.0       | 1.91     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250116  | Repayment         | 117.86 | 115.82    | 2.04     | 0.0  | 0.0       | 584.18       | false    | false    |
      | 20250116  | Accrual           | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250117  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250118  | Accrual           | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250119  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250120  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250121  | Accrual           | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250122  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250123  | Accrual           | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250124  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250125  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250126  | Accrual           | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250127  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250128  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250129  | Accrual           | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250130  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250131  | Repayment         | 117.86 | 116.16    | 1.7      | 0.0  | 0.0       | 468.02       | false    | false    |
      | 20250131  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Disbursement      | 300.0  | 0.0       | 0.0      | 0.0  | 0.0       | 768.02       | false    | false    |
    Then Admin fails to disburse the loan on "20250201" with "100" amount due to exceed approved amount
#    --- undo disbursement --- #
    When Admin sets the business date to "20250202"
    When Admin runs inline COB job for Loan
    When Admin successfully undo last disbursal
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On     | Principal   | Net Disbursal Amount |
      | 20250101          | 20250101  | 700.0       |                      |
    When Admin sets the business date to "20250202"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101  |                 | 700.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 15   | 20250116  | 20250116 | 584.18          | 115.82        | 2.04     | 0.0  | 0.0       | 117.86 | 117.86 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20250131  | 20250131 | 468.02          | 116.16        | 1.7      | 0.0  | 0.0       | 117.86 | 117.86 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20250215 |                 | 351.53          | 116.49        | 1.37     | 0.0  | 0.0       | 117.86 | 0.0    | 0.0        | 0.0  | 117.86      |
      | 4  | 15   | 20250302    |                 | 234.7           | 116.83        | 1.03     | 0.0  | 0.0       | 117.86 | 0.0    | 0.0        | 0.0  | 117.86      |
      | 5  | 15   | 20250317    |                 | 117.52          | 117.18        | 0.68     | 0.0  | 0.0       | 117.86 | 0.0    | 0.0        | 0.0  | 117.86      |
      | 6  | 15   | 20250401    |                 | 0.0             | 117.52        | 0.34     | 0.0  | 0.0       | 117.86 | 0.0    | 0.0        | 0.0  | 117.86      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 700.0         | 7.16     | 0.0  | 0.0       | 707.16 | 235.72 | 0.0        | 0.0  | 471.44      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement      | 700.0  | 0.0       | 0.0      | 0.0  | 0.0       | 700.0        | false    | false    |
      | 20250115  | Accrual           | 1.91   | 0.0       | 1.91     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250116  | Repayment         | 117.86 | 115.82    | 2.04     | 0.0  | 0.0       | 584.18       | false    | false    |
      | 20250116  | Accrual           | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250117  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250118  | Accrual           | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250119  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250120  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250121  | Accrual           | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250122  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250123  | Accrual           | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250124  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250125  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250126  | Accrual           | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250127  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250128  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250129  | Accrual           | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250130  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250131  | Repayment         | 117.86 | 116.16    | 1.7      | 0.0  | 0.0       | 468.02       | false    | false    |
      | 20250131  | Accrual           | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Accrual           | 0.09   | 0.0       | 0.09     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Admin fails to disburse the loan on "20250202" with "200" amount
    When Loan Pay-off is made on "20250202"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3659
  Scenario: Verify tranche interest bearing progressive loan that expects tranche with added 2 more tranches and undo last disbursement - UC3
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with disbursement details and following data:
      | LoanProduct                                                                                | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            | 1st_tranche_disb_expected_date |1st_tranche_disb_principal |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSE_EXPECT_TRANCHE | 20250101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION | 20250101                | 700.0                     |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 700.0           |               |          | 0.0  |           | 0.0    |      |            |      | 0.0         |
      | 1  | 31   | 20250201 |           | 585.02          | 114.98        | 4.08     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      | 2  | 28   | 20250301    |           | 469.37          | 115.65        | 3.41     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      | 3  | 31   | 20250401    |           | 353.05          | 116.32        | 2.74     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      | 4  | 30   | 20250501      |           | 236.05          | 117.0         | 2.06     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      | 5  | 31   | 20250601     |           | 118.37          | 117.68        | 1.38     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      | 6  | 30   | 20250701     |           | 0.0             | 118.37        | 0.69     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 700.0         | 14.36    | 0.0  | 0.0       | 714.36  | 0.0  | 0.0        | 0.0  | 714.36      |
    When Admin successfully disburse the loan on "20250101" with "600" EUR transaction amount
  #  When Admin runs inline COB job for Loan
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On    | Principal   | Net Disbursal Amount |
      | 20250101          | 20250101 | 600.0       |                      |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 600.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 501.45          | 98.55         | 3.5      | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
      | 2  | 28   | 20250301    |           | 402.33          | 99.12         | 2.93     | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
      | 3  | 31   | 20250401    |           | 302.63          | 99.7          | 2.35     | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
      | 4  | 30   | 20250501      |           | 202.35          | 100.28        | 1.77     | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
      | 5  | 31   | 20250601     |           | 101.48          | 100.87        | 1.18     | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
      | 6  | 30   | 20250701     |           | 0.0             | 101.48        | 0.59     | 0.0  | 0.0       | 102.07 | 0.0  | 0.0        | 0.0  | 102.07      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 600.0         | 12.32    | 0.0  | 0.0       | 612.32 | 0.0  | 0.0        | 0.0  | 612.32      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 600.0  | 0.0       | 0.0      | 0.0  | 0.0       | 600.0        | false    | false    |
    Then Admin fails to disburse the loan on "20250101" with "200" amount
#    --- add 2nd expected disbursement details with expected disbursement date - 8 Jan, 2025 --- #
    And Admin successfully add disbursement detail to the loan on "20250108" with 300 EUR transaction amount
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On    | Principal   | Net Disbursal Amount |
      | 20250101          | 20250101 | 600.0       |                      |
      | 20250108          |                 | 300.0       | 600.0                |
    When Admin sets the business date to "20250108"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 600.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20250108  |           | 300.0           |               |          | 0.0  |           | 0.0    |      |            |      | 0.0         |
      | 1  | 31   | 20250201 |           | 801.45          | 98.55         | 3.5      | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
      | 2  | 28   | 20250301    |           | 702.33          | 99.12         | 2.93     | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
      | 3  | 31   | 20250401    |           | 602.63          | 99.7          | 2.35     | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
      | 4  | 30   | 20250501      |           | 502.35          | 100.28        | 1.77     | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
      | 5  | 31   | 20250601     |           | 401.48          | 100.87        | 1.18     | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
      | 6  | 30   | 20250701     |           | 300.0           | 101.48        | 0.59     | 0.0  | 0.0       | 102.07 | 0.0  | 0.0        | 0.0  | 102.07      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 600.0         | 12.32    | 0.0  | 0.0       | 612.32 | 0.0  | 0.0        | 0.0  | 612.32      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 600.0  | 0.0       | 0.0      | 0.0  | 0.0       | 600.0        | false    | false    |
      | 20250107  | Accrual          | 0.68   | 0.0       | 0.68     | 0.0  | 0.0       | 0.0          | false    | false    |
#    --- 2nd disbursement partial - 8 January, 2025  --- #
    When Admin successfully disburse the loan on "20250108" with "300" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 600.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20250108  |           | 300.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 751.84          | 148.16        | 4.85     | 0.0  | 0.0       | 153.01 | 0.0  | 0.0        | 0.0  | 153.01      |
      | 2  | 28   | 20250301    |           | 603.22          | 148.62        | 4.39     | 0.0  | 0.0       | 153.01 | 0.0  | 0.0        | 0.0  | 153.01      |
      | 3  | 31   | 20250401    |           | 453.73          | 149.49        | 3.52     | 0.0  | 0.0       | 153.01 | 0.0  | 0.0        | 0.0  | 153.01      |
      | 4  | 30   | 20250501      |           | 303.37          | 150.36        | 2.65     | 0.0  | 0.0       | 153.01 | 0.0  | 0.0        | 0.0  | 153.01      |
      | 5  | 31   | 20250601     |           | 152.13          | 151.24        | 1.77     | 0.0  | 0.0       | 153.01 | 0.0  | 0.0        | 0.0  | 153.01      |
      | 6  | 30   | 20250701     |           | 0.0             | 152.13        | 0.89     | 0.0  | 0.0       | 153.02 | 0.0  | 0.0        | 0.0  | 153.02      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 900.0         | 18.07    | 0.0  | 0.0       | 918.07 | 0.0  | 0.0        | 0.0  | 918.07      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 600.0  | 0.0       | 0.0      | 0.0  | 0.0       | 600.0        | false    | false    |
      | 20250107  | Accrual          | 0.68   | 0.0       | 0.68     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Disbursement     | 300.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
    Then Admin fails to disburse the loan on "20250108" with "100" amount
#    --- add 3rd expected disbursement details with expected disbursement date - 15 Jan, 2025 --- #
    And Admin successfully add disbursement detail to the loan on "20250115" with 100 EUR transaction amount
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On    | Principal   | Net Disbursal Amount |
      | 20250101          | 20250101 | 600.0       |                      |
      | 20250108          | 20250108 | 300.0       | 600.0                |
      | 20250115          |                 | 100.0       | 300.0                |
    When Admin sets the business date to "20250115"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 600.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20250108  |           | 300.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20250115  |           | 100.0           |               |          | 0.0  |           | 0.0    |      |            |      | 0.0         |
      | 1  | 31   | 20250201 |           | 851.84          | 148.16        | 4.85     | 0.0  | 0.0       | 153.01 | 0.0  | 0.0        | 0.0  | 153.01      |
      | 2  | 28   | 20250301    |           | 703.22          | 148.62        | 4.39     | 0.0  | 0.0       | 153.01 | 0.0  | 0.0        | 0.0  | 153.01      |
      | 3  | 31   | 20250401    |           | 553.73          | 149.49        | 3.52     | 0.0  | 0.0       | 153.01 | 0.0  | 0.0        | 0.0  | 153.01      |
      | 4  | 30   | 20250501      |           | 403.37          | 150.36        | 2.65     | 0.0  | 0.0       | 153.01 | 0.0  | 0.0        | 0.0  | 153.01      |
      | 5  | 31   | 20250601     |           | 252.13          | 151.24        | 1.77     | 0.0  | 0.0       | 153.01 | 0.0  | 0.0        | 0.0  | 153.01      |
      | 6  | 30   | 20250701     |           | 100.0           | 152.13        | 0.89     | 0.0  | 0.0       | 153.02 | 0.0  | 0.0        | 0.0  | 153.02      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 900.0         | 18.07    | 0.0  | 0.0       | 918.07 | 0.0  | 0.0        | 0.0  | 918.07      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 600.0  | 0.0       | 0.0      | 0.0  | 0.0       | 600.0        | false    | false    |
      | 20250107  | Accrual          | 0.68   | 0.0       | 0.68     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Disbursement     | 300.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
      | 20250108  | Accrual          | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
#    --- 3rd disbursement partial - 15 Jan, 2025  --- #
    When Admin successfully disburse the loan on "20250115" with "50" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 600.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20250108  |           | 300.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20250115  |           | 50.0            |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 793.52          | 156.48        | 5.01     | 0.0  | 0.0       | 161.49 | 0.0  | 0.0        | 0.0  | 161.49      |
      | 2  | 28   | 20250301    |           | 636.66          | 156.86        | 4.63     | 0.0  | 0.0       | 161.49 | 0.0  | 0.0        | 0.0  | 161.49      |
      | 3  | 31   | 20250401    |           | 478.88          | 157.78        | 3.71     | 0.0  | 0.0       | 161.49 | 0.0  | 0.0        | 0.0  | 161.49      |
      | 4  | 30   | 20250501      |           | 320.18          | 158.7         | 2.79     | 0.0  | 0.0       | 161.49 | 0.0  | 0.0        | 0.0  | 161.49      |
      | 5  | 31   | 20250601     |           | 160.56          | 159.62        | 1.87     | 0.0  | 0.0       | 161.49 | 0.0  | 0.0        | 0.0  | 161.49      |
      | 6  | 30   | 20250701     |           | 0.0             | 160.56        | 0.94     | 0.0  | 0.0       | 161.5  | 0.0  | 0.0        | 0.0  | 161.5       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 950.0         | 18.95    | 0.0  | 0.0       | 968.95 | 0.0  | 0.0        | 0.0  | 968.95      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 600.0  | 0.0       | 0.0      | 0.0  | 0.0       | 600.0        | false    | false    |
      | 20250107  | Accrual          | 0.68   | 0.0       | 0.68     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Disbursement     | 300.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
      | 20250108  | Accrual          | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Disbursement     | 50.0   | 0.0       | 0.0      | 0.0  | 0.0       | 950.0        | false    | false    |
#    --- undo last disbursement --- #
    When Admin sets the business date to "20250116"
    When Admin runs inline COB job for Loan
    When Admin successfully undo last disbursal
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On    | Principal   | Net Disbursal Amount |
      | 20250101          | 20250101 | 600.0       |                      |
      | 20250108          | 20250108 | 300.0       | 600.0                |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 600.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20250108  |           | 300.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 751.84          | 148.16        | 4.85     | 0.0  | 0.0       | 153.01 | 0.0  | 0.0        | 0.0  | 153.01      |
      | 2  | 28   | 20250301    |           | 603.22          | 148.62        | 4.39     | 0.0  | 0.0       | 153.01 | 0.0  | 0.0        | 0.0  | 153.01      |
      | 3  | 31   | 20250401    |           | 453.73          | 149.49        | 3.52     | 0.0  | 0.0       | 153.01 | 0.0  | 0.0        | 0.0  | 153.01      |
      | 4  | 30   | 20250501      |           | 303.37          | 150.36        | 2.65     | 0.0  | 0.0       | 153.01 | 0.0  | 0.0        | 0.0  | 153.01      |
      | 5  | 31   | 20250601     |           | 152.13          | 151.24        | 1.77     | 0.0  | 0.0       | 153.01 | 0.0  | 0.0        | 0.0  | 153.01      |
      | 6  | 30   | 20250701     |           | 0.0             | 152.13        | 0.89     | 0.0  | 0.0       | 153.02 | 0.0  | 0.0        | 0.0  | 153.02      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 900.0         | 18.07    | 0.0  | 0.0       | 918.07 | 0.0  | 0.0        | 0.0  | 918.07      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 600.0  | 0.0       | 0.0      | 0.0  | 0.0       | 600.0        | false    | false    |
      | 20250107  | Accrual          | 0.68   | 0.0       | 0.68     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Disbursement     | 300.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
      | 20250108  | Accrual          | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Accrual          | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Admin fails to disburse the loan on "20250116" with "100" amount
    When Loan Pay-off is made on "20250116"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3660
  Scenario: Verify tranche interest bearing progressive loan that expects tranche with repayment and undo disbursement - UC4
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with disbursement details and following data:
      | LoanProduct                                                                                | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            | 1st_tranche_disb_expected_date |1st_tranche_disb_principal |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSE_EXPECT_TRANCHE | 20250101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION | 20250101                | 700.0                     |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 700.0           |               |          | 0.0  |           | 0.0    |      |            |      | 0.0         |
      | 1  | 31   | 20250201 |           | 585.02          | 114.98        | 4.08     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      | 2  | 28   | 20250301    |           | 469.37          | 115.65        | 3.41     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      | 3  | 31   | 20250401    |           | 353.05          | 116.32        | 2.74     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      | 4  | 30   | 20250501      |           | 236.05          | 117.0         | 2.06     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      | 5  | 31   | 20250601     |           | 118.37          | 117.68        | 1.38     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      | 6  | 30   | 20250701     |           | 0.0             | 118.37        | 0.69     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 700.0         | 14.36    | 0.0  | 0.0       | 714.36  | 0.0  | 0.0        | 0.0  | 714.36      |
    When Admin successfully disburse the loan on "20250101" with "700" EUR transaction amount
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On    | Principal   | Net Disbursal Amount |
      | 20250101          | 20250101 | 700.0       |                      |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 700.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 585.02          | 114.98        | 4.08     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      | 2  | 28   | 20250301    |           | 469.37          | 115.65        | 3.41     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      | 3  | 31   | 20250401    |           | 353.05          | 116.32        | 2.74     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      | 4  | 30   | 20250501      |           | 236.05          | 117.0         | 2.06     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      | 5  | 31   | 20250601     |           | 118.37          | 117.68        | 1.38     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      | 6  | 30   | 20250701     |           | 0.0             | 118.37        | 0.69     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 700.0         | 14.36     | 0.0  | 0.0       | 714.36  | 0.0  | 0.0        | 0.0  | 714.36      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement       | 700.0  | 0.0       | 0.0      | 0.0  | 0.0       | 700.0        | false    | false    |
#    --- 1st repayment - 1 Feb, 2025  --- #
    When Admin sets the business date to "20250201"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20250201" with 119.06 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101  |                  | 700.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250201 | 20250201 | 585.02          | 114.98        | 4.08     | 0.0  | 0.0       | 119.06 | 119.06 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250301    |                  | 469.37          | 115.65        | 3.41     | 0.0  | 0.0       | 119.06 | 0.0    | 0.0        | 0.0  | 119.06      |
      | 3  | 31   | 20250401    |                  | 353.05          | 116.32        | 2.74     | 0.0  | 0.0       | 119.06 | 0.0    | 0.0        | 0.0  | 119.06      |
      | 4  | 30   | 20250501      |                  | 236.05          | 117.0         | 2.06     | 0.0  | 0.0       | 119.06 | 0.0    | 0.0        | 0.0  | 119.06      |
      | 5  | 31   | 20250601     |                  | 118.37          | 117.68        | 1.38     | 0.0  | 0.0       | 119.06 | 0.0    | 0.0        | 0.0  | 119.06      |
      | 6  | 30   | 20250701     |                  | 0.0             | 118.37        | 0.69     | 0.0  | 0.0       | 119.06 | 0.0    | 0.0        | 0.0  | 119.06      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 700.0         | 14.36    | 0.0  | 0.0       | 714.36 | 119.06 | 0.0        | 0.0  | 595.3      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement      | 700.0  | 0.0       | 0.0      | 0.0  | 0.0       | 700.0        | false    | false    |
      | 20250131  | Accrual           | 3.95   | 0.0       | 3.95     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Repayment         | 119.06 | 114.98    | 4.08     | 0.0  | 0.0       | 585.02       | false    | false    |
#    --- add 2nd expected disbursement details with expected disbursement date - 5 Feb, 2025 --- #
    And Admin successfully add disbursement detail to the loan on "20250205" with 300 EUR transaction amount
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On    | Principal   | Net Disbursal Amount |
      | 20250101          | 20250101 | 700.0       |                      |
      | 20250205         |                 | 300.0       | 700.0                |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101  |                  | 700.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250201 | 20250201 | 585.02          | 114.98        | 4.08     | 0.0  | 0.0       | 119.06 | 119.06 | 0.0        | 0.0  | 0.0         |
      |    |      | 20250205 |                  | 300.0           |               |          | 0.0  |           | 0.0    |        |            |      | 0.0         |
      | 2  | 28   | 20250301    |                  | 769.37          | 115.65        | 3.41     | 0.0  | 0.0       | 119.06 | 0.0    | 0.0        | 0.0  | 119.06      |
      | 3  | 31   | 20250401    |                  | 653.05          | 116.32        | 2.74     | 0.0  | 0.0       | 119.06 | 0.0    | 0.0        | 0.0  | 119.06      |
      | 4  | 30   | 20250501      |                  | 536.05          | 117.0         | 2.06     | 0.0  | 0.0       | 119.06 | 0.0    | 0.0        | 0.0  | 119.06      |
      | 5  | 31   | 20250601     |                  | 418.37          | 117.68        | 1.38     | 0.0  | 0.0       | 119.06 | 0.0    | 0.0        | 0.0  | 119.06      |
      | 6  | 30   | 20250701     |                  | 300.0           | 118.37        | 0.69     | 0.0  | 0.0       | 119.06 | 0.0    | 0.0        | 0.0  | 119.06      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 700.0         | 14.36    | 0.0  | 0.0       | 714.36 | 119.06 | 0.0        | 0.0  | 595.3      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement      | 700.0  | 0.0       | 0.0      | 0.0  | 0.0       | 700.0        | false    | false    |
      | 20250131  | Accrual           | 3.95   | 0.0       | 3.95     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Repayment         | 119.06 | 114.98    | 4.08     | 0.0  | 0.0       | 585.02       | false    | false    |
#    --- 2nd disbursement - 5 February, 2025  ---
    When Admin sets the business date to "20250205"
    When Admin runs inline COB job for Loan
    When Admin successfully disburse the loan on "20250205" with "200" EUR transaction amount
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On     | Principal   | Net Disbursal Amount |
      | 20250101          | 20250101  | 700.0       |                      |
      | 20250205         | 20250205 | 200.0       | 700.0                |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101  |                  | 700.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250201 | 20250201 | 585.02          | 114.98        | 4.08     | 0.0  | 0.0       | 119.06 | 119.06 | 0.0        | 0.0  | 0.0         |
      |    |      | 20250205 |                  | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 2  | 28   | 20250301    |                  | 629.7           | 155.32        | 4.41     | 0.0  | 0.0       | 159.73 | 0.0    | 0.0        | 0.0  | 159.73      |
      | 3  | 31   | 20250401    |                  | 473.64          | 156.06        | 3.67     | 0.0  | 0.0       | 159.73 | 0.0    | 0.0        | 0.0  | 159.73      |
      | 4  | 30   | 20250501      |                  | 316.67          | 156.97        | 2.76     | 0.0  | 0.0       | 159.73 | 0.0    | 0.0        | 0.0  | 159.73      |
      | 5  | 31   | 20250601     |                  | 158.79          | 157.88        | 1.85     | 0.0  | 0.0       | 159.73 | 0.0    | 0.0        | 0.0  | 159.73      |
      | 6  | 30   | 20250701     |                  | 0.0             | 158.79        | 0.93     | 0.0  | 0.0       | 159.72 | 0.0    | 0.0        | 0.0  | 159.72      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 900.0         | 17.7     | 0.0  | 0.0       | 917.7  | 119.06 | 0.0        | 0.0  | 798.64      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement      | 700.0  | 0.0       | 0.0      | 0.0  | 0.0       | 700.0        | false    | false    |
      | 20250131  | Accrual           | 3.95   | 0.0       | 3.95     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Repayment         | 119.06 | 114.98    | 4.08     | 0.0  | 0.0       | 585.02       | false    | false    |
      | 20250201 | Accrual           | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250202 | Accrual           | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250203 | Accrual           | 0.12   | 0.0       | 0.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250204 | Accrual           | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250205 | Disbursement      | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 785.02       | false    | false    |
    Then Admin fails to disburse the loan on "20250205" with "100" amount
  # -- undo disbursement ----
    When Admin sets the business date to "20250206"
    When Admin runs inline COB job for Loan
    When Admin successfully undo disbursal
    Then Loan status has changed to "Approved"
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On     | Principal   | Net Disbursal Amount |
      | 20250101          |                  | 700.0       |                      |
      | 20250205         |                  | 200.0       | 700.0                |
    When Admin sets the business date to "20250202"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 700.0           |               |          | 0.0  |           | 0.0    |      |            |      | 0.0         |
      | 1  | 31   | 20250201 |           | 585.02          | 114.98        | 4.08     | 0.0  | 0.0       | 119.06 | 0.0  | 0.0        | 0.0  | 119.06      |
      |    |      | 20250205 |           | 200.0           |               |          | 0.0  |           | 0.0    |      |            |      | 0.0         |
      | 2  | 28   | 20250301    |           | 629.7           | 155.32        | 4.41     | 0.0  | 0.0       | 159.73 | 0.0  | 0.0        | 0.0  | 159.73      |
      | 3  | 31   | 20250401    |           | 473.64          | 156.06        | 3.67     | 0.0  | 0.0       | 159.73 | 0.0  | 0.0        | 0.0  | 159.73      |
      | 4  | 30   | 20250501      |           | 316.67          | 156.97        | 2.76     | 0.0  | 0.0       | 159.73 | 0.0  | 0.0        | 0.0  | 159.73      |
      | 5  | 31   | 20250601     |           | 158.79          | 157.88        | 1.85     | 0.0  | 0.0       | 159.73 | 0.0  | 0.0        | 0.0  | 159.73      |
      | 6  | 30   | 20250701     |           | 0.0             | 158.79        | 0.93     | 0.0  | 0.0       | 159.72 | 0.0  | 0.0        | 0.0  | 159.72      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 900.0         | 17.7     | 0.0  | 0.0       | 917.7  | 0.0    | 0.0        | 0.0  | 917.7       |
    Then Loan Transactions tab has none transaction
    When Admin sets the business date to "20250302"
    When Admin runs inline COB job for Loan
    When Admin successfully disburse the loan on "20250201" with "750" EUR transaction amount
    When Admin successfully disburse the loan on "20250301" with "200" EUR transaction amount
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On     | Principal   | Net Disbursal Amount |
      | 20250101          | 20250201 | 750.0       |                      |
      | 20250205         | 20250301    | 200.0       | 700.0                |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date   | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250201 |             | 750.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 28   | 20250301    |             | 626.81          | 123.19        | 4.37     | 0.0  | 0.0       | 127.56 | 0.0    | 0.0        | 0.0  | 127.56      |
      |    |      | 20250301    |             | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 2  | 31   | 20250401    |             | 663.39          | 163.42        | 4.85     | 0.0  | 0.0       | 168.27 | 0.0    | 0.0        | 0.0  | 168.27      |
      | 3  | 30   | 20250501      |             | 498.99          | 164.4         | 3.87     | 0.0  | 0.0       | 168.27 | 0.0    | 0.0        | 0.0  | 168.27      |
      | 4  | 31   | 20250601     |             | 333.63          | 165.36        | 2.91     | 0.0  | 0.0       | 168.27 | 0.0    | 0.0        | 0.0  | 168.27      |
      | 5  | 30   | 20250701     |             | 167.31          | 166.32        | 1.95     | 0.0  | 0.0       | 168.27 | 0.0    | 0.0        | 0.0  | 168.27      |
      | 6  | 31   | 20250801   |             | 0.0             | 167.31        | 0.98     | 0.0  | 0.0       | 168.29 | 0.0    | 0.0        | 0.0  | 168.29      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 950.0         | 18.93    | 0.0  | 0.0       | 968.93 | 0.0    | 0.0        | 0.0  | 968.93      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250201 | Disbursement      | 750.0  | 0.0       | 0.0      | 0.0  | 0.0       | 750.0        | false    | false    |
      | 20250301    | Disbursement      | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 950.0        | false    | false    |
    Then Admin fails to disburse the loan on "20250301" with "50" amount
    When Admin sets the business date to "20250801"
    When Loan Pay-off is made on "20250801"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3636
  Scenario: Verify that no negative amount interest refund created after multiple Merchant Issued Refund
    When Admin sets the business date to "20250405"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_REFUND_INTEREST_RECALCULATION_MULTIDISB | 20250405     | 300            | 20.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250405" with "300" amount and expected disbursement date on "20250405"
    And Admin successfully disburse the loan on "20250405" with "265.91" EUR transaction amount
    And Admin successfully disburse the loan on "20250405" with "1.99" EUR transaction amount
    And Admin successfully disburse the loan on "20250405" with "20.0" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250405     |           | 265.91          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      |    |      | 20250405     |           | 1.99            |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      |    |      | 20250405     |           | 20.0            |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20250505       |           | 241.9           | 46.0          | 4.97     | 0.0  | 0.0       | 50.97 | 0.0  | 0.0        | 0.0  | 50.97       |
      | 2  | 31   | 20250605      |           | 195.24          | 46.66         | 4.31     | 0.0  | 0.0       | 50.97 | 0.0  | 0.0        | 0.0  | 50.97       |
      | 3  | 30   | 20250705      |           | 147.64          | 47.6          | 3.37     | 0.0  | 0.0       | 50.97 | 0.0  | 0.0        | 0.0  | 50.97       |
      | 4  | 31   | 20250805    |           | 99.3            | 48.34         | 2.63     | 0.0  | 0.0       | 50.97 | 0.0  | 0.0        | 0.0  | 50.97       |
      | 5  | 31   | 20250905 |           | 50.1            | 49.2          | 1.77     | 0.0  | 0.0       | 50.97 | 0.0  | 0.0        | 0.0  | 50.97       |
      | 6  | 30   | 20251005   |           | 0.0             | 50.1          | 0.86     | 0.0  | 0.0       | 50.96 | 0.0  | 0.0        | 0.0  | 50.96       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 287.9         | 17.91    | 0.0  | 0.0       | 305.81 | 0.0  | 0.0        | 0.0  | 305.81      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250405    | Disbursement     | 265.91 | 0.0       | 0.0      | 0.0  | 0.0       | 265.91       | false    | false    |
      | 20250405    | Disbursement     | 1.99   | 0.0       | 0.0      | 0.0  | 0.0       | 267.9        | false    | false    |
      | 20250405    | Disbursement     | 20.0   | 0.0       | 0.0      | 0.0  | 0.0       | 287.9        | false    | false    |
    When Admin sets the business date to "20250406"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250406" with 6.29 EUR transaction amount and system-generated Idempotency key
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250405     |           | 265.91          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      |    |      | 20250405     |           | 1.99            |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      |    |      | 20250405     |           | 20.0            |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20250505       |           | 241.79          | 46.11         | 4.86     | 0.0  | 0.0       | 50.97 | 6.3  | 6.3        | 0.0  | 44.67       |
      | 2  | 31   | 20250605      |           | 195.13          | 46.66         | 4.31     | 0.0  | 0.0       | 50.97 | 0.0  | 0.0        | 0.0  | 50.97       |
      | 3  | 30   | 20250705      |           | 147.53          | 47.6          | 3.37     | 0.0  | 0.0       | 50.97 | 0.0  | 0.0        | 0.0  | 50.97       |
      | 4  | 31   | 20250805    |           | 99.19           | 48.34         | 2.63     | 0.0  | 0.0       | 50.97 | 0.0  | 0.0        | 0.0  | 50.97       |
      | 5  | 31   | 20250905 |           | 49.99           | 49.2          | 1.77     | 0.0  | 0.0       | 50.97 | 0.0  | 0.0        | 0.0  | 50.97       |
      | 6  | 30   | 20251005   |           | 0.0             | 49.99         | 0.86     | 0.0  | 0.0       | 50.85 | 0.0  | 0.0        | 0.0  | 50.85       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 287.9         | 17.8     | 0.0  | 0.0       | 305.7 | 6.3  | 6.3        | 0.0  | 299.4       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250405    | Disbursement           | 265.91 | 0.0       | 0.0      | 0.0  | 0.0       | 265.91       | false    | false    |
      | 20250405    | Disbursement           | 1.99   | 0.0       | 0.0      | 0.0  | 0.0       | 267.9        | false    | false    |
      | 20250405    | Disbursement           | 20.0   | 0.0       | 0.0      | 0.0  | 0.0       | 287.9        | false    | false    |
      | 20250406    | Merchant Issued Refund | 6.29   | 6.29      | 0.0      | 0.0  | 0.0       | 281.61       | false    | false    |
      | 20250406    | Interest Refund        | 0.01   | 0.01      | 0.0      | 0.0  | 0.0       | 281.6        | false    | false    |
    When Admin sets the business date to "20250407"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250407" with 1.99 EUR transaction amount and system-generated Idempotency key
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250405     |           | 265.91          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      |    |      | 20250405     |           | 1.99            |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      |    |      | 20250405     |           | 20.0            |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20250505       |           | 241.76          | 46.14         | 4.83     | 0.0  | 0.0       | 50.97 | 8.29 | 8.29       | 0.0  | 42.68       |
      | 2  | 31   | 20250605      |           | 195.1           | 46.66         | 4.31     | 0.0  | 0.0       | 50.97 | 0.0  | 0.0        | 0.0  | 50.97       |
      | 3  | 30   | 20250705      |           | 147.5           | 47.6          | 3.37     | 0.0  | 0.0       | 50.97 | 0.0  | 0.0        | 0.0  | 50.97       |
      | 4  | 31   | 20250805    |           | 99.16           | 48.34         | 2.63     | 0.0  | 0.0       | 50.97 | 0.0  | 0.0        | 0.0  | 50.97       |
      | 5  | 31   | 20250905 |           | 49.96           | 49.2          | 1.77     | 0.0  | 0.0       | 50.97 | 0.0  | 0.0        | 0.0  | 50.97       |
      | 6  | 30   | 20251005   |           | 0.0             | 49.96         | 0.86     | 0.0  | 0.0       | 50.82 | 0.0  | 0.0        | 0.0  | 50.82       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 287.9         | 17.77    | 0.0  | 0.0       | 305.67 | 8.29 | 8.29       | 0.0  | 297.38      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250405    | Disbursement           | 265.91 | 0.0       | 0.0      | 0.0  | 0.0       | 265.91       | false    | false    |
      | 20250405    | Disbursement           | 1.99   | 0.0       | 0.0      | 0.0  | 0.0       | 267.9        | false    | false    |
      | 20250405    | Disbursement           | 20.0   | 0.0       | 0.0      | 0.0  | 0.0       | 287.9        | false    | false    |
      | 20250406    | Merchant Issued Refund | 6.29   | 6.29      | 0.0      | 0.0  | 0.0       | 281.61       | false    | false    |
      | 20250406    | Interest Refund        | 0.01   | 0.01      | 0.0      | 0.0  | 0.0       | 281.6        | false    | false    |
      | 20250406    | Accrual                | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250407    | Merchant Issued Refund | 1.99   | 1.99      | 0.0      | 0.0  | 0.0       | 279.61       | false    | false    |
    When Admin sets the business date to "20250408"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250405     |           | 265.91          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      |    |      | 20250405     |           | 1.99            |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      |    |      | 20250405     |           | 20.0            |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20250505       |           | 241.76          | 46.14         | 4.83     | 0.0  | 0.0       | 50.97 | 8.29 | 8.29       | 0.0  | 42.68       |
      | 2  | 31   | 20250605      |           | 195.1           | 46.66         | 4.31     | 0.0  | 0.0       | 50.97 | 0.0  | 0.0        | 0.0  | 50.97       |
      | 3  | 30   | 20250705      |           | 147.5           | 47.6          | 3.37     | 0.0  | 0.0       | 50.97 | 0.0  | 0.0        | 0.0  | 50.97       |
      | 4  | 31   | 20250805    |           | 99.16           | 48.34         | 2.63     | 0.0  | 0.0       | 50.97 | 0.0  | 0.0        | 0.0  | 50.97       |
      | 5  | 31   | 20250905 |           | 49.96           | 49.2          | 1.77     | 0.0  | 0.0       | 50.97 | 0.0  | 0.0        | 0.0  | 50.97       |
      | 6  | 30   | 20251005   |           | 0.0             | 49.96         | 0.86     | 0.0  | 0.0       | 50.82 | 0.0  | 0.0        | 0.0  | 50.82       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 287.9         | 17.77    | 0.0  | 0.0       | 305.67 | 8.29 | 8.29       | 0.0  | 297.38      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250405    | Disbursement           | 265.91 | 0.0       | 0.0      | 0.0  | 0.0       | 265.91       | false    | false    |
      | 20250405    | Disbursement           | 1.99   | 0.0       | 0.0      | 0.0  | 0.0       | 267.9        | false    | false    |
      | 20250405    | Disbursement           | 20.0   | 0.0       | 0.0      | 0.0  | 0.0       | 287.9        | false    | false    |
      | 20250406    | Merchant Issued Refund | 6.29   | 6.29      | 0.0      | 0.0  | 0.0       | 281.61       | false    | false    |
      | 20250406    | Interest Refund        | 0.01   | 0.01      | 0.0      | 0.0  | 0.0       | 281.6        | false    | false    |
      | 20250406    | Accrual                | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250407    | Merchant Issued Refund | 1.99   | 1.99      | 0.0      | 0.0  | 0.0       | 279.61       | false    | false    |
      | 20250407    | Accrual                | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20251005"
    When Loan Pay-off is made on "20251005"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3783
  Scenario: Verify that remaining repayment periods are correctly calculated when early repayment is made on till rest frequency type loan
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_REST_FREQUENCY_DATE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240107"
    And Customer makes "AUTOPAY" repayment on "20240107" with 17.01 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240107 | 83.1            | 16.9          | 0.11     | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                 | 66.96           | 16.14         | 0.87     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                 | 50.34           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                 | 33.62           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                 | 16.81           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                 | 0.0             | 16.81         | 0.1      | 0.0  | 0.0       | 16.91 | 0.0   | 0.0        | 0.0  | 16.91       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.96     | 0.0  | 0.0       | 101.96 | 17.01 | 17.01      | 0.0  | 84.95       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240102  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Repayment        | 17.01  | 16.9      | 0.11     | 0.0  | 0.0       | 83.1         | false    | false    |
    When Admin sets the business date to "20240701"
    When Loan Pay-off is made on "20240701"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3798
  Scenario: Verify prepayment on daily interest recalculation loan with preClosureInterestCalculationStrategy = till rest frequency date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_REST_FREQUENCY_DATE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin sets the business date to "20240402"
    And Customer makes "AUTOPAY" repayment on "20240312" with 101.74 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |               | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20240201 | 20240312 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 17.01 | 0.0         |
      | 2  | 29   | 20240301    | 20240312 | 67.14           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 17.01 | 0.0         |
      | 3  | 31   | 20240401    | 20240312 | 50.71           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0   | 0.0         |
      | 4  | 30   | 20240501      | 20240312 | 33.7            | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0   | 0.0         |
      | 5  | 31   | 20240601     | 20240312 | 16.69           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0   | 0.0         |
      | 6  | 30   | 20240701     | 20240312 | 0.0             | 16.69         | 0.0      | 0.0  | 0.0       | 16.69 | 16.69 | 16.69      | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 100.0         | 1.74     | 0.0  | 0.0       | 101.74 | 101.74 | 67.72      | 34.02 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0   | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240312    | Repayment        | 101.74  | 100.0     | 1.74     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240402    | Accrual          | 1.74    | 0.0       | 1.74     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Customer undo "1"th "Repayment" transaction made on "20240312"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late  | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |       |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0   | 17.01       |
      | 2  | 29   | 20240301    |           | 67.14           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0   | 17.01       |
      | 3  | 31   | 20240401    |           | 50.71           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0   | 17.01       |
      | 4  | 30   | 20240501      |           | 34.01           | 16.7          | 0.31     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0   | 17.01       |
      | 5  | 31   | 20240601     |           | 17.2            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0   | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 17.2          | 0.1      | 0.0  | 0.0       | 17.3  | 0.0  | 0.0        | 0.0   | 17.3        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 100.0         | 2.35     | 0.0  | 0.0       | 102.35 | 0.0    | 0.0        | 0.0   | 102.35      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0   | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240312    | Repayment        | 101.74  | 100.0     | 1.74     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20240402    | Accrual          | 1.74    | 0.0       | 1.74     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20240322" with 101.74 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount

  @TestRailId:C3830
  Scenario: Progressive loan - flat interest, multi-disbursement, allowPartialPeriodInterestCalculation = true, actual/actual, second disbursement in the middle of installment period
    When Admin sets the business date to "20240601"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_INTEREST_FLAT_ADV_PMT_ALLOC_MULTIDISBURSE | 20240101   | 3000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin sets the business date to "20240715"
    When Admin successfully disburse the loan on "20240715" with "250" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 666.67          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      |    |      | 20240715      |           | 250.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 2  | 31   | 20240801    |           | 457.77          | 458.9         | 11.37    | 0.0  | 0.0       | 470.27 | 0.0  | 0.0        | 0.0  | 470.27      |
      | 3  | 31   | 20240901 |           | 0.0             | 457.77        | 12.5     | 0.0  | 0.0       | 470.27 | 0.0  | 0.0        | 0.0  | 470.27      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1250          | 33.87    | 0.0  | 0.0       | 1283.87 | 0.0  | 0.0        | 0.0  | 1283.87     |
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
    And Customer makes "AUTOPAY" repayment on "20240715" with 813.6 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20240601      |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 30   | 20240701      | 20240715 | 666.67          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 343.33 | 0.0        | 343.33 | 0.0         |
      |    |      | 20240715      |              | 250.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 31   | 20240801    | 20240715 | 457.77          | 458.9         | 11.37    | 0.0  | 0.0       | 470.27 | 470.27 | 470.27     | 0.0    | 0.0         |
      | 3  | 31   | 20240901 |              | 0.0             | 457.77        | 12.5     | 0.0  | 0.0       | 470.27 | 0.0    | 0.0        | 0.0    | 470.27      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late   | Outstanding |
      | 1250          | 33.87    | 0.0  | 0.0       | 1283.87 | 813.6 | 470.27     | 343.33 | 470.27      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240715     | Disbursement            | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1250.0       |
      | 20240715     | Repayment               | 813.6  | 792.23    | 21.37    | 0.0  | 0.0       | 457.77       |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20240715" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 792.23 |
      | ASSET     | 112603       | Interest/Fee Receivable   |       | 21.37  |
      | LIABILITY | 145023       | Suspense/Clearing account | 813.6 |        |
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
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240715     | Repayment               | 813.6  | 792.23    | 21.37    | 0.0  | 0.0       | 457.77       | true     | false    |
    When Admin sets the business date to "20240901"
    When Loan Pay-off is made on "20240901"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3831
  Scenario: Progressive loan - flat interest, multi-disbursement, allowPartialPeriodInterestCalculation = true, actual/actual, second disbursement on the due date of installment period
    When Admin sets the business date to "20240601"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_INTEREST_FLAT_ADV_PMT_ALLOC_MULTIDISBURSE | 20240101   | 3000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin sets the business date to "20240901"
    When Loan Pay-off is made on "20240901"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3832
  Scenario: Progressive loan - flat interest, multi-disbursement, allowPartialPeriodInterestCalculation = true, 360/30, second disbursement in the middle of installment period
    When Admin sets the business date to "20240601"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                          | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_INTEREST_FLAT_360_30_ADV_PMT_ALLOC_MULTIDISBURSE | 20240101   | 3000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin sets the business date to "20240715"
    When Admin successfully disburse the loan on "20240715" with "250" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 666.67          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      |    |      | 20240715      |           | 250.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 2  | 31   | 20240801    |           | 457.77          | 458.9         | 11.37    | 0.0  | 0.0       | 470.27 | 0.0  | 0.0        | 0.0  | 470.27      |
      | 3  | 31   | 20240901 |           | 0.0             | 457.77        | 12.5     | 0.0  | 0.0       | 470.27 | 0.0  | 0.0        | 0.0  | 470.27      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1250          | 33.87    | 0.0  | 0.0       | 1283.87 | 0.0  | 0.0        | 0.0  | 1283.87     |
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
    And Customer makes "AUTOPAY" repayment on "20240715" with 813.6 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20240601      |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 30   | 20240701      | 20240715 | 666.67          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 343.33 | 0.0        | 343.33 | 0.0         |
      |    |      | 20240715      |              | 250.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 31   | 20240801    | 20240715 | 457.77          | 458.9         | 11.37    | 0.0  | 0.0       | 470.27 | 470.27 | 470.27     | 0.0    | 0.0         |
      | 3  | 31   | 20240901 |              | 0.0             | 457.77        | 12.5     | 0.0  | 0.0       | 470.27 | 0.0    | 0.0        | 0.0    | 470.27      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late   | Outstanding |
      | 1250          | 33.87    | 0.0  | 0.0       | 1283.87 | 813.6 | 470.27     | 343.33 | 470.27      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240715     | Disbursement            | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1250.0       |
      | 20240715     | Repayment               | 813.6  | 792.23    | 21.37    | 0.0  | 0.0       | 457.77       |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20240715" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 792.23 |
      | ASSET     | 112603       | Interest/Fee Receivable   |       | 21.37  |
      | LIABILITY | 145023       | Suspense/Clearing account | 813.6 |        |
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
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240715     | Repayment               | 813.6  | 792.23    | 21.37    | 0.0  | 0.0       | 457.77       | true     | false    |
    When Admin sets the business date to "20240901"
    When Loan Pay-off is made on "20240901"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3833
  Scenario: Progressive loan - flat interest, multi-disbursement, allowPartialPeriodInterestCalculation = true, 360/30, second disbursement on the due date of installment period
    When Admin sets the business date to "20240601"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                          | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_INTEREST_FLAT_360_30_ADV_PMT_ALLOC_MULTIDISBURSE | 20240101   | 3000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin sets the business date to "20240901"
    When Loan Pay-off is made on "20240901"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3834
  Scenario: Progressive loan - down payment, flat interest, multi-disbursement, allowPartialPeriodInterestCalculation = true, actual/actual, second disbursement in the middle of installment period
    When Admin sets the business date to "20240601"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                               | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_INTEREST_FLAT_ADV_PMT_ALLOC_MULTIDISBURSE | 20240101   | 3000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240601      |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 30   | 20240701      |           | 500.0           | 250.0         | 7.5      | 0.0  | 0.0       | 257.5 | 0.0  | 0.0        | 0.0  | 257.5       |
      |    |      | 20240715      |           | 250.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 3  | 0    | 20240715      |           | 687.5           | 62.5          | 0.0      | 0.0  | 0.0       | 62.5  | 0.0  | 0.0        | 0.0  | 62.5        |
      | 4  | 31   | 20240801    |           | 343.33          | 344.17        | 8.53     | 0.0  | 0.0       | 352.7 | 0.0  | 0.0        | 0.0  | 352.7       |
      | 5  | 31   | 20240901 |           | 0.0             | 343.33        | 9.37     | 0.0  | 0.0       | 352.7 | 0.0  | 0.0        | 0.0  | 352.7       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1250          | 25.4     | 0.0  | 0.0       | 1275.4 | 0.0  | 0.0        | 0.0  | 1275.4      |
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
    And Customer makes "AUTOPAY" repayment on "20240715" with 922.7 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240601      |              | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20240601      | 20240715 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 30   | 20240701      | 20240715 | 500.0           | 250.0         | 7.5      | 0.0  | 0.0       | 257.5 | 257.5 | 0.0        | 257.5 | 0.0         |
      |    |      | 20240715      |              | 250.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 3  | 0    | 20240715      | 20240715 | 687.5           | 62.5          | 0.0      | 0.0  | 0.0       | 62.5  | 62.5  | 0.0        | 0.0   | 0.0         |
      | 4  | 31   | 20240801    | 20240715 | 343.33          | 344.17        | 8.53     | 0.0  | 0.0       | 352.7 | 352.7 | 352.7      | 0.0   | 0.0         |
      | 5  | 31   | 20240901 |              | 0.0             | 343.33        | 9.37     | 0.0  | 0.0       | 352.7 | 0.0   | 0.0        | 0.0   | 352.7       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1250          | 25.4     | 0.0  | 0.0       | 1275.4 | 922.7 | 352.7      | 507.5 | 352.7       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240715     | Disbursement            | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1250.0       |
      | 20240715     | Repayment               | 922.7  | 906.67    | 16.03    | 0.0  | 0.0       | 343.33       |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20240715" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 906.67 |
      | ASSET     | 112603       | Interest/Fee Receivable   |       | 16.03  |
      | LIABILITY | 145023       | Suspense/Clearing account | 922.7 |        |
    When Admin sets the business date to "20240901"
    When Loan Pay-off is made on "20240901"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3835
  Scenario: Progressive loan - flat interest, multi-disbursement, allowPartialPeriodInterestCalculation = false, actual/actual, second disbursement in the middle of installment period
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
    When Admin sets the business date to "20240901"
    When Loan Pay-off is made on "20240901"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

