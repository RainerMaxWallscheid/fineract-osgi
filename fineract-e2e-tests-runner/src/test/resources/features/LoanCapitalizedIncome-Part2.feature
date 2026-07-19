@CapitalizedIncomeFeature
Feature: Capitalized Income - Part2

  @TestRailId:C3742
  Scenario: Verify capitalized income amortization reversal when multiple payments create complex overpayment scenario
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME | 20240101   | 2000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "2000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "1500" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240105"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240105" with "300" EUR transaction amount
  # First partial payment
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240105" with 900 EUR transaction amount and system-generated Idempotency key
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240108"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240108" with "200" EUR transaction amount
  # Second payment that causes overpayment
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240108" with 1200 EUR transaction amount and system-generated Idempotency key
    Then Loan status will be "OVERPAID"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 1500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20240105  | Capitalized Income              | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 1800.0       | false    |
      | 20240105  | Repayment                       | 900.0  | 898.87    | 1.13     | 0.0  | 0.0       | 901.13       | false    |
      | 20240108  | Capitalized Income              | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 1101.13      | false    |
      | 20240108  | Repayment                       | 1200.0 | 1101.13   | 0.51     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Accrual                         | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Capitalized Income Amortization | 500.0  | 0.0       | 500.0    | 0.0  | 0.0       | 0.0          | false    |
  # Undo first capitalized income
    When Customer undo "1"th "Capitalized Income" transaction made on "20240105"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                           | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                               | 1500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    | false    |
      | 20240105  | Capitalized Income                         | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 1800.0       | true     | false    |
      | 20240105  | Repayment                                  | 900.0  | 898.87    | 1.13     | 0.0  | 0.0       | 601.13       | false    | false    |
      | 20240108  | Capitalized Income                         | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 801.13       | false    | false    |
      | 20240108  | Accrual                                    | 1.64   | 0.0       | 1.64     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Capitalized Income Amortization            | 500.0  | 0.0       | 500.0    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Repayment                                  | 1200.0 | 801.13    | 0.34     | 0.0  | 0.0       | 0.0          | false    | true    |
      | 20240108  | Capitalized Income Amortization Adjustment | 300.0  | 0.0       | 300.0    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual Adjustment                         | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan has 0.0 outstanding amount
    And Loan has 398.53 overpaid amount

    When Admin makes Credit Balance Refund transaction on "20240108" with 398.53 EUR transaction amount
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3743
  Scenario: Verify Capitalized income and Caplitalized income adjustment - Accounting and repayment schedule handling in case of loan is overpaid (Capitalized Income Scenarios - UC9)
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 150            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "150" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date                | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101     |            | 100.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      |    |      | 20240101     |            |  50.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20240201    |            | 100.29          |  49.71        | 0.87     | 0.0  | 0.0       | 50.58  | 0.0   | 0.0        | 0.0  | 50.58       |
      | 2  | 29   | 20240301       |            |  50.3           |  49.99        | 0.59     | 0.0  | 0.0       | 50.58  | 0.0   | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401       |            |   0.0           |  50.3         | 0.29     | 0.0  | 0.0       | 50.59  | 0.0   | 0.0        | 0.0  | 50.59       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75  | 0.0   | 0.0        | 0.0  | 151.75      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 50.0   |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 50.0   |
    When Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240201" with 50.58 EUR transaction amount
    When Admin sets the business date to "20240301"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240301" with 50.58 EUR transaction amount
    When Admin sets the business date to "20240401"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240401" with 60.6 EUR transaction amount
    Then Loan status will be "OVERPAID"
    And Loan has 10.01 overpaid amount
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401    | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 50.59 | 0.0        | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75 | 151.75 | 0.0        | 0.0  | 0.0         |
    And Loan Transactions tab has a "REPAYMENT" transaction with date "20240401" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 50.3   |
      | ASSET     | 112603       | Interest/Fee Receivable   |       | 0.29   |
      | LIABILITY | l1           | Overpayment account       |       | 10.01  |
      | LIABILITY | 145023       | Suspense/Clearing account | 60.6  |        |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    | false    |
      | 20240201 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240301    | Repayment                       | 50.58  | 49.99     | 0.59     | 0.0  | 0.0       | 50.3         | false    | false    |
      | 20240301    | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Repayment                       | 60.6   | 50.3      | 0.29     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240405"
    And Admin runs inline COB job for Loan
    And Admin makes Credit Balance Refund transaction on "20240405" with 10.01 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401    | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 50.59 | 0.0        | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75 | 151.75 | 0.0        | 0.0  | 0.0         |
    And Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20240405" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | LIABILITY | l1           | Overpayment account       | 10.01 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 10.01  |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    | false    |
      | 20240201 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240301    | Repayment                       | 50.58  | 49.99     | 0.59     | 0.0  | 0.0       | 50.3         | false    | false    |
      | 20240301    | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Repayment                       | 60.6   | 50.3      | 0.29     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240405    | Credit Balance Refund           | 10.01  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240415"
    And Admin runs inline COB job for Loan
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240415" with "15" EUR transaction amount
    Then Loan status will be "OVERPAID"
    And Loan has 15 overpaid amount
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401    | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 50.59 | 0.0        | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75 | 151.75 | 0.0        | 0.0  | 0.0         |
    And Loan Transactions tab has a "CAPITALIZED_INCOME_ADJUSTMENT" transaction with date "20240415" which has the following Journal entries:
      | Type      | Account code | Account name        | Debit | Credit |
      | LIABILITY | l1           | Overpayment account |       | 15.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 15.0  |        |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    | false    |
      | 20240201 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240301    | Repayment                       | 50.58  | 49.99     | 0.59     | 0.0  | 0.0       | 50.3         | false    | false    |
      | 20240301    | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Repayment                       | 60.6   | 50.3      | 0.29     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240405    | Credit Balance Refund           | 10.01  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240415    | Capitalized Income Adjustment   | 15.0   | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240415    | Capitalized Income Amortization Adjustment | 15.0   | 0.0       | 15.0     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Admin makes Credit Balance Refund transaction on "20240415" with 15 EUR transaction amount
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @Skip @TestRailId:C3744
  Scenario: Verify Capitalized income and Caplitalized income adjustment - Accounting and repayment schedule handling in case of loan is overpaid (Capitalized Income Scenarios - UC10)
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 150            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "150" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date                | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101     |            | 100.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      |    |      | 20240101     |            |  50.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20240201    |            | 100.29          |  49.71        | 0.87     | 0.0  | 0.0       | 50.58  | 0.0   | 0.0        | 0.0  | 50.58       |
      | 2  | 29   | 20240301       |            |  50.3           |  49.99        | 0.59     | 0.0  | 0.0       | 50.58  | 0.0   | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401       |            |   0.0           |  50.3         | 0.29     | 0.0  | 0.0       | 50.59  | 0.0   | 0.0        | 0.0  | 50.59       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75  | 0.0   | 0.0        | 0.0  | 151.75      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 50.0   |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 50.0   |
    When Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240201" with 50.58 EUR transaction amount
    When Admin sets the business date to "20240301"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240301" with 50.58 EUR transaction amount
    When Admin sets the business date to "20240401"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240401" with 40.59 EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Loan has 10 outstanding amount
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    |                  | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 40.59 | 0.0        | 0.0  | 10.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75 | 141.75 | 0.0        | 0.0  | 10.0         |
    And Loan Transactions tab has a "REPAYMENT" transaction with date "20240401" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 40.59  |
      | LIABILITY | 145023       | Suspense/Clearing account | 40.59 |        |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    | false    |
      | 20240201 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240301    | Repayment                       | 50.58  | 49.99     | 0.59     | 0.0  | 0.0       | 50.3         | false    | false    |
      | 20240301    | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Repayment                       | 40.59  | 40.59     | 0.0      | 0.0  | 0.0       | 9.71         | false    | false    |
    When Admin sets the business date to "20240402"
    And Admin runs inline COB job for Loan
    When Admin sets the business date to "20240415"
    And Admin runs inline COB job for Loan
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240415" with "15" EUR transaction amount
    Then Loan status will be "OVERPAID"
    And Loan has 5 overpaid amount
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240415    | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 50.59 | 0.0        | 10.0 | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75 | 151.75 | 0.0        | 10.0 | 0.0         |
    And Loan Transactions tab has a "CAPITALIZED_INCOME_ADJUSTMENT" transaction with date "20240415" which has the following Journal entries:
      | Type      | Account code | Account name        | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable    |       | 9.71   |
      | ASSET     | 112603       | Interest/Fee Receivable |       | 0.29   |
      | LIABILITY | l1           | Overpayment account |       | 5.0    |
      | LIABILITY | 145024       | Deferred Capitalized Income | 15.0  |        |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    | false    |
      | 20240201 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240301    | Repayment                       | 50.58  | 49.99     | 0.59     | 0.0  | 0.0       | 50.3         | false    | false    |
      | 20240301    | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Repayment                       | 40.59  | 40.59     | 0.0      | 0.0  | 0.0       | 9.71         | false    | false    |
      | 20240401    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240415    | Capitalized Income Adjustment   | 15.0   | 9.71      | 0.29     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240415    | Capitalized Income Amortization Adjustment | 15.0   | 0.0       | 15.0     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Admin makes Credit Balance Refund transaction on "20240415" with 5 EUR transaction amount
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3745
  Scenario: Verify Capitalized income and Caplitalized income adjustment - Accounting and repayment schedule handling in case of loan is overpaid (Capitalized Income Scenarios - UC11)
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 200            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      |    |      | 20240101  |           | 50.0            |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 0.0  | 0.0        | 0.0  | 50.58       |
      | 2  | 29   | 20240301    |           | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 0.0  | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |           | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 0.0  | 0.0        | 0.0  | 50.59       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75 | 0.0  | 0.0        | 0.0  | 151.75      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    When Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240201" with 50.58 EUR transaction amount
    When Admin sets the business date to "20240301"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240301" with 50.58 EUR transaction amount
    When Admin sets the business date to "20240315"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240315" with 50.59 EUR transaction amount
    Then Loan status will be "OVERPAID"
    And Loan has 0.16 overpaid amount
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240315    | 0.0             | 50.3          | 0.13     | 0.0  | 0.0       | 50.43 | 50.43 | 50.43      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 150.0         | 1.59     | 0.0  | 0.0       | 151.59 | 151.59 | 50.43      | 0.0  | 0.0         |
    And Loan Transactions tab has a "REPAYMENT" transaction with date "20240315" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 50.3   |
      | ASSET     | 112603       | Interest/Fee Receivable   |       | 0.13   |
      | LIABILITY | l1           | Overpayment account       |       | 0.16   |
      | LIABILITY | 145023       | Suspense/Clearing account | 50.59 |        |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    | false    |
      | 20240201 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240301    | Repayment                       | 50.58  | 49.99     | 0.59     | 0.0  | 0.0       | 50.3         | false    | false    |
      | 20240301    | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Repayment                       | 50.59  | 50.3      | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Capitalized Income Amortization | 9.34   | 0.0       | 9.34     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Admin makes Credit Balance Refund transaction on "20240315" with 0.16 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240315    | 0.0             | 50.3          | 0.13     | 0.0  | 0.0       | 50.43 | 50.43 | 50.43      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 150.0         | 1.59     | 0.0  | 0.0       | 151.59 | 151.59 | 50.43      | 0.0  | 0.0         |
    And Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20240315" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | LIABILITY | l1           | Overpayment account       | 0.16  |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 0.16   |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    | false    |
      | 20240201 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240301    | Repayment                       | 50.58  | 49.99     | 0.59     | 0.0  | 0.0       | 50.3         | false    | false    |
      | 20240301    | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Repayment                       | 50.59  | 50.3      | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Capitalized Income Amortization | 9.34   | 0.0       | 9.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Credit Balance Refund           | 0.16   | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240316"
    And Admin runs inline COB job for Loan
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240316" with "50" EUR transaction amount
    Then Loan status will be "ACTIVE"
    #    TODO doublecheck
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      |    |      | 20240101  |                  | 50.0            |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58  | 50.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58  | 50.58 | 0.0        | 0.0  | 0.0         |
      |    |      | 20240316    |                  | 50.0            |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 3  | 31   | 20240401    |                  | 0.0             | 100.3         | 0.28     | 0.0  | 0.0       | 100.58 | 50.43 | 50.43      | 0.0  | 50.15       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 200.0         | 1.74     | 0.0  | 0.0       | 201.74 | 151.59 | 50.43      | 0.0  | 50.15       |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240316" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    | false    |
      | 20240201 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240301    | Repayment                       | 50.58  | 49.99     | 0.59     | 0.0  | 0.0       | 50.3         | false    | false    |
      | 20240301    | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Repayment                       | 50.59  | 50.3      | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Capitalized Income Amortization | 9.34   | 0.0       | 9.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Credit Balance Refund           | 0.16   | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 50.0         | false    | false    |

    When Loan Pay-off is made on "20240316"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3746
  Scenario: Verify Capitalized income and Caplitalized income adjustment - Accounting and repayment schedule handling in case of loan is overpaid (Capitalized Income Scenarios - UC12)
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 200            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      |    |      | 20240101  |           | 50.0            |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 0.0  | 0.0        | 0.0  | 50.58       |
      | 2  | 29   | 20240301    |           | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 0.0  | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |           | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 0.0  | 0.0        | 0.0  | 50.59       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75 | 0.0  | 0.0        | 0.0  | 151.75      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    When Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240201" with 50.58 EUR transaction amount
    When Admin sets the business date to "20240301"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240301" with 50.58 EUR transaction amount
    When Admin sets the business date to "20240315"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240315" with 50.59 EUR transaction amount
    Then Loan status will be "OVERPAID"
    And Loan has 0.16 overpaid amount
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240315    | 0.0             | 50.3          | 0.13     | 0.0  | 0.0       | 50.43 | 50.43 | 50.43      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 150.0         | 1.59     | 0.0  | 0.0       | 151.59 | 151.59 | 50.43      | 0.0  | 0.0         |
    And Loan Transactions tab has a "REPAYMENT" transaction with date "20240315" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 50.3   |
      | ASSET     | 112603       | Interest/Fee Receivable   |       | 0.13   |
      | LIABILITY | l1           | Overpayment account       |       | 0.16   |
      | LIABILITY | 145023       | Suspense/Clearing account | 50.59 |        |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    | false    |
      | 20240201 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240301    | Repayment                       | 50.58  | 49.99     | 0.59     | 0.0  | 0.0       | 50.3         | false    | false    |
      | 20240301    | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Repayment                       | 50.59  | 50.3      | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Capitalized Income Amortization | 9.34   | 0.0       | 9.34     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240316"
    And Admin runs inline COB job for Loan
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240316" with "50" EUR transaction amount
    Then Loan status will be "ACTIVE"
#    TODO doublecheck
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      |    |      | 20240101  |                  | 50.0            |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58  | 50.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58  | 50.58 | 0.0        | 0.0  | 0.0         |
      |    |      | 20240316    |                  | 50.0            |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 3  | 31   | 20240401    |                  | 0.0             | 100.3         | 0.28     | 0.0  | 0.0       | 100.58 | 50.59 | 50.59      | 0.0  | 49.99       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 200.0         | 1.74     | 0.0  | 0.0       | 201.74 | 151.75 | 50.59      | 0.0  | 49.99       |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240316" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    | false    |
      | 20240201 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240301    | Repayment                       | 50.58  | 49.99     | 0.59     | 0.0  | 0.0       | 50.3         | false    | false    |
      | 20240301    | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Repayment                       | 50.59  | 50.3      | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Capitalized Income Amortization | 9.34   | 0.0       | 9.34     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 49.84        | false    | false    |

    When Loan Pay-off is made on "20240316"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3747
  Scenario: Verify Capitalized Income Amortization validation while run COB a month after Capitalized Income trn - UC1
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 200            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |            | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |            | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |            | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 0.0   | 0.0        | 0.0  | 50.58       |
      | 2  | 29   | 20240301    |            | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 0.0   | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |            | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 0.0   | 0.0        | 0.0  | 50.59       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.00 | 0.00      | 151.75 | 0.0   | 0.0        | 0.0  | 151.75      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
    When Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240131  | Accrual                         | 0.85   | 0.0       | 0.85     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 17.03  | 0.0       | 17.03    | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3748
  Scenario: Verify Capitalized Income Amortization while run COB a month after Capitalized Income with Adjustment trns - UC2
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 200            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240101" with "40" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |            | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |            | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |            | 100.06          | 49.94         | 0.64     | 0.0  | 0.0       | 50.58 | 40.0  | 40.0       | 0.0  | 10.58       |
      | 2  | 29   | 20240301    |            | 50.06           | 50.0          | 0.58     | 0.0  | 0.0       | 50.58 | 0.0   | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |            | 0.0             | 50.06         | 0.29     | 0.0  | 0.0       | 50.35 | 0.0   | 0.0        | 0.0  | 50.35       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.51     | 0.00 | 0.00      | 151.51 | 40.0  | 40.0       | 0.0  | 111.51      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Adjustment   | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 110.0        | false    | false    |
    When Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Adjustment   | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 110.0        | false    | false    |
      | 20240131  | Accrual                         | 0.62   | 0.0       | 0.62     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 3.41   | 0.0       | 3.41     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3749
  Scenario: Verify backdated Capitalized Income Amortization while add Capitalised Income trn with a month earlier date - UC3
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 200            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |            | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |            | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0   | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |            | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0   | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |            | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0   | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.00 | 0.00      | 101.17 | 0.0   | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
    When Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240131  | Accrual                         | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    When Admin sets the business date to "20240202"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |            | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |            | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |            | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 0.0   | 0.0        | 0.0  | 50.58       |
      | 2  | 29   | 20240301    |            | 50.31           | 49.98         | 0.6      | 0.0  | 0.0       | 50.58 | 0.0   | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |            | 0.0             | 50.31         | 0.29     | 0.0  | 0.0       | 50.6  | 0.0   | 0.0        | 0.0  | 50.6        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.76     | 0.00 | 0.00      | 151.76 | 0.0   | 0.0        | 0.0  | 151.76      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240131  | Accrual                         | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual                         | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 17.58  | 0.0       | 17.58    | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240202"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3750
  Scenario: Verify backdated Capitalized Income Amortization while add Capitalised Income and Adjustment trns with earlier date - UC4
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 200            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |            | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |            | 66.86           | 33.14         | 0.58     | 0.0  | 0.0       | 33.72 | 0.0   | 0.0        | 0.0  | 33.72       |
      | 2  | 29   | 20240301    |            | 33.53           | 33.33         | 0.39     | 0.0  | 0.0       | 33.72 | 0.0   | 0.0        | 0.0  | 33.72       |
      | 3  | 31   | 20240401    |            | 0.0             | 33.53         | 0.2      | 0.0  | 0.0       | 33.73 | 0.0   | 0.0        | 0.0  | 33.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.00 | 0.00      | 101.17 | 0.0   | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
    When Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240131  | Accrual                         | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "50" EUR transaction amount
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240102" with "40" EUR transaction amount
    When Admin sets the business date to "20240202"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |            | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240102  |            | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |            | 100.06          | 49.94         | 0.64     | 0.0  | 0.0       | 50.58 | 40.0  | 40.0       | 0.0  | 10.58       |
      | 2  | 29   | 20240301    |            | 50.07           | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 0.0   | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |            | 0.0             | 50.07         | 0.29     | 0.0  | 0.0       | 50.36 | 0.0   | 0.0        | 0.0  | 50.36       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.52     | 0.00 | 0.00      | 151.52 | 40.0  | 40.0       | 0.0  | 111.52      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240102  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240102  | Capitalized Income Adjustment   | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 110.0        | false    | false    |
      | 20240131  | Accrual                         | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual                         | 0.08   | 0.0       | 0.08     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 3.44   | 0.0       | 3.44     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240202"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3751
  Scenario: Verify Capitalized Income Amortization while add additional Capitalized Income trn with earlier date - UC5
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 200            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |            | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |            | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |            | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 0.0   | 0.0        | 0.0  | 50.58       |
      | 2  | 29   | 20240301    |            | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 0.0   | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |            | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 0.0   | 0.0        | 0.0  | 50.59       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.00 | 0.00      | 151.75 | 0.0   | 0.0        | 0.0  | 151.75      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
    When Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240131  | Accrual                         | 0.85   | 0.0       | 0.85     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 17.03  | 0.0       | 17.03    | 0.0  | 0.0       | 0.0          | false    | false    |
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "50" EUR transaction amount
    When Admin sets the business date to "20240202"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |            | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |            | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |            | 133.72          | 66.28         | 1.16     | 0.0  | 0.0       | 67.44 | 0.0   | 0.0        | 0.0  | 67.44       |
      | 2  | 29   | 20240301    |            | 67.07           | 66.65         | 0.79     | 0.0  | 0.0       | 67.44 | 0.0   | 0.0        | 0.0  | 67.44       |
      | 3  | 31   | 20240401    |            | 0.0             | 67.07         | 0.39     | 0.0  | 0.0       | 67.46 | 0.0   | 0.0        | 0.0  | 67.46       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 200.0         | 2.34     | 0.00 | 0.00      | 202.34 | 0.0   | 0.0        | 0.0  | 202.34      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240102  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
      | 20240131  | Accrual                         | 0.85   | 0.0       | 0.85     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 17.03  | 0.0       | 17.03    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual                         | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 17.77  | 0.0       | 17.77    | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240202"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3752
  Scenario: Verify Capitalized Income Amortization while add additional Capitalized Income trn with earlier date after Adjustment trn - UC6
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 300            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "300" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240101" with "40" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |            | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |            | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |            | 100.06          | 49.94         | 0.64     | 0.0  | 0.0       | 50.58 | 40.0  | 40.0       | 0.0  | 10.58       |
      | 2  | 29   | 20240301    |            | 50.06           | 50.0          | 0.58     | 0.0  | 0.0       | 50.58 | 0.0   | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |            | 0.0             | 50.06         | 0.29     | 0.0  | 0.0       | 50.35 | 0.0   | 0.0        | 0.0  | 50.35       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.51     | 0.00 | 0.00      | 151.51 | 40.0  | 40.0       | 0.0  | 111.51     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Adjustment   | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 110.0        | false    | false    |
    When Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Adjustment   | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 110.0        | false    | false    |
      | 20240131  | Accrual                         | 0.62   | 0.0       | 0.62     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 3.41   | 0.0       | 3.41     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "50" EUR transaction amount
    When Admin sets the business date to "20240202"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |            | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |            | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240102  |            | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |            | 133.48          | 66.52         | 0.92     | 0.0  | 0.0       | 67.44 | 40.0  | 40.0       | 0.0  | 27.44       |
      | 2  | 29   | 20240301    |            | 66.82           | 66.66         | 0.78     | 0.0  | 0.0       | 67.44 | 0.0   | 0.0        | 0.0  | 67.44       |
      | 3  | 31   | 20240401    |            | 0.0             | 66.82         | 0.39     | 0.0  | 0.0       | 67.21 | 0.0   | 0.0        | 0.0  | 67.21       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 200.0         | 2.09     | 0.00 | 0.00      | 202.09 | 40.0  | 40.0       | 0.0  | 162.09      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Adjustment   | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 110.0        | false    | false    |
      | 20240102  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 160.0        | false    | false    |
      | 20240131  | Accrual                         | 0.62   | 0.0       | 0.62     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 3.41   | 0.0       | 3.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual                         | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 17.33  | 0.0       | 17.33    | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240202"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3753
  Scenario: Verify Capitalized Income Amortization while add additional Capitalized Income with Adjustment trns with earlier date after Adjustment trn - UC7
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 300            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "300" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240101" with "40" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |            | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |            | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |            | 100.06          | 49.94         | 0.64     | 0.0  | 0.0       | 50.58 | 40.0  | 40.0       | 0.0  | 10.58       |
      | 2  | 29   | 20240301    |            | 50.06           | 50.0          | 0.58     | 0.0  | 0.0       | 50.58 | 0.0   | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |            | 0.0             | 50.06         | 0.29     | 0.0  | 0.0       | 50.35 | 0.0   | 0.0        | 0.0  | 50.35       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.51     | 0.00 | 0.00      | 151.51 | 40.0  | 40.0       | 0.0  | 111.51     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Adjustment   | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 110.0        | false    | false    |
    When Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Adjustment   | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 110.0        | false    | false    |
      | 20240131  | Accrual                         | 0.62   | 0.0       | 0.62     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 3.41   | 0.0       | 3.41     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "70" EUR transaction amount
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240102" with "60" EUR trn amount with "20240102" date for capitalized income
    When Admin sets the business date to "20240202"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240102  |                  | 70.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240102  | 145.83          | 74.17         | 0.02     | 0.0  | 0.0       | 74.19 | 74.19 | 74.19      | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  |  73.02          | 72.81         | 1.38     | 0.0  | 0.0       | 74.19 | 25.81 | 25.81      | 0.0  | 48.38       |
      | 3  | 31   | 20240401    |                  |   0.0           | 73.02         | 0.43     | 0.0  | 0.0       | 73.45 | 0.0   | 0.0        | 0.0  | 73.45       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 220.0         | 1.83     | 0.00 | 0.00      | 221.83 | 100.0 | 100.0      | 0.0  | 121.83     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Adjustment   | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 110.0        | false    | false    |
      | 20240102  | Capitalized Income              | 70.0   | 70.0      | 0.0      | 0.0  | 0.0       | 180.0        | false    | false    |
      | 20240102  | Capitalized Income Adjustment   | 60.0   | 59.98     | 0.02     | 0.0  | 0.0       | 120.02       | false    | false    |
      | 20240131  | Accrual                         | 0.62   | 0.0       | 0.62     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 3.41   | 0.0       | 3.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual                         | 0.08   | 0.0       | 0.08     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 3.55   | 0.0       | 3.55     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240202"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3754
  Scenario: Verify Capitalized Income Amortization while run COB a month after Capitalized Income with Adjustment trns for multidisbursl loan - UC8
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_RECALC_EMI_360_30_MULTIDISB_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 200            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240101" with "40" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |            | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |            | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |            | 100.06          | 49.94         | 0.64     | 0.0  | 0.0       | 50.58 | 40.0  | 40.0       | 0.0  | 10.58       |
      | 2  | 29   | 20240301    |            | 50.06           | 50.0          | 0.58     | 0.0  | 0.0       | 50.58 | 0.0   | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |            | 0.0             | 50.06         | 0.29     | 0.0  | 0.0       | 50.35 | 0.0   | 0.0        | 0.0  | 50.35       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.51     | 0.00 | 0.00      | 151.51 | 40.0  | 40.0       | 0.0  | 111.51      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Adjustment   | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 110.0        | false    | false    |
    When Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Adjustment   | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 110.0        | false    | false    |
      | 20240131  | Accrual                         | 0.62   | 0.0       | 0.62     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 3.41   | 0.0       | 3.41     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3755
  Scenario: Verify Capitalized Income Amortization while add additional Capitalized Income trn with earlier date for multidisbursl loan - UC9
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_RECALC_EMI_360_30_MULTIDISB_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 200            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |            | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |            | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |            | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 0.0   | 0.0        | 0.0  | 50.58       |
      | 2  | 29   | 20240301    |            | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 0.0   | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |            | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 0.0   | 0.0        | 0.0  | 50.59       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.00 | 0.00      | 151.75 | 0.0   | 0.0        | 0.0  | 151.75      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
    When Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240131  | Accrual                         | 0.85   | 0.0       | 0.85     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 17.03  | 0.0       | 17.03    | 0.0  | 0.0       | 0.0          | false    | false    |
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "50" EUR transaction amount
    When Admin sets the business date to "20240202"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |            | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |            | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |            | 133.72          | 66.28         | 1.16     | 0.0  | 0.0       | 67.44 | 0.0   | 0.0        | 0.0  | 67.44       |
      | 2  | 29   | 20240301    |            | 67.07           | 66.65         | 0.79     | 0.0  | 0.0       | 67.44 | 0.0   | 0.0        | 0.0  | 67.44       |
      | 3  | 31   | 20240401    |            | 0.0             | 67.07         | 0.39     | 0.0  | 0.0       | 67.46 | 0.0   | 0.0        | 0.0  | 67.46       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 200.0         | 2.34     | 0.00 | 0.00      | 202.34 | 0.0   | 0.0        | 0.0  | 202.34      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240102  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
      | 20240131  | Accrual                         | 0.85   | 0.0       | 0.85     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 17.03  | 0.0       | 17.03    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual                         | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 17.77  | 0.0       | 17.77    | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240202"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3735
  Scenario: Verify Capitalized Income business events
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 150            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "150" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "90" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "60" EUR transaction amount
    And Admin sets the business date to "20240102"
    Then LoanCapitalizedIncomeTransactionCreatedBusinessEvent is raised on "20240101"
    When Admin runs inline COB job for Loan
    Then LoanCapitalizedIncomeAmortizationTransactionCreatedBusinessEvent is raised on "20240101"
    And Loan status will be "ACTIVE"
    When Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240102" with "10" EUR transaction amount
    And Admin sets the business date to "20240103"
    Then LoanCapitalizedIncomeAdjustmentTransactionCreatedBusinessEvent is raised on "20240102"
    When Admin runs inline COB job for Loan
    And Admin sets the business date to "20240104"
    And Admin runs inline COB job for Loan
    And Customer undo "1"th capitalized income adjustment on "20240102"
    When Customer undo "1"th "Capitalized Income" transaction made on "20240101"
    And Admin sets the business date to "20240105"
    And Admin runs inline COB job for Loan

    When Loan Pay-off is made on "20240105"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3758
  Scenario: Verify validation of capitalized income amount with disbursement amount not exceed approved over applied amount for multidisbursal progressive loan - failed scenario
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_RECALC_EMI_360_30_MULTIDISB_OVER_APPLIED_PERCENTAGE_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin successfully disburse the loan on "20240102" with "300" EUR transaction amount
    Then Capitalized income with payment type "AUTOPAY" on "20240102" is forbidden with amount "300" while exceed approved amount

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3759
  Scenario: Verify validation of capitalized income amount with disbursement amount not exceed approved over applied amount for multidisbursal progressive loan - successful scenario
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_RECALC_EMI_360_30_MULTIDISB_OVER_APPLIED_PERCENTAGE_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin successfully disburse the loan on "20240102" with "300" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "200" EUR transaction amount

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3782
  Scenario: Verify that Capitalized Income Amortization Adjustment is created when a Capitalized Income Adjustment overpays the loan
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 10000          | 10                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "10000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "500" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      |    |      | 20240101  |           | 500.0           |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 1129.66         | 370.34        | 12.5     | 0.0  | 0.0       | 382.84  | 0.0  | 0.0        | 0.0  | 382.84      |
      | 2  | 29   | 20240301    |           | 756.23          | 373.43        | 9.41     | 0.0  | 0.0       | 382.84  | 0.0  | 0.0        | 0.0  | 382.84      |
      | 3  | 31   | 20240401    |           | 379.69          | 376.54	       | 6.3      | 0.0  | 0.0       | 382.84  | 0.0  | 0.0        | 0.0  | 382.84      |
      | 4  | 30   | 20240501      |           | 0.0             | 379.69        | 3.16     | 0.0  | 0.0       | 382.85  | 0.0  | 0.0        | 0.0  | 382.85      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1500.0        | 31.37    | 0.0  | 0.0       | 1531.37 | 0.0  | 0.0        | 0.0  | 1531.37     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Capitalized Income | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 500.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 500.0  |
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Capitalized Income              | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20240101  | Capitalized Income Amortization | 4.13   | 0.0       | 4.13     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | INCOME    | 404000       | Interest Income              |        | 4.13   |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 4.13   |        |
    When Admin sets the business date to "20240103"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Capitalized Income              | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20240101  | Capitalized Income Amortization | 4.13   | 0.0       | 4.13     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Accrual                         | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Capitalized Income Amortization | 4.13   | 0.0       | 4.13     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | INCOME    | 404000       | Interest Income              |        | 4.13   |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 4.13   |        |
    And Customer makes "AUTOPAY" repayment on "20240103" with 1100 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0     |            |      |             |
      |    |      | 20240101  |                 | 500.0           |               |          | 0.0  |           | 0.0     | 0.0     |            |      |             |
      | 1  | 31   | 20240201 | 20240103 | 1117.97         | 382.03        | 0.81     | 0.0  | 0.0       | 382.84  | 382.84  | 382.84     | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240103 | 735.13          | 382.84        | 0.0      | 0.0  | 0.0       | 382.84  | 382.84  | 382.84     | 0.0  | 0.0         |
      | 3  | 31   | 20240401    |                 | 362.09          | 373.04	     | 9.8      | 0.0  | 0.0       | 382.84  | 334.32  | 334.32     | 0.0  | 48.52       |
      | 4  | 30   | 20240501      |                 | 0.0             | 362.09        | 3.02     | 0.0  | 0.0       | 365.11  | 0.0     | 0.0        | 0.0  | 365.11      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance    | Late | Outstanding |
      | 1500.0        | 13.63    | 0.0  | 0.0       | 1513.63 | 1100.0  | 1100.0        | 0.0  | 413.63      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount    | Principal | Interest | Fees | Penalties | Loan Balance    | Reverted |
      | 20240101  | Disbursement                    | 1000.0    | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0          | false    |
      | 20240101  | Capitalized Income              | 500.0     | 500.0     | 0.0      | 0.0  | 0.0       | 1500.0          | false    |
      | 20240101  | Capitalized Income Amortization | 4.13      | 0.0       | 4.13     | 0.0  | 0.0       | 0.0             | false    |
      | 20240102  | Accrual                         | 0.4       | 0.0       | 0.4      | 0.0  | 0.0       | 0.0             | false    |
      | 20240102  | Capitalized Income Amortization | 4.13      | 0.0       | 4.13     | 0.0  | 0.0       | 0.0             | false    |
      | 20240103  | Repayment                       | 1100.0    | 1099.19   | 0.81     | 0.0  | 0.0       | 400.81          | false    |
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240102" with "497" EUR transaction amount
    Then Loan status will be "OVERPAID"
    And Loan has 0 outstanding amount
    And Loan has 96.33 overpaid amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0     |            |      |             |
      |    |      | 20240101  |                 | 500.0           |               |          | 0.0  |           | 0.0     | 0.0     |            |      |             |
      | 1  | 31   | 20240201 | 20240102 | 1117.56         | 382.44        | 0.4      | 0.0  | 0.0       | 382.84  | 382.84  | 382.84     | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240103 | 734.99          | 382.57        | 0.27     | 0.0  | 0.0       | 382.84  | 382.84  | 382.84     | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240103 | 352.15          | 382.84	     | 0.0      | 0.0  | 0.0       | 382.84  | 382.84  | 382.84     | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240103 | 0.0             | 352.15        | 0.0      | 0.0  | 0.0       | 352.15  | 352.15  | 352.15     | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid     | In advance     | Late | Outstanding |
      | 1500.0        | 0.67     | 0.0  | 0.0       | 1500.67 | 1500.67  | 1500.67        | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                             | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                                 | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Capitalized Income                           | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20240101  | Capitalized Income Amortization              | 4.13   | 0.0       | 4.13     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Accrual                                      | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Capitalized Income Amortization              | 4.13   | 0.0       | 4.13     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Capitalized Income Adjustment                | 497.0  | 496.6     | 0.4      | 0.0  | 0.0       | 1003.4       | false    |
      | 20240102  | Capitalized Income Amortization Adjustment   | 5.26   | 0.0       | 5.26     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Repayment                                    | 1100.0 | 1003.4    | 0.27     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Accrual                                      | 0.27   | 0.0       | 0.27     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION_ADJUSTMENT" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | INCOME    | 404000       | Interest Income              | 5.26   |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 5.26   |

    When Admin makes Credit Balance Refund transaction on "20240103" with 96.33 EUR transaction amount
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3899
  Scenario: Verify available disbursement amount should consider calculation with capitalized income
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_RECALC_EMI_360_30_MULTIDISB_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC  | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
  # Available amount = 1000 - 500 - 0 - 0 = 500
    And Admin successfully disburse the loan on "20240101" with "500" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Loan's available disbursement amount is "500.0"
    When Admin sets the business date to "20240102"
  # Available amount = 1000 - 500 - 200 - 0 = 300
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "200" EUR transaction amount
    Then Loan's available disbursement amount is "300.0"
  # This should succeed as 300 <= 300
    When Admin successfully disburse the loan on "20240102" with "300" EUR transaction amount
  # Available amount = 1000 - 800 - 200 - 0 = 0
    Then Loan's available disbursement amount is "0.0"

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3913
  Scenario: Verify available disbursement amount calculation with multiple capitalized income transactions
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSAL_CAPITALIZED_INCOME | 20240101   | 2000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "2000" amount and expected disbursement date on "20240101"
  # Available amount = 2000 - 1000 - 0 - 0 = 1000
    And Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Loan's available disbursement amount is "1000.0"
    When Admin sets the business date to "20240102"
  # Available amount = 2000 - 1000 - 300 - 0 = 700
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "300" EUR transaction amount
    Then Loan's available disbursement amount is "700.0"
    When Admin sets the business date to "20240103"
  # Available amount = 2000 - 1000 - 300 - 200 - 0 = 500
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240103" with "200" EUR transaction amount
    Then Loan's available disbursement amount is "500.0"
  # Available amount = 2000 - 1000 - 500 - 0 = 500
    When Admin successfully disburse the loan on "20240103" with "400" EUR transaction amount
  # Available amount = 2000 - 1400 - 500 - 0 = 100
    Then Loan's available disbursement amount is "100.0"
    When Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240103" with "100" EUR transaction amount
  # Available amount = 2000 - 1400 - 600 - 0 = 0
    Then Loan's available disbursement amount is "0.0"

    When Loan Pay-off is made on "20240103"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3914
  Scenario: Verify available disbursement amount calculation after capitalized income adjustment
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSAL_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
  # Available amount = 1000 - 600 - 0 - 0 = 400
    And Admin successfully disburse the loan on "20240101" with "600" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Loan's available disbursement amount is "400.0"
    When Admin sets the business date to "20240102"
  # Available amount = 1000 - 600 - 300 - 0 = 100
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "300" EUR transaction amount
    Then Loan's available disbursement amount is "100.0"
  # Add capitalized income adjustment to increase available amount
    When Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240102" with "150" EUR transaction amount
  # Available amount = 1000 - 600 - (300-150) - 0 = 250
    Then Loan's available disbursement amount is "250.0"
    When Admin successfully disburse the loan on "20240102" with "250" EUR transaction amount
  # Available amount = 1000 - 850 - 150 - 0 = 0
    Then Loan's available disbursement amount is "0.0"

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3915
  Scenario: Verify available disbursement amount calculation with over applied amount configuration
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_RECALC_EMI_360_30_MULTIDISB_OVER_APPLIED_PERCENTAGE_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1200" amount and expected disbursement date on "20240101"
  # With 10% over applied: max disbursable = 1000 * 1.10 = 1100
  # But available amount = 1200 - 700 - 0 - 0 = 500
    And Admin successfully disburse the loan on "20240101" with "700" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Loan's available disbursement amount is "500.0"
    When Admin sets the business date to "20240102"
  # Available amount = 1200 - 700 - 200 - 0 = 300
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "200" EUR transaction amount
    Then Loan's available disbursement amount is "300.0"
  # This should succeed as total = 700 + 300 + 200 = 1200
    When Admin successfully disburse the loan on "20240102" with "300" EUR transaction amount
  # Available amount = 1200 - 900 - 300 - 0 = 0
    Then Loan's available disbursement amount is "0.0"

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4005
  Scenario: Verify capitalized income transaction creation with classification field set
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_CAPITALIZED_INCOME | 20240101    | 1000.0         | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "900" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "100" EUR transaction amount and "capitalized_income_transaction_classification_value" classification
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 900.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101 | 20240101 | 675.0           | 225.0         | 0.0      | 0.0  | 0.0       | 225.0 | 225.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20240102 |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 30   | 20240131 |                 | 0.0             | 775.0         | 0.0      | 0.0  | 0.0       | 775.0 | 0.0   | 0.0        | 0.0  | 775.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 225.0 | 0.0        | 0.0  | 775.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240101  | Down Payment       | 225.0  | 225.0     | 0.0      | 0.0  | 0.0       | 675.0        | false    |
      | 20240102  | Capitalized Income | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 775.0        | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 100.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 100.0  |
    And Loan Transactions tab has a "Capitalized Income" transaction with date "20240102" which has classification code value "capitalized_income_transaction_classification_value"
    And Deferred Capitalized Income contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 100.0  | 0.0              | 100.0               | 0.0             | 0.0                |
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240102" with "50" EUR transaction amount
    And Loan Transactions tab has a "Capitalized Income Adjustment" transaction with date "20240102" which has classification code value "capitalized_income_transaction_classification_value"

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4008
  Scenario: Verify Capitalized income amortization allocation mappings
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 250            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "250" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date                | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101     |            | 100.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      |    |      | 20240101     |            |  50.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20240201    |            | 100.29          |  49.71        | 0.87     | 0.0  | 0.0       | 50.58  | 0.0   | 0.0        | 0.0  | 50.58       |
      | 2  | 29   | 20240301       |            |  50.3           |  49.99        | 0.59     | 0.0  | 0.0       | 50.58  | 0.0   | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401       |            |   0.0           |  50.3         | 0.29     | 0.0  | 0.0       | 50.59  | 0.0   | 0.0        | 0.0  | 50.59       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75  | 0.0   | 0.0        | 0.0  | 151.75      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 50.0   |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 50.0   |
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "100" EUR transaction amount
    When Admin sets the business date to "20240103"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 250.0        | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 1.66   | 0.0       | 1.66     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240101" contains the following data:
      | Date            | Type | Amount |
      | 20240101 | AM   | 0.55   |
      | 20240102 | AM   | 0.55   |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240102" contains the following data:
      | Date            | Type | Amount |
      | 20240102 | AM   | 1.11   |

    When Loan Pay-off is made on "20240103"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4020
  Scenario: Verify Capitalized income amortization allocation mappings when capitalized income transaction is reversed
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 350            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "350" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date                | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101     |            | 100.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      |    |      | 20240101     |            |  50.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20240201    |            | 100.29          |  49.71        | 0.87     | 0.0  | 0.0       | 50.58  | 0.0   | 0.0        | 0.0  | 50.58       |
      | 2  | 29   | 20240301       |            |  50.3           |  49.99        | 0.59     | 0.0  | 0.0       | 50.58  | 0.0   | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401       |            |   0.0           |  50.3         | 0.29     | 0.0  | 0.0       | 50.59  | 0.0   | 0.0        | 0.0  | 50.59       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75  | 0.0   | 0.0        | 0.0  | 151.75      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 50.0   |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 50.0   |
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "200" EUR transaction amount
    When Admin sets the business date to "20240103"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income              | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 350.0        | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 2.77   | 0.0       | 2.77     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240101" contains the following data:
      | Date            | Type | Amount |
      | 20240101 | AM   | 0.55   |
      | 20240102 | AM   | 0.55   |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240102" contains the following data:
      | Date            | Type | Amount |
      | 20240102 | AM   | 2.22   |
    When Customer undo "1"th "Capitalized Income" transaction made on "20240101"
    When Admin sets the business date to "20240104"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | true     | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income              | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 300.0        | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 2.77   | 0.0       | 2.77     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                         | 0.05   | 0.0       | 0.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 1.12   | 0.0       | 1.12     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240101" contains the following data:
      | Date            | Type   | Amount |
      | 20240101 | AM     | 0.55   |
      | 20240102 | AM     | 0.55   |
      | 20240103 | AM_ADJ | 1.1    |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240102" contains the following data:
      | Date            | Type | Amount |
      | 20240102 | AM   | 2.22   |
      | 20240103 | AM   | 2.22   |
    When Admin sets the business date to "20240105"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | true     | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income              | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 300.0        | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 2.77   | 0.0       | 2.77     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                         | 0.05   | 0.0       | 0.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 1.12   | 0.0       | 1.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                         | 0.05   | 0.0       | 0.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization | 2.23   | 0.0       | 2.23     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240101" contains the following data:
      | Date            | Type   | Amount |
      | 20240101 | AM     | 0.55   |
      | 20240102 | AM     | 0.55   |
      | 20240103 | AM_ADJ | 1.1    |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240102" contains the following data:
      | Date            | Type | Amount |
      | 20240102 | AM   | 2.22   |
      | 20240103 | AM   | 2.22   |
      | 20240104 | AM   | 2.23   |

    When Loan Pay-off is made on "20240105"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4021
  Scenario: Verify Capitalized income amortization allocation mappings when capitalized income adjustment occurs
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 250            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "250" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date                | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101     |            | 100.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      |    |      | 20240101     |            |  50.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20240201    |            | 100.29          |  49.71        | 0.87     | 0.0  | 0.0       | 50.58  | 0.0   | 0.0        | 0.0  | 50.58       |
      | 2  | 29   | 20240301       |            |  50.3           |  49.99        | 0.59     | 0.0  | 0.0       | 50.58  | 0.0   | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401       |            |   0.0           |  50.3         | 0.29     | 0.0  | 0.0       | 50.59  | 0.0   | 0.0        | 0.0  | 50.59       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75  | 0.0   | 0.0        | 0.0  | 151.75      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 50.0   |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 50.0   |
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "100" EUR transaction amount
    When Admin sets the business date to "20240103"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 250.0        | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 1.66   | 0.0       | 1.66     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240101" contains the following data:
      | Date            | Type | Amount |
      | 20240101 | AM   | 0.55   |
      | 20240102 | AM   | 0.55   |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240102" contains the following data:
      | Date            | Type | Amount |
      | 20240102 | AM   | 1.11   |
    When Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240102" with "40" EUR transaction amount
    When Admin sets the business date to "20240104"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 250.0        | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 1.66   | 0.0       | 1.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Adjustment   | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 210.0        | false    | false    |
      | 20240103  | Accrual                         | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 0.77   | 0.0       | 0.77     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240101" contains the following data:
      | Date            | Type   | Amount |
      | 20240101 | AM     | 0.55   |
      | 20240102 | AM     | 0.55   |
      | 20240103 | AM_ADJ | 0.34   |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240102" contains the following data:
      | Date            | Type | Amount |
      | 20240102 | AM   | 1.11   |
      | 20240103 | AM   | 1.11   |
    When Admin sets the business date to "20240105"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 250.0        | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 1.66   | 0.0       | 1.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Adjustment   | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 210.0        | false    | false    |
      | 20240103  | Accrual                         | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 0.77   | 0.0       | 0.77     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                         | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization | 1.21   | 0.0       | 1.21     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240101" contains the following data:
      | Date            | Type   | Amount |
      | 20240101 | AM     | 0.55   |
      | 20240102 | AM     | 0.55   |
      | 20240103 | AM_ADJ | 0.34   |
      | 20240104 | AM     | 0.1    |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240102" contains the following data:
      | Date            | Type | Amount |
      | 20240102 | AM   | 1.11   |
      | 20240103 | AM   | 1.11   |
      | 20240104 | AM   | 1.11   |
    And Admin adds capitalized income adjustment of capitalized income transaction made on "20240102" with "AUTOPAY" payment type to the loan on "20240104" with "60" EUR transaction amount
    When Admin sets the business date to "20240106"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                           | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                               | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income                         | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income                         | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 250.0        | false    | false    |
      | 20240102  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization            | 1.66   | 0.0       | 1.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Adjustment              | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 210.0        | false    | false    |
      | 20240103  | Accrual                                    | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization            | 0.77   | 0.0       | 0.77     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                                    | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization            | 1.21   | 0.0       | 1.21     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Adjustment              | 60.0   | 59.89     | 0.11     | 0.0  | 0.0       | 150.11       | false    | false    |
      | 20240105  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization Adjustment | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240101" contains the following data:
      | Date            | Type   | Amount |
      | 20240101 | AM     | 0.55   |
      | 20240102 | AM     | 0.55   |
      | 20240103 | AM_ADJ | 0.34   |
      | 20240104 | AM     | 0.1    |
      | 20240105 | AM     | 0.11   |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240102" contains the following data:
      | Date            | Type   | Amount |
      | 20240102 | AM     | 1.11   |
      | 20240103 | AM     | 1.11   |
      | 20240104 | AM     | 1.11   |
      | 20240105 | AM_ADJ | 0.25   |
    When Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240105" with "10" EUR transaction amount
    When Admin sets the business date to "20240107"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                           | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                               | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income                         | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income                         | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 250.0        | false    | false    |
      | 20240102  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization            | 1.66   | 0.0       | 1.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Adjustment              | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 210.0        | false    | false    |
      | 20240103  | Accrual                                    | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization            | 0.77   | 0.0       | 0.77     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                                    | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization            | 1.21   | 0.0       | 1.21     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Adjustment              | 60.0   | 59.89     | 0.11     | 0.0  | 0.0       | 150.11       | false    | false    |
      | 20240105  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization Adjustment | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Adjustment              | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 140.11       | false    | false    |
      | 20240106  | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Capitalized Income Amortization Adjustment | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240101" contains the following data:
      | Date            | Type   | Amount |
      | 20240101 | AM     | 0.55   |
      | 20240102 | AM     | 0.55   |
      | 20240103 | AM_ADJ | 0.34   |
      | 20240104 | AM     | 0.1    |
      | 20240105 | AM     | 0.11   |
      | 20240106 | AM_ADJ | 0.97   |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240102" contains the following data:
      | Date            | Type   | Amount |
      | 20240102 | AM     | 1.11   |
      | 20240103 | AM     | 1.11   |
      | 20240104 | AM     | 1.11   |
      | 20240105 | AM_ADJ | 0.25   |
      | 20240106 | AM     | 0.43   |

    When Loan Pay-off is made on "20240105"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4041
  Scenario: Verify Capitalized Income amortization allocation mapping when already amortized amount is greater than should be after capitalized income adjustment
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 200            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 30                | DAYS                  | 1              | DAYS                   | 30                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Admin runs inline COB job for Loan
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "1" EUR transaction amount
    When Admin sets the business date to "20240115"
    And Admin runs inline COB job for Loan
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240101" contains the following data:
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
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 1.0    | 0.47             | 0.53                | 0.0             | 0.0                |
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240115" with "0.7" EUR transaction amount
    When Admin sets the business date to "20240116"
    And Admin runs inline COB job for Loan
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240101" contains the following data:
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
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 1.0    | 0.3              | 0.0                 | 0.7             | 0.0                |
    When Admin sets the business date to "20240125"
    And Admin runs inline COB job for Loan
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240101" contains the following data:
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
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 1.0    | 0.3              | 0.0                 | 0.7             | 0.0                |

    When Loan Pay-off is made on "20240125"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4042
  Scenario: Verify Capitalized Income amortization allocation mapping when after capitalized income adjustment and charge-off
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 200            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 30                | DAYS                  | 1              | DAYS                   | 30                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Admin runs inline COB job for Loan
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "1" EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income | 1.0    | 1.0       | 0.0      | 0.0  | 0.0       | 101.0        | false    |
    When Admin sets the business date to "20240115"
    And Admin runs inline COB job for Loan
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240115" with "0.3" EUR transaction amount
    When Admin sets the business date to "20240116"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income              | 1.0    | 1.0       | 0.0      | 0.0  | 0.0       | 101.0        | false    |
      | 20240101  | Capitalized Income Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Capitalized Income Amortization | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Capitalized Income Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Capitalized Income Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Capitalized Income Amortization | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Capitalized Income Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Capitalized Income Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Capitalized Income Amortization | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Capitalized Income Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Capitalized Income Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Capitalized Income Amortization | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Capitalized Income Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Capitalized Income Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Capitalized Income Amortization | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Capitalized Income Adjustment   | 0.3    | 0.3       | 0.0      | 0.0  | 0.0       | 100.7        | false    |
      | 20240115  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Capitalized Income Amortization | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240101" contains the following data:
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
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 1.0    | 0.48             | 0.22                | 0.3             | 0.0                |
    And Admin does charge-off the loan on "20240116"
    Then Loan status will be "ACTIVE"
    And Loan marked as charged-off on "20240116"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income              | 1.0    | 1.0       | 0.0      | 0.0  | 0.0       | 101.0        | false    |
      | 20240101  | Capitalized Income Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Capitalized Income Amortization | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240103  | Capitalized Income Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240104  | Capitalized Income Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Capitalized Income Amortization | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240106  | Capitalized Income Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240107  | Capitalized Income Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240108  | Capitalized Income Amortization | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240109  | Capitalized Income Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Capitalized Income Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240111  | Capitalized Income Amortization | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240112  | Capitalized Income Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240113  | Capitalized Income Amortization | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240114  | Capitalized Income Amortization | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Capitalized Income Adjustment   | 0.3    | 0.3       | 0.0      | 0.0  | 0.0       | 100.7        | false    |
      | 20240115  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Capitalized Income Amortization | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Capitalized Income Amortization | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Charge-off                      | 101.08 | 100.7     | 0.38     | 0.0  | 0.0       | 0.0          | false    |
      | 20240116  | Capitalized Income Amortization | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240101" contains the following data:
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
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 1.0    | 0.5              | 0.0                 | 0.3             | 0.2                |

    When Loan Pay-off is made on "20240116"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4095
  Scenario: Verify GL entries for Capitalized Income Amortization - UC1: Amortization for Capitalized Income with NO classification rule
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADV_PMNT_ALLOCATION_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC_CLASSIFICATION_INCOME_MAP | 20240101   | 350            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "350" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
      | ASSET     | 112601       | Loans Receivable            | 50.0  |        |
    And Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 404000       | Interest Income             |       | 0.55   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 0.55  |        |

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4096
  Scenario: Verify GL entries for Capitalized Income Amortization - UC2: Amortization for Capitalized Income with classification rule: capitalized_income_transaction_classification_value
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADV_PMNT_ALLOCATION_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC_CLASSIFICATION_INCOME_MAP | 20240101   | 350            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "350" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount and "capitalized_income_transaction_classification_value" classification
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
      | ASSET     | 112601       | Loans Receivable            | 50.0  |        |
    And Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 744008       | Recoveries                  |       | 0.55   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 0.55  |        |

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4097
  Scenario: Verify GL entries for Capitalized Income Amortization - UC3: Amortization for Capitalized Incomes with NO classification and with classification rule: capitalized_income_transaction_classification_value
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADV_PMNT_ALLOCATION_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC_CLASSIFICATION_INCOME_MAP | 20240101   | 350            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "350" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "20" EUR transaction amount and "capitalized_income_transaction_classification_value" classification
    When Admin sets the business date to "20240103"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
      | ASSET     | 112601       | Loans Receivable            | 50.0  |        |
    And Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 404000       | Interest Income             |       | 0.55   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 0.55  |        |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 20.0   |
      | ASSET     | 112601       | Loans Receivable            | 20.0  |        |
    And Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 744008       | Recoveries                  |       | 0.22   |
      | INCOME    | 404000       | Interest Income             |       | 0.55   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 0.77  |        |

    When Loan Pay-off is made on "20240103"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4114
  Scenario: Verify Capitalized Income journal entries values when backdated new capitalized income with no classification and capitalized income adjustment for existing one with classification occurs on the same day
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADV_PMNT_ALLOCATION_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC_CLASSIFICATION_INCOME_MAP | 20240101   | 200            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount and "capitalized_income_transaction_classification_value" classification
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      |    |      | 20240101  |           | 50.0            |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 0.0  | 0.0        | 0.0  | 50.58       |
      | 2  | 29   | 20240301    |           | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 0.0  | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |           | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 0.0  | 0.0        | 0.0  | 50.59       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75  | 0.0   | 0.0        | 0.0  | 151.75      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    And Loan Transactions tab has a "Capitalized Income" transaction with date "20240101" which has classification code value "capitalized_income_transaction_classification_value"
    Then LoanCapitalizedIncomeTransactionCreatedBusinessEvent is raised on "20240101"
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240101" with "25" EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type              | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                  | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income            | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Adjustment | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 125.0        | false    | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable             | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |       | 50.0   |
    And Loan Transactions tab has a "CAPITALIZED_INCOME_ADJUSTMENT" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable            |       | 25.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 25.0  |        |
    When Admin sets the business date to "20240415"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Adjustment   | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 125.0        | false    | false    |
      | 20240401    | Accrual                         | 2.04   | 0.0       | 2.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240414    | Capitalized Income Amortization | 25.0   | 0.0       | 25.0     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20240414" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 744008       | Recoveries                  |       | 25.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 25.0  |        |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240101" contains the following data:
      | Date          | Type | Amount |
      | 20240414 | AM   | 25.0   |
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "30" EUR transaction amount
    When Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240101" with "5" EUR transaction amount
    When Admin sets the business date to "20240416"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Adjustment   | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 125.0        | false    | false    |
      | 20240101  | Capitalized Income              | 30.0   | 30.0      | 0.0      | 0.0  | 0.0       | 155.0        | false    | false    |
      | 20240101  | Capitalized Income Adjustment   | 5.0    | 5.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240401    | Accrual                         | 2.04   | 0.0       | 2.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240414    | Capitalized Income Amortization | 25.0   | 0.0       | 25.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240415    | Capitalized Income Amortization | 25.0   | 0.0       | 25.0     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for the "1"th "CAPITALIZED_INCOME" transaction created on "20240101" contains the following data:
      | Date          | Type   | Amount |
      | 20240414 | AM     | 25.0   |
      | 20240415 | AM_ADJ | 5.0    |
    And Loan Amortization Allocation Mapping for the "2"th "CAPITALIZED_INCOME" transaction created on "20240101" contains the following data:
      | Date          | Type   | Amount |
      | 20240415 | AM     | 30.0   |
    And Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20240415" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 404000       | Interest Income             |       | 30.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 5.0    |
      | LIABILITY | 145024       | Deferred Capitalized Income | 30.0  |        |
      | INCOME    | 744008       | Recoveries                  | 5.0   |        |

    When Loan Pay-off is made on "20240416"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4115
  Scenario: Verify Capitalized Income journal entries values when backdated new capitalized income and capitalized income adjustment for existing one occurs on the same day, no classification
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 200            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      |    |      | 20240101  |           | 50.0            |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 0.0  | 0.0        | 0.0  | 50.58       |
      | 2  | 29   | 20240301    |           | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 0.0  | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |           | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 0.0  | 0.0        | 0.0  | 50.59       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75  | 0.0   | 0.0        | 0.0  | 151.75      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable            | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
    Then LoanCapitalizedIncomeTransactionCreatedBusinessEvent is raised on "20240101"
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240101" with "25" EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type              | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                  | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income            | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Adjustment | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 125.0        | false    | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable             | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |       | 50.0   |
    And Loan Transactions tab has a "CAPITALIZED_INCOME_ADJUSTMENT" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable            |       | 25.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 25.0  |        |
    When Admin sets the business date to "20240415"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Adjustment   | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 125.0        | false    | false    |
      | 20240401    | Accrual                         | 2.04   | 0.0       | 2.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240414    | Capitalized Income Amortization | 25.0   | 0.0       | 25.0     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20240414" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 404000       | Interest Income             |       | 25.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 25.0  |        |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20240101" contains the following data:
      | Date          | Type | Amount |
      | 20240414 | AM   | 25.0   |
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "30" EUR transaction amount
    When Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240101" with "5" EUR transaction amount
    When Admin sets the business date to "20240416"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Adjustment   | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 125.0        | false    | false    |
      | 20240101  | Capitalized Income              | 30.0   | 30.0      | 0.0      | 0.0  | 0.0       | 155.0        | false    | false    |
      | 20240101  | Capitalized Income Adjustment   | 5.0    | 5.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240401    | Accrual                         | 2.04   | 0.0       | 2.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240414    | Capitalized Income Amortization | 25.0   | 0.0       | 25.0     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240415    | Capitalized Income Amortization | 25.0   | 0.0       | 25.0     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for the "1"th "CAPITALIZED_INCOME" transaction created on "20240101" contains the following data:
      | Date          | Type   | Amount |
      | 20240414 | AM     | 25.0   |
      | 20240415 | AM_ADJ | 5.0    |
    And Loan Amortization Allocation Mapping for the "2"th "CAPITALIZED_INCOME" transaction created on "20240101" contains the following data:
      | Date          | Type   | Amount |
      | 20240415 | AM     | 30.0   |
    And Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20240415" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 404000       | Interest Income             |       | 30.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 5.0    |
      | LIABILITY | 145024       | Deferred Capitalized Income | 30.0  |        |
      | INCOME    | 404000       | Interest Income             | 5.0   |        |

    When Loan Pay-off is made on "20240416"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C85353
  Scenario: Verify Capitalized Income amortization allocation mappings after loan re-open via repayment reversal
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20260101   | 250            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260101" with "250" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the loan on "20260101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20260101" with "50" EUR transaction amount
    When Admin sets the business date to "20260102"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20260101  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20260101" contains the following data:
      | Date            | Type | Amount |
      | 20260101 | AM   | 0.56   |
    When Admin sets the business date to "20260103"
    When Loan Pay-off is made on "20260103"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20260101  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Repayment                       | 150.06 | 150.0     | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Accrual                         | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Capitalized Income Amortization | 49.44  | 0.0       | 49.44    | 0.0  | 0.0       | 0.0          | false    | false    |
    When Customer undo "1"th "Repayment" transaction made on "20260103"
    Then Loan status will be "ACTIVE"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20260101  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Repayment                       | 150.06 | 150.0     | 0.06     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20260103  | Accrual                         | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Capitalized Income Amortization | 49.44  | 0.0       | 49.44    | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20260104"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20260101  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Repayment                       | 150.06 | 150.0     | 0.06     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20260103  | Accrual                         | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Capitalized Income Amortization | 49.44  | 0.0       | 49.44    | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20260101" contains the following data:
      | Date            | Type | Amount |
      | 20260101 | AM   | 0.56   |
      | 20260103 | AM   | 49.44  |
    When Admin sets the business date to "20260105"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20260101  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Repayment                       | 150.06 | 150.0     | 0.06     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20260103  | Accrual                         | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Capitalized Income Amortization | 49.44  | 0.0       | 49.44    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260104  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20260101" contains the following data:
      | Date            | Type | Amount |
      | 20260101 | AM   | 0.56   |
      | 20260103 | AM   | 49.44  |

    When Loan Pay-off is made on "20260105"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C85354
  Scenario: Verify Capitalized Income amortization allocation mappings after loan re-open via payout refund reversal
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20260101   | 250            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260101" with "250" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the loan on "20260101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20260101" with "50" EUR transaction amount
    When Admin sets the business date to "20260102"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20260101  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20260101" contains the following data:
      | Date            | Type | Amount |
      | 20260101 | AM   | 0.56   |
    When Admin sets the business date to "20260103"
    And Customer makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20260103" with 150.06 EUR transaction amount and self-generated Idempotency key
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20260101  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Payout Refund                   | 150.06 | 150.0     | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Accrual                         | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Capitalized Income Amortization | 49.44  | 0.0       | 49.44    | 0.0  | 0.0       | 0.0          | false    | false    |
    When Customer undo "1"th "Payout Refund" transaction made on "20260103"
    Then Loan status will be "ACTIVE"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20260101  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Payout Refund                   | 150.06 | 150.0     | 0.06     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20260103  | Accrual                         | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Capitalized Income Amortization | 49.44  | 0.0       | 49.44    | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20260104"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20260101  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Payout Refund                   | 150.06 | 150.0     | 0.06     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20260103  | Accrual                         | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Capitalized Income Amortization | 49.44  | 0.0       | 49.44    | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20260101" contains the following data:
      | Date            | Type | Amount |
      | 20260101 | AM   | 0.56   |
      | 20260103 | AM   | 49.44  |
    When Admin sets the business date to "20260105"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20260101  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Payout Refund                   | 150.06 | 150.0     | 0.06     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20260103  | Accrual                         | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260103  | Capitalized Income Amortization | 49.44  | 0.0       | 49.44    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260104  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Amortization Allocation Mapping for "CAPITALIZED_INCOME" transaction created on "20260101" contains the following data:
      | Date            | Type | Amount |
      | 20260101 | AM   | 0.56   |
      | 20260103 | AM   | 49.44  |

    When Loan Pay-off is made on "20260105"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
