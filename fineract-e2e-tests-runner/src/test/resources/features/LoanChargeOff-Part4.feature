@ChargeOffFeature
Feature: Charge-off - Part4

  @TestRailId:C3622
  Scenario: Verify repayment reversal after charge-off and merchant issued refund and interestRecalculation=false
    When Admin sets the business date to "20250314"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_NO_INTEREST_RECALC_REFUND_FULL | 20250314     | 900            | 9.9                    | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250314" with "900" amount and expected disbursement date on "20250314"
    And Admin successfully disburse the loan on "20250314" with "900" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250314 |           | 900.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250414 |           | 677.88          | 222.12        | 7.57     | 0.0  | 0.0       | 229.69 | 0.0  | 0.0        | 0.0  | 229.69      |
      | 2  | 30   | 20250514   |           | 453.71          | 224.17        | 5.52     | 0.0  | 0.0       | 229.69 | 0.0  | 0.0        | 0.0  | 229.69      |
      | 3  | 31   | 20250614  |           | 227.83          | 225.88        | 3.81     | 0.0  | 0.0       | 229.69 | 0.0  | 0.0        | 0.0  | 229.69      |
      | 4  | 30   | 20250714  |           | 0.0             | 227.83        | 1.85     | 0.0  | 0.0       | 229.68 | 0.0  | 0.0        | 0.0  | 229.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 900.0         | 18.75    | 0.0  | 0.0       | 918.75 | 0.0  | 0.0        | 0.0  | 918.75      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250314    | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        |
    When Admin sets the business date to "20250405"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250405" with 100 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250314 |           | 900.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20250414 |           | 677.88          | 222.12        | 7.57     | 0.0  | 0.0       | 229.69 | 100.0 | 100.0      | 0.0  | 129.69      |
      | 2  | 30   | 20250514   |           | 453.71          | 224.17        | 5.52     | 0.0  | 0.0       | 229.69 | 0.0   | 0.0        | 0.0  | 229.69      |
      | 3  | 31   | 20250614  |           | 227.83          | 225.88        | 3.81     | 0.0  | 0.0       | 229.69 | 0.0   | 0.0        | 0.0  | 229.69      |
      | 4  | 30   | 20250714  |           | 0.0             | 227.83        | 1.85     | 0.0  | 0.0       | 229.68 | 0.0   | 0.0        | 0.0  | 229.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 900.0         | 18.75    | 0.0  | 0.0       | 918.75 | 100.0 | 100.0      | 0.0  | 818.75      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250314    | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        |
      | 20250405    | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 800.0        |
    When Admin sets the business date to "20250414"
    And Admin does charge-off the loan on "20250414"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250314 |           | 900.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20250414 |           | 677.88          | 222.12        | 7.57     | 0.0  | 0.0       | 229.69 | 100.0 | 100.0      | 0.0  | 129.69      |
      | 2  | 30   | 20250514   |           | 453.71          | 224.17        | 5.52     | 0.0  | 0.0       | 229.69 | 0.0   | 0.0        | 0.0  | 229.69      |
      | 3  | 31   | 20250614  |           | 227.83          | 225.88        | 3.81     | 0.0  | 0.0       | 229.69 | 0.0   | 0.0        | 0.0  | 229.69      |
      | 4  | 30   | 20250714  |           | 0.0             | 227.83        | 1.85     | 0.0  | 0.0       | 229.68 | 0.0   | 0.0        | 0.0  | 229.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 900.0         | 18.75    | 0.0  | 0.0       | 918.75 | 100.0 | 100.0      | 0.0  | 818.75      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250314    | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        |
      | 20250405    | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 800.0        |
      | 20250414    | Accrual          | 7.57   | 0.0       | 7.57     | 0.0  | 0.0       | 0.0          |
      | 20250414    | Charge-off       | 818.75 | 800.0     | 18.75    | 0.0  | 0.0       | 0.0          |
    When Admin sets the business date to "20250415"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250415" with 900 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250314 |               | 900.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250414 | 20250415 | 677.88          | 222.12        | 7.57     | 0.0  | 0.0       | 229.69 | 229.69 | 100.0      | 129.69 | 0.0         |
      | 2  | 30   | 20250514   | 20250415 | 453.71          | 224.17        | 5.52     | 0.0  | 0.0       | 229.69 | 229.69 | 229.69     | 0.0    | 0.0         |
      | 3  | 31   | 20250614  | 20250415 | 227.83          | 225.88        | 3.81     | 0.0  | 0.0       | 229.69 | 229.69 | 229.69     | 0.0    | 0.0         |
      | 4  | 30   | 20250714  | 20250415 | 0.0             | 227.83        | 1.85     | 0.0  | 0.0       | 229.68 | 229.68 | 229.68     | 0.0    | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      | 900.0         | 18.75    | 0.0  | 0.0       | 918.75 | 918.75 | 789.06     | 129.69 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250314    | Disbursement           | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        |
      | 20250405    | Repayment              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 800.0        |
      | 20250414    | Accrual                | 7.57   | 0.0       | 7.57     | 0.0  | 0.0       | 0.0          |
      | 20250414    | Charge-off             | 818.75 | 800.0     | 18.75    | 0.0  | 0.0       | 0.0          |
      | 20250415    | Merchant Issued Refund | 900.0  | 800.0     | 18.75    | 0.0  | 0.0       | 0.0          |
    When Customer undo "1"th repayment on "20250405"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250314 |               | 900.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250414 | 20250415 | 677.88          | 222.12        | 7.57     | 0.0  | 0.0       | 229.69 | 229.69 | 0.0        | 229.69 | 0.0         |
      | 2  | 30   | 20250514   | 20250415 | 453.71          | 224.17        | 5.52     | 0.0  | 0.0       | 229.69 | 229.69 | 229.69     | 0.0    | 0.0         |
      | 3  | 31   | 20250614  | 20250415 | 227.83          | 225.88        | 3.81     | 0.0  | 0.0       | 229.69 | 229.69 | 229.69     | 0.0    | 0.0         |
      | 4  | 30   | 20250714  |               | 0.0             | 227.83        | 1.85     | 0.0  | 0.0       | 229.68 | 210.93 | 210.93     | 0.0    | 18.75       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late   | Outstanding |
      | 900.0         | 18.75    | 0.0  | 0.0       | 918.75 | 900.0 | 670.31     | 229.69 | 18.75       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250314    | Disbursement           | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
      | 20250405    | Repayment              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 800.0        | true     | false    |
      | 20250414    | Accrual                | 7.57   | 0.0       | 7.57     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250414    | Charge-off             | 918.75 | 900.0     | 18.75    | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20250415    | Merchant Issued Refund | 900.0  | 883.1     | 16.9     | 0.0  | 0.0       | 16.9         | false    | true     |

  @TestRailId:C3623
  Scenario: Verify repayment reversal after zero interest behaviour charge-off and merchant issued refund and interestRecalculation=false
    When Admin sets the business date to "20250314"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INT_DAILY_EMI_ACTUAL_ACTUAL_NO_INTEREST_RECALC_INT_REFUND_FULL_ZERO_INT_CHARGE_OFF | 20250314     | 900            | 9.9                    | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250314" with "900" amount and expected disbursement date on "20250314"
    And Admin successfully disburse the loan on "20250314" with "900" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250314 |           | 900.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250414 |           | 677.88          | 222.12        | 7.57     | 0.0  | 0.0       | 229.69 | 0.0  | 0.0        | 0.0  | 229.69      |
      | 2  | 30   | 20250514   |           | 453.71          | 224.17        | 5.52     | 0.0  | 0.0       | 229.69 | 0.0  | 0.0        | 0.0  | 229.69      |
      | 3  | 31   | 20250614  |           | 227.83          | 225.88        | 3.81     | 0.0  | 0.0       | 229.69 | 0.0  | 0.0        | 0.0  | 229.69      |
      | 4  | 30   | 20250714  |           | 0.0             | 227.83        | 1.85     | 0.0  | 0.0       | 229.68 | 0.0  | 0.0        | 0.0  | 229.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 900.0         | 18.75    | 0.0  | 0.0       | 918.75 | 0.0  | 0.0        | 0.0  | 918.75      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250314    | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        |
    When Admin sets the business date to "20250405"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250405" with 100 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250314 |           | 900.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20250414 |           | 677.88          | 222.12        | 7.57     | 0.0  | 0.0       | 229.69 | 100.0 | 100.0      | 0.0  | 129.69      |
      | 2  | 30   | 20250514   |           | 453.71          | 224.17        | 5.52     | 0.0  | 0.0       | 229.69 | 0.0   | 0.0        | 0.0  | 229.69      |
      | 3  | 31   | 20250614  |           | 227.83          | 225.88        | 3.81     | 0.0  | 0.0       | 229.69 | 0.0   | 0.0        | 0.0  | 229.69      |
      | 4  | 30   | 20250714  |           | 0.0             | 227.83        | 1.85     | 0.0  | 0.0       | 229.68 | 0.0   | 0.0        | 0.0  | 229.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 900.0         | 18.75    | 0.0  | 0.0       | 918.75 | 100.0 | 100.0      | 0.0  | 818.75      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250314    | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        |
      | 20250405    | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 800.0        |
    When Admin sets the business date to "20250414"
    And Admin does charge-off the loan on "20250414"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250314 |           | 900.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20250414 |           | 677.88          | 222.12        | 7.57     | 0.0  | 0.0       | 229.69 | 100.0 | 100.0      | 0.0  | 129.69      |
      | 2  | 30   | 20250514   |           | 448.19          | 229.69        | 0.0      | 0.0  | 0.0       | 229.69 | 0.0   | 0.0        | 0.0  | 229.69      |
      | 3  | 31   | 20250614  |           | 218.5           | 229.69        | 0.0      | 0.0  | 0.0       | 229.69 | 0.0   | 0.0        | 0.0  | 229.69      |
      | 4  | 30   | 20250714  |           | 0.0             | 218.5         | 0.0      | 0.0  | 0.0       | 218.5  | 0.0   | 0.0        | 0.0  | 218.5       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 900.0         | 7.57     | 0.0  | 0.0       | 907.57 | 100.0 | 100.0      | 0.0  | 807.57      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250314    | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        |
      | 20250405    | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 800.0        |
      | 20250414    | Accrual          | 7.57   | 0.0       | 7.57     | 0.0  | 0.0       | 0.0          |
      | 20250414    | Charge-off       | 807.57 | 800.0     | 7.57     | 0.0  | 0.0       | 0.0          |
    When Admin sets the business date to "20250415"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250415" with 900 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250314 |               | 900.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250414 | 20250415 | 677.88          | 222.12        | 7.57     | 0.0  | 0.0       | 229.69 | 229.69 | 100.0      | 129.69 | 0.0         |
      | 2  | 30   | 20250514   | 20250415 | 448.19          | 229.69        | 0.0      | 0.0  | 0.0       | 229.69 | 229.69 | 229.69     | 0.0    | 0.0         |
      | 3  | 31   | 20250614  | 20250415 | 218.5           | 229.69        | 0.0      | 0.0  | 0.0       | 229.69 | 229.69 | 229.69     | 0.0    | 0.0         |
      | 4  | 30   | 20250714  | 20250415 | 0.0             | 218.5         | 0.0      | 0.0  | 0.0       | 218.5  | 218.5  | 218.5      | 0.0    | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      | 900.0         | 7.57     | 0.0  | 0.0       | 907.57 | 907.57 | 777.88     | 129.69 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250314    | Disbursement           | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        |
      | 20250405    | Repayment              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 800.0        |
      | 20250414    | Accrual                | 7.57   | 0.0       | 7.57     | 0.0  | 0.0       | 0.0          |
      | 20250414    | Charge-off             | 807.57 | 800.0     | 7.57     | 0.0  | 0.0       | 0.0          |
      | 20250415    | Merchant Issued Refund | 900.0  | 800.0     | 7.57     | 0.0  | 0.0       | 0.0          |
    When Customer undo "1"th repayment on "20250405"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250314 |               | 900.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250414 | 20250415 | 677.88          | 222.12        | 7.57     | 0.0  | 0.0       | 229.69 | 229.69 | 0.0        | 229.69 | 0.0         |
      | 2  | 30   | 20250514   | 20250415 | 448.19          | 229.69        | 0.0      | 0.0  | 0.0       | 229.69 | 229.69 | 229.69     | 0.0    | 0.0         |
      | 3  | 31   | 20250614  | 20250415 | 218.5           | 229.69        | 0.0      | 0.0  | 0.0       | 229.69 | 229.69 | 229.69     | 0.0    | 0.0         |
      | 4  | 30   | 20250714  |               | 0.0             | 218.5         | 0.0      | 0.0  | 0.0       | 218.5  | 210.93 | 210.93     | 0.0    | 7.57        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late   | Outstanding |
      | 900.0         | 7.57     | 0.0  | 0.0       | 907.57 | 900.0 | 670.31     | 229.69 | 7.57        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250314    | Disbursement           | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
      | 20250405    | Repayment              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 800.0        | true     | false    |
      | 20250414    | Accrual                | 7.57   | 0.0       | 7.57     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250414    | Charge-off             | 907.57 | 900.0     | 7.57     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20250415    | Merchant Issued Refund | 900.0  | 892.43    | 7.57     | 0.0  | 0.0       | 7.57         | false    | true     |

  @TestRailId:C3624
  Scenario: Verify repayment reversal after accelerate maturity behaviour charge-off and merchant issued refund and interestRecalculation=false
    When Admin sets the business date to "20250314"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INT_DAILY_EMI_ACTUAL_ACTUAL_NO_INTEREST_RECALC_INT_REFUND_FULL_ACC_MATUR_CHARGE_OFF | 20250314     | 900            | 9.9                    | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250314" with "900" amount and expected disbursement date on "20250314"
    And Admin successfully disburse the loan on "20250314" with "900" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250314 |           | 900.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250414 |           | 677.88          | 222.12        | 7.57     | 0.0  | 0.0       | 229.69 | 0.0  | 0.0        | 0.0  | 229.69      |
      | 2  | 30   | 20250514   |           | 453.71          | 224.17        | 5.52     | 0.0  | 0.0       | 229.69 | 0.0  | 0.0        | 0.0  | 229.69      |
      | 3  | 31   | 20250614  |           | 227.83          | 225.88        | 3.81     | 0.0  | 0.0       | 229.69 | 0.0  | 0.0        | 0.0  | 229.69      |
      | 4  | 30   | 20250714  |           | 0.0             | 227.83        | 1.85     | 0.0  | 0.0       | 229.68 | 0.0  | 0.0        | 0.0  | 229.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 900.0         | 18.75    | 0.0  | 0.0       | 918.75 | 0.0  | 0.0        | 0.0  | 918.75      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250314    | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        |
    When Admin sets the business date to "20250405"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250405" with 100 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250314 |           | 900.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20250414 |           | 677.88          | 222.12        | 7.57     | 0.0  | 0.0       | 229.69 | 100.0 | 100.0      | 0.0  | 129.69      |
      | 2  | 30   | 20250514   |           | 453.71          | 224.17        | 5.52     | 0.0  | 0.0       | 229.69 | 0.0   | 0.0        | 0.0  | 229.69      |
      | 3  | 31   | 20250614  |           | 227.83          | 225.88        | 3.81     | 0.0  | 0.0       | 229.69 | 0.0   | 0.0        | 0.0  | 229.69      |
      | 4  | 30   | 20250714  |           | 0.0             | 227.83        | 1.85     | 0.0  | 0.0       | 229.68 | 0.0   | 0.0        | 0.0  | 229.68      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 900.0         | 18.75    | 0.0  | 0.0       | 918.75 | 100.0 | 100.0      | 0.0  | 818.75      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250314    | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        |
      | 20250405    | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 800.0        |
    When Admin sets the business date to "20250414"
    And Admin does charge-off the loan on "20250414"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250314 |           | 900.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20250414 |           | 0.0             | 900.0         | 7.57     | 0.0  | 0.0       | 907.57 | 100.0 | 100.0      | 0.0  | 807.57      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 900.0         | 7.57     | 0.0  | 0.0       | 907.57 | 100.0 | 100.0      | 0.0  | 807.57      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250314    | Disbursement     | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        |
      | 20250405    | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 800.0        |
      | 20250414    | Accrual          | 7.57   | 0.0       | 7.57     | 0.0  | 0.0       | 0.0          |
      | 20250414    | Charge-off       | 807.57 | 800.0     | 7.57     | 0.0  | 0.0       | 0.0          |
    When Admin sets the business date to "20250415"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250415" with 900 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250314 |               | 900.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250414 | 20250415 | 0.0             | 900.0         | 7.57     | 0.0  | 0.0       | 907.57 | 907.57 | 100.0      | 807.57 | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      | 900.0         | 7.57     | 0.0  | 0.0       | 907.57 | 907.57 | 100.0      | 807.57 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250314    | Disbursement           | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        |
      | 20250405    | Repayment              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 800.0        |
      | 20250414    | Accrual                | 7.57   | 0.0       | 7.57     | 0.0  | 0.0       | 0.0          |
      | 20250414    | Charge-off             | 807.57 | 800.0     | 7.57     | 0.0  | 0.0       | 0.0          |
      | 20250415    | Merchant Issued Refund | 900.0  | 800.0     | 7.57     | 0.0  | 0.0       | 0.0          |
    When Customer undo "1"th repayment on "20250405"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250314 |           | 900.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |       |             |
      | 1  | 31   | 20250414 |           | 0.0             | 900.0         | 7.57     | 0.0  | 0.0       | 907.57 | 900.0 | 0.0        | 900.0 | 7.57        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 900.0         | 7.57     | 0.0  | 0.0       | 907.57 | 900.0 | 0.0        | 900.0 | 7.57        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250314    | Disbursement           | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
      | 20250405    | Repayment              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 800.0        | true     | false    |
      | 20250414    | Accrual                | 7.57   | 0.0       | 7.57     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250414    | Charge-off             | 907.57 | 900.0     | 7.57     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20250415    | Merchant Issued Refund | 900.0  | 900.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | true     |

  @TestRailId:C3643
  Scenario: As a user I want to verify that charge-off transaction if the amount balance becomes zero is reversed after backdated full repayment and MIR, interestRecalculation = false
    When Admin sets the business date to "20250311"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_ZERO_INTEREST_CHARGE_OFF_DELINQUENT_REASON | 20250311     | 500            | 7                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250311" with "500" amount and expected disbursement date on "20250311"
    And Admin successfully disburse the loan on "20250311" with "500" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Waived | Outstanding |
      |    |      | 20250311    |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |        |             |
      | 1  | 31   | 20250411    |                  | 417.92          | 82.08         | 2.92     | 0.0  | 0.0       | 85.0  | 0.0   | 0.0        | 0.0  | 0.0    | 85.0        |
      | 2  | 30   | 20250511      |                  | 335.36          | 82.56         | 2.44     | 0.0  | 0.0       | 85.0  | 0.0   | 0.0        | 0.0  | 0.0    | 85.0        |
      | 3  | 31   | 20250611     |                  | 252.32          | 83.04         | 1.96     | 0.0  | 0.0       | 85.0  | 0.0   | 0.0        | 0.0  | 0.0    | 85.0        |
      | 4  | 30   | 20250711     |                  | 168.79          | 83.53         | 1.47     | 0.0  | 0.0       | 85.0  | 0.0   | 0.0        | 0.0  | 0.0    | 85.0        |
      | 5  | 31   | 20250811   |                  | 84.77           | 84.02         | 0.98     | 0.0  | 0.0       | 85.0  | 0.0   | 0.0        | 0.0  | 0.0    | 85.0        |
      | 6  | 31   | 20250911|                  | 0.0             | 84.77         | 0.49     | 0.0  | 0.0       | 85.26 | 0.0   | 0.0        | 0.0  | 0.0    | 85.26       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Waived | Outstanding |
      | 500.0         | 10.26    | 0.0  | 0         | 510.26 | 0.0   | 0          | 0    | 0.0    | 510.26      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250311    | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
    Then Admin can successfully set Fraud flag to the loan
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20250414"
    And Admin does charge-off the loan with reason "DELINQUENT" on "20250414"
    Then LoanBalanceChangedBusinessEvent is created on "20250414"
    Then Loan marked as charged-off on "20250414"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Waived | Outstanding |
      |    |      | 20250311     |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |        |             |
      | 1  | 31   | 20250411     |           | 417.92          | 82.08         | 2.92     | 0.0  | 0.0       | 85.0  | 0.0  | 0.0        | 0.0  | 0.0    | 85.0        |
      | 2  | 30   | 20250511       |           | 333.16          | 84.76         | 0.24     | 0.0  | 0.0       | 85.0  | 0.0  | 0.0        | 0.0  | 0.0    | 85.0        |
      | 3  | 31   | 20250611      |           | 248.16          | 85.0          | 0.0      | 0.0  | 0.0       | 85.0  | 0.0  | 0.0        | 0.0  | 0.0    | 85.0        |
      | 4  | 30   | 20250711      |           | 163.16          | 85.0          | 0.0      | 0.0  | 0.0       | 85.0  | 0.0  | 0.0        | 0.0  | 0.0    | 85.0        |
      | 5  | 31   | 20250811    |           | 78.16           | 85.0          | 0.0      | 0.0  | 0.0       | 85.0  | 0.0  | 0.0        | 0.0  | 0.0    | 85.0        |
      | 6  | 31   | 20250911 |           | 0.0             | 78.16         | 0.0      | 0.0  | 0.0       | 78.16 | 0.0  | 0.0        | 0.0  | 0.0    | 78.16       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Waived | Outstanding |
      | 500.0         | 3.16     | 0.0  | 0         | 503.16 | 0    | 0          | 0    | 0.0    | 503.16      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250311    | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20250414    | Accrual          | 3.16   | 0.0       | 3.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250414    | Charge-off       | 503.16 | 500.0     | 3.16     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin runs inline COB job for Loan
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250413" with 500 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Waived | Outstanding |
      |    |      | 20250311     |                | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |        |             |
      | 1  | 31   | 20250411     | 20250413  | 417.92          | 82.08         | 2.92     | 0.0  | 0.0       | 85.0  | 85.0  | 0.0        | 85.0 | 0.0    | 0.0         |
      | 2  | 30   | 20250511       | 20250413  | 335.36          | 82.56         | 2.44     | 0.0  | 0.0       | 85.0  | 85.0  | 85.0       | 0.0  | 0.0    | 0.0         |
      | 3  | 31   | 20250611      | 20250413  | 252.32          | 83.04         | 1.96     | 0.0  | 0.0       | 85.0  | 85.0  | 85.0       | 0.0  | 0.0    | 0.0         |
      | 4  | 30   | 20250711      | 20250413  | 168.79          | 83.53         | 1.47     | 0.0  | 0.0       | 85.0  | 85.0  | 85.0       | 0.0  | 0.0    | 0.0         |
      | 5  | 31   | 20250811    | 20250413  | 84.77           | 84.02         | 0.98     | 0.0  | 0.0       | 85.0  | 85.0  | 85.0       | 0.0  | 0.0    | 0.0         |
      | 6  | 31   | 20250911 |                | 0.0             | 84.77         | 0.0      | 0.0  | 0.0       | 84.77 | 75.0  | 75.0       | 0.0  | 0.0    | 9.77        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Waived | Outstanding |
      | 500.0         | 9.77     | 0.0  | 0         | 509.77 | 500.0 | 415.0      | 85.0 | 0.0    | 9.77        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type    | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250311    | Disbursement        | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20250413    | Repayment           | 500.0  | 490.23    | 9.77     | 0.0  | 0.0       | 9.77         | false    | false    |
      | 20250414    | Accrual             | 3.16   | 0.0       | 3.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250414    | Accrual Adjustment  | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250414    | Charge-off          | 9.77   | 9.77      | 0.0      | 0.0  | 0.0       | 0.0          | false    | true     |
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250413" with 500 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Waived | Outstanding |
      |    |      | 20250311     |                | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |        |             |
      | 1  | 31   | 20250411     | 20250413  | 417.92          | 82.08         | 2.92     | 0.0  | 0.0       | 85.0  | 85.0  | 0.0        | 85.0 | 0.0    | 0.0         |
      | 2  | 30   | 20250511       | 20250413  | 335.36          | 82.56         | 2.44     | 0.0  | 0.0       | 85.0  | 85.0  | 85.0       | 0.0  | 0.0    | 0.0         |
      | 3  | 31   | 20250611      | 20250413  | 252.32          | 83.04         | 1.96     | 0.0  | 0.0       | 85.0  | 85.0  | 85.0       | 0.0  | 0.0    | 0.0         |
      | 4  | 30   | 20250711      | 20250413  | 168.79          | 83.53         | 1.47     | 0.0  | 0.0       | 85.0  | 85.0  | 85.0       | 0.0  | 0.0    | 0.0         |
      | 5  | 31   | 20250811    | 20250413  | 84.77           | 84.02         | 0.98     | 0.0  | 0.0       | 85.0  | 85.0  | 85.0       | 0.0  | 0.0    | 0.0         |
      | 6  | 31   | 20250911 | 20250413  | 0.0             | 84.77         | 0.49     | 0.0  | 0.0       | 85.26 | 85.26 | 85.26      | 0.0  | 0.0    | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Waived | Outstanding |
      | 500.0         | 10.26    | 0.0  | 0         | 510.26 | 510.26 | 425.26     | 85.0  | 0.0    | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250311    | Disbursement            | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20250413    | Repayment               | 500.0  | 490.23    | 9.77     | 0.0  | 0.0       | 9.77         | false    | false    |
      | 20250413    | Merchant Issued Refund  | 500.0  | 9.77      | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250414    | Accrual                 | 3.16   | 0.0       | 3.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250414    | Accrual Adjustment      | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250414    | Accrual                 | 7.34   | 0.0       | 7.34     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3644
  Scenario: As a user I want to verify that charge-off transaction if the amount balance becomes zero is reversed after backdated full repayment and MIR, interestRecalculation = true
    When Admin sets the business date to "20250311"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_ZERO_INTEREST_CHARGE_OFF_DELINQUENT_REASON_INTEREST_RECALC | 20250311     | 500            | 7                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250311" with "500" amount and expected disbursement date on "20250311"
    And Admin successfully disburse the loan on "20250311" with "500" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Waived | Outstanding |
      |    |      | 20250311    |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |        |             |
      | 1  | 31   | 20250411    |                  | 417.92          | 82.08         | 2.92     | 0.0  | 0.0       | 85.0  | 0.0   | 0.0        | 0.0  | 0.0    | 85.0        |
      | 2  | 30   | 20250511      |                  | 335.36          | 82.56         | 2.44     | 0.0  | 0.0       | 85.0  | 0.0   | 0.0        | 0.0  | 0.0    | 85.0        |
      | 3  | 31   | 20250611     |                  | 252.32          | 83.04         | 1.96     | 0.0  | 0.0       | 85.0  | 0.0   | 0.0        | 0.0  | 0.0    | 85.0        |
      | 4  | 30   | 20250711     |                  | 168.79          | 83.53         | 1.47     | 0.0  | 0.0       | 85.0  | 0.0   | 0.0        | 0.0  | 0.0    | 85.0        |
      | 5  | 31   | 20250811   |                  | 84.77           | 84.02         | 0.98     | 0.0  | 0.0       | 85.0  | 0.0   | 0.0        | 0.0  | 0.0    | 85.0        |
      | 6  | 31   | 20250911|                  | 0.0             | 84.77         | 0.49     | 0.0  | 0.0       | 85.26 | 0.0   | 0.0        | 0.0  | 0.0    | 85.26       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Waived | Outstanding |
      | 500.0         | 10.26    | 0.0  | 0         | 510.26 | 0.0   | 0          | 0    | 0.0    | 510.26      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250311    | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
    Then Admin can successfully set Fraud flag to the loan
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20250414"
    And Admin does charge-off the loan with reason "DELINQUENT" on "20250414"
    Then LoanBalanceChangedBusinessEvent is created on "20250414"
    Then Loan marked as charged-off on "20250414"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Waived | Outstanding |
      |    |      | 20250311     |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |        |             |
      | 1  | 31   | 20250411     |           | 417.92          | 82.08         | 2.92     | 0.0  | 0.0       | 85.0  | 0.0  | 0.0        | 0.0  | 0.0    | 85.0        |
      | 2  | 30   | 20250511       |           | 333.21          | 84.71         | 0.29     | 0.0  | 0.0       | 85.0  | 0.0  | 0.0        | 0.0  | 0.0    | 85.0        |
      | 3  | 31   | 20250611      |           | 248.21          | 85.0          | 0.0      | 0.0  | 0.0       | 85.0  | 0.0  | 0.0        | 0.0  | 0.0    | 85.0        |
      | 4  | 30   | 20250711      |           | 163.21          | 85.0          | 0.0      | 0.0  | 0.0       | 85.0  | 0.0  | 0.0        | 0.0  | 0.0    | 85.0        |
      | 5  | 31   | 20250811    |           | 78.21           | 85.0          | 0.0      | 0.0  | 0.0       | 85.0  | 0.0  | 0.0        | 0.0  | 0.0    | 85.0        |
      | 6  | 31   | 20250911 |           | 0.0             | 78.21         | 0.0      | 0.0  | 0.0       | 78.21 | 0.0  | 0.0        | 0.0  | 0.0    | 78.21       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Waived | Outstanding |
      | 500.0         | 3.21     | 0.0  | 0         | 503.21 | 0    | 0          | 0    | 0.0    | 503.21      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250311    | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20250414    | Accrual          | 3.21   | 0.0       | 3.21     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250414    | Charge-off       | 503.21 | 500.0     | 3.21     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin runs inline COB job for Loan
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250413" with 500 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Waived | Outstanding |
      |    |      | 20250311     |                | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |        |             |
      | 1  | 31   | 20250411     | 20250413  | 417.92          | 82.08         | 2.92     | 0.0  | 0.0       | 85.0  | 85.0  | 0.0        | 85.0 | 0.0    | 0.0         |
      | 2  | 30   | 20250511       | 20250413  | 333.12          | 84.8          | 0.2      | 0.0  | 0.0       | 85.0  | 85.0  | 85.0       | 0.0  | 0.0    | 0.0         |
      | 3  | 31   | 20250611      | 20250413  | 248.12          | 85.0          | 0.0      | 0.0  | 0.0       | 85.0  | 85.0  | 85.0       | 0.0  | 0.0    | 0.0         |
      | 4  | 30   | 20250711      | 20250413  | 163.12          | 85.0          | 0.0      | 0.0  | 0.0       | 85.0  | 85.0  | 85.0       | 0.0  | 0.0    | 0.0         |
      | 5  | 31   | 20250811    | 20250413  | 78.12           | 85.0          | 0.0      | 0.0  | 0.0       | 85.0  | 85.0  | 85.0       | 0.0  | 0.0    | 0.0         |
      | 6  | 31   | 20250911 |                | 0.0             | 78.12         | 0.0      | 0.0  | 0.0       | 78.12 | 75.0  | 75.0       | 0.0  | 0.0    | 3.12        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Waived | Outstanding |
      | 500.0         | 3.12     | 0.0  | 0         | 503.12 | 500.0 | 415.0      | 85.0  | 0.0    | 3.12        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250311    | Disbursement       | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20250413    | Repayment          | 500.0  | 496.89    | 3.11     | 0.0  | 0.0       | 3.11         | false    | false    |
      | 20250414    | Accrual            | 3.21   | 0.0       | 3.21     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250414    | Accrual Adjustment | 0.09   | 0.0       | 0.09     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250414    | Charge-off         | 3.12   | 3.11      | 0.01     | 0.0  | 0.0       | 0.0          | false    | true     |
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250413" with 500 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Waived | Outstanding |
      |    |      | 20250311     |                | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |        |             |
      | 1  | 31   | 20250411     | 20250413  | 417.92          | 82.08         | 2.92     | 0.0  | 0.0       | 85.0  | 85.0  | 0.0        | 85.0 | 0.0    | 0.0         |
      | 2  | 30   | 20250511       | 20250413  | 333.11          | 84.81         | 0.19     | 0.0  | 0.0       | 85.0  | 85.0  | 85.0       | 0.0  | 0.0    | 0.0         |
      | 3  | 31   | 20250611      | 20250413  | 248.11          | 85.0          | 0.0      | 0.0  | 0.0       | 85.0  | 85.0  | 85.0       | 0.0  | 0.0    | 0.0         |
      | 4  | 30   | 20250711      | 20250413  | 163.11          | 85.0          | 0.0      | 0.0  | 0.0       | 85.0  | 85.0  | 85.0       | 0.0  | 0.0    | 0.0         |
      | 5  | 31   | 20250811    | 20250413  | 78.11           | 85.0          | 0.0      | 0.0  | 0.0       | 85.0  | 85.0  | 85.0       | 0.0  | 0.0    | 0.0         |
      | 6  | 31   | 20250911 | 20250413  | 0.0             | 78.11         | 0.0      | 0.0  | 0.0       | 78.11 | 78.11 | 78.11      | 0.0  | 0.0    | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Waived | Outstanding |
      | 500.0         | 3.11     | 0.0  | 0         | 503.11 | 503.11 | 418.11     | 85.0  | 0.0    | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250311    | Disbursement            | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20250413    | Repayment               | 500.0  | 496.89    | 3.11     | 0.0  | 0.0       | 3.11         | false    | false    |
      | 20250413    | Merchant Issued Refund  | 500.0  | 3.11      | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250414    | Accrual                 | 3.21   | 0.0       | 3.21     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250414    | Accrual Adjustment      | 0.09   | 0.0       | 0.09     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250414    | Accrual Adjustment      | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3719
  Scenario: Verify correct schedule reconstruction when backdated repayment covers remaining balance after charge-off with interest recalculation
    Given Global configuration "is-principal-compounding-disabled-for-overdue-loans" is enabled
    When Admin sets the business date to "20250106"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INTEREST_RECALCULATION_ACCELERATE_MATURITY_CHARGE_OFF_BEHAVIOUR | 20250106   | 5000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250106" with "5000" amount and expected disbursement date on "20250106"
    And Admin successfully disburse the loan on "20250106" with "5000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250106  |           | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250206 |           | 4178.74         | 821.26        | 29.17    | 0.0  | 0.0       | 850.43 | 0.0  | 0.0        | 0.0  | 850.43      |
      | 2  | 28   | 20250306    |           | 3352.69         | 826.05        | 24.38    | 0.0  | 0.0       | 850.43 | 0.0  | 0.0        | 0.0  | 850.43      |
      | 3  | 31   | 20250406    |           | 2521.82	       | 830.87        | 19.56    | 0.0  | 0.0       | 850.43 | 0.0  | 0.0        | 0.0  | 850.43      |
      | 4  | 30   | 20250506      |           | 1686.1          | 835.72        | 14.71    | 0.0  | 0.0       | 850.43 | 0.0  | 0.0        | 0.0  | 850.43      |
      | 5  | 31   | 20250606     |           | 845.51          | 840.59        | 9.84     | 0.0  | 0.0       | 850.43 | 0.0  | 0.0        | 0.0  | 850.43      |
      | 6  | 30   | 20250706     |           | 0.0             | 845.51        | 4.93     | 0.0  | 0.0       | 850.44 | 0.0  | 0.0        | 0.0  | 850.44      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 5000.0        | 102.59   | 0.0  | 0.0       | 5102.59 | 0.0  | 0.0        | 0.0  | 5102.59     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250106  | Disbursement     | 5000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       | false    | false    |
    When Admin sets the business date to "20250206"
    And Customer makes "AUTOPAY" repayment on "20250206" with 850.43 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250106  |                  | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250206 | 20250206 | 4178.74         | 821.26        | 29.17    | 0.0  | 0.0       | 850.43 | 850.43 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250306    |                  | 3352.69         | 826.05        | 24.38    | 0.0  | 0.0       | 850.43 | 0.0    | 0.0        | 0.0  | 850.43      |
      | 3  | 31   | 20250406    |                  | 2521.82         | 830.87        | 19.56    | 0.0  | 0.0       | 850.43 | 0.0    | 0.0        | 0.0  | 850.43      |
      | 4  | 30   | 20250506      |                  | 1686.1          | 835.72        | 14.71    | 0.0  | 0.0       | 850.43 | 0.0    | 0.0        | 0.0  | 850.43      |
      | 5  | 31   | 20250606     |                  | 845.51          | 840.59        | 9.84     | 0.0  | 0.0       | 850.43 | 0.0    | 0.0        | 0.0  | 850.43      |
      | 6  | 30   | 20250706     |                  | 0.0             | 845.51        | 4.93     | 0.0  | 0.0       | 850.44 | 0.0    | 0.0        | 0.0  | 850.44      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 5000.0        | 102.59   | 0.0  | 0.0       | 5102.59 | 850.43 | 0.0        | 0.0  | 4252.16     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250106  | Disbursement     | 5000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       | false    | false    |
      | 20250206 | Repayment        | 850.43 | 821.26    | 29.17    | 0.0  | 0.0       | 4178.74      | false    | false    |
    When Admin sets the business date to "20250306"
    And Customer makes "AUTOPAY" repayment on "20250306" with 850.43 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250106  |                  | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250206 | 20250206 | 4178.74         | 821.26        | 29.17    | 0.0  | 0.0       | 850.43 | 850.43 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250306    | 20250306    | 3352.69         | 826.05        | 24.38    | 0.0  | 0.0       | 850.43 | 850.43 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20250406    |                  | 2521.82         | 830.87        | 19.56    | 0.0  | 0.0       | 850.43 | 0.0    | 0.0        | 0.0  | 850.43      |
      | 4  | 30   | 20250506      |                  | 1686.1          | 835.72        | 14.71    | 0.0  | 0.0       | 850.43 | 0.0    | 0.0        | 0.0  | 850.43      |
      | 5  | 31   | 20250606     |                  | 845.51          | 840.59        | 9.84     | 0.0  | 0.0       | 850.43 | 0.0    | 0.0        | 0.0  | 850.43      |
      | 6  | 30   | 20250706     |                  | 0.0             | 845.51        | 4.93     | 0.0  | 0.0       | 850.44 | 0.0    | 0.0        | 0.0  | 850.44      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 5000.0        | 102.59   | 0.0  | 0.0       | 5102.59 | 1700.86| 0.0        | 0.0  | 3401.73     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250106  | Disbursement     | 5000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       | false    | false    |
      | 20250206 | Repayment        | 850.43 | 821.26    | 29.17    | 0.0  | 0.0       | 4178.74      | false    | false    |
      | 20250306    | Repayment        | 850.43 | 826.05    | 24.38    | 0.0  | 0.0       | 3352.69      | false    | false    |
  # Charge-off on 20250401 (accelerated maturity)
    When Admin sets the business date to "20250401"
    And Admin does charge-off the loan on "20250401"
    Then LoanBalanceChangedBusinessEvent is created on "20250401"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      |    |      | 20250106  |                  | 5000.0          |               |          | 0.0  |           | 0.0     | 0.0    |            |      |             |
      | 1  | 31   | 20250206 | 20250206 | 4178.74         | 821.26        | 29.17    | 0.0  | 0.0       | 850.43  | 850.43 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250306    | 20250306    | 3352.69         | 826.05        | 24.38    | 0.0  | 0.0       | 850.43  | 850.43 | 0.0        | 0.0  | 0.0         |
      | 3  | 26   | 20250401    |                  | 0.0             | 3352.69       | 16.4     | 0.0  | 0.0       | 3369.09 | 0.0    | 0.0        | 0.0  | 3369.09     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 5000.0        | 69.95    | 0.0  | 0.0       | 5069.95 | 1700.86| 0.0        | 0.0  | 3369.09     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250106  | Disbursement     | 5000.0  | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       | false    | false    |
      | 20250206 | Repayment        | 850.43  | 821.26    | 29.17    | 0.0  | 0.0       | 4178.74      | false    | false    |
      | 20250306    | Repayment        | 850.43  | 826.05    | 24.38    | 0.0  | 0.0       | 3352.69      | false    | false    |
      | 20250401    | Accrual          | 69.95   | 0.0       | 69.95    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250401    | Charge-off       | 3369.09 | 3352.69   | 16.4     | 0.0  | 0.0       | 0.0          | false    | false    |
  # BUG TRIGGER: Full backdated repayment after charge-off
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250315" with 3358.37 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250106  |                  | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250206 | 20250206 | 4178.74         | 821.26        | 29.17    | 0.0  | 0.0       | 850.43 | 850.43 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250306    | 20250306    | 3352.69         | 826.05        | 24.38    | 0.0  | 0.0       | 850.43 | 850.43 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20250406    | 20250315    | 2507.94         | 844.75        | 5.68     | 0.0  | 0.0       | 850.43 | 850.43 | 850.43     | 0.0  | 0.0         |
      | 4  | 30   | 20250506      | 20250315    | 1657.51         | 850.43        | 0.0      | 0.0  | 0.0       | 850.43 | 850.43 | 850.43     | 0.0  | 0.0         |
      | 5  | 31   | 20250606     | 20250315    | 807.08          | 850.43        | 0.0      | 0.0  | 0.0       | 850.43 | 850.43 | 850.43     | 0.0  | 0.0         |
      | 6  | 30   | 20250706     | 20250315    | 0.0             | 807.08        | 0.0      | 0.0  | 0.0       | 807.08 | 807.08 | 807.08     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 5000.0        | 59.23    | 0.0  | 0.0       | 5059.23 | 5059.23 | 3358.37    | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250106  | Disbursement       | 5000.0  | 0.0       | 0.0      | 0.0  | 0.0       | 5000.0       | false    | false    |
      | 20250206 | Repayment          | 850.43  | 821.26    | 29.17    | 0.0  | 0.0       | 4178.74      | false    | false    |
      | 20250306    | Repayment          | 850.43  | 826.05    | 24.38    | 0.0  | 0.0       | 3352.69      | false    | false    |
      | 20250315    | Repayment          | 3358.37 | 3352.69   | 5.68     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250401    | Accrual            | 69.95   | 0.0       | 69.95    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250401    | Accrual Adjustment | 10.72   | 0.0       | 10.72    | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Global configuration "is-principal-compounding-disabled-for-overdue-loans" is disabled

  @TestRailId:C3757
  Scenario: Verify that charge-off flag and charge-off date are lifted in case the charge-off transaction got reversed
    Given Global configuration "is-principal-compounding-disabled-for-overdue-loans" is enabled
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INTEREST_RECALCULATION_ACCELERATE_MATURITY_CHARGE_OFF_BEHAVIOUR | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.01 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0   | 0.0        | 0.0  | 17.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 17.01 | 0.0        | 0.0  | 85.04       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
    When Admin sets the business date to "20240331"
    And Admin does charge-off the loan with reason "OTHER" on "20240331"
    Then LoanBalanceChangedBusinessEvent is created on "20240331"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 30   | 20240331    |                  | 0.0             | 67.05         | 0.47     | 0.0  | 0.0       | 67.52 | 0.0   | 0.0        | 0.0  | 67.52       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.54     | 0.0  | 0.0       | 101.54 | 17.01 | 0.0        | 0.0  | 84.53       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240331    | Accrual          | 1.54   | 0.0       | 1.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Charge-off       | 84.53  | 83.57     | 0.96     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Details response contains chargedOff flag set to true
    And Loan Details response contains chargedOffOnDate set to "20240331"
    When Admin sets the business date to "20240301"
    And Customer makes "AUTOPAY" repayment on "20240301" with 84.06 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240301    | 50.04           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01        | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240301    | 33.03           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01        | 0.0  | 0.0         |
      | 5  | 31   | 20240601     | 20240301    | 16.02           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01        | 0.0  | 0.0         |
      | 6  | 30   | 20240701     | 20240301    | 0.0             | 16.02         | 0.0      | 0.0  | 0.0       | 16.02 | 16.02 | 16.02      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 100.0         | 1.07     | 0.0  | 0.0       | 101.07 | 101.07 | 67.05      | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement       | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment          | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment          | 84.06  | 83.57     | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Adjustment | 0.47   | 0.0       | 0.47     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual            | 1.54   | 0.0       | 1.54     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Details response does not contain chargedOff flag and chargedOffOnDate field after repayment and reverted charge off
    And Loan has 0.0 outstanding amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Global configuration "is-principal-compounding-disabled-for-overdue-loans" is disabled

  @TestRailId:C3988
  Scenario: Backdated charge-off accrual handling with isInterestRecognitionOnDisbursementDate=true
    When Admin sets the business date to "20250720"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_RECOGNITION_DISBURSEMENT_DAILY_EMI_360_30_ACCRUAL_ACTIVITY | 20241214  | 1000           | 12.2301                | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20241214" with "1000" amount and expected disbursement date on "20241214"
    When Admin successfully disburse the loan on "20241214" with "1000" EUR transaction amount
    When Admin does charge-off the loan on "20250720"
    When Admin runs COB job
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241214 | Disbursement     | 1000.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20250114  | Accrual Activity | 10.19   | 0.0       | 10.19    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250214 | Accrual Activity | 10.19   | 0.0       | 10.19    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250314    | Accrual Activity | 10.19   | 0.0       | 10.19    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250414    | Accrual Activity | 10.19   | 0.0       | 10.19    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250514      | Accrual Activity | 10.19   | 0.0       | 10.19    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250614     | Accrual Activity | 10.19   | 0.0       | 10.19    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250714     | Accrual Activity | 10.19   | 0.0       | 10.19    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250720     | Accrual          | 73.3    | 0.0       | 73.3     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250720     | Charge-off       | 1142.48 | 1000.0    | 142.48   | 0.0  | 0.0       | 0.0          | false    | false    |
    When Loan Pay-off is made on "20250720"
    Then Loan's all installments have obligations met

  @TestRailId:C4016
  Scenario: Verify early repayment with MIRs and change-off afterwards for 24m progressive loan - UC1
    When Admin sets the business date to "20250507"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_ZERO_CHARGE_OFF | 20250507       | 1001           | 35.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250507" with "1001" amount and expected disbursement date on "20250507"
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250507          |                  | 1001.0          |               |          | 0.0  |           | 0.0   |       |            |      | 0.0         |
      | 1  | 31   | 20250607         |                  | 971.92          | 29.08         | 30.02    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 2  | 30   | 20250707         |                  | 941.97          | 29.95         | 29.15    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 3  | 31   | 20250807       |                  | 911.12          | 30.85         | 28.25    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 4  | 31   | 20250907    |                  | 879.35          | 31.77         | 27.33    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 5  | 30   | 20251007      |                  | 846.62          | 32.73         | 26.37    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 6  | 31   | 20251107     |                  | 812.91          | 33.71         | 25.39    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 7  | 30   | 20251207     |                  | 778.19          | 34.72         | 24.38    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 8  | 31   | 20260107      |                  | 742.43          | 35.76         | 23.34    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 9  | 31   | 20260207     |                  | 705.6           | 36.83         | 22.27    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 10 | 28   | 20260307        |                  | 667.66          | 37.94         | 21.16    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 11 | 31   | 20260407        |                  | 628.58          | 39.08         | 20.02    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 12 | 30   | 20260507          |                  | 588.33          | 40.25         | 18.85    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 13 | 31   | 20260607         |                  | 546.87          | 41.46         | 17.64    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 14 | 30   | 20260707         |                  | 504.17          | 42.7          | 16.4     | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 15 | 31   | 20260807       |                  | 460.19          | 43.98         | 15.12    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 16 | 31   | 20260907    |                  | 414.89          | 45.3          | 13.8     | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 17 | 30   | 20261007      |                  | 368.23          | 46.66         | 12.44    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 18 | 31   | 20261107     |                  | 320.17          | 48.06         | 11.04    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 19 | 30   | 20261207     |                  | 270.67          | 49.5          |  9.6     | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 20 | 31   | 20270107      |                  | 219.69          | 50.98         |  8.12    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 21 | 31   | 20270207     |                  | 167.18          | 52.51         |  6.59    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 22 | 28   | 20270307        |                  | 113.09          | 54.09         |  5.01    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 23 | 31   | 20270407        |                  |  57.38          | 55.71         |  3.39    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 24 | 30   | 20270507          |                  |   0.0           | 57.38         |  1.72    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1001.0        | 417.4    | 0.0  | 0.0       | 1418.4 |  0.0 | 0.0        | 0.0  | 1418.4      |

    When Admin successfully disburse the loan on "20250507" with "179.04" EUR transaction amount
    When Admin sets the business date to "20250508"
    When Admin successfully disburse the loan on "20250508" with "52.07" EUR transaction amount
    When Admin successfully disburse the loan on "20250508" with "171.31" EUR transaction amount
    When Admin sets the business date to "20250510"
    When Admin runs inline COB job for Loan

    When Admin sets the business date to "20250511"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250511" with 61.19 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20250512"
    When Admin runs inline COB job for Loan

    When Admin sets the business date to "20250514"
    When Admin successfully disburse the loan on "20250513" with "81.67" EUR transaction amount
    When Admin successfully disburse the loan on "20250514" with "62.05" EUR transaction amount
    When Admin sets the business date to "20250515"
    When Admin runs inline COB job for Loan

    When Admin sets the business date to "20250516"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250516" with 52.07 EUR transaction amount and system-generated Idempotency key
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250516" with 49.36 EUR transaction amount and system-generated Idempotency key
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250516" with 81.67 EUR transaction amount and system-generated Idempotency key
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250516" with 62.05 EUR transaction amount and system-generated Idempotency key

    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid   | In advance | Late | Outstanding |
      |    |      | 20250507          |                  | 179.04          |               |          | 0.0  |           | 0.0   |  0.0   |            |      |             |
      |    |      | 20250508          |                  |  52.07          |               |          | 0.0  |           | 0.0   |  0.0   |            |      |             |
      |    |      | 20250508          |                  | 171.31          |               |          | 0.0  |           | 0.0   |  0.0   |            |      |             |
      |    |      | 20250513          |                  |  81.67          |               |          | 0.0  |           | 0.0   |  0.0   |            |      |             |
      |    |      | 20250514          |                  |  62.05          |               |          | 0.0  |           | 0.0   |  0.0   |            |      |             |
      | 1  | 31   | 20250607         |                  | 522.41          | 23.73         |  8.45    | 0.0  | 0.0       | 32.18 | 2.25   | 2.25       | 0.0  | 29.93       |
      | 2  | 30   | 20250707         |                  | 496.71          | 25.7          |  6.48    | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 3  | 31   | 20250807       |                  | 470.24          | 26.47         |  5.71    | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 4  | 31   | 20250907    |                  | 442.98          | 27.26         |  4.92    | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 5  | 30   | 20251007      |                  | 414.9           | 28.08         |  4.1     | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 6  | 31   | 20251107     |                  | 385.98          | 28.92         |  3.26    | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 7  | 30   | 20251207     |                  | 356.19          | 29.79         |  2.39    | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 8  | 31   | 20260107      |                  | 325.51          | 30.68         |  1.5     | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 9  | 31   | 20260207     |                  | 306.34          | 19.17         |  0.57    | 0.0  | 0.0       | 19.74 |  0.0   |  0.0       | 0.0  | 19.74       |
      | 10 | 28   | 20260307        | 20250516      | 306.34          |  0.0          |  0.0     | 0.0  | 0.0       |  0.0  |  0.0   |  0.0       | 0.0  |  0.0        |
      | 11 | 31   | 20260407        | 20250516      | 306.34          |  0.0          |  0.0     | 0.0  | 0.0       |  0.0  |  0.0   |  0.0       | 0.0  |  0.0        |
      | 12 | 30   | 20260507          | 20250516      | 306.34          |  0.0          |  0.0     | 0.0  | 0.0       |  0.0  |  0.0   |  0.0       | 0.0  |  0.0        |
      | 13 | 31   | 20260607         | 20250516      | 276.47          | 29.87         |  0.0     | 0.0  | 0.0       | 29.87 | 29.87  | 29.87      | 0.0  |  0.0        |
      | 14 | 30   | 20260707         | 20250516      | 244.29          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 | 32.18  | 32.18      | 0.0  |  0.0        |
      | 15 | 31   | 20260807       | 20250516      | 226.98          | 17.31         |  0.0     | 0.0  | 0.0       | 17.31 | 17.31  | 17.31      | 0.0  |  0.0        |
      | 16 | 31   | 20260907    | 20250516      | 194.8           | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 | 32.18  | 32.18      | 0.0  |  0.0        |
      | 17 | 30   | 20261007      | 20250516      | 162.62          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 | 32.18  | 32.18      | 0.0  |  0.0        |
      | 18 | 31   | 20261107     | 20250516      | 145.44          | 17.18         |  0.0     | 0.0  | 0.0       | 17.18 | 17.18  | 17.18      | 0.0  |  0.0        |
      | 19 | 30   | 20261207     | 20250516      | 113.26          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 | 32.18  | 32.18      | 0.0  |  0.0        |
      | 20 | 31   | 20270107      | 20250516      |  93.37          | 19.89         |  0.0     | 0.0  | 0.0       | 19.89 | 19.89  | 19.89      | 0.0  |  0.0        |
      | 21 | 31   | 20270207     | 20250516      |  61.19          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 | 32.18  | 32.18      | 0.0  |  0.0        |
      | 22 | 28   | 20270307        | 20250511      |  47.41          | 13.78         |  0.0     | 0.0  | 0.0       | 13.78 | 13.78  | 13.78      | 0.0  |  0.0        |
      | 23 | 31   | 20270407        | 20250511      |  23.66          | 23.75         |  0.0     | 0.0  | 0.0       | 23.75 | 23.75  | 23.75      | 0.0  |  0.0        |
      | 24 | 30   | 20270507          | 20250511      |   0.0           | 23.66         |  0.0     | 0.0  | 0.0       | 23.66 | 23.66  | 23.66      | 0.0  |  0.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 546.14        | 37.38    | 0.0  | 0.0       | 583.52 | 308.59 | 308.59     | 0.0  | 274.93      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount  | Principal | Interest | Fees | Penalties | Loan Balance  | Reverted | Replayed |
      | 20250507      | Disbursement           | 179.04  | 0.0       | 0.0      | 0.0  | 0.0       | 179.04        | false    | false    |
      | 20250508      | Disbursement           | 52.07   | 0.0       | 0.0      | 0.0  | 0.0       | 231.11        | false    | false    |
      | 20250508      | Disbursement           | 171.31  | 0.0       | 0.0      | 0.0  | 0.0       | 402.42        | false    | false    |
      | 20250509      | Accrual                | 0.56    | 0.0       | 0.56     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250510      | Accrual                | 0.39    | 0.0       | 0.39     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250511      | Merchant Issued Refund | 61.19   | 61.19     | 0.0      | 0.0  | 0.0       | 341.23        | false    | false    |
      | 20250511      | Interest Refund        | 0.24    | 0.0       | 0.24     | 0.0  | 0.0       | 341.23        | false    | false    |
      | 20250511      | Accrual                | 0.39    | 0.0       | 0.39     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250512      | Accrual                | 0.33    | 0.0       | 0.33     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250513      | Disbursement           | 81.67   | 0.0       | 0.0      | 0.0  | 0.0       | 422.9         | false    | false    |
      | 20250513      | Accrual                | 0.33    | 0.0       | 0.33     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250514      | Disbursement           | 62.05   | 0.0       | 0.0      | 0.0  | 0.0       | 484.95        | false    | false    |
      | 20250514      | Accrual                | 0.41    | 0.0       | 0.41     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250516      | Merchant Issued Refund | 52.07   | 52.07     | 0.0      | 0.0  | 0.0       | 432.88        | false    | false    |
      | 20250516      | Interest Refund        | 0.45    | 0.0       | 0.45     | 0.0  | 0.0       | 432.88        | false    | false    |
      | 20250516      | Merchant Issued Refund | 49.36   | 49.36     | 0.0      | 0.0  | 0.0       | 383.52        | false    | false    |
      | 20250516      | Interest Refund        | 0.43    | 0.0       | 0.43     | 0.0  | 0.0       | 383.52        | false    | false    |
      | 20250516      | Merchant Issued Refund | 81.67   | 81.67     | 0.0      | 0.0  | 0.0       | 301.85        | false    | false    |
      | 20250516      | Interest Refund        | 0.65    | 0.0       | 0.65     | 0.0  | 0.0       | 301.85        | false    | false    |
      | 20250516      | Merchant Issued Refund | 62.05   | 62.05     | 0.0      | 0.0  | 0.0       | 239.8         | false    | false    |
      | 20250516      | Interest Refund        | 0.48    | 0.0       | 0.48     | 0.0  | 0.0       | 239.8         | false    | false    |

    When Admin sets the business date to "20250614"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20250714"
    When Admin runs inline COB job for Loan

    When Admin sets the business date to "20250814"
    When Admin runs inline COB job for Loan
    And Admin does charge-off the loan on "20250814"
    When Admin sets the business date to "20250815"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid   | In advance | Late | Outstanding |
      |    |      | 20250507          |                  | 179.04          |               |          | 0.0  |           | 0.0   |  0.0   |            |      |             |
      |    |      | 20250508          |                  |  52.07          |               |          | 0.0  |           | 0.0   |  0.0   |            |      |             |
      |    |      | 20250508          |                  | 171.31          |               |          | 0.0  |           | 0.0   |  0.0   |            |      |             |
      |    |      | 20250513          |                  |  81.67          |               |          | 0.0  |           | 0.0   |  0.0   |            |      |             |
      |    |      | 20250514          |                  |  62.05          |               |          | 0.0  |           | 0.0   |  0.0   |            |      |             |
      | 1  | 31   | 20250607         |                  | 522.41          | 23.73         |  8.45    | 0.0  | 0.0       | 32.18 | 2.25   | 2.25       | 0.0  | 29.93       |
      | 2  | 30   | 20250707         |                  | 497.42          | 24.99         |  7.19    | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 3  | 31   | 20250807       |                  | 472.43          | 24.99         |  7.19    | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 4  | 31   | 20250907    |                  | 441.87          | 30.56         |  1.62    | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 5  | 30   | 20251007      |                  | 409.69          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 6  | 31   | 20251107     |                  | 377.51          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 7  | 30   | 20251207     |                  | 345.33          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 8  | 31   | 20260107      |                  | 313.15          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 9  | 31   | 20260207     |                  | 306.34          |  6.81         |  0.0     | 0.0  | 0.0       |  6.81 |  0.0   |  0.0       | 0.0  | 6.81       |
      | 10 | 28   | 20260307        | 20250516      | 306.34          |  0.0          |  0.0     | 0.0  | 0.0       |  0.0  |  0.0   |  0.0       | 0.0  |  0.0        |
      | 11 | 31   | 20260407        | 20250516      | 306.34          |  0.0          |  0.0     | 0.0  | 0.0       |  0.0  |  0.0   |  0.0       | 0.0  |  0.0        |
      | 12 | 30   | 20260507          | 20250516      | 306.34          |  0.0          |  0.0     | 0.0  | 0.0       |  0.0  |  0.0   |  0.0       | 0.0  |  0.0        |
      | 13 | 31   | 20260607         | 20250516      | 276.47          | 29.87         |  0.0     | 0.0  | 0.0       | 29.87 | 29.87  | 29.87      | 0.0  |  0.0        |
      | 14 | 30   | 20260707         | 20250516      | 244.29          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 | 32.18  | 32.18      | 0.0  |  0.0        |
      | 15 | 31   | 20260807       | 20250516      | 226.98          | 17.31         |  0.0     | 0.0  | 0.0       | 17.31 | 17.31  | 17.31      | 0.0  |  0.0        |
      | 16 | 31   | 20260907    | 20250516      | 194.8           | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 | 32.18  | 32.18      | 0.0  |  0.0        |
      | 17 | 30   | 20261007      | 20250516      | 162.62          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 | 32.18  | 32.18      | 0.0  |  0.0        |
      | 18 | 31   | 20261107     | 20250516      | 145.44          | 17.18         |  0.0     | 0.0  | 0.0       | 17.18 | 17.18  | 17.18      | 0.0  |  0.0        |
      | 19 | 30   | 20261207     | 20250516      | 113.26          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 | 32.18  | 32.18      | 0.0  |  0.0        |
      | 20 | 31   | 20270107      | 20250516      |  93.37          | 19.89         |  0.0     | 0.0  | 0.0       | 19.89 | 19.89  | 19.89      | 0.0  |  0.0        |
      | 21 | 31   | 20270207     | 20250516      |  61.19          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 | 32.18  | 32.18      | 0.0  |  0.0        |
      | 22 | 28   | 20270307        | 20250511      |  47.41          | 13.78         |  0.0     | 0.0  | 0.0       | 13.78 | 13.78  | 13.78      | 0.0  |  0.0        |
      | 23 | 31   | 20270407        | 20250511      |  23.66          | 23.75         |  0.0     | 0.0  | 0.0       | 23.75 | 23.75  | 23.75      | 0.0  |  0.0        |
      | 24 | 30   | 20270507          | 20250511      |   0.0           | 23.66         |  0.0     | 0.0  | 0.0       | 23.66 | 23.66  | 23.66      | 0.0  |  0.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 546.14        | 24.45    | 0.0  | 0.0       | 570.59 | 308.59 | 308.59     | 0.0  | 262.0       |

  @TestRailId:C4017
  Scenario: Verify early repayment with MIRs and charge with change-off afterwards for 24m progressive loan - UC2
    When Admin sets the business date to "20250507"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_ZERO_CHARGE_OFF | 20250507       | 1001           | 35.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250507" with "1001" amount and expected disbursement date on "20250507"
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250507          |                  | 1001.0          |               |          | 0.0  |           | 0.0   |       |            |      | 0.0         |
      | 1  | 31   | 20250607         |                  | 971.92          | 29.08         | 30.02    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 2  | 30   | 20250707         |                  | 941.97          | 29.95         | 29.15    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 3  | 31   | 20250807       |                  | 911.12          | 30.85         | 28.25    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 4  | 31   | 20250907    |                  | 879.35          | 31.77         | 27.33    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 5  | 30   | 20251007      |                  | 846.62          | 32.73         | 26.37    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 6  | 31   | 20251107     |                  | 812.91          | 33.71         | 25.39    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 7  | 30   | 20251207     |                  | 778.19          | 34.72         | 24.38    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 8  | 31   | 20260107      |                  | 742.43          | 35.76         | 23.34    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 9  | 31   | 20260207     |                  | 705.6           | 36.83         | 22.27    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 10 | 28   | 20260307        |                  | 667.66          | 37.94         | 21.16    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 11 | 31   | 20260407        |                  | 628.58          | 39.08         | 20.02    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 12 | 30   | 20260507          |                  | 588.33          | 40.25         | 18.85    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 13 | 31   | 20260607         |                  | 546.87          | 41.46         | 17.64    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 14 | 30   | 20260707         |                  | 504.17          | 42.7          | 16.4     | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 15 | 31   | 20260807       |                  | 460.19          | 43.98         | 15.12    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 16 | 31   | 20260907    |                  | 414.89          | 45.3          | 13.8     | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 17 | 30   | 20261007      |                  | 368.23          | 46.66         | 12.44    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 18 | 31   | 20261107     |                  | 320.17          | 48.06         | 11.04    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 19 | 30   | 20261207     |                  | 270.67          | 49.5          |  9.6     | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 20 | 31   | 20270107      |                  | 219.69          | 50.98         |  8.12    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 21 | 31   | 20270207     |                  | 167.18          | 52.51         |  6.59    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 22 | 28   | 20270307        |                  | 113.09          | 54.09         |  5.01    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 23 | 31   | 20270407        |                  |  57.38          | 55.71         |  3.39    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 24 | 30   | 20270507          |                  |   0.0           | 57.38         |  1.72    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1001.0        | 417.4    | 0.0  | 0.0       | 1418.4 |  0.0 | 0.0        | 0.0  | 1418.4      |

    When Admin successfully disburse the loan on "20250507" with "179.04" EUR transaction amount
    When Admin sets the business date to "20250508"
    When Admin successfully disburse the loan on "20250508" with "52.07" EUR transaction amount
    When Admin successfully disburse the loan on "20250508" with "171.31" EUR transaction amount
    When Admin sets the business date to "20250510"
    When Admin runs inline COB job for Loan

    When Admin sets the business date to "20250511"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250511" with 61.19 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20250512"
    When Admin runs inline COB job for Loan

    When Admin sets the business date to "20250514"
    When Admin successfully disburse the loan on "20250513" with "81.67" EUR transaction amount
    When Admin successfully disburse the loan on "20250514" with "62.05" EUR transaction amount
    When Admin sets the business date to "20250515"
    When Admin runs inline COB job for Loan

    When Admin sets the business date to "20250516"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250516" with 52.07 EUR transaction amount and system-generated Idempotency key
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250516" with 49.36 EUR transaction amount and system-generated Idempotency key
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250516" with 81.67 EUR transaction amount and system-generated Idempotency key
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250516" with 62.05 EUR transaction amount and system-generated Idempotency key

    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid   | In advance | Late | Outstanding |
      |    |      | 20250507          |                  | 179.04          |               |          | 0.0  |           | 0.0   |  0.0   |            |      |             |
      |    |      | 20250508          |                  |  52.07          |               |          | 0.0  |           | 0.0   |  0.0   |            |      |             |
      |    |      | 20250508          |                  | 171.31          |               |          | 0.0  |           | 0.0   |  0.0   |            |      |             |
      |    |      | 20250513          |                  |  81.67          |               |          | 0.0  |           | 0.0   |  0.0   |            |      |             |
      |    |      | 20250514          |                  |  62.05          |               |          | 0.0  |           | 0.0   |  0.0   |            |      |             |
      | 1  | 31   | 20250607         |                  | 522.41          | 23.73         |  8.45    | 0.0  | 0.0       | 32.18 | 2.25   | 2.25       | 0.0  | 29.93       |
      | 2  | 30   | 20250707         |                  | 496.71          | 25.7          |  6.48    | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 3  | 31   | 20250807       |                  | 470.24          | 26.47         |  5.71    | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 4  | 31   | 20250907    |                  | 442.98          | 27.26         |  4.92    | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 5  | 30   | 20251007      |                  | 414.9           | 28.08         |  4.1     | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 6  | 31   | 20251107     |                  | 385.98          | 28.92         |  3.26    | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 7  | 30   | 20251207     |                  | 356.19          | 29.79         |  2.39    | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 8  | 31   | 20260107      |                  | 325.51          | 30.68         |  1.5     | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 9  | 31   | 20260207     |                  | 306.34          | 19.17         |  0.57    | 0.0  | 0.0       | 19.74 |  0.0   |  0.0       | 0.0  | 19.74       |
      | 10 | 28   | 20260307        | 20250516      | 306.34          |  0.0          |  0.0     | 0.0  | 0.0       |  0.0  |  0.0   |  0.0       | 0.0  |  0.0        |
      | 11 | 31   | 20260407        | 20250516      | 306.34          |  0.0          |  0.0     | 0.0  | 0.0       |  0.0  |  0.0   |  0.0       | 0.0  |  0.0        |
      | 12 | 30   | 20260507          | 20250516      | 306.34          |  0.0          |  0.0     | 0.0  | 0.0       |  0.0  |  0.0   |  0.0       | 0.0  |  0.0        |
      | 13 | 31   | 20260607         | 20250516      | 276.47          | 29.87         |  0.0     | 0.0  | 0.0       | 29.87 | 29.87  | 29.87      | 0.0  |  0.0        |
      | 14 | 30   | 20260707         | 20250516      | 244.29          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 | 32.18  | 32.18      | 0.0  |  0.0        |
      | 15 | 31   | 20260807       | 20250516      | 226.98          | 17.31         |  0.0     | 0.0  | 0.0       | 17.31 | 17.31  | 17.31      | 0.0  |  0.0        |
      | 16 | 31   | 20260907    | 20250516      | 194.8           | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 | 32.18  | 32.18      | 0.0  |  0.0        |
      | 17 | 30   | 20261007      | 20250516      | 162.62          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 | 32.18  | 32.18      | 0.0  |  0.0        |
      | 18 | 31   | 20261107     | 20250516      | 145.44          | 17.18         |  0.0     | 0.0  | 0.0       | 17.18 | 17.18  | 17.18      | 0.0  |  0.0        |
      | 19 | 30   | 20261207     | 20250516      | 113.26          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 | 32.18  | 32.18      | 0.0  |  0.0        |
      | 20 | 31   | 20270107      | 20250516      |  93.37          | 19.89         |  0.0     | 0.0  | 0.0       | 19.89 | 19.89  | 19.89      | 0.0  |  0.0        |
      | 21 | 31   | 20270207     | 20250516      |  61.19          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 | 32.18  | 32.18      | 0.0  |  0.0        |
      | 22 | 28   | 20270307        | 20250511      |  47.41          | 13.78         |  0.0     | 0.0  | 0.0       | 13.78 | 13.78  | 13.78      | 0.0  |  0.0        |
      | 23 | 31   | 20270407        | 20250511      |  23.66          | 23.75         |  0.0     | 0.0  | 0.0       | 23.75 | 23.75  | 23.75      | 0.0  |  0.0        |
      | 24 | 30   | 20270507          | 20250511      |   0.0           | 23.66         |  0.0     | 0.0  | 0.0       | 23.66 | 23.66  | 23.66      | 0.0  |  0.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 546.14        | 37.38    | 0.0  | 0.0       | 583.52 | 308.59 | 308.59     | 0.0  | 274.93      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount  | Principal | Interest | Fees | Penalties | Loan Balance  | Reverted | Replayed |
      | 20250507      | Disbursement           | 179.04  | 0.0       | 0.0      | 0.0  | 0.0       | 179.04        | false    | false    |
      | 20250508      | Disbursement           | 52.07   | 0.0       | 0.0      | 0.0  | 0.0       | 231.11        | false    | false    |
      | 20250508      | Disbursement           | 171.31  | 0.0       | 0.0      | 0.0  | 0.0       | 402.42        | false    | false    |
      | 20250509      | Accrual                | 0.56    | 0.0       | 0.56     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250510      | Accrual                | 0.39    | 0.0       | 0.39     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250511      | Merchant Issued Refund | 61.19   | 61.19     | 0.0      | 0.0  | 0.0       | 341.23        | false    | false    |
      | 20250511      | Interest Refund        | 0.24    | 0.0       | 0.24     | 0.0  | 0.0       | 341.23        | false    | false    |
      | 20250511      | Accrual                | 0.39    | 0.0       | 0.39     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250512      | Accrual                | 0.33    | 0.0       | 0.33     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250513      | Disbursement           | 81.67   | 0.0       | 0.0      | 0.0  | 0.0       | 422.9         | false    | false    |
      | 20250513      | Accrual                | 0.33    | 0.0       | 0.33     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250514      | Disbursement           | 62.05   | 0.0       | 0.0      | 0.0  | 0.0       | 484.95        | false    | false    |
      | 20250514      | Accrual                | 0.41    | 0.0       | 0.41     | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20250516      | Merchant Issued Refund | 52.07   | 52.07     | 0.0      | 0.0  | 0.0       | 432.88        | false    | false    |
      | 20250516      | Interest Refund        | 0.45    | 0.0       | 0.45     | 0.0  | 0.0       | 432.88        | false    | false    |
      | 20250516      | Merchant Issued Refund | 49.36   | 49.36     | 0.0      | 0.0  | 0.0       | 383.52        | false    | false    |
      | 20250516      | Interest Refund        | 0.43    | 0.0       | 0.43     | 0.0  | 0.0       | 383.52        | false    | false    |
      | 20250516      | Merchant Issued Refund | 81.67   | 81.67     | 0.0      | 0.0  | 0.0       | 301.85        | false    | false    |
      | 20250516      | Interest Refund        | 0.65    | 0.0       | 0.65     | 0.0  | 0.0       | 301.85        | false    | false    |
      | 20250516      | Merchant Issued Refund | 62.05   | 62.05     | 0.0      | 0.0  | 0.0       | 239.8         | false    | false    |
      | 20250516      | Interest Refund        | 0.48    | 0.0       | 0.48     | 0.0  | 0.0       | 239.8         | false    | false    |

    When Admin sets the business date to "20250614"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20250714"
    When Admin runs inline COB job for Loan
# --- add charge on Aug, 14 --- #
    When Admin sets the business date to "20250814"
    When Admin runs inline COB job for Loan
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250815" due date and 10 EUR transaction amount
    When Admin sets the business date to "20250815"
# --- make charge-off on Aug, 15 --- #
    And Admin does charge-off the loan on "20250815"
    When Admin sets the business date to "20250816"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid   | In advance | Late | Outstanding |
      |    |      | 20250507          |                  | 179.04          |               |          | 0.0  |           | 0.0   |  0.0   |            |      |             |
      |    |      | 20250508          |                  |  52.07          |               |          | 0.0  |           | 0.0   |  0.0   |            |      |             |
      |    |      | 20250508          |                  | 171.31          |               |          | 0.0  |           | 0.0   |  0.0   |            |      |             |
      |    |      | 20250513          |                  |  81.67          |               |          | 0.0  |           | 0.0   |  0.0   |            |      |             |
      |    |      | 20250514          |                  |  62.05          |               |          | 0.0  |           | 0.0   |  0.0   |            |      |             |
      | 1  | 31   | 20250607         |                  | 522.41          | 23.73         |  8.45    | 0.0  | 0.0       | 32.18 | 2.25   | 2.25       | 0.0  | 29.93       |
      | 2  | 30   | 20250707         |                  | 497.42          | 24.99         |  7.19    | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 3  | 31   | 20250807       |                  | 472.43          | 24.99         |  7.19    | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 4  | 31   | 20250907    |                  | 442.11          | 30.32         |  1.86    | 0.0  | 10.0      | 42.18 |  0.0   |  0.0       | 0.0  | 42.18       |
      | 5  | 30   | 20251007      |                  | 409.93          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 6  | 31   | 20251107     |                  | 377.75          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 7  | 30   | 20251207     |                  | 345.57          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 8  | 31   | 20260107      |                  | 313.39          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 |  0.0   |  0.0       | 0.0  | 32.18       |
      | 9  | 31   | 20260207     |                  | 306.34          |  7.05         |  0.0     | 0.0  | 0.0       |  7.05 |  0.0   |  0.0       | 0.0  | 7.05        |
      | 10 | 28   | 20260307        | 20250516      | 306.34          |  0.0          |  0.0     | 0.0  | 0.0       |  0.0  |  0.0   |  0.0       | 0.0  |  0.0        |
      | 11 | 31   | 20260407        | 20250516      | 306.34          |  0.0          |  0.0     | 0.0  | 0.0       |  0.0  |  0.0   |  0.0       | 0.0  |  0.0        |
      | 12 | 30   | 20260507          | 20250516      | 306.34          |  0.0          |  0.0     | 0.0  | 0.0       |  0.0  |  0.0   |  0.0       | 0.0  |  0.0        |
      | 13 | 31   | 20260607         | 20250516      | 276.47          | 29.87         |  0.0     | 0.0  | 0.0       | 29.87 | 29.87  | 29.87      | 0.0  |  0.0        |
      | 14 | 30   | 20260707         | 20250516      | 244.29          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 | 32.18  | 32.18      | 0.0  |  0.0        |
      | 15 | 31   | 20260807       | 20250516      | 226.98          | 17.31         |  0.0     | 0.0  | 0.0       | 17.31 | 17.31  | 17.31      | 0.0  |  0.0        |
      | 16 | 31   | 20260907    | 20250516      | 194.8           | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 | 32.18  | 32.18      | 0.0  |  0.0        |
      | 17 | 30   | 20261007      | 20250516      | 162.62          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 | 32.18  | 32.18      | 0.0  |  0.0        |
      | 18 | 31   | 20261107     | 20250516      | 145.44          | 17.18         |  0.0     | 0.0  | 0.0       | 17.18 | 17.18  | 17.18      | 0.0  |  0.0        |
      | 19 | 30   | 20261207     | 20250516      | 113.26          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 | 32.18  | 32.18      | 0.0  |  0.0        |
      | 20 | 31   | 20270107      | 20250516      |  93.37          | 19.89         |  0.0     | 0.0  | 0.0       | 19.89 | 19.89  | 19.89      | 0.0  |  0.0        |
      | 21 | 31   | 20270207     | 20250516      |  61.19          | 32.18         |  0.0     | 0.0  | 0.0       | 32.18 | 32.18  | 32.18      | 0.0  |  0.0        |
      | 22 | 28   | 20270307        | 20250511      |  47.41          | 13.78         |  0.0     | 0.0  | 0.0       | 13.78 | 13.78  | 13.78      | 0.0  |  0.0        |
      | 23 | 31   | 20270407        | 20250511      |  23.66          | 23.75         |  0.0     | 0.0  | 0.0       | 23.75 | 23.75  | 23.75      | 0.0  |  0.0        |
      | 24 | 30   | 20270507          | 20250511      |   0.0           | 23.66         |  0.0     | 0.0  | 0.0       | 23.66 | 23.66  | 23.66      | 0.0  |  0.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 546.14        | 24.69    | 0.0  | 10.0      | 580.83 | 308.59 | 308.59     | 0.0  | 272.24      |

  @TestRailId:C4153
  Scenario: Verify that totalUnpaidPayableNotDueInterest doesn't get reset to 0 on the charge-off date
    When Admin sets the business date to "20250501"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_360_30_ZERO_INTEREST_CHARGE_OFF_ACCRUAL_ACTIVITY | 20250501       | 423.38         | 12.25                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250501" with "423.38" amount and expected disbursement date on "20250501"
    And Admin successfully disburse the loan on "20250501" with "423.38" EUR transaction amount
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 423.38        | 56.13    | 0.0  | 0.0       | 479.51 | 0.0  | 0.0        | 0.0  | 479.51      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250501      | Disbursement     | 423.38 | 0.0       | 0.0      | 0.0  | 0.0       | 423.38       |
    When Admin sets the business date to "20250601"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250601" with 19.98 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 423.38        | 56.13    | 0.0  | 0.0       | 479.51 | 19.98 | 0.0        | 0.0  | 459.53      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250501      | Disbursement     | 423.38 | 0.0       | 0.0      | 0.0  | 0.0       | 423.38       |
      | 20250601     | Repayment        | 19.98  | 15.66     | 4.32     | 0.0  | 0.0       | 407.72       |
    When Admin sets the business date to "20250701"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250701" with 19.98 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 423.38        | 56.13    | 0.0  | 0.0       | 479.51 | 39.96 | 0.0        | 0.0  | 439.55      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250501      | Disbursement     | 423.38 | 0.0       | 0.0      | 0.0  | 0.0       | 423.38       |
      | 20250601     | Repayment        | 19.98  | 15.66     | 4.32     | 0.0  | 0.0       | 407.72       |
      | 20250701     | Repayment        | 19.98  | 15.82     | 4.16     | 0.0  | 0.0       | 391.9        |
    When Admin sets the business date to "20251008"
    When Admin runs inline COB job for Loan
    Then Loan has 11.51 total unpaid payable due interest
    Then Loan has 0.79 total unpaid payable not due interest
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 423.38        | 56.13    | 0.0  | 0.0       | 479.51 | 39.96 | 0.0        | 0.0  | 439.55      |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250501       | Disbursement     | 423.38 | 0.0       | 0.0      | 0.0  | 0.0       | 423.38       |
      | 20250601      | Repayment        | 19.98  | 15.66     | 4.32     | 0.0  | 0.0       | 407.72       |
      | 20250601      | Accrual Activity | 4.32   | 0.0       | 4.32     | 0.0  | 0.0       | 0.0          |
      | 20250701      | Repayment        | 19.98  | 15.82     | 4.16     | 0.0  | 0.0       | 391.9        |
      | 20250701      | Accrual Activity | 4.16   | 0.0       | 4.16     | 0.0  | 0.0       | 0.0          |
      | 20250801    | Accrual Activity | 4.0    | 0.0       | 4.0      | 0.0  | 0.0       | 0.0          |
      | 20250901 | Accrual Activity | 3.84   | 0.0       | 3.84     | 0.0  | 0.0       | 0.0          |
      | 20251001   | Accrual Activity | 3.67   | 0.0       | 3.67     | 0.0  | 0.0       | 0.0          |
      | 20251007   | Accrual          | 20.67  | 0.0       | 20.67    | 0.0  | 0.0       | 0.0          |
    And Admin does charge-off the loan on "20251008"
    Then LoanBalanceChangedBusinessEvent is created on "20251008"
    Then Loan has 11.51 total unpaid payable due interest
    Then Loan has 0.79 total unpaid payable not due interest
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 423.38        | 20.78    | 0.0  | 0.0       | 444.16 | 39.96 | 0.0        | 0.0  | 404.2       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250501       | Disbursement     | 423.38 | 0.0       | 0.0      | 0.0  | 0.0       | 423.38       |
      | 20250601      | Repayment        | 19.98  | 15.66     | 4.32     | 0.0  | 0.0       | 407.72       |
      | 20250601      | Accrual Activity | 4.32   | 0.0       | 4.32     | 0.0  | 0.0       | 0.0          |
      | 20250701      | Repayment        | 19.98  | 15.82     | 4.16     | 0.0  | 0.0       | 391.9        |
      | 20250701      | Accrual Activity | 4.16   | 0.0       | 4.16     | 0.0  | 0.0       | 0.0          |
      | 20250801    | Accrual Activity | 4.0    | 0.0       | 4.0      | 0.0  | 0.0       | 0.0          |
      | 20250901 | Accrual Activity | 3.84   | 0.0       | 3.84     | 0.0  | 0.0       | 0.0          |
      | 20251001   | Accrual Activity | 3.67   | 0.0       | 3.67     | 0.0  | 0.0       | 0.0          |
      | 20251007   | Accrual          | 20.67  | 0.0       | 20.67    | 0.0  | 0.0       | 0.0          |
      | 20251008   | Accrual          | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          |
      | 20251008   | Charge-off       | 404.2  | 391.9     | 12.3     | 0.0  | 0.0       | 0.0          |

  @TestRailId:C4228
  Scenario: Verify that totalUnpaidPayableNotDueInterest is correct when charge-off falls on a due date of an open repayment period
    When Admin sets the business date to "20250501"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_360_30_ZERO_INTEREST_CHARGE_OFF_ACCRUAL_ACTIVITY | 20250501       | 423.38         | 12.25                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250501" with "423.38" amount and expected disbursement date on "20250501"
    And Admin successfully disburse the loan on "20250501" with "423.38" EUR transaction amount
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 423.38        | 56.13    | 0.0  | 0.0       | 479.51 | 0.0  | 0.0        | 0.0  | 479.51      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250501      | Disbursement     | 423.38 | 0.0       | 0.0      | 0.0  | 0.0       | 423.38       |
    When Admin sets the business date to "20250601"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250601" with 19.98 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 423.38        | 56.13    | 0.0  | 0.0       | 479.51 | 19.98 | 0.0        | 0.0  | 459.53      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250501      | Disbursement     | 423.38 | 0.0       | 0.0      | 0.0  | 0.0       | 423.38       |
      | 20250601     | Repayment        | 19.98  | 15.66     | 4.32     | 0.0  | 0.0       | 407.72       |
    When Admin sets the business date to "20250701"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250701" with 19.98 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 423.38        | 56.13    | 0.0  | 0.0       | 479.51 | 39.96 | 0.0        | 0.0  | 439.55      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250501      | Disbursement     | 423.38 | 0.0       | 0.0      | 0.0  | 0.0       | 423.38       |
      | 20250601     | Repayment        | 19.98  | 15.66     | 4.32     | 0.0  | 0.0       | 407.72       |
      | 20250701     | Repayment        | 19.98  | 15.82     | 4.16     | 0.0  | 0.0       | 391.9        |
    When Admin sets the business date to "20251001"
    When Admin runs inline COB job for Loan
    Then Loan has 11.51 total unpaid payable due interest
    Then Loan has 0.0 total unpaid payable not due interest
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 423.38        | 56.13    | 0.0  | 0.0       | 479.51 | 39.96 | 0.0        | 0.0  | 439.55      |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250501       | Disbursement     | 423.38 | 0.0       | 0.0      | 0.0  | 0.0       | 423.38       |
      | 20250601      | Repayment        | 19.98  | 15.66     | 4.32     | 0.0  | 0.0       | 407.72       |
      | 20250601      | Accrual Activity | 4.32   | 0.0       | 4.32     | 0.0  | 0.0       | 0.0          |
      | 20250701      | Repayment        | 19.98  | 15.82     | 4.16     | 0.0  | 0.0       | 391.9        |
      | 20250701      | Accrual Activity | 4.16   | 0.0       | 4.16     | 0.0  | 0.0       | 0.0          |
      | 20250801    | Accrual Activity | 4.0    | 0.0       | 4.0      | 0.0  | 0.0       | 0.0          |
      | 20250901 | Accrual Activity | 3.84   | 0.0       | 3.84     | 0.0  | 0.0       | 0.0          |
      | 20250930 | Accrual          | 19.87  | 0.0       | 19.87    | 0.0  | 0.0       | 0.0          |
    And Admin does charge-off the loan on "20251001"
    Then LoanBalanceChangedBusinessEvent is created on "20251001"
    Then Loan has 11.51 total unpaid payable due interest
    Then Loan has 0.0 total unpaid payable not due interest

  @TestRailId:C4579
  Scenario: Verify charge-off after repayment reversal with merchant refund and credit balance refund
    When Admin sets the business date to "20251103"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_RECALC_ZERO_CHARGE_OFF_ACCRUAL | 20251103  | 127.17         | 9.51                   | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20251103" with "127.17" amount and expected disbursement date on "20251103"
    When Admin successfully disburse the loan on "20251103" with "127.17" EUR transaction amount
    When Admin sets the business date to "20251203"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20251203" with 6 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20251217"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20251217" with 145 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20260123"
    When Admin makes Credit Balance Refund transaction on "20260123" with 23.83 EUR transaction amount
    When Customer undo "1"th "Repayment" transaction made on "20251203"
    And Admin does charge-off the loan on "20260123"
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20251103 | Disbursement           | 127.17 | 0.0       | 0.0      | 0.0  | 0.0       | 127.17       | false    |
      | 20251203 | Repayment              | 6.0    | 5.01      | 0.99     | 0.0  | 0.0       | 122.16       | true     |
      | 20251203 | Accrual Activity       | 0.99   | 0.0       | 0.99     | 0.0  | 0.0       | 0.0          | false    |
      | 20251217 | Accrual                | 1.44   | 0.0       | 1.44     | 0.0  | 0.0       | 0.0          | false    |
      | 20251217 | Merchant Issued Refund | 145.0  | 127.17    | 1.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20251217 | Interest Refund        | 1.45   | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    |
      | 20251217 | Accrual Activity       | 0.46   | 0.0       | 0.46     | 0.0  | 0.0       | 0.0          | false    |
      | 20260103  | Accrual Activity       | 0.46   | 0.0       | 0.46     | 0.0  | 0.0       | 0.0          | false    |
      | 20260123  | Credit Balance Refund  | 23.83  | 6.0       | 0.0      | 0.0  | 0.0       | 6.0          | false    |
      | 20260123  | Accrual                | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20260123  | Charge-off             | 6.0    | 6.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20251103  |                  | 127.17          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20251203  | 20251217 | 122.32          | 4.85          | 0.99     | 0.0  | 0.0       | 5.84  | 5.84  | 0.0        | 5.84 | 0.0         |
      | 2  | 31   | 20260103   | 20251217 | 116.94          | 5.38          | 0.46     | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 3  | 31   | 20260203  |                  | 111.1           | 29.67         | 0.0      | 0.0  | 0.0       | 29.67 | 23.67 | 23.67      | 0.0  | 6.0         |
      | 4  | 28   | 20260303     | 20251217 | 105.26          | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 5  | 31   | 20260403     | 20251217 | 99.42           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 6  | 30   | 20260503       | 20251217 | 93.58           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 7  | 31   | 20260603      | 20251217 | 87.74           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 8  | 30   | 20260703      | 20251217 | 81.9            | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 9  | 31   | 20260803    | 20251217 | 76.06           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 10 | 31   | 20260903 | 20251217 | 70.22           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 11 | 30   | 20261003   | 20251217 | 64.38           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 12 | 31   | 20261103  | 20251217 | 58.54           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 13 | 30   | 20261203  | 20251217 | 52.7            | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 14 | 31   | 20270103   | 20251217 | 46.86           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 15 | 31   | 20270203  | 20251217 | 41.02           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 16 | 28   | 20270303     | 20251217 | 35.18           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 17 | 31   | 20270403     | 20251217 | 29.34           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 18 | 30   | 20270503       | 20251217 | 23.5            | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 19 | 31   | 20270603      | 20251217 | 17.66           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 20 | 30   | 20270703      | 20251217 | 11.82           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 21 | 31   | 20270803    | 20251217 | 5.98            | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 22 | 31   | 20270903 | 20251217 | 0.14            | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 23 | 30   | 20271003   | 20251217 | 0.0             | 0.14          | 0.0      | 0.0  | 0.0       | 0.14  | 0.14  | 0.14       | 0.0  | 0.0         |
      | 24 | 31   | 20271103  | 20251217 | 0.0             | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 151.0         | 1.45     | 0.0  | 0.0       | 152.45 | 146.45 | 140.61     | 5.84 | 6.0         |
    When Loan Pay-off is made on "20260123"
    Then Loan's all installments have obligations met

  @TestRailId:C4580
  Scenario: Verify charge-off after repayment reversal with multiple merchant refunds and credit balance refund
    When Admin sets the business date to "20230312"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_RECALC_ZERO_CHARGE_OFF_ACCRUAL | 20230312     | 127.17         | 9.51                   | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230312" with "127.17" amount and expected disbursement date on "20230312"
#  --- Step 1: Disbursement ---
    When Admin successfully disburse the loan on "20230312" with "127.17" EUR transaction amount
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20230312     |           | 127.17          |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 31   | 20230412     |           | 122.36          | 4.81          | 1.03     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 2  | 30   | 20230512       |           | 117.48          | 4.88          | 0.96     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 3  | 31   | 20230612      |           | 112.59          | 4.89          | 0.95     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 4  | 30   | 20230712      |           | 107.63          | 4.96          | 0.88     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 5  | 31   | 20230812    |           | 102.66          | 4.97          | 0.87     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 6  | 31   | 20230912 |           | 97.65           | 5.01          | 0.83     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 7  | 30   | 20231012   |           | 92.57           | 5.08          | 0.76     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 8  | 31   | 20231112  |           | 87.48           | 5.09          | 0.75     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 9  | 30   | 20231212  |           | 82.32           | 5.16          | 0.68     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 10 | 31   | 20240112   |           | 77.14           | 5.18          | 0.66     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 11 | 31   | 20240212  |           | 71.92           | 5.22          | 0.62     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 12 | 29   | 20240312     |           | 66.62           | 5.3           | 0.54     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 13 | 31   | 20240412     |           | 61.32           | 5.3           | 0.54     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 14 | 30   | 20240512       |           | 55.96           | 5.36          | 0.48     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 15 | 31   | 20240612      |           | 50.57           | 5.39          | 0.45     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 16 | 30   | 20240712      |           | 45.13           | 5.44          | 0.4      | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 17 | 31   | 20240812    |           | 39.65           | 5.48          | 0.36     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 18 | 31   | 20240912 |           | 34.13           | 5.52          | 0.32     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 19 | 30   | 20241012   |           | 28.56           | 5.57          | 0.27     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 20 | 31   | 20241112  |           | 22.95           | 5.61          | 0.23     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 21 | 30   | 20241212  |           | 17.29           | 5.66          | 0.18     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 22 | 31   | 20250112   |           | 11.59           | 5.7           | 0.14     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 23 | 31   | 20250212  |           | 5.84            | 5.75          | 0.09     | 0.0  | 0.0       | 5.84 | 0.0  | 0.0        | 0.0  | 5.84        |
      | 24 | 28   | 20250312     |           | 0.0             | 5.84          | 0.04     | 0.0  | 0.0       | 5.88 | 0.0  | 0.0        | 0.0  | 5.88        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 127.17        | 13.03    | 0.0  | 0.0       | 140.20 | 0.0  | 0.0        | 0.0  | 140.20      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20230312    | Disbursement     | 127.17 | 0.0       | 0.0      | 0.0  | 0.0       | 127.17       | false    | false    |
#  --- Step 2: First Repayment ---
    When Admin sets the business date to "20230412"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230412" with 5.84 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 127.17        | 13.03    | 0.0  | 0.0       | 140.20 | 5.84 | 0.0        | 0.0  | 134.36      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20230312    | Disbursement     | 127.17 | 0.0       | 0.0      | 0.0  | 0.0       | 127.17       | false    | false    |
      | 20230412    | Repayment        | 5.84   | 4.81      | 1.03     | 0.0  | 0.0       | 122.36       | false    | false    |
#  --- Step 3: Merchant Issued Refunds (2x 42.39) ---
    When Admin sets the business date to "20230420"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230420" with 42.39 EUR transaction amount and system-generated Idempotency key
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230420" with 42.39 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 127.17        | 4.4      | 0.0  | 0.0       | 131.57 | 91.49 | 85.65      | 0.0  | 40.08       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20230312    | Disbursement           | 127.17 | 0.0       | 0.0      | 0.0  | 0.0       | 127.17       | false    | false    |
      | 20230412    | Repayment              | 5.84   | 4.81      | 1.03     | 0.0  | 0.0       | 122.36       | false    | false    |
      | 20230420    | Merchant Issued Refund | 42.39  | 42.39     | 0.0      | 0.0  | 0.0       | 79.97        | false    | false    |
      | 20230420    | Interest Refund        | 0.44   | 0.44      | 0.0      | 0.0  | 0.0       | 79.53        | false    | false    |
      | 20230420    | Merchant Issued Refund | 42.39  | 42.39     | 0.0      | 0.0  | 0.0       | 37.14        | false    | false    |
      | 20230420    | Interest Refund        | 0.43   | 0.43      | 0.0      | 0.0  | 0.0       | 36.71        | false    | false    |
#  --- Step 4: Repayment on 20230512 (will be reversed later) ---
    When Admin sets the business date to "20230512"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230512" with 5.84 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 127.17        | 4.32     | 0.0  | 0.0       | 131.49 | 97.33 | 90.29      | 0.0  | 34.16       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20230312    | Disbursement           | 127.17 | 0.0       | 0.0      | 0.0  | 0.0       | 127.17       | false    | false    |
      | 20230412    | Repayment              | 5.84   | 4.81      | 1.03     | 0.0  | 0.0       | 122.36       | false    | false    |
      | 20230420    | Merchant Issued Refund | 42.39  | 42.39     | 0.0      | 0.0  | 0.0       | 79.97        | false    | false    |
      | 20230420    | Interest Refund        | 0.44   | 0.44      | 0.0      | 0.0  | 0.0       | 79.53        | false    | false    |
      | 20230420    | Merchant Issued Refund | 42.39  | 42.39     | 0.0      | 0.0  | 0.0       | 37.14        | false    | false    |
      | 20230420    | Interest Refund        | 0.43   | 0.43      | 0.0      | 0.0  | 0.0       | 36.71        | false    | false    |
      | 20230512      | Repayment              | 5.84   | 5.37      | 0.47     | 0.0  | 0.0       | 31.34        | false    | false    |
#  --- Step 5: Undo Repayment from 20230512 ---
    When Admin sets the business date to "20230513"
    When Customer undo "1"th "Repayment" transaction made on "20230512"
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230512" is reverted
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 127.17        | 4.4      | 0.0  | 0.0       | 131.57 | 91.49 | 85.65       | 0.0  | 40.08      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20230312    | Disbursement           | 127.17 | 0.0       | 0.0      | 0.0  | 0.0       | 127.17       | false    | false    |
      | 20230412    | Repayment              | 5.84   | 4.81      | 1.03     | 0.0  | 0.0       | 122.36       | false    | false    |
      | 20230420    | Merchant Issued Refund | 42.39  | 42.39     | 0.0      | 0.0  | 0.0       | 79.97        | false    | false    |
      | 20230420    | Interest Refund        | 0.44   | 0.44      | 0.0      | 0.0  | 0.0       | 79.53        | false    | false    |
      | 20230420    | Merchant Issued Refund | 42.39  | 42.39     | 0.0      | 0.0  | 0.0       | 37.14        | false    | false    |
      | 20230420    | Interest Refund        | 0.43   | 0.43      | 0.0      | 0.0  | 0.0       | 36.71        | false    | false    |
      | 20230512      | Repayment              | 5.84   | 5.37      | 0.47     | 0.0  | 0.0       | 31.34        | true     | false    |
#  --- Step 6: Repayment on 20230522 ---
    When Admin sets the business date to "20230522"
    When Customer makes "REPAYMENT" transaction with "REAL_TIME" payment type on "20230522" with 5.84 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 127.17        | 4.35     | 0.0  | 0.0       | 131.52 | 97.33 | 90.29      | 1.2  | 34.19       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20230312    | Disbursement           | 127.17 | 0.0       | 0.0      | 0.0  | 0.0       | 127.17       | false    | false    |
      | 20230412    | Repayment              | 5.84   | 4.81      | 1.03     | 0.0  | 0.0       | 122.36       | false    | false    |
      | 20230420    | Merchant Issued Refund | 42.39  | 42.39     | 0.0      | 0.0  | 0.0       | 79.97        | false    | false    |
      | 20230420    | Interest Refund        | 0.44   | 0.44      | 0.0      | 0.0  | 0.0       | 79.53        | false    | false    |
      | 20230420    | Merchant Issued Refund | 42.39  | 42.39     | 0.0      | 0.0  | 0.0       | 37.14        | false    | false    |
      | 20230420    | Interest Refund        | 0.43   | 0.43      | 0.0      | 0.0  | 0.0       | 36.71        | false    | false    |
      | 20230512      | Repayment              | 5.84   | 5.37      | 0.47     | 0.0  | 0.0       | 31.34        | true     | false    |
      | 20230522      | Repayment              | 5.84   | 5.27      | 0.57     | 0.0  | 0.0       | 31.44        | false    | false    |
    When Admin sets the business date to "20230612"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230612" with 5.84 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 127.17        | 4.17     | 0.0  | 0.0       | 131.34 | 103.17 | 96.13     | 1.2  | 28.17       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20230312    | Disbursement           | 127.17 | 0.0       | 0.0      | 0.0  | 0.0       | 127.17       | false    | false    |
      | 20230412    | Repayment              | 5.84   | 4.81      | 1.03     | 0.0  | 0.0       | 122.36       | false    | false    |
      | 20230420    | Merchant Issued Refund | 42.39  | 42.39     | 0.0      | 0.0  | 0.0       | 79.97        | false    | false    |
      | 20230420    | Interest Refund        | 0.44   | 0.44      | 0.0      | 0.0  | 0.0       | 79.53        | false    | false    |
      | 20230420    | Merchant Issued Refund | 42.39  | 42.39     | 0.0      | 0.0  | 0.0       | 37.14        | false    | false    |
      | 20230420    | Interest Refund        | 0.43   | 0.43      | 0.0      | 0.0  | 0.0       | 36.71        | false    | false    |
      | 20230512      | Repayment              | 5.84   | 5.37      | 0.47     | 0.0  | 0.0       | 31.34        | true     | false    |
      | 20230522      | Repayment              | 5.84   | 5.27      | 0.57     | 0.0  | 0.0       | 31.44        | false    | false    |
      | 20230612     | Repayment              | 5.84   | 5.67      | 0.17     | 0.0  | 0.0       | 25.77        | false    | false    |
#  --- Step 8: Repayment on 20230712 (will be reversed later) ---
    When Admin sets the business date to "20230712"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230712" with 5.84 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 127.17        | 3.9      | 0.0  | 0.0       | 131.07 | 109.01 | 101.97     | 1.2  | 22.06       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20230312    | Disbursement           | 127.17 | 0.0       | 0.0      | 0.0  | 0.0       | 127.17       | false    | false    |
      | 20230412    | Repayment              | 5.84   | 4.81      | 1.03     | 0.0  | 0.0       | 122.36       | false    | false    |
      | 20230420    | Merchant Issued Refund | 42.39  | 42.39     | 0.0      | 0.0  | 0.0       | 79.97        | false    | false    |
      | 20230420    | Interest Refund        | 0.44   | 0.44      | 0.0      | 0.0  | 0.0       | 79.53        | false    | false    |
      | 20230420    | Merchant Issued Refund | 42.39  | 42.39     | 0.0      | 0.0  | 0.0       | 37.14        | false    | false    |
      | 20230420    | Interest Refund        | 0.43   | 0.43      | 0.0      | 0.0  | 0.0       | 36.71        | false    | false    |
      | 20230512      | Repayment              | 5.84   | 5.37      | 0.47     | 0.0  | 0.0       | 31.34        | true     | false    |
      | 20230522      | Repayment              | 5.84   | 5.27      | 0.57     | 0.0  | 0.0       | 31.44        | false    | false    |
      | 20230612     | Repayment              | 5.84   | 5.67      | 0.17     | 0.0  | 0.0       | 25.77        | false    | false    |
      | 20230712     | Repayment              | 5.84   | 5.64      | 0.2      | 0.0  | 0.0       | 20.13        | false    | false    |
#  --- Step 9: Merchant Issued Refund on 20230724 ---
    When Admin sets the business date to "20230724"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230724" with 42.39 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 127.17        | 2.03     | 0.0  | 0.0       | 129.2  | 129.2  | 122.16     | 1.2  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20230312    | Disbursement           | 127.17 | 0.0       | 0.0      | 0.0  | 0.0       | 127.17       | false    | false    |
      | 20230412    | Repayment              | 5.84   | 4.81      | 1.03     | 0.0  | 0.0       | 122.36       | false    | false    |
      | 20230412    | Accrual Activity       | 1.03   | 0.0       | 1.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20230420    | Merchant Issued Refund | 42.39  | 42.39     | 0.0      | 0.0  | 0.0       | 79.97        | false    | false    |
      | 20230420    | Interest Refund        | 0.44   | 0.44      | 0.0      | 0.0  | 0.0       | 79.53        | false    | false    |
      | 20230420    | Merchant Issued Refund | 42.39  | 42.39     | 0.0      | 0.0  | 0.0       | 37.14        | false    | false    |
      | 20230420    | Interest Refund        | 0.43   | 0.43      | 0.0      | 0.0  | 0.0       | 36.71        | false    | false    |
      | 20230512      | Repayment              | 5.84   | 5.37      | 0.47     | 0.0  | 0.0       | 31.34        | true     | false    |
      | 20230512      | Accrual Activity       | 0.47   | 0.0       | 0.47     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20230522      | Repayment              | 5.84   | 5.27      | 0.57     | 0.0  | 0.0       | 31.44        | false    | false    |
      | 20230612     | Repayment              | 5.84   | 5.67      | 0.17     | 0.0  | 0.0       | 25.77        | false    | false    |
      | 20230612     | Accrual Activity       | 0.1    | 0.0       | 0.1      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20230712     | Repayment              | 5.84   | 5.64      | 0.2      | 0.0  | 0.0       | 20.13        | false    | false    |
      | 20230724     | Merchant Issued Refund | 42.39  | 20.13     | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20230724     | Interest Refund        | 1.16   | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20230724     | Accrual                | 2.03   | 0.0       | 2.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20230724     | Accrual Activity       | 0.43   | 0.0       | 0.43     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan status will be "OVERPAID"
#  --- Step 10: Credit Balance Refund on 20230725 ---
    When Admin sets the business date to "20230725"
    When Admin makes Credit Balance Refund transaction on "20230725" with 23.36 EUR transaction amount
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 127.17        | 2.03     | 0.0  | 0.0       | 129.2  | 129.2  | 122.16     | 1.2  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20230312    | Disbursement           | 127.17 | 0.0       | 0.0      | 0.0  | 0.0       | 127.17       | false    | false    |
      | 20230412    | Repayment              | 5.84   | 4.81      | 1.03     | 0.0  | 0.0       | 122.36       | false    | false    |
      | 20230412    | Accrual Activity       | 1.03   | 0.0       | 1.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20230420    | Merchant Issued Refund | 42.39  | 42.39     | 0.0      | 0.0  | 0.0       | 79.97        | false    | false    |
      | 20230420    | Interest Refund        | 0.44   | 0.44      | 0.0      | 0.0  | 0.0       | 79.53        | false    | false    |
      | 20230420    | Merchant Issued Refund | 42.39  | 42.39     | 0.0      | 0.0  | 0.0       | 37.14        | false    | false    |
      | 20230420    | Interest Refund        | 0.43   | 0.43      | 0.0      | 0.0  | 0.0       | 36.71        | false    | false    |
      | 20230512      | Repayment              | 5.84   | 5.37      | 0.47     | 0.0  | 0.0       | 31.34        | true     | false    |
      | 20230512      | Accrual Activity       | 0.47   | 0.0       | 0.47     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20230522      | Repayment              | 5.84   | 5.27      | 0.57     | 0.0  | 0.0       | 31.44        | false    | false    |
      | 20230612     | Repayment              | 5.84   | 5.67      | 0.17     | 0.0  | 0.0       | 25.77        | false    | false    |
      | 20230612     | Accrual Activity       | 0.1    | 0.0       | 0.1      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20230712     | Repayment              | 5.84   | 5.64      | 0.2      | 0.0  | 0.0       | 20.13        | false    | false    |
      | 20230724     | Merchant Issued Refund | 42.39  | 20.13     | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20230724     | Interest Refund        | 1.16   | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20230724     | Accrual                | 2.03   | 0.0       | 2.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20230724     | Accrual Activity       | 0.43   | 0.0       | 0.43     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20230725     | Credit Balance Refund  | 23.36  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
#  --- Step 11: Undo Repayment from 20230712 ---
    When Customer undo "1"th "Repayment" transaction made on "20230712"
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 150.53        | 2.36     | 0.0  | 0.0       | 152.89 | 146.74 | 139.7      | 1.2  | 6.15        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20230312    | Disbursement           | 127.17 | 0.0       | 0.0      | 0.0  | 0.0       | 127.17       | false    | false    |
      | 20230412    | Repayment              | 5.84   | 4.81      | 1.03     | 0.0  | 0.0       | 122.36       | false    | false    |
      | 20230412    | Accrual Activity       | 1.03   | 0.0       | 1.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20230420    | Merchant Issued Refund | 42.39  | 42.39     | 0.0      | 0.0  | 0.0       | 79.97        | false    | false    |
      | 20230420    | Interest Refund        | 0.44   | 0.44      | 0.0      | 0.0  | 0.0       | 79.53        | false    | false    |
      | 20230420    | Merchant Issued Refund | 42.39  | 42.39     | 0.0      | 0.0  | 0.0       | 37.14        | false    | false    |
      | 20230420    | Interest Refund        | 0.43   | 0.43      | 0.0      | 0.0  | 0.0       | 36.71        | false    | false    |
      | 20230512      | Repayment              | 5.84   | 5.37      | 0.47     | 0.0  | 0.0       | 31.34        | true     | false    |
      | 20230512      | Accrual Activity       | 0.47   | 0.0       | 0.47     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20230522      | Repayment              | 5.84   | 5.27      | 0.57     | 0.0  | 0.0       | 31.44        | false    | false    |
      | 20230612     | Repayment              | 5.84   | 5.67      | 0.17     | 0.0  | 0.0       | 25.77        | false    | false    |
      | 20230612     | Accrual Activity       | 0.1    | 0.0       | 0.1      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20230712     | Repayment              | 5.84   | 5.64      | 0.2      | 0.0  | 0.0       | 20.13        | true     | false    |
      | 20230724     | Accrual                | 2.03   | 0.0       | 2.03     | 0.0  | 0.0       | 0.0          | false    | false     |
      | 20230724     | Merchant Issued Refund | 42.39  | 25.77     | 0.28     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20230724     | Interest Refund        | 1.18   | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20230725     | Credit Balance Refund  | 23.36  | 5.84      | 0.0      | 0.0  | 0.0       | 5.84         | false    | true     |
    Then Loan status will be "ACTIVE"
#  --- Step 12: Charge-off on 20230726
    When Admin sets the business date to "20230726"
    And Admin does charge-off the loan on "20230726"
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230312     |               | 127.17          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20230412     | 20230412 | 122.36          | 4.81          | 1.03     | 0.0  | 0.0       | 5.84  | 5.84  | 0.0        | 0.0  | 0.0         |
      | 2  | 30   | 20230512       | 20230522   | 116.99          | 5.37          | 0.47     | 0.0  | 0.0       | 5.84  | 5.84  | 4.64       | 1.2  | 0.0         |
      | 3  | 31   | 20230612      | 20230522   | 111.25          | 5.74          | 0.1      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 4  | 30   | 20230712      | 20230522   | 105.41          | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 5  | 31   | 20230812    |               | 99.74           | 29.03         | 0.45     | 0.0  | 0.0       | 29.48 | 23.36 | 23.36      | 0.0  | 6.12        |
      | 6  | 31   | 20230912 | 20230612  | 93.9            | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 7  | 30   | 20231012   | 20230612  | 88.06           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 8  | 31   | 20231112  | 20230724  | 82.5            | 5.56          | 0.28     | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 9  | 30   | 20231212  | 20230724  | 76.66           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 10 | 31   | 20240112   | 20230724  | 70.82           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 11 | 31   | 20240212  | 20230724  | 64.98           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 12 | 29   | 20240312     | 20230724  | 59.14           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 13 | 31   | 20240412     | 20230724  | 53.3            | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 14 | 30   | 20240512       | 20230724  | 47.46           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 15 | 31   | 20240612      | 20230724  | 41.62           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 16 | 30   | 20240712      | 20230724  | 35.78           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 17 | 31   | 20240812    | 20230724  | 29.94           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 18 | 31   | 20240912 | 20230724  | 24.1            | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 19 | 30   | 20241012   | 20230724  | 18.26           | 5.84          | 0.0      | 0.0  | 0.0       | 5.84  | 5.84  | 5.84       | 0.0  | 0.0         |
      | 20 | 31   | 20241112  | 20230724  | 13.15           | 5.11          | 0.0      | 0.0  | 0.0       | 5.11  | 5.11  | 5.11       | 0.0  | 0.0         |
      | 21 | 30   | 20241212  | 20230724  | 9.38            | 3.77          | 0.0      | 0.0  | 0.0       | 3.77  | 3.77  | 3.77       | 0.0  | 0.0         |
      | 22 | 31   | 20250112   | 20230420 | 5.61            | 3.77          | 0.0      | 0.0  | 0.0       | 3.77  | 3.77  | 3.77       | 0.0  | 0.0         |
      | 23 | 31   | 20250212  | 20230420 | 1.91            | 3.7           | 0.0      | 0.0  | 0.0       | 3.7   | 3.7   | 3.7        | 0.0  | 0.0         |
      | 24 | 28   | 20250312     | 20230420 | 0.0             | 1.91          | 0.0      | 0.0  | 0.0       | 1.91  | 1.91  | 1.91       | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 150.53        | 2.33     | 0.0  | 0.0       | 152.86 | 146.74 | 139.7      | 1.2  | 6.12        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20230312    | Disbursement           | 127.17  | 0.0       | 0.0      | 0.0  | 0.0       | 127.17       | false    | false    |
      | 20230412    | Repayment              | 5.84    | 4.81      | 1.03     | 0.0  | 0.0       | 122.36       | false    | false    |
      | 20230412    | Accrual Activity       | 1.03    | 0.0       | 1.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20230420    | Merchant Issued Refund | 42.39   | 42.39     | 0.0      | 0.0  | 0.0       | 79.97        | false    | false    |
      | 20230420    | Interest Refund        | 0.44    | 0.44      | 0.0      | 0.0  | 0.0       | 79.53        | false    | false    |
      | 20230420    | Merchant Issued Refund | 42.39   | 42.39     | 0.0      | 0.0  | 0.0       | 37.14        | false    | false    |
      | 20230420    | Interest Refund        | 0.43    | 0.43      | 0.0      | 0.0  | 0.0       | 36.71        | false    | false    |
      | 20230512      | Repayment              | 5.84    | 5.37      | 0.47     | 0.0  | 0.0       | 31.34        | true     | false    |
      | 20230512      | Accrual Activity       | 0.47    | 0.0       | 0.47     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20230522      | Repayment              | 5.84    | 5.27      | 0.57     | 0.0  | 0.0       | 31.44        | false    | false    |
      | 20230612     | Repayment              | 5.84    | 5.67      | 0.17     | 0.0  | 0.0       | 25.77        | false    | false    |
      | 20230612     | Accrual Activity       | 0.1    | 0.0       | 0.1      | 0.0  | 0.0       | 0.0           | false    | false    |
      | 20230712     | Repayment              | 5.84    | 5.64      | 0.2      | 0.0  | 0.0       | 20.13        | true     | false    |
      | 20230724     | Accrual                | 2.03    | 0.0       | 2.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20230724     | Merchant Issued Refund | 42.39   | 25.77     | 0.28     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20230724     | Interest Refund        | 1.18    | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20230725     | Credit Balance Refund  | 23.36   | 5.84      | 0.0      | 0.0  | 0.0       | 5.84         | false    | true     |
      | 20230726     | Accrual                | 0.02    | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20230726     | Charge-off             | 6.12   | 5.84       | 0.28     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan status will be "ACTIVE"

