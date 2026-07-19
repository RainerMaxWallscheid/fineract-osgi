@BuyDownFeeFeature
Feature: Buy Down Fees

  @TestRailId:C3770
  Scenario: Verify loan with Buy Down fees and full payment - UC1.1
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101    | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 33.72 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment        | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
    When Admin sets the business date to "20240301"
    And Customer makes "AUTOPAY" repayment on "20240301" with 33.72 EUR transaction amount
    When Admin sets the business date to "20240401"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240401" with 33.73 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240301    | Repayment                 | 33.72  | 33.33     | 0.39     | 0.0  | 0.0       | 33.53        | false    |
      | 20240331    | Accrual                   | 1.16   | 0.0       | 1.16     | 0.0  | 0.0       | 0.0          | false    |
      | 20240331    | Buy Down Fee Amortization | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Repayment                 | 33.73  | 33.53     | 0.2      | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 50.0             | 0.0                      | 0.0             | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240331"

  @TestRailId:C3827
  Scenario: Verify loan with Buy Down fees and full payment and daily amortization - UC1.2
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101    | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin runs inline COB job for Loan
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE_AMORTIZATION" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 0.55   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 0.55  |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.55             | 49.45                    | 0.0             | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240101"
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 33.72 EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240301"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240301" with 33.72 EUR transaction amount
    When Admin sets the business date to "20240401"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240401" with 33.73 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240117  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240117  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240118  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240118  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240119  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240119  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240120  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240120  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240121  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240121  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240122  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240122  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240123  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240123  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240124  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240124  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240127  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240127  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240128  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240128  | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240129  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240129  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240130  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240130  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |

      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240201 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240202 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240202 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240203 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240203 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240204 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240204 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240205 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240205 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240206 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240206 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240207 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240207 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240208 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240208 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240209 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240209 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240210 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240210 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240211 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240211 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240212 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240212 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240213 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240213 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240214 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240214 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240215 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240215 | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240216 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240216 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240217 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240217 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240218 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240218 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240219 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240219 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240220 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240220 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240221 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240221 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240222 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240222 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240223 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240223 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240224 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240224 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240225 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240225 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240226 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240226 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240227 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240227 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240228 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240228 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240229 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240229 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |

      | 20240301    | Repayment                 | 33.72  | 33.33     | 0.39     | 0.0  | 0.0       | 33.53        | false    |
      | 20240301    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240302    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240302    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240303    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240304    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240304    | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240305    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240305    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240306    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240307    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240307    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240308    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240309    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240309    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240310    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240310    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240311    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240312    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240312    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240313    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240313    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240314    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240315    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240315    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240316    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240317    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240317    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240318    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240318    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240319    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240320    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240320    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240321    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240321    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240322    | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240323    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240323    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240324    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240324    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240325    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240326    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240326    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240327    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240328    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240328    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240329    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240329    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240330    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240331    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240331    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |

      | 20240401    | Repayment                 | 33.73  | 33.53     | 0.2      | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 50.0             | 0.0                      | 0.0             | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240331"

  @TestRailId:C3771
  Scenario: Verify loan with Buy Down fees and early payoff - UC2.1
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101    | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 33.72 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment        | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
    When Admin sets the business date to "20240301"
    When Loan Pay-off is made on "20240301"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240301    | Repayment                 | 67.25  | 66.86     | 0.39     | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Accrual                   | 0.97   | 0.0       | 0.97     | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Buy Down Fee Amortization | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE_AMORTIZATION" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 50.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 50.0  |        |
    And Buy down fee contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 50.0             | 0.0                      | 0.0             | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240301"

  @TestRailId:C3828
  Scenario: Verify loan with Buy Down fees and early payoff and daily amortization - UC2.2
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101    | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE_AMORTIZATION" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 0.55   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 0.55  |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.55             | 49.45                    | 0.0             | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240101"
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 33.72 EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240301"
    When Admin runs inline COB job for Loan
    When Loan Pay-off is made on "20240301"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240117  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240117  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240118  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240118  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240119  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240119  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240120  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240120  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240121  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240121  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240122  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240122  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240123  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240123  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240124  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240124  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240127  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240127  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240128  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240128  | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240129  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240129  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240130  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240130  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |

      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240201 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240202 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240202 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240203 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240203 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240204 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240204 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240205 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240205 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240206 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240206 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240207 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240207 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240208 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240208 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240209 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240209 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240210 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240210 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240211 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240211 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240212 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240212 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240213 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240213 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240214 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240214 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240215 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240215 | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240216 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240216 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240217 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240217 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240218 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240218 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240219 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240219 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240220 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240220 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240221 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240221 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240222 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240222 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240223 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240223 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240224 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240224 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240225 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240225 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240226 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240226 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240227 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240227 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240228 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240228 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240229 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240229 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |

      | 20240301    | Repayment                 | 67.25  | 66.86     | 0.39     | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Buy Down Fee Amortization | 17.03  | 0.0       | 17.03    | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE_AMORTIZATION" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 17.03  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 17.03 |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 50.0             | 0.0                      | 0.0             | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240301"

  @TestRailId:C3772
  Scenario: Verify loan with Buy Down fees and charge-off transaction - amortization in case of loan charge-off event - UC3.1
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101    | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 33.72 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment        | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
    When Admin sets the business date to "20240301"
    And Admin does charge-off the loan on "20240301"
    Then Loan status will be "ACTIVE"
    And Loan marked as charged-off on "20240301"
    And Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable           |        | 66.86  |
      | ASSET     | 112603       | Interest/Fee Receivable    |        |  0.59  |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt       |  66.86 |        |
      | INCOME    | 404001       | Interest Income Charge Off |   0.59 |        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240301    | Buy Down Fee Amortization | 33.52  | 0.0       | 33.52    | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Accrual                   | 0.97   | 0.0       | 0.97     | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Charge-off                | 67.45  | 66.86     | 0.59     | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Buy Down Fee Amortization | 16.48  | 0.0       | 16.48    | 0.0  | 0.0       | 0.0          | false    |
# --- check BDF journal entries for before and after charge-off trn processed --- #
    And Loan Transactions tab has 2 a "BUY_DOWN_FEE_AMORTIZATION" transactions with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 33.52  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 33.52 |        |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt        |       | 16.48  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 16.48 |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 33.52            | 0.0                      | 0.0             | 16.48              |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240301"

    When Loan Pay-off is made on "20240301"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3829
  Scenario: Verify loan with Buy Down fees and charge-off transaction - daily amortization and amortization in case of loan charge-off event - UC3.2
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101    | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE_AMORTIZATION" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 0.55   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 0.55  |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.55             | 49.45                    | 0.0             | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240101"
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 33.72 EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240301"
    When Admin runs inline COB job for Loan
    And Admin does charge-off the loan on "20240301"
    Then Loan status will be "ACTIVE"
    And Loan marked as charged-off on "20240301"
    And Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable           |        | 66.86  |
      | ASSET     | 112603       | Interest/Fee Receivable    |        |  0.59  |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt       |  66.86 |        |
      | INCOME    | 404001       | Interest Income Charge Off |   0.59 |        |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240117  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240117  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240118  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240118  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240119  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240119  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240120  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240120  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240121  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240121  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240122  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240122  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240123  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240123  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240124  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240124  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240127  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240127  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240128  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240128  | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240129  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240129  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240130  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240130  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |

      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240201 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240202 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240202 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240203 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240203 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240204 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240204 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240205 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240205 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240206 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240206 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240207 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240207 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240208 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240208 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240209 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240209 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240210 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240210 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240211 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240211 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240212 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240212 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240213 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240213 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240214 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240214 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240215 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240215 | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240216 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240216 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240217 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240217 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240218 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240218 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240219 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240219 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240220 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240220 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240221 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240221 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240222 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240222 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240223 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240223 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240224 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240224 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240225 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240225 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240226 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240226 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240227 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240227 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240228 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240228 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240229 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240229 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |

      | 20240301    | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Charge-off                | 67.45  | 66.86     | 0.59     | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Buy Down Fee Amortization | 16.48  | 0.0       | 16.48    | 0.0  | 0.0       | 0.0          | false    |
# --- check BDFA journal entries for before and after charge-off trn processed --- #
    And Loan Transactions tab has 2 a "BUY_DOWN_FEE_AMORTIZATION" transactions with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 0.55   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 0.55  |        |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt        |       | 16.48  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 16.48 |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 33.52            | 0.0                      | 0.0             | 16.48              |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240301"
    When Loan Pay-off is made on "20240301"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3848
  Scenario: Verify loan with Buy Down fees and undo the charge-off transaction - amortization in case of loan charge-off event should also be reversed  - UC3.3
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101    | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
# --- charge-off ---#
    When Admin sets the business date to "20240201"
    And Admin does charge-off the loan on "20240201"
    Then Loan status will be "ACTIVE"
    And Loan marked as charged-off on "20240201"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240201" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable           |        | 100.0  |
      | ASSET     | 112603       | Interest/Fee Receivable    |        |  1.17  |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt       | 100.0  |        |
      | INCOME    | 404001       | Interest Income Charge Off |  1.17  |        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee Amortization | 17.58  | 0.0       | 17.58    | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Accrual                   | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Charge-off                | 101.17 | 100.0     | 1.17     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee Amortization | 32.42  | 0.0       | 32.42    | 0.0  | 0.0       | 0.0          | false    |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 17.58            | 0.0                      | 0.0             | 32.42              |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240201"
# --- check BDFA journal entries for before and after charge-off trn processed --- #
    And Loan Transactions tab has 2 a "BUY_DOWN_FEE_AMORTIZATION" transactions with date "20240201" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 17.58  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 17.58 |        |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt        |       | 32.42  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 32.42 |        |
# --- charge-off undo ---#
    Then Admin does a charge-off undo the loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee Amortization | 17.58  | 0.0       | 17.58    | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Accrual                   | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Charge-off                | 101.17 | 100.0     | 1.17     | 0.0  | 0.0       | 0.0          | true     |
    And Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240201" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable           |        | 100.0  |
      | ASSET     | 112603       | Interest/Fee Receivable    |        |  1.17  |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt       | 100.0  |        |
      | INCOME    | 404001       | Interest Income Charge Off |  1.17  |        |
      | ASSET     | 112601       | Loans Receivable           | 100.0  |        |
      | ASSET     | 112603       | Interest/Fee Receivable    |  1.17  |        |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt       |        | 100.0  |
      | INCOME    | 404001       | Interest Income Charge Off |        | 1.17   |
    And Loan Transactions tab has 1 a "BUY_DOWN_FEE_AMORTIZATION" transactions with date "20240201" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 17.58  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 17.58 |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 17.58            | 32.42                    | 0.0             | 0.0                |
    When Loan Pay-off is made on "20240201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3849
  Scenario: Verify loan with Buy Down fees and undo the charge-off a fraud loan - amortization in case of loan charge-off event should also be reversed  - UC3.4
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101    | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    Then Admin can successfully set Fraud flag to the loan
# --- charge-off ---#
    When Admin sets the business date to "20240201"
    And Admin does charge-off the loan on "20240201"
    Then Loan status will be "ACTIVE"
    And Loan marked as charged-off on "20240201"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240201" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable           |        | 100.0  |
      | ASSET     | 112603       | Interest/Fee Receivable    |        |  1.17  |
      | EXPENSE   | 744037       | Credit Loss/Bad Debt-Fraud | 100.0  |        |
      | INCOME    | 404001       | Interest Income Charge Off |  1.17  |        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee Amortization | 17.58  | 0.0       | 17.58    | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Accrual                   | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Charge-off                | 101.17 | 100.0     | 1.17     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee Amortization | 32.42  | 0.0       | 32.42    | 0.0  | 0.0       | 0.0          | false    |
# --- check BDFA journal entries for before and after charge-off trn processed --- #
    And Loan Transactions tab has 2 a "BUY_DOWN_FEE_AMORTIZATION" transactions with date "20240201" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 17.58  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 17.58 |        |
      | EXPENSE   | 744037       | Credit Loss/Bad Debt-Fraud  |       | 32.42  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 32.42 |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 17.58            | 0.0                      | 0.0             | 32.42              |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240201"
# --- charge-off undo ---#
    Then Admin does a charge-off undo the loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee Amortization | 17.58  | 0.0       | 17.58    | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Accrual                   | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Charge-off                | 101.17 | 100.0     | 1.17     | 0.0  | 0.0       | 0.0          | true     |
    And Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240201" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable           |        | 100.0  |
      | ASSET     | 112603       | Interest/Fee Receivable    |        |  1.17  |
      | EXPENSE   | 744037       | Credit Loss/Bad Debt-Fraud | 100.0  |        |
      | INCOME    | 404001       | Interest Income Charge Off |  1.17  |        |
      | ASSET     | 112601       | Loans Receivable           | 100.0  |        |
      | ASSET     | 112603       | Interest/Fee Receivable    |  1.17  |        |
      | EXPENSE   | 744037       | Credit Loss/Bad Debt-Fraud |        | 100.0  |
      | INCOME    | 404001       | Interest Income Charge Off |        | 1.17   |
    And Loan Transactions tab has 1 a "BUY_DOWN_FEE_AMORTIZATION" transactions with date "20240201" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 17.58  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 17.58 |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 17.58            | 32.42                    | 0.0             | 0.0                |
    When Loan Pay-off is made on "20240201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3850
  Scenario: Verify loan with Buy Down fees and charge-off with "delinquent" reason - amortization in case of loan charge-off event - UC3.5
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES_CHARGE_OFF_REASON | 20240101    | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    Then Admin can successfully set Fraud flag to the loan
    When Admin sets the business date to "20240125"
    And Admin does charge-off the loan with reason "DELINQUENT" on "20240125"
    And Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240125" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable           |        | 100.0  |
      | ASSET     | 112603       | Interest/Fee Receivable    |        |  1.17  |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt       | 100.0  |        |
      | INCOME    | 404001       | Interest Income Charge Off |  1.17  |        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Buy Down Fee Amortization | 13.74  | 0.0       | 13.74    | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Accrual                   | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Charge-off                | 101.17 | 100.0     | 1.17     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Buy Down Fee Amortization | 36.26  | 0.0       | 36.26    | 0.0  | 0.0       | 0.0          | false    |
# --- check BDFA journal entries for before and after charge-off trn processed --- #
    And Loan Transactions tab has 2 a "BUY_DOWN_FEE_AMORTIZATION" transactions with date "20240125" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 13.74  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 13.74 |        |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt        |       | 36.26  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 36.26 |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 13.74            | 0.0                      | 0.0             | 36.26              |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240125"
    When Loan Pay-off is made on "20240125"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3851
  Scenario: Verify loan with Buy Down fees and charge-off a fraud loan - amortization in case of loan charge-off event - UC3.6
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES_CHARGE_OFF_REASON | 20240101    | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    Then Admin can successfully set Fraud flag to the loan
    When Admin sets the business date to "20240125"
    And Admin does charge-off the loan on "20240125"
    And Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240125" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable           |        | 100.0  |
      | ASSET     | 112603       | Interest/Fee Receivable    |        |  1.17  |
      | EXPENSE   | 744037       | Credit Loss/Bad Debt-Fraud | 100.0  |        |
      | INCOME    | 404001       | Interest Income Charge Off |  1.17  |        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Buy Down Fee Amortization | 13.74  | 0.0       | 13.74    | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Accrual                   | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Charge-off                | 101.17 | 100.0     | 1.17     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Buy Down Fee Amortization | 36.26  | 0.0       | 36.26    | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has 2 a "BUY_DOWN_FEE_AMORTIZATION" transactions with date "20240125" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 13.74  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 13.74 |        |
      | EXPENSE   | 744037       | Credit Loss/Bad Debt-Fraud  |       | 36.26  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 36.26 |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 13.74            | 0.0                      | 0.0             | 36.26              |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240125"
    When Loan Pay-off is made on "20240125"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3852
  Scenario: Verify loan with Buy Down fees and undo the charge-off transaction with "delinquent" reason - amortization in case of loan charge-off event should also be reversed - UC3.7
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES_CHARGE_OFF_REASON | 20240101    | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    Then Admin can successfully set Fraud flag to the loan
    When Admin sets the business date to "20240125"
    And Admin does charge-off the loan with reason "DELINQUENT" on "20240125"
    And Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240125" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable           |        | 100.0  |
      | ASSET     | 112603       | Interest/Fee Receivable    |        |  1.17  |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt       | 100.0  |        |
      | INCOME    | 404001       | Interest Income Charge Off |  1.17  |        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Buy Down Fee Amortization | 13.74  | 0.0       | 13.74    | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Accrual                   | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Charge-off                | 101.17 | 100.0     | 1.17     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Buy Down Fee Amortization | 36.26  | 0.0       | 36.26    | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has 2 a "BUY_DOWN_FEE_AMORTIZATION" transactions with date "20240125" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 13.74  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 13.74 |        |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt        |       | 36.26  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 36.26 |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 13.74            | 0.0                      | 0.0             | 36.26              |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240125"
    Then Admin does a charge-off undo the loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Buy Down Fee Amortization | 13.74  | 0.0       | 13.74    | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Accrual                   | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Charge-off                | 101.17 | 100.0     | 1.17     | 0.0  | 0.0       | 0.0          | true     |
    And Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240125" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable           |        | 100.0  |
      | ASSET     | 112603       | Interest/Fee Receivable    |        |  1.17  |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt       | 100.0  |        |
      | INCOME    | 404001       | Interest Income Charge Off |  1.17  |        |
      | ASSET     | 112601       | Loans Receivable           | 100.0  |        |
      | ASSET     | 112603       | Interest/Fee Receivable    |  1.17  |        |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt       |        | 100.0  |
      | INCOME    | 404001       | Interest Income Charge Off |        | 1.17   |
    And Loan Transactions tab has 1 a "BUY_DOWN_FEE_AMORTIZATION" transactions with date "20240125" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 13.74  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 13.74 |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 13.74            | 36.26                    | 0.0             | 0.0                |
    When Loan Pay-off is made on "20240125"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3886
  Scenario: Verify loan with with a few Buy Down fees with adjustment and charge-off transaction - amortization in case of loan charge-off event - UC3.8
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101    | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
# --- add 2nd BuyDownFee - on Feb,1st 2024 --- #
    When Admin sets the business date to "20240201"
    When Admin runs inline COB job for Loan
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240201" with "50" EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Accrual                   | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Buy Down Fee Amortization | 17.03  | 0.0       | 17.03    | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Buy down fee by external-id contains the following data:
      | Date             | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101  | 50.0       | 17.03            | 32.97                    | 0.0             | 0.0                |
      | 20240201 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240131"
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240201"
# --- charge-off the loan --- #
    When Admin sets the business date to "20240301"
    And Admin does charge-off the loan on "20240301"
    Then Loan status will be "ACTIVE"
    And Loan marked as charged-off on "20240301"
    And Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable           |        | 100.0  |
      | ASSET     | 112603       | Interest/Fee Receivable    |        |  1.36  |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt       |  100.0 |        |
      | INCOME    | 404001       | Interest Income Charge Off |   1.36 |        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Accrual                   | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Buy Down Fee Amortization | 17.03  | 0.0       | 17.03    | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Buy Down Fee Amortization | 41.49  | 0.0       | 41.49    | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Accrual                   | 0.6    | 0.0       | 0.6      | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Charge-off                | 101.36 | 100.0     | 1.36     | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Buy Down Fee Amortization | 41.48  | 0.0       | 41.48    | 0.0  | 0.0       | 0.0          | false    |
# --- check BDF journal entries for before and after charge-off trn processed --- #
    And Loan Transactions tab has 2 a "BUY_DOWN_FEE_AMORTIZATION" transactions with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 41.49  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 41.49 |        |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt        |       | 41.48  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 41.48 |        |
    And Buy down fee by external-id contains the following data:
      | Date             | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101  | 50.0       | 33.52            | 0.0                     | 0.0              | 16.48              |
      | 20240201 | 50.0       | 25.0             | 0.0                     | 0.0              | 25.0               |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240301"
    When Loan Pay-off is made on "20240301"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:С3825
  Scenario: Verify loan with Buy Down Fee adjustment trn and repayment trns - UC4
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101    | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
# --- 1st repayment on February,1 ---#
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 33.72 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 33.72 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0   | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |                  | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0   | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 33.72 | 0.0        | 0.0  | 67.45       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment        | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
# --- BuyDownFee Adjustment trns on March,1 ---#
    When Admin sets the business date to "20240301"
    And Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20240301" with "10" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 33.72 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0   | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |                  | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0   | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 33.72 | 0.0        | 0.0  | 67.45       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement            | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee            | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment               | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240301    | Buy Down Fee Adjustment | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE_ADJUSTMENT" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            |       | 10.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 10.0  |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 40.0                     | 10.0            | 0.0                |
    And LoanBuyDownFeeAdjustmentTransactionCreatedBusinessEvent is created on "20240301"
# --- 2nd repayment on April,1 ---#
    When Admin sets the business date to "20240401"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240401" with 33.73 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240301    | Buy Down Fee Adjustment   | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240331    | Accrual                   | 1.35   | 0.0       | 1.35     | 0.0  | 0.0       | 0.0          | false    |
      | 20240331    | Buy Down Fee Amortization | 40.0   | 0.0       | 40.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Repayment                 | 33.73  | 33.34     | 0.39     | 0.0  | 0.0       | 33.52        | false    |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 40.0             | 0.0                      | 10.0            | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240331"
    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240301    | Buy Down Fee Adjustment   | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240331    | Accrual                   | 1.35   | 0.0       | 1.35     | 0.0  | 0.0       | 0.0          | false    |
      | 20240331    | Buy Down Fee Amortization | 40.0   | 0.0       | 40.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Repayment                 | 33.73  | 33.34     | 0.39     | 0.0  | 0.0       | 33.52        | false    |
      | 20240401    | Repayment                 | 33.91  | 33.52     | 0.39     | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |

  @TestRailId:С3826
  Scenario: Verify loan with a few Buy Down Fee adjustment trns and repayment trns - UC5
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101    | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
# --- 1st repayment on February,1 ---#
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 33.72 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 33.72 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0   | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |                  | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0   | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 33.72 | 0.0        | 0.0  | 67.45       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment        | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
# --- 1st BuyDownFee Adjustment trns on March,1 ---#
    When Admin sets the business date to "20240301"
    And Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20240301" with "10" EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement            | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee            | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment               | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240301    | Buy Down Fee Adjustment | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE_ADJUSTMENT" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            |       | 10.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 10.0  |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 40.0                     | 10.0            | 0.0                |
    And LoanBuyDownFeeAdjustmentTransactionCreatedBusinessEvent is created on "20240301"
# --- 2nd BuyDownFee Adjustment trns on March,15 ---#
    When Admin sets the business date to "20240315"
    And Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20240315" with "5" EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement            | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee            | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment               | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240301    | Buy Down Fee Adjustment | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240315    | Buy Down Fee Adjustment |  5.0   | 0.0       | 5.0      | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE_ADJUSTMENT" transaction with date "20240315" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            |       |  5.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income |  5.0  |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 35.0                     | 15.0            | 0.0                |
    And LoanBuyDownFeeAdjustmentTransactionCreatedBusinessEvent is created on "20240315"
# --- 2nd repayment on April,1 ---#
    When Admin sets the business date to "20240401"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240401" with 33.73 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240301    | Buy Down Fee Adjustment   | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240315    | Buy Down Fee Adjustment   |  5.0   | 0.0       | 5.0      | 0.0  | 0.0       | 0.0          | false    |
      | 20240331    | Accrual                   | 1.35   | 0.0       | 1.35     | 0.0  | 0.0       | 0.0          | false    |
      | 20240331    | Buy Down Fee Amortization | 35.0   | 0.0       | 35.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Repayment                 | 33.73  | 33.34     | 0.39     | 0.0  | 0.0       | 33.52        | false    |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 35.0             | 0.0                      | 15.0            | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240331"
    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240301    | Buy Down Fee Adjustment   | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240315    | Buy Down Fee Adjustment   |  5.0   | 0.0       | 5.0      | 0.0  | 0.0       | 0.0          | false    |
      | 20240331    | Accrual                   | 1.35   | 0.0       | 1.35     | 0.0  | 0.0       | 0.0          | false    |
      | 20240331    | Buy Down Fee Amortization | 35.0   | 0.0       | 35.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Repayment                 | 33.73  | 33.34     | 0.39     | 0.0  | 0.0       | 33.52        | false    |
      | 20240401    | Repayment                 | 33.91  | 33.52     | 0.39     | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |

  @TestRailId:C3853
  Scenario: Verify add buy down fee to a progressive loan after disbursement and then write off loan - amortization in case of loan close event
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101    | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "900" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240102" with "100" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 900.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 601.74          | 298.26        | 5.25     | 0.0  | 0.0       | 303.51 | 0.0  | 0.0        | 0.0  | 303.51      |
      | 2  | 29   | 20240301    |           | 301.74          | 300.0         | 3.51     | 0.0  | 0.0       | 303.51 | 0.0  | 0.0        | 0.0  | 303.51      |
      | 3  | 31   | 20240401    |           | 0.0             | 301.74        | 1.76     | 0.0  | 0.0       | 303.5  | 0.0  | 0.0        | 0.0  | 303.5       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 900.0         | 10.52    | 0.0  | 0.0       | 910.52 | 0.0  | 0.0        | 0.0  | 910.52      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240102  | Buy Down Fee     | 100.0  | 0.0       | 100.0    | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 100.0 |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 100.0  |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240102 | 100.0      | 0.0              | 100.0                    | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240102"
# --- make write-off --- #
    And Admin does write-off the loan on "20240102"
    Then Loan has 0 outstanding amount
    Then Loan status will be "CLOSED_WRITTEN_OFF"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 900.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 | 20240102 | 601.74          | 298.26        | 5.25     | 0.0  | 0.0       | 303.51 | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240102 | 301.74          | 300.0         | 3.51     | 0.0  | 0.0       | 303.51 | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240102 | 0.0             | 301.74        | 1.76     | 0.0  | 0.0       | 303.5  | 0.0  | 0.0        | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 900.0         | 10.52    | 0.0  | 0.0       | 910.52 | 0.0  | 0.0        | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240102  | Buy Down Fee              | 100.0  | 0.0       | 100.0    | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Close (as written-off)    | 910.52 | 900.0     | 10.52    | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Buy Down Fee Amortization | 100.0  | 0.0       | 100.0    | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE_AMORTIZATION" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | e4           | Written off                 |       | 100.0  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 100.0 |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240102 | 100.0      | 100.0            | 0.0                      | 0.0             | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240102"

  @TestRailId:C3881
  Scenario: Verify loan with Buy Down Fee adjustment reversal scenario - UC7
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101    | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
# --- 1st repayment on February,1 ---#
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 33.72 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 33.72 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0   | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |                  | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0   | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 33.72 | 0.0        | 0.0  | 67.45       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240117  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240117  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240118  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240118  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240119  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240119  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240120  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240120  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240121  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240121  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240122  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240122  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240123  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240123  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240124  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240124  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240127  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240127  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240128  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240128  | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240129  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240129  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240130  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240130  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |

      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 17.03            | 32.97                    | 0.0             | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240131"
    # --- 2nd repayment on March,1 ---#
    When Admin sets the business date to "20240301"
    And Customer makes "AUTOPAY" repayment on "20240301" with 33.72 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 33.72 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 33.72 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    |                  | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0   | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 67.44 | 0.0        | 0.0  | 33.73       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240117  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240117  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240118  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240118  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240119  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240119  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240120  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240120  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240121  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240121  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240122  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240122  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240123  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240123  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240124  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240124  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240127  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240127  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240128  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240128  | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240129  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240129  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240130  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240130  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |

      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240201 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240202 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240202 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240203 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240203 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240204 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240204 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240205 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240205 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240206 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240206 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240207 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240207 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240208 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240208 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240209 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240209 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240210 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240210 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240211 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240211 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240212 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240212 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240213 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240213 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240214 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240214 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240215 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240215 | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240216 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240216 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240217 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240217 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240218 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240218 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240219 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240219 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240220 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240220 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240221 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240221 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240222 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240222 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240223 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240223 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240224 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240224 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240225 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240225 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240226 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240226 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240227 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240227 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240228 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240228 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240229 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240229 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Repayment                 | 33.72  | 33.33     | 0.39     | 0.0  | 0.0       | 33.53        | false    |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240229"
    # --- BuyDownFee Adjustment trns on March,1 ---#
    And Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20240301" with "10" EUR transaction amount
    When Admin sets the business date to "20240302"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 33.72 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 33.72 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    |                  | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0   | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 67.44 | 0.0        | 0.0  | 33.73       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240117  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240117  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240118  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240118  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240119  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240119  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240120  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240120  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240121  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240121  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240122  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240122  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240123  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240123  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240124  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240124  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240127  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240127  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240128  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240128  | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240129  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240129  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240130  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240130  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |

      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240201 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240202 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240202 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240203 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240203 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240204 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240204 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240205 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240205 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240206 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240206 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240207 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240207 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240208 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240208 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240209 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240209 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240210 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240210 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240211 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240211 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240212 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240212 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240213 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240213 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240214 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240214 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240215 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240215 | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240216 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240216 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240217 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240217 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240218 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240218 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240219 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240219 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240220 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240220 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240221 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240221 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240222 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240222 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240223 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240223 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240224 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240224 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240225 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240225 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240226 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240226 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240227 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240227 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240228 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240228 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240229 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240229 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |

      | 20240301    | Repayment                 | 33.72  | 33.33     | 0.39     | 0.0  | 0.0       | 33.53        | false    |
      | 20240301    | Buy Down Fee Adjustment   | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Buy Down Fee Amortization | 0.22   | 0.0       | 0.22     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE_ADJUSTMENT" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            |       | 10.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 10.0  |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 33.19            | 6.81                     | 10.0            | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240301"
    And LoanBuyDownFeeAdjustmentTransactionCreatedBusinessEvent is created on "20240301"
# --- BuyDownFee Adjustment reversal on March,1 ---#
    When Customer undo "1"th "Buy Down Fee Adjustment" transaction made on "20240301"
    When Admin sets the business date to "20240303"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240117  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240117  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240118  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240118  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240119  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240119  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240120  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240120  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240121  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240121  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240122  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240122  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240123  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240123  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240124  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240124  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240127  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240127  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240128  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240128  | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240129  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240129  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240130  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240130  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |

      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240201 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240202 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240202 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240203 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240203 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240204 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240204 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240205 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240205 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240206 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240206 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240207 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240207 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240208 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240208 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240209 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240209 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240210 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240210 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240211 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240211 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240212 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240212 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240213 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240213 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240214 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240214 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240215 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240215 | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240216 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240216 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240217 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240217 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240218 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240218 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240219 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240219 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240220 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240220 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240221 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240221 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240222 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240222 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240223 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240223 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240224 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240224 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240225 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240225 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240226 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240226 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240227 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240227 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240228 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240228 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240229 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240229 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |

      | 20240301    | Repayment                 | 33.72  | 33.33     | 0.39     | 0.0  | 0.0       | 33.53        | false    |
      | 20240301    | Buy Down Fee Adjustment   | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | true     |
      | 20240301    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Buy Down Fee Amortization | 0.22   | 0.0       | 0.22     | 0.0  | 0.0       | 0.0          | false    |
      | 20240302    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240302    | Buy Down Fee Amortization | 0.88   | 0.0       | 0.88     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE_ADJUSTMENT" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            |       | 10.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 10.0  |        |
      | EXPENSE   | 450280       | Buy Down Expense            | 10.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 10.0   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 34.07            | 15.93                    | 0.0             | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240302"

    When Loan Pay-off is made on "20240303"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3887
  Scenario: Verify Buy Down Fee reversal - UC6
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan status will be "ACTIVE"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240101"
    # --- repayment on February,1 ---#
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 33.72 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 33.72 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0   | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |                  | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0   | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 33.72 | 0.0        | 0.0  | 67.45       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
# --- Run COB to amortize Buy Down Fee ---#
    When Admin sets the business date to "20240216"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 33.72 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0   | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |                  | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0   | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 33.72 | 0.0        | 0.0  | 67.45       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240117  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240117  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240118  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240118  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240119  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240119  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240120  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240120  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240121  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240121  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240122  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240122  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240123  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240123  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240124  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240124  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240127  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240127  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240128  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240128  | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240129  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240129  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240130  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240130  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240201 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240202 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240202 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240203 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240203 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240204 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240204 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240205 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240205 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240206 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240206 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240207 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240207 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240208 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240208 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240209 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240209 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240210 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240210 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240211 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240211 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240212 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240212 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240213 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240213 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240214 | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240214 | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240215 | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240215 | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240215"
# --- Reverse Buy Down Fee transaction ---#
#    When Admin sets the business date to "20240215"
    When Customer undo "1"th "Buy Down Fee" transaction made on "20240101"
    When Admin sets the business date to "20240217"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 33.72 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0   | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |                  | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0   | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 33.72 | 0.0        | 0.0  | 67.45       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                     | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                         | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee                         | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | true     |
      | 20240101  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Accrual                              | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Buy Down Fee Amortization            | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Accrual                              | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240117  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240117  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240118  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240118  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240119  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240119  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240120  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240120  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240121  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240121  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240122  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240122  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240123  | Accrual                              | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240123  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240124  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240124  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240127  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240127  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240128  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240128  | Buy Down Fee Amortization            | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240129  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240129  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240130  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240130  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Accrual                              | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240131  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                            | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240201 | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240202 | Accrual                              | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240202 | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240203 | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240203 | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240204 | Accrual                              | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240204 | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240205 | Accrual                              | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240205 | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240206 | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240206 | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240207 | Accrual                              | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240207 | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240208 | Accrual                              | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240208 | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240209 | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240209 | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240210 | Accrual                              | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240210 | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240211 | Accrual                              | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240211 | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240212 | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240212 | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240213 | Accrual                              | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240213 | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240214 | Accrual                              | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240214 | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240215 | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240215 | Buy Down Fee Amortization            | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240216 | Accrual                              | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240216 | Buy Down Fee Amortization Adjustment | 25.27  | 0.0       | 25.27    | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
      | EXPENSE   | 450280       | Buy Down Expense            |       | 50.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 50.0  |        |
    And LoanBuyDownFeeAmortizationAdjustmentTransactionCreatedBusinessEvent is created on "20240216"

    When Loan Pay-off is made on "20240217"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3888
  Scenario: Verify Buy Down Fee reversal on same business date
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
# -- undo Buy Down Fee transaction at the same biz date when it was added -- #
    When Customer undo "1"th "Buy Down Fee" transaction made on "20240101"
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | true     |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
      | EXPENSE   | 450280       | Buy Down Expense            |       | 50.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 50.0  |        |

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3889
  Scenario: Verify Buy Down Fee reversal forbidden when adjustment exists
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan status will be "ACTIVE"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240101"
# --- Add Buy Down Fee Adjustment ---#
    When Admin sets the business date to "20240110"
    And Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20240110" with "10" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Buy Down Fee Adjustment   | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE_ADJUSTMENT" transaction with date "20240110" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            |       | 10.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 10.0  |        |
    And LoanBuyDownFeeAdjustmentTransactionCreatedBusinessEvent is created on "20240110"
# --- Verify that Buy Down Fee reversal is forbidden due to existing adjustment ---#
    Then Customer is forbidden to undo "1"th "Buy Down Fee" transaction made on "20240101" due to adjustment exists
# --- Reverse Buy Down Fee Adjustment first ---#
    When Customer undo "1"th "Buy Down Fee Adjustment" transaction made on "20240110"
    When Admin sets the business date to "20240111"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Buy Down Fee Adjustment   | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | true     |
      | 20240110  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE_ADJUSTMENT" transaction with date "20240110" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            |       | 10.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 10.0  |        |
      | EXPENSE   | 450280       | Buy Down Expense            | 10.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 10.0   |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240110"
# --- Now Buy Down Fee reversal should be allowed ---#
    When Customer undo "1"th "Buy Down Fee" transaction made on "20240101"
    When Admin sets the business date to "20240112"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                     | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                         | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee                         | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | true     |
      | 20240101  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Accrual                              | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Buy Down Fee Adjustment              | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | true     |
      | 20240110  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Buy Down Fee Amortization            | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Buy Down Fee Amortization Adjustment | 5.49   | 0.0       | 5.49     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
    And LoanBuyDownFeeAmortizationAdjustmentTransactionCreatedBusinessEvent is created on "20240111"

    When Loan Pay-off is made on "20240112"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3981
  Scenario: Verify loan with Buy Down fees and full payment for non-merchant - UC1
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES_NON_MERCHANT | 20240101    | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | LIABILITY | 145023       | Suspense/Clearing account   | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 33.72 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment        | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
    When Admin sets the business date to "20240301"
    And Customer makes "AUTOPAY" repayment on "20240301" with 33.72 EUR transaction amount
    When Admin sets the business date to "20240401"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240401" with 33.73 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240301    | Repayment                 | 33.72  | 33.33     | 0.39     | 0.0  | 0.0       | 33.53        | false    |
      | 20240331    | Accrual                   | 1.16   | 0.0       | 1.16     | 0.0  | 0.0       | 0.0          | false    |
      | 20240331    | Buy Down Fee Amortization | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Repayment                 | 33.73  | 33.53     | 0.2      | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE_AMORTIZATION" transaction with date "20240331" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 50.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 50.0  |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 50.0             | 0.0                      | 0.0             | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240331"

  @TestRailId:C3982
  Scenario: Verify Buy Down Fee reversal on same business date for non-merchant - UC2
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES_NON_MERCHANT | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
# -- undo Buy Down Fee transaction at the same biz date when it was added -- #
    When Customer undo "1"th "Buy Down Fee" transaction made on "20240101"
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | true     |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | LIABILITY | 145023       | Suspense/Clearing account   | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
      | LIABILITY | 145023       | Suspense/Clearing account   |       | 50.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 50.0  |        |
    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3983
  Scenario: Verify loan with Buy Down fees and undo the charge-off transaction for non merchant - amortization in case of loan charge-off event is also reversed - UC3.1
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES_NON_MERCHANT | 20240101    | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | LIABILITY | 145023       | Suspense/Clearing account   | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
# --- charge-off ---#
    When Admin sets the business date to "20240201"
    And Admin does charge-off the loan on "20240201"
    Then Loan status will be "ACTIVE"
    And Loan marked as charged-off on "20240201"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240201" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable           |        | 100.0  |
      | ASSET     | 112603       | Interest/Fee Receivable    |        |  1.17  |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt       | 100.0  |        |
      | INCOME    | 404001       | Interest Income Charge Off |  1.17  |        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee Amortization | 17.58  | 0.0       | 17.58    | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Accrual                   | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Charge-off                | 101.17 | 100.0     | 1.17     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee Amortization | 32.42  | 0.0       | 32.42    | 0.0  | 0.0       | 0.0          | false    |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 17.58            | 0.0                      | 0.0             | 32.42              |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240201"
# --- check BDFA journal entries for before and after charge-off trn processed --- #
    And Loan Transactions tab has 2 a "BUY_DOWN_FEE_AMORTIZATION" transactions with date "20240201" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 17.58  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 17.58 |        |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt        |       | 32.42  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 32.42 |        |
# --- charge-off undo ---#
    Then Admin does a charge-off undo the loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee Amortization | 17.58  | 0.0       | 17.58    | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Accrual                   | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Charge-off                | 101.17 | 100.0     | 1.17     | 0.0  | 0.0       | 0.0          | true     |
    And Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240201" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable           |        | 100.0  |
      | ASSET     | 112603       | Interest/Fee Receivable    |        |  1.17  |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt       | 100.0  |        |
      | INCOME    | 404001       | Interest Income Charge Off |  1.17  |        |
      | ASSET     | 112601       | Loans Receivable           | 100.0  |        |
      | ASSET     | 112603       | Interest/Fee Receivable    |  1.17  |        |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt       |        | 100.0  |
      | INCOME    | 404001       | Interest Income Charge Off |        | 1.17   |
    And Loan Transactions tab has 1 a "BUY_DOWN_FEE_AMORTIZATION" transactions with date "20240201" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 17.58  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 17.58 |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 17.58            | 32.42                    | 0.0             | 0.0                |

    When Loan Pay-off is made on "20240201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3984
  Scenario: Verify loan with Buy Down fees and undo the charge-off a fraud loan for non-merchant - amortization in case of loan charge-off event is also reversed - UC3.2
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES_NON_MERCHANT | 20240101    | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | LIABILITY | 145023       | Suspense/Clearing account   | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    Then Admin can successfully set Fraud flag to the loan
# --- charge-off ---#
    When Admin sets the business date to "20240201"
    And Admin does charge-off the loan on "20240201"
    Then Loan status will be "ACTIVE"
    And Loan marked as charged-off on "20240201"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240201" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable           |        | 100.0  |
      | ASSET     | 112603       | Interest/Fee Receivable    |        |  1.17  |
      | EXPENSE   | 744037       | Credit Loss/Bad Debt-Fraud | 100.0  |        |
      | INCOME    | 404001       | Interest Income Charge Off |  1.17  |        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee Amortization | 17.58  | 0.0       | 17.58    | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Accrual                   | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Charge-off                | 101.17 | 100.0     | 1.17     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee Amortization | 32.42  | 0.0       | 32.42    | 0.0  | 0.0       | 0.0          | false    |
# --- check BDFA journal entries for before and after charge-off trn processed --- #
    And Loan Transactions tab has 2 a "BUY_DOWN_FEE_AMORTIZATION" transactions with date "20240201" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 17.58  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 17.58 |        |
      | EXPENSE   | 744037       | Credit Loss/Bad Debt-Fraud  |       | 32.42  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 32.42 |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 17.58            | 0.0                      | 0.0             | 32.42              |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240201"
# --- charge-off undo ---#
    Then Admin does a charge-off undo the loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Buy Down Fee Amortization | 17.58  | 0.0       | 17.58    | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Accrual                   | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Charge-off                | 101.17 | 100.0     | 1.17     | 0.0  | 0.0       | 0.0          | true     |
    And Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240201" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable           |        | 100.0  |
      | ASSET     | 112603       | Interest/Fee Receivable    |        |  1.17  |
      | EXPENSE   | 744037       | Credit Loss/Bad Debt-Fraud | 100.0  |        |
      | INCOME    | 404001       | Interest Income Charge Off |  1.17  |        |
      | ASSET     | 112601       | Loans Receivable           | 100.0  |        |
      | ASSET     | 112603       | Interest/Fee Receivable    |  1.17  |        |
      | EXPENSE   | 744037       | Credit Loss/Bad Debt-Fraud |        | 100.0  |
      | INCOME    | 404001       | Interest Income Charge Off |        | 1.17   |
    And Loan Transactions tab has 1 a "BUY_DOWN_FEE_AMORTIZATION" transactions with date "20240201" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 17.58  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 17.58 |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 17.58            | 32.42                    | 0.0             | 0.0                |
    When Loan Pay-off is made on "20240201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3985
  Scenario: Verify loan with Buy Down fees and undo the charge-off transaction with "delinquent" reason for non-merchant - amortization in case of loan charge-off event is also reversed - UC3.3
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                             | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES_NON_MERCHANT_CHARGE_OFF_REASON | 20240101    | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | LIABILITY | 145023       | Suspense/Clearing account   | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    Then Admin can successfully set Fraud flag to the loan
    When Admin sets the business date to "20240125"
    And Admin does charge-off the loan with reason "DELINQUENT" on "20240125"
    And Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240125" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable           |        | 100.0  |
      | ASSET     | 112603       | Interest/Fee Receivable    |        |  1.17  |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt       | 100.0  |        |
      | INCOME    | 404001       | Interest Income Charge Off |  1.17  |        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Buy Down Fee Amortization | 13.74  | 0.0       | 13.74    | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Accrual                   | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Charge-off                | 101.17 | 100.0     | 1.17     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Buy Down Fee Amortization | 36.26  | 0.0       | 36.26    | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has 2 a "BUY_DOWN_FEE_AMORTIZATION" transactions with date "20240125" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 13.74  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 13.74 |        |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt        |       | 36.26  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 36.26 |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 13.74            | 0.0                      | 0.0             | 36.26              |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240125"
    Then Admin does a charge-off undo the loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Buy Down Fee Amortization | 13.74  | 0.0       | 13.74    | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Accrual                   | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20240125  | Charge-off                | 101.17 | 100.0     | 1.17     | 0.0  | 0.0       | 0.0          | true     |
    And Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240125" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable           |        | 100.0  |
      | ASSET     | 112603       | Interest/Fee Receivable    |        |  1.17  |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt       | 100.0  |        |
      | INCOME    | 404001       | Interest Income Charge Off |  1.17  |        |
      | ASSET     | 112601       | Loans Receivable           | 100.0  |        |
      | ASSET     | 112603       | Interest/Fee Receivable    |  1.17  |        |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt       |        | 100.0  |
      | INCOME    | 404001       | Interest Income Charge Off |        | 1.17   |
    And Loan Transactions tab has 1 a "BUY_DOWN_FEE_AMORTIZATION" transactions with date "20240125" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 13.74  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 13.74 |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 13.74            | 36.26                    | 0.0             | 0.0                |
    When Loan Pay-off is made on "20240125"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:С3986
  Scenario: Verify loan with Buy Down Fee adjustment trn and repayment trns for non-merchant - UC4
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES_NON_MERCHANT | 20240101    | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | LIABILITY | 145023       | Suspense/Clearing account   | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
# --- 1st repayment on February,1 ---#
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 33.72 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 33.72 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0   | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |                  | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0   | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 33.72 | 0.0        | 0.0  | 67.45       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment        | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
# --- BuyDownFee Adjustment trns on March,1 ---#
    When Admin sets the business date to "20240301"
    And Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20240301" with "10" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 33.72 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0   | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |                  | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0   | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 33.72 | 0.0        | 0.0  | 67.45       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement            | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee            | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment               | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240301    | Buy Down Fee Adjustment | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE_ADJUSTMENT" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | LIABILITY | 145023       | Suspense/Clearing account   |       | 10.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 10.0  |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 40.0                     | 10.0            | 0.0                |
    And LoanBuyDownFeeAdjustmentTransactionCreatedBusinessEvent is created on "20240301"
# --- 2nd repayment on April,1 ---#
    When Admin sets the business date to "20240401"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240401" with 33.73 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240301    | Buy Down Fee Adjustment   | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240331    | Accrual                   | 1.35   | 0.0       | 1.35     | 0.0  | 0.0       | 0.0          | false    |
      | 20240331    | Buy Down Fee Amortization | 40.0   | 0.0       | 40.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Repayment                 | 33.73  | 33.34     | 0.39     | 0.0  | 0.0       | 33.52        | false    |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 40.0             | 0.0                      | 10.0            | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240331"
    When Loan Pay-off is made on "20240401"
    Then Loan's all installments have obligations met
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240301    | Buy Down Fee Adjustment   | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240331    | Accrual                   | 1.35   | 0.0       | 1.35     | 0.0  | 0.0       | 0.0          | false    |
      | 20240331    | Buy Down Fee Amortization | 40.0   | 0.0       | 40.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Repayment                 | 33.73  | 33.34     | 0.39     | 0.0  | 0.0       | 33.52        | false    |
      | 20240401    | Repayment                 | 33.91  | 33.52     | 0.39     | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |

# --- BuyDownFee Adjustment reversal on March,1 ---#
    When Customer undo "1"th "Buy Down Fee Adjustment" transaction made on "20240301"
    When Admin sets the business date to "20240403"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240301    | Buy Down Fee Adjustment   | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | true     |
      | 20240331    | Accrual                   | 1.35   | 0.0       | 1.35     | 0.0  | 0.0       | 0.0          | false    |
      | 20240331    | Buy Down Fee Amortization | 40.0   | 0.0       | 40.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Repayment                 | 33.73  | 33.34     | 0.39     | 0.0  | 0.0       | 33.52        | false    |
      | 20240401    | Repayment                 | 33.91  | 33.52     | 0.39     | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE_ADJUSTMENT" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | LIABILITY | 145023       | Suspense/Clearing account   |       | 10.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 10.0  |        |
      | LIABILITY | 145023       | Suspense/Clearing account   | 10.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 10.0   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 50.0             | 0.0                      | 0.0             | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240401"

  @TestRailId:C4004
  Scenario: Verify buy down fee transaction creation with classification field set
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount and "buydown_fee_transaction_classification_value" classification
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Loan Transactions tab has a "Buy Down Fee" transaction with date "20240101" which has classification code value "buydown_fee_transaction_classification_value"
    And Buy down fee contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    And Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20240101" with "25" EUR transaction amount
    And Loan Transactions tab has a "Buy Down Fee Adjustment" transaction with date "20240101" which has classification code value "buydown_fee_transaction_classification_value"

    When Loan Pay-off is made on "20240101"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4009
  Scenario: Verify Buy Down Fee amortization allocation mappings
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101   | 250            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "250" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | EXPENSE   | 450280       | Buy Down Expense             | 50.0   |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 50.0   |
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240102" with "100" EUR transaction amount
    When Admin sets the business date to "20240103"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee              | 100.0  | 0.0       | 100.0    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee Amortization | 1.66   | 0.0       | 1.66     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240101" contains the following data:
      | Date            | Type | Amount |
      | 20240101 | AM   | 0.55   |
      | 20240102 | AM   | 0.55   |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240102" contains the following data:
      | Date            | Type | Amount |
      | 20240102 | AM   | 1.11   |

    When Loan Pay-off is made on "20240103"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4019
  Scenario: Verify Buy Down Fee amortization allocation mappings when buy down fee transaction is reversed
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101   | 350            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "350" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | EXPENSE   | 450280       | Buy Down Expense             | 50.0   |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 50.0   |
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240102" with "200" EUR transaction amount
    When Admin sets the business date to "20240103"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee              | 200.0  | 0.0       | 200.0    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee Amortization | 2.77   | 0.0       | 2.77     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240101" contains the following data:
      | Date            | Type | Amount |
      | 20240101 | AM   | 0.55   |
      | 20240102 | AM   | 0.55   |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240102" contains the following data:
      | Date            | Type | Amount |
      | 20240102 | AM   | 2.22   |
    When Customer undo "1"th "Buy Down Fee" transaction made on "20240101"
    When Admin sets the business date to "20240104"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee              | 200.0  | 0.0       | 200.0    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee Amortization | 2.77   | 0.0       | 2.77     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Buy Down Fee Amortization | 1.12   | 0.0       | 1.12     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240101" contains the following data:
      | Date            | Type   | Amount |
      | 20240101 | AM     | 0.55   |
      | 20240102 | AM     | 0.55   |
      | 20240103 | AM_ADJ | 1.1    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240102" contains the following data:
      | Date            | Type | Amount |
      | 20240102 | AM   | 2.22   |
      | 20240103 | AM   | 2.22   |
    When Admin sets the business date to "20240105"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee              | 200.0  | 0.0       | 200.0    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee Amortization | 2.77   | 0.0       | 2.77     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Buy Down Fee Amortization | 1.12   | 0.0       | 1.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Buy Down Fee Amortization | 2.23   | 0.0       | 2.23     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240101" contains the following data:
      | Date            | Type   | Amount |
      | 20240101 | AM     | 0.55   |
      | 20240102 | AM     | 0.55   |
      | 20240103 | AM_ADJ | 1.1    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240102" contains the following data:
      | Date            | Type | Amount |
      | 20240102 | AM   | 2.22   |
      | 20240103 | AM   | 2.22   |
      | 20240104 | AM   | 2.23   |

    When Loan Pay-off is made on "20240105"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4022
  Scenario: Verify Buy Down Fee amortization allocation mappings when buy down fee adjustment occurs
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101   | 350            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "350" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | EXPENSE   | 450280       | Buy Down Expense             | 50.0   |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 50.0   |
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240102" with "100" EUR transaction amount
    When Admin sets the business date to "20240103"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee              | 100.0  | 0.0       | 100.0    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee Amortization | 1.66   | 0.0       | 1.66     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240101" contains the following data:
      | Date            | Type | Amount |
      | 20240101 | AM   | 0.55   |
      | 20240102 | AM   | 0.55   |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240102" contains the following data:
      | Date            | Type | Amount |
      | 20240102 | AM   | 1.11   |
    When Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20240102" with "40" EUR transaction amount
    When Admin sets the business date to "20240104"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee              | 100.0  | 0.0       | 100.0    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee Amortization | 1.66   | 0.0       | 1.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee Adjustment   | 40.0   | 0.0       | 40.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Buy Down Fee Amortization | 0.77   | 0.0       | 0.77     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240101" contains the following data:
      | Date            | Type   | Amount |
      | 20240101 | AM     | 0.55   |
      | 20240102 | AM     | 0.55   |
      | 20240103 | AM_ADJ | 0.34   |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240102" contains the following data:
      | Date            | Type | Amount |
      | 20240102 | AM   | 1.11   |
      | 20240103 | AM   | 1.11   |
    When Admin sets the business date to "20240105"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240101  | Buy Down Fee Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee              | 100.0  | 0.0       | 100.0    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee Amortization | 1.66   | 0.0       | 1.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee Adjustment   | 40.0   | 0.0       | 40.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Buy Down Fee Amortization | 0.77   | 0.0       | 0.77     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Buy Down Fee Amortization | 1.21   | 0.0       | 1.21     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240101" contains the following data:
      | Date            | Type   | Amount |
      | 20240101 | AM     | 0.55   |
      | 20240102 | AM     | 0.55   |
      | 20240103 | AM_ADJ | 0.34   |
      | 20240104 | AM     | 0.1    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240102" contains the following data:
      | Date            | Type | Amount |
      | 20240102 | AM   | 1.11   |
      | 20240103 | AM   | 1.11   |
      | 20240104 | AM   | 1.11   |
    And Admin adds buy down fee adjustment of buy down fee transaction made on "20240102" with "AUTOPAY" payment type to the loan on "20240104" with "60" EUR transaction amount
    When Admin sets the business date to "20240106"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                     | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                         | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Buy Down Fee                         | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240101  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee                         | 100.0  | 0.0       | 100.0    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee Amortization            | 1.66   | 0.0       | 1.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee Adjustment              | 40.0   | 0.0       | 40.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Buy Down Fee Amortization            | 0.77   | 0.0       | 0.77     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Buy Down Fee Amortization            | 1.21   | 0.0       | 1.21     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Buy Down Fee Adjustment              | 60.0   | 0.0       | 60.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Buy Down Fee Amortization Adjustment | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240101" contains the following data:
      | Date            | Type   | Amount |
      | 20240101 | AM     | 0.55   |
      | 20240102 | AM     | 0.55   |
      | 20240103 | AM_ADJ | 0.34   |
      | 20240104 | AM     | 0.1    |
      | 20240105 | AM     | 0.11   |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240102" contains the following data:
      | Date            | Type   | Amount |
      | 20240102 | AM     | 1.11   |
      | 20240103 | AM     | 1.11   |
      | 20240104 | AM     | 1.11   |
      | 20240105 | AM_ADJ | 0.25   |
    When Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20240105" with "10" EUR transaction amount
    When Admin sets the business date to "20240107"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                     | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                         | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Buy Down Fee                         | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240101  | Buy Down Fee Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee                         | 100.0  | 0.0       | 100.0    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee Amortization            | 1.66   | 0.0       | 1.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Buy Down Fee Adjustment              | 40.0   | 0.0       | 40.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Buy Down Fee Amortization            | 0.77   | 0.0       | 0.77     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Buy Down Fee Amortization            | 1.21   | 0.0       | 1.21     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Buy Down Fee Adjustment              | 60.0   | 0.0       | 60.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual                              | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Buy Down Fee Amortization Adjustment | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Buy Down Fee Adjustment              | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual                              | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Buy Down Fee Amortization Adjustment | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240101" contains the following data:
      | Date            | Type   | Amount |
      | 20240101 | AM     | 0.55   |
      | 20240102 | AM     | 0.55   |
      | 20240103 | AM_ADJ | 0.34   |
      | 20240104 | AM     | 0.1    |
      | 20240105 | AM     | 0.11   |
      | 20240106 | AM_ADJ | 0.97   |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240102" contains the following data:
      | Date            | Type   | Amount |
      | 20240102 | AM     | 1.11   |
      | 20240103 | AM     | 1.11   |
      | 20240104 | AM     | 1.11   |
      | 20240105 | AM_ADJ | 0.25   |
      | 20240106 | AM     | 0.43   |

    When Loan Pay-off is made on "20240107"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4040
  Scenario: Verify Buy Down Fee amortization allocation mapping when already amortized amount is greater than should be after buy down fee adjustment
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 30                | DAYS                  | 1              | DAYS                   | 30                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Admin runs inline COB job for Loan
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "1" EUR transaction amount
    When Admin sets the business date to "20240115"
    And Admin runs inline COB job for Loan
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240101" contains the following data:
      | Date            | Type   | Amount |
      | 20240101 | AM     | 0.03   |
      | 20240102 | AM     | 0.04   |
      | 20240103 | AM     | 0.03   |
      | 20240104 | AM     | 0.03   |
      | 20240105 | AM     | 0.04   |
      | 20240106 | AM     | 0.03   |
      | 20240107 | AM     | 0.03   |
      | 20240108 | AM     | 0.04   |
      | 20240109 | AM     | 0.03   |
      | 20240110 | AM     | 0.03   |
      | 20240111 | AM     | 0.04   |
      | 20240112 | AM     | 0.03   |
      | 20240113 | AM     | 0.03   |
      | 20240114 | AM     | 0.04   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 1.0        | 0.47             | 0.53                     | 0.0             | 0.0                |
    And Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20240115" with "0.7" EUR transaction amount
    When Admin sets the business date to "20240116"
    And Admin runs inline COB job for Loan
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240101" contains the following data:
      | Date            | Type   | Amount |
      | 20240101 | AM     | 0.03   |
      | 20240102 | AM     | 0.04   |
      | 20240103 | AM     | 0.03   |
      | 20240104 | AM     | 0.03   |
      | 20240105 | AM     | 0.04   |
      | 20240106 | AM     | 0.03   |
      | 20240107 | AM     | 0.03   |
      | 20240108 | AM     | 0.04   |
      | 20240109 | AM     | 0.03   |
      | 20240110 | AM     | 0.03   |
      | 20240111 | AM     | 0.04   |
      | 20240112 | AM     | 0.03   |
      | 20240113 | AM     | 0.03   |
      | 20240114 | AM     | 0.04   |
      | 20240115 | AM_ADJ | 0.17   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 1.0        | 0.3              | 0.0                      | 0.7             | 0.0                |
    When Admin sets the business date to "20240125"
    And Admin runs inline COB job for Loan
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240101" contains the following data:
      | Date            | Type   | Amount |
      | 20240101 | AM     | 0.03   |
      | 20240102 | AM     | 0.04   |
      | 20240103 | AM     | 0.03   |
      | 20240104 | AM     | 0.03   |
      | 20240105 | AM     | 0.04   |
      | 20240106 | AM     | 0.03   |
      | 20240107 | AM     | 0.03   |
      | 20240108 | AM     | 0.04   |
      | 20240109 | AM     | 0.03   |
      | 20240110 | AM     | 0.03   |
      | 20240111 | AM     | 0.04   |
      | 20240112 | AM     | 0.03   |
      | 20240113 | AM     | 0.03   |
      | 20240114 | AM     | 0.04   |
      | 20240115 | AM_ADJ | 0.17   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 1.0        | 0.3              | 0.0                      | 0.7             | 0.0                |

    When Loan Pay-off is made on "20240125"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4043
  Scenario: Verify Buy Down Fee amortization allocation mapping when after buy down fee adjustment and charge-off
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 30                | DAYS                  | 1              | DAYS                   | 30                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Admin runs inline COB job for Loan
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "1" EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 1.0    | 0.0       | 1.0      | 0.0  | 0.0       | 0.0          | false    |
    When Admin sets the business date to "20240115"
    And Admin runs inline COB job for Loan
    And Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20240115" with "0.3" EUR transaction amount
    When Admin sets the business date to "20240116"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 1.0    | 0.0       | 1.0      | 0.0  | 0.0       | 0.0          | false    |
      | 20240101  | Buy Down Fee Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Buy Down Fee Amortization | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Buy Down Fee Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Buy Down Fee Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Buy Down Fee Amortization | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Buy Down Fee Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Buy Down Fee Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Buy Down Fee Amortization | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Buy Down Fee Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Buy Down Fee Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Buy Down Fee Amortization | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Buy Down Fee Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Buy Down Fee Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Buy Down Fee Amortization | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Buy Down Fee Adjustment   | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Buy Down Fee Amortization | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240101" contains the following data:
      | Date            | Type | Amount |
      | 20240101 | AM   | 0.03   |
      | 20240102 | AM   | 0.04   |
      | 20240103 | AM   | 0.03   |
      | 20240104 | AM   | 0.03   |
      | 20240105 | AM   | 0.04   |
      | 20240106 | AM   | 0.03   |
      | 20240107 | AM   | 0.03   |
      | 20240108 | AM   | 0.04   |
      | 20240109 | AM   | 0.03   |
      | 20240110 | AM   | 0.03   |
      | 20240111 | AM   | 0.04   |
      | 20240112 | AM   | 0.03   |
      | 20240113 | AM   | 0.03   |
      | 20240114 | AM   | 0.04   |
      | 20240115 | AM   | 0.01   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 1.0        | 0.48             | 0.22                     | 0.3             | 0.0                |
    And Admin does charge-off the loan on "20240116"
    Then Loan status will be "ACTIVE"
    And Loan marked as charged-off on "20240116"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 1.0    | 0.0       | 1.0      | 0.0  | 0.0       | 0.0          | false    |
      | 20240101  | Buy Down Fee Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Buy Down Fee Amortization | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Buy Down Fee Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Buy Down Fee Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Buy Down Fee Amortization | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Buy Down Fee Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Buy Down Fee Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Buy Down Fee Amortization | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Buy Down Fee Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Buy Down Fee Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Buy Down Fee Amortization | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Buy Down Fee Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Buy Down Fee Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Buy Down Fee Amortization | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Buy Down Fee Adjustment   | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Buy Down Fee Amortization | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Buy Down Fee Amortization | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Charge-off                | 100.38 | 100.0     | 0.38     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Buy Down Fee Amortization | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240101" contains the following data:
      | Date            | Type | Amount |
      | 20240101 | AM   | 0.03   |
      | 20240102 | AM   | 0.04   |
      | 20240103 | AM   | 0.03   |
      | 20240104 | AM   | 0.03   |
      | 20240105 | AM   | 0.04   |
      | 20240106 | AM   | 0.03   |
      | 20240107 | AM   | 0.03   |
      | 20240108 | AM   | 0.04   |
      | 20240109 | AM   | 0.03   |
      | 20240110 | AM   | 0.03   |
      | 20240111 | AM   | 0.04   |
      | 20240112 | AM   | 0.03   |
      | 20240113 | AM   | 0.03   |
      | 20240114 | AM   | 0.04   |
      | 20240115 | AM   | 0.01   |
      | 20240116 | AM   | 0.02   |
      | 20240116 | AM   | 0.2    |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 1.0        | 0.5              | 0.0                      | 0.3             | 0.2                |

    When Loan Pay-off is made on "20240116"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4092
  Scenario: Verify GL entries for Buydown Fee Amortization - UC1: Amortization for Buydown fee with NO classification rule
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES_CLASSIFICATION_INCOME_MAP | 20240101   | 350            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "350" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    And Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Loan Transactions tab has a "BUY_DOWN_FEE_AMORTIZATION" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 0.55   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 0.55  |        |

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4093
  Scenario: Verify GL entries for Buydown Fee Amortization - UC2: Amortization for Buydown fee with classification rule: pending_bankruptcy
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES_CLASSIFICATION_INCOME_MAP | 20240101   | 350            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "350" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount and "buydown_fee_transaction_classification_value" classification
    And Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Loan Transactions tab has a "BUY_DOWN_FEE_AMORTIZATION" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 404007       | Fee Income                  |       | 0.55   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 0.55  |        |

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4094
  Scenario: Verify GL entries for Buydown Fee Amortization - UC3: Amortization for Buydown fees with NO classification and with classification rule: pending_bankruptcy
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES_CLASSIFICATION_INCOME_MAP | 20240101   | 350            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "350" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    And Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240102" with "20" EUR transaction amount and "buydown_fee_transaction_classification_value" classification
    And Admin sets the business date to "20240103"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Loan Transactions tab has a "BUY_DOWN_FEE_AMORTIZATION" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 0.55   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 0.55  |        |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 20.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 20.0   |
    And Loan Transactions tab has a "BUY_DOWN_FEE_AMORTIZATION" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 404007       | Fee Income                  |       | 0.22   |
      | INCOME    | 450281       | Income From Buy Down        |       | 0.55   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 0.77  |        |

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4116
  Scenario: Verify Buy Down Fee journal entries values when backdated new buy down fee with no classification and buy down fee adjustment for existing one with classification occurs on the same day
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES_CLASSIFICATION_INCOME_MAP | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount and "buydown_fee_transaction_classification_value" classification
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Loan Transactions tab has a "Buy Down Fee" transaction with date "20240101" which has classification code value "buydown_fee_transaction_classification_value"
    And Buy down fee contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    And Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20240101" with "25" EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240101  | Buy Down Fee Adjustment   | 25.0   | 0.0       | 25.0     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense             | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |       | 50.0   |
    And Loan Transactions tab has a "BUY_DOWN_FEE_ADJUSTMENT" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            |       | 25.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 25.0  |        |
    When Admin sets the business date to "20240415"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240101  | Buy Down Fee Adjustment   | 25.0   | 0.0       | 25.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Accrual                   | 1.55   | 0.0       | 1.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240414    | Buy Down Fee Amortization | 25.0   | 0.0       | 25.0     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE_AMORTIZATION" transaction with date "20240414" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 404007       | Fee Income                  |       | 25.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 25.0  |        |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240101" contains the following data:
      | Date          | Type | Amount |
      | 20240414 | AM   | 25.0   |
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "30" EUR transaction amount
    When Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20240101" with "5" EUR transaction amount
    When Admin sets the business date to "20240416"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240101  | Buy Down Fee Adjustment   | 25.0   | 0.0       | 25.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240101  | Buy Down Fee              | 30.0   | 0.0       | 30.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240101  | Buy Down Fee Adjustment   | 5.0    | 0.0       | 5.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Accrual                   | 1.55   | 0.0       | 1.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240414    | Buy Down Fee Amortization | 25.0   | 0.0       | 25.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240415    | Buy Down Fee Amortization | 25.0   | 0.0       | 25.0     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for the "1"th "BUY_DOWN_FEE" transaction created on "20240101" contains the following data:
      | Date          | Type   | Amount |
      | 20240414 | AM     | 25.0   |
      | 20240415 | AM_ADJ | 5.0    |
    And Loan Amortization Allocation Mapping for the "2"th "BUY_DOWN_FEE" transaction created on "20240101" contains the following data:
      | Date          | Type   | Amount |
      | 20240415 | AM     | 30.0   |
    And Loan Transactions tab has a "BUY_DOWN_FEE_AMORTIZATION" transaction with date "20240415" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 30.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 5.0    |
      | LIABILITY | 145024       | Deferred Capitalized Income | 30.0  |        |
      | INCOME    | 404007       | Fee Income                  | 5.0   |        |

    When Loan Pay-off is made on "20240416"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4117
  Scenario: Verify Buy Down Fee journal entries values when backdated new buy down fee and buy down fee adjustment for existing one occurs on the same day, no classification
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    And Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20240101" with "25" EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240101  | Buy Down Fee Adjustment   | 25.0   | 0.0       | 25.0     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense             | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |       | 50.0   |
    And Loan Transactions tab has a "BUY_DOWN_FEE_ADJUSTMENT" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            |       | 25.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 25.0  |        |
    When Admin sets the business date to "20240415"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240101  | Buy Down Fee Adjustment   | 25.0   | 0.0       | 25.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Accrual                   | 1.55   | 0.0       | 1.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240414    | Buy Down Fee Amortization | 25.0   | 0.0       | 25.0     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE_AMORTIZATION" transaction with date "20240414" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 25.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 25.0  |        |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20240101" contains the following data:
      | Date          | Type | Amount |
      | 20240414 | AM   | 25.0   |
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "30" EUR transaction amount
    When Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20240101" with "5" EUR transaction amount
    When Admin sets the business date to "20240416"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240101  | Buy Down Fee Adjustment   | 25.0   | 0.0       | 25.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240101  | Buy Down Fee              | 30.0   | 0.0       | 30.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240101  | Buy Down Fee Adjustment   | 5.0    | 0.0       | 5.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Accrual                   | 1.55   | 0.0       | 1.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240414    | Buy Down Fee Amortization | 25.0   | 0.0       | 25.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240415    | Buy Down Fee Amortization | 25.0   | 0.0       | 25.0     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for the "1"th "BUY_DOWN_FEE" transaction created on "20240101" contains the following data:
      | Date          | Type   | Amount |
      | 20240414 | AM     | 25.0   |
      | 20240415 | AM_ADJ | 5.0    |
    And Loan Amortization Allocation Mapping for the "2"th "BUY_DOWN_FEE" transaction created on "20240101" contains the following data:
      | Date          | Type   | Amount |
      | 20240415 | AM     | 30.0   |
    And Loan Transactions tab has a "BUY_DOWN_FEE_AMORTIZATION" transaction with date "20240415" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 30.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 5.0    |
      | LIABILITY | 145024       | Deferred Capitalized Income | 30.0  |        |
      | INCOME    | 450281       | Income From Buy Down        | 5.0   |        |

    When Loan Pay-off is made on "20240416"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met



    ##
  ## ISSUE:   Buydown amortizes slower after waiver-reversal
  @TestRailId:CXXXX
  Scenario Outline: Verify Buy Down Fee Amortization Works correctly after Buy Down Fee Adjustment Reversal
    ##Create and disburse a loan for 3-month period with buydown fees enabled (2026/03/11).
    When Admin sets the business date to "20260311"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | <loanProduct> | 20260311     | 1500           | 9.99                   | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260311" with "1500" amount and expected disbursement date on "20260311"
    And Admin successfully disburse the loan on "20260311" with "1500" EUR transaction amount
    Then Loan status will be "ACTIVE"

    ##Add 2 buydown fees transactions with the same amount (300 each).
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20260311" with "300" EUR transaction amount
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20260311" with "300" EUR transaction amount

    ##Run COB until 2026/04/11.
    When Admin sets the business date to "20260312"
    Then Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following new buy down fee amortization data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260311    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Admin sets the business date to "20260412"
    Then Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following new buy down fee amortization data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260312    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260313    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260314    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260315    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260316    | Buy Down Fee Amortization | 6.54   | 0.0       | 6.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260317    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260318    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260319    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260320    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260321    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260322    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260323    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260324    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260325    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260326    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260327    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260328    | Buy Down Fee Amortization | 6.54   | 0.0       | 6.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260329    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260330    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260331    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260401    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260402    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260403    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260404    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260405    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260406    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260407    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260408    | Buy Down Fee Amortization | 6.54   | 0.0       | 6.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260409    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260410    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260411    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |

    ##Waive the first buydown fees (2026/04/12). ( Buydown Fee Adjustment )
    Then Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20260412" with "300" EUR transaction amount
    When Admin sets the business date to "20260413"

    ##Run COB - This creates a buydown amortization adjustment (127.55)
    Then Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following new buy down fee amortization data:
      | Transaction date | Transaction Type                     | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260412    | Buy Down Fee Amortization Adjustment | 101.09 | 0.0       | 101.09   | 0.0  | 0.0       | 0.0          | false    | false    |

    ##Reverse the waiver from Step 4 (2026/04/13)
    When Customer undo "1"th "Buy Down Fee Adjustment" transaction made on "20260412"

    ##ISSUE: Run COB - This creates a buydown amortization much lower than adjustment amount in step 5 (86.07)
    When Admin sets the business date to "20260414"
    Then Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following new buy down fee amortization data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260413    | Buy Down Fee Amortization | 114.13 | 0.0       | 114.13   | 0.0  | 0.0       | 0.0          | false    | false    |

    ##ISSUE: Run COB for following day as well - This creates amortization of 4.92, which is lower than the previous amount of 6.52 before waiver.
    When Admin sets the business date to "20260612"
    Then Admin runs inline COB job for Loan

    Examples:
      | loanProduct |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES_CHARGE_OFF_REASON |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES_NON_MERCHANT_CHARGE_OFF_REASON |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES_NON_MERCHANT |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES_CLASSIFICATION_INCOME_MAP |

  @TestRailId:C85357
  Scenario: Verify Buy Down Fee Amortization Works correctly after Buy Down Fee Adjustment Reversal buydown fee as fee
    ##Create and disburse a loan for 3-month period with buydown fees enabled (2026/03/11).
    When Admin sets the business date to "20260311"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES_FEE_INCOME | 20260311     | 1500           | 9.99                   | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260311" with "1500" amount and expected disbursement date on "20260311"
    And Admin successfully disburse the loan on "20260311" with "1500" EUR transaction amount
    Then Loan status will be "ACTIVE"

    ##Add 2 buydown fees transactions with the same amount (300 each).
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20260311" with "300" EUR transaction amount
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20260311" with "300" EUR transaction amount

    ##Run COB until 2026/04/11.
    When Admin sets the business date to "20260312"
    Then Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following new buy down fee amortization data:
      | Transaction date | Transaction Type          | Amount | Principal | Fees | Interest | Penalties | Loan Balance | Reverted | Replayed |
      | 20260311    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Admin sets the business date to "20260412"
    Then Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following new buy down fee amortization data:
      | Transaction date | Transaction Type          | Amount | Principal | Fees | Interest | Penalties | Loan Balance | Reverted | Replayed |
      | 20260312    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260313    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260314    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260315    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260316    | Buy Down Fee Amortization | 6.54   | 0.0       | 6.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260317    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260318    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260319    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260320    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260321    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260322    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260323    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260324    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260325    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260326    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260327    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260328    | Buy Down Fee Amortization | 6.54   | 0.0       | 6.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260329    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260330    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260331    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260401    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260402    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260403    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260404    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260405    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260406    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260407    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260408    | Buy Down Fee Amortization | 6.54   | 0.0       | 6.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260409    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260410    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260411    | Buy Down Fee Amortization | 6.52   | 0.0       | 6.52     | 0.0  | 0.0       | 0.0          | false    | false    |

    ##Waive the first buydown fees (2026/04/12). ( Buydown Fee Adjustment )
    Then Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20260412" with "300" EUR transaction amount
    When Admin sets the business date to "20260413"

    ##Run COB - This creates a buydown amortization adjustment (127.55)
    Then Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following new buy down fee amortization data:
      | Transaction date | Transaction Type                     | Amount | Principal | Fees | Interest | Penalties | Loan Balance | Reverted | Replayed |
      | 20260412    | Buy Down Fee Amortization Adjustment | 101.09 | 0.0       | 101.09   | 0.0  | 0.0       | 0.0          | false    | false    |

    ##Reverse the waiver from Step 4 (2026/04/13)
    When Customer undo "1"th "Buy Down Fee Adjustment" transaction made on "20260412"

    ##ISSUE: Run COB - This creates a buydown amortization much lower than adjustment amount in step 5 (86.07)
    When Admin sets the business date to "20260414"
    Then Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following new buy down fee amortization data:
      | Transaction date | Transaction Type          | Amount | Principal | Fees | Interest | Penalties | Loan Balance | Reverted | Replayed |
      | 20260413    | Buy Down Fee Amortization | 114.13 | 0.0       | 114.13   | 0.0  | 0.0       | 0.0          | false    | false    |

    ##ISSUE: Run COB for following day as well - This creates amortization of 4.92, which is lower than the previous amount of 6.52 before waiver.
    When Admin sets the business date to "20260612"
    Then Admin runs inline COB job for Loan

  @TestRailId:C85358
  Scenario: Verify loan with Buy Down fees as FEE income type and full payment
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES_FEE_INCOME | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 0.0      | 50.0 | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 33.72 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 0.0      | 50.0 | 0.0       | 0.0          | false    |
      | 20240201 | Repayment        | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
    When Admin sets the business date to "20240301"
    And Customer makes "AUTOPAY" repayment on "20240301" with 33.72 EUR transaction amount
    When Admin sets the business date to "20240401"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240401" with 33.73 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 0.0      | 50.0 | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240301    | Repayment                 | 33.72  | 33.33     | 0.39     | 0.0  | 0.0       | 33.53        | false    |
      | 20240331    | Accrual                   | 1.16   | 0.0       | 1.16     | 0.0  | 0.0       | 0.0          | false    |
      | 20240331    | Buy Down Fee Amortization | 50.0   | 0.0       | 0.0      | 50.0 | 0.0       | 0.0          | false    |
      | 20240401    | Repayment                 | 33.73  | 33.53     | 0.2      | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 50.0             | 0.0                      | 0.0             | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240331"

  @TestRailId:C85359
  Scenario: Verify loan with Buy Down Fee adjustment as FEE income type and repayment transactions
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES_FEE_INCOME | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |           | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0  | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |           | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0  | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 0.0  | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 0.0      | 50.0 | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    And LoanBuyDownFeeTransactionCreatedBusinessEvent is created on "20240101"
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 33.72 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 33.72 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0   | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |                  | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0   | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 33.72 | 0.0        | 0.0  | 67.45       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee     | 50.0   | 0.0       | 0.0      | 50.0 | 0.0       | 0.0          | false    |
      | 20240201 | Repayment        | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
    When Admin sets the business date to "20240301"
    And Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20240301" with "10" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 33.72 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0   | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |                  | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0   | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 33.72 | 0.0        | 0.0  | 67.45       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement            | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee            | 50.0   | 0.0       | 0.0      | 50.0 | 0.0       | 0.0          | false    |
      | 20240201 | Repayment               | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240301    | Buy Down Fee Adjustment | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "BUY_DOWN_FEE_ADJUSTMENT" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | EXPENSE   | 450280       | Buy Down Expense            |       | 10.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 10.0  |        |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 0.0              | 40.0                     | 10.0            | 0.0                |
    And LoanBuyDownFeeAdjustmentTransactionCreatedBusinessEvent is created on "20240301"
    When Admin sets the business date to "20240401"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240401" with 33.73 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 0.0      | 50.0 | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240301    | Buy Down Fee Adjustment   | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          | false    |
      | 20240331    | Accrual                   | 1.35   | 0.0       | 1.35     | 0.0  | 0.0       | 0.0          | false    |
      | 20240331    | Buy Down Fee Amortization | 40.0   | 0.0       | 0.0      | 40.0 | 0.0       | 0.0          | false    |
      | 20240401    | Repayment                 | 33.73  | 33.34     | 0.39     | 0.0  | 0.0       | 33.52        | false    |
    And Buy down fee by external-id contains the following data:
      | Date            | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20240101 | 50.0       | 40.0             | 0.0                      | 10.0            | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20240331"
    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Buy Down Fee              | 50.0   | 0.0       | 0.0      | 50.0 | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                 | 33.72  | 33.14     | 0.58     | 0.0  | 0.0       | 66.86        | false    |
      | 20240301    | Buy Down Fee Adjustment   | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          | false    |
      | 20240331    | Accrual                   | 1.35   | 0.0       | 1.35     | 0.0  | 0.0       | 0.0          | false    |
      | 20240331    | Buy Down Fee Amortization | 40.0   | 0.0       | 0.0      | 40.0 | 0.0       | 0.0          | false    |
      | 20240401    | Repayment                 | 33.73  | 33.34     | 0.39     | 0.0  | 0.0       | 33.52        | false    |
      | 20240401    | Repayment                 | 33.91  | 33.52     | 0.39     | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Accrual                   | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |

  @TestRailId:C85355
  Scenario: Verify Buy Down Fee amortization allocation mappings after loan re-open via repayment reversal
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20260101   | 250            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260101" with "250" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the loan on "20260101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20260101" with "50" EUR transaction amount
    When Admin sets the business date to "20260102"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260101  | Buy Down Fee Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20260101" contains the following data:
      | Date            | Type | Amount |
      | 20260101 | AM   | 0.56   |
    When Admin sets the business date to "20260103"
    When Loan Pay-off is made on "20260103"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260101  | Buy Down Fee Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Repayment                 | 100.04 | 100.0     | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Accrual                   | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Buy Down Fee Amortization | 49.44  | 0.0       | 49.44    | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20260101" contains the following data:
      | Date            | Type | Amount |
      | 20260101 | AM   | 0.56   |
      | 20260103 | AM   | 49.44  |
    When Customer undo "1"th "Repayment" transaction made on "20260103"
    Then Loan status will be "ACTIVE"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260101  | Buy Down Fee Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Repayment                 | 100.04 | 100.0     | 0.04     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20260103  | Accrual                   | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Buy Down Fee Amortization | 49.44  | 0.0       | 49.44    | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20260104"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260101  | Buy Down Fee Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Repayment                 | 100.04 | 100.0     | 0.04     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20260103  | Accrual                   | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Buy Down Fee Amortization | 49.44  | 0.0       | 49.44    | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20260101" contains the following data:
      | Date            | Type | Amount |
      | 20260101 | AM   | 0.56   |
      | 20260103 | AM   | 49.44  |
    When Admin sets the business date to "20260105"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260101  | Buy Down Fee Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Repayment                 | 100.04 | 100.0     | 0.04     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20260103  | Accrual                   | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Buy Down Fee Amortization | 49.44  | 0.0       | 49.44    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260104  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20260101" contains the following data:
      | Date            | Type | Amount |
      | 20260101 | AM   | 0.56   |
      | 20260103 | AM   | 49.44  |

    When Loan Pay-off is made on "20260105"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C85356
  Scenario: Verify Buy Down Fee amortization allocation mappings after loan re-open via payout refund reversal
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20260101   | 250            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260101" with "250" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the loan on "20260101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20260101" with "50" EUR transaction amount
    When Admin sets the business date to "20260102"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260101  | Buy Down Fee Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20260101" contains the following data:
      | Date            | Type | Amount |
      | 20260101 | AM   | 0.56   |
    When Admin sets the business date to "20260103"
    And Customer makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20260103" with 100.04 EUR transaction amount and self-generated Idempotency key
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260101  | Buy Down Fee Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Payout Refund             | 100.04 | 100.0     | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Accrual                   | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Buy Down Fee Amortization | 49.44  | 0.0       | 49.44    | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20260101" contains the following data:
      | Date            | Type | Amount |
      | 20260101 | AM   | 0.56   |
      | 20260103 | AM   | 49.44  |
    When Customer undo "1"th "Payout Refund" transaction made on "20260103"
    Then Loan status will be "ACTIVE"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260101  | Buy Down Fee Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Payout Refund             | 100.04 | 100.0     | 0.04     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20260103  | Accrual                   | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Buy Down Fee Amortization | 49.44  | 0.0       | 49.44    | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20260104"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260101  | Buy Down Fee Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Payout Refund             | 100.04 | 100.0     | 0.04     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20260103  | Accrual                   | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Buy Down Fee Amortization | 49.44  | 0.0       | 49.44    | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20260101" contains the following data:
      | Date            | Type | Amount |
      | 20260101 | AM   | 0.56   |
      | 20260103 | AM   | 49.44  |
    When Admin sets the business date to "20260105"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260101  | Disbursement              | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260101  | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260101  | Buy Down Fee Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Payout Refund             | 100.04 | 100.0     | 0.04     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20260103  | Accrual                   | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Buy Down Fee Amortization | 49.44  | 0.0       | 49.44    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260104  | Accrual                   | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "BUY_DOWN_FEE" transaction created on "20260101" contains the following data:
      | Date            | Type | Amount |
      | 20260101 | AM   | 0.56   |
      | 20260103 | AM   | 49.44  |

    When Loan Pay-off is made on "20260105"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
