@LoanReAgingAccrualsFeature
Feature: LoanReAgingAccruals

  @TestRailId:C4417 @AdvancedPaymentAllocation
  Scenario: Verify Re-aging on interest bearing loan - Interest calculation: Default Behavior - Accrual and Accrual Activity handling
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_REFUND_INTEREST_RECALC_ACCRUAL_ACTIVITY | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
    When Admin sets the business date to "20240201"
    When Admin runs inline COB job for Loan
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
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
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
    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate    | numberOfInstallments |
      | 1               | MONTHS        | 20240401| 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501      |                  | 56.36           | 13.89         | 0.41     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 6  | 31   | 20240601     |                  | 42.39           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701     |                  | 28.34           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801   |                  | 14.21           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901|                  | 0.0             | 14.21         | 0.08     | 0.0  | 0.0       | 14.29 | 0.0   | 0.0        | 0.0  | 14.29       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.8      | 0.0  | 0.0       | 102.8 | 17.01 | 0.0        | 0.0  | 85.79       |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240201 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      When Admin sets the business date to "20240401"
    And Customer makes "AUTOPAY" repayment on "20240401" with 14.3 EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240501"
    And Customer makes "AUTOPAY" repayment on "20240501" with 14.3 EUR transaction amount
    When Admin sets the business date to "20240601"
    And Customer makes "AUTOPAY" repayment on "20240601" with 14.3 EUR transaction amount
    When Admin sets the business date to "20240701"
    And Customer makes "AUTOPAY" repayment on "20240701" with 14.3 EUR transaction amount
    When Admin sets the business date to "20240801"
    And Customer makes "AUTOPAY" repayment on "20240801" with 14.3 EUR transaction amount
    When Admin sets the business date to "20240901"
    And Customer makes "AUTOPAY" repayment on "20240901" with 14.29 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101   | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201  | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201  | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315     | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401     | Repayment        | 14.3   | 13.32     | 0.98     | 0.0  | 0.0       | 70.25        | false    | false    |
      | 20240401     | Accrual Activity | 0.98   | 0.0       | 0.98     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501       | Repayment        | 14.3   | 13.89     | 0.41     | 0.0  | 0.0       | 56.36        | false    | false    |
      | 20240501       | Accrual Activity | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240601      | Repayment        | 14.3   | 13.97     | 0.33     | 0.0  | 0.0       | 42.39        | false    | false    |
      | 20240601      | Accrual Activity | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240701      | Repayment        | 14.3   | 14.05     | 0.25     | 0.0  | 0.0       | 28.34        | false    | false    |
      | 20240701      | Accrual Activity | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240801    | Repayment        | 14.3   | 14.13     | 0.17     | 0.0  | 0.0       | 14.21        | false    | false    |
      | 20240801    | Accrual Activity | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240901 | Repayment        | 14.29  | 14.21     | 0.08     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240901 | Accrual Activity | 0.08   | 0.0       | 0.08     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240315     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240901 | Accrual          | 1.26   | 0.0       | 1.26     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4418 @AdvancedPaymentAllocation
  Scenario: Verify Re-aging on interest bearing loan - Interest calculation: Default Behavior - Accrual and Accrual Activity handling, Backdated re-aging
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_REFUND_INTEREST_RECALC_ACCRUAL_ACTIVITY | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
    When Admin sets the business date to "20240201"
    When Admin runs inline COB job for Loan
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
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
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
    When Admin sets the business date to "20240501"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101   | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201  | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201  | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301     | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401     | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240201  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203  | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206  | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209  | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212  | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216  | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219  | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222  | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225  | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228  | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229  | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240402     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240403     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240404     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240405     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240406     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240407     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240408     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240409     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240410     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240411     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240412     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240413     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240414     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240415     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240416     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240417     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240418     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240419     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240420     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240421     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240422     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240423     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240424     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240425     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240426     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240427     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240428     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240429     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240430     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240315 | 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 0    | 20240315    |                  | 70.03           | 13.54         | 0.71     | 0.0  | 0.0       | 14.25 | 0.0   | 0.0        | 0.0  | 14.25       |
      | 5  | 31   | 20240415    |                  | 56.27           | 13.76         | 0.49     | 0.0  | 0.0       | 14.25 | 0.0   | 0.0        | 0.0  | 14.25       |
      | 6  | 30   | 20240515      |                  | 42.43           | 13.84         | 0.41     | 0.0  | 0.0       | 14.25 | 0.0   | 0.0        | 0.0  | 14.25       |
      | 7  | 31   | 20240615     |                  | 28.43           | 14.0          | 0.25     | 0.0  | 0.0       | 14.25 | 0.0   | 0.0        | 0.0  | 14.25       |
      | 8  | 30   | 20240715     |                  | 14.35           | 14.08         | 0.17     | 0.0  | 0.0       | 14.25 | 0.0   | 0.0        | 0.0  | 14.25       |
      | 9  | 31   | 20240815   |                  | 0.0             | 14.35         | 0.08     | 0.0  | 0.0       | 14.43 | 0.0   | 0.0        | 0.0  | 14.43       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.69     | 0.0  | 0.0       | 102.69 | 17.01 | 0.0        | 0.0  | 85.68       |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual Activity | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240415    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has no new accrual data
    And Customer makes "AUTOPAY" repayment on "20240501" with 28.5 EUR transaction amount
    When Admin sets the business date to "20240515"
    And Customer makes "AUTOPAY" repayment on "20240515" with 14.25 EUR transaction amount
    When Admin sets the business date to "20240615"
    And Customer makes "AUTOPAY" repayment on "20240615" with 14.25 EUR transaction amount
    When Admin sets the business date to "20240715"
    And Customer makes "AUTOPAY" repayment on "20240715" with 14.25 EUR transaction amount
    When Admin sets the business date to "20240815"
    And Customer makes "AUTOPAY" repayment on "20240815" with 14.43 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual Activity | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240415    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Repayment        | 28.5   | 27.3      | 1.2      | 0.0  | 0.0       | 56.27        | false    | false    |
      | 20240515      | Repayment        | 14.25  | 13.84     | 0.41     | 0.0  | 0.0       | 42.43        | false    | false    |
      | 20240515      | Accrual Activity | 0.41   | 0.0       | 0.41     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240615     | Repayment        | 14.25  | 14.0      | 0.25     | 0.0  | 0.0       | 28.43        | false    | false    |
      | 20240615     | Accrual Activity | 0.25   | 0.0       | 0.25     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240715     | Repayment        | 14.25  | 14.08     | 0.17     | 0.0  | 0.0       | 14.35        | false    | false    |
      | 20240715     | Accrual Activity | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240815   | Repayment        | 14.43  | 14.35     | 0.08     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240815   | Accrual Activity | 0.08   | 0.0       | 0.08     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240815   | Accrual          | 0.66   | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4419 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging with accruals on interest bearing loan - Interest calculation: Default Behavior - Fees and Interest Split before re-aging - UC2
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL  | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.01 EUR transaction amount
    When Admin sets the business date to "20240215"
    When Admin runs inline COB job for Loan
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240215" due date and 10 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.05           | 16.52         | 0.49     | 10.0 | 0.0       | 27.01 | 0.0   | 0.0        | 0.0  | 27.01       |
      | 3  | 31   | 20240401    |                  | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0   | 0.0        | 0.0  | 17.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 10.0 | 0.0       | 112.05 | 17.01 | 0.0        | 0.0  | 95.04       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual          | 0.8    | 0.0       | 0.8      | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20240215 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate    | numberOfInstallments |
      | 1               | MONTHS        | 20240401| 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 83.57           | 0.0           | 0.0      | 10.0 | 0.0       | 10.0  | 0.0   | 0.0        | 0.0  | 10.0        |
      | 3  | 14   | 20240315    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501      |                  | 56.36           | 13.89         | 0.41     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 6  | 31   | 20240601     |                  | 42.39           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701     |                  | 28.34           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801   |                  | 14.21           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901|                  | 0.0             | 14.21         | 0.08     | 0.0  | 0.0       | 14.29 | 0.0   | 0.0        | 0.0  | 14.29       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.8      | 10.0 | 0.0       | 112.8 | 17.01 | 0.0        | 0.0  | 95.79       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual          | 0.8    | 0.0       | 0.8      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 10.02  | 0.0       | 0.02     | 10.0 | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 10.49  | 0.0       | 0.49     | 10.0 | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20240215 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |

    When Admin sets the business date to "20240401"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual          | 0.8    | 0.0       | 0.8      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 10.02  | 0.0       | 0.02     | 10.0 | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          | false    | true     |
      | 20240302    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin successfully undo Loan re-aging transaction
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.05           | 16.52         | 0.49     | 10.0 | 0.0       | 27.01 | 0.0   | 0.0        | 0.0  | 27.01       |
      | 3  | 31   | 20240401    |                  | 50.53           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.81           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 17.0            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 17.0          | 0.1      | 0.0  | 0.0       | 17.1  | 0.0   | 0.0        | 0.0  | 17.1        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.15     | 10.0 | 0.0       | 112.15 | 17.01 | 0.0        | 0.0  | 95.14       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual          | 0.8    | 0.0       | 0.8      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 10.02  | 0.0       | 0.02     | 10.0 | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 10.49  | 0.0       | 0.49     | 10.0 | 0.0       | 0.0          | false    | true     |
      | 20240302    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20240315    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |

    And Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20240215 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |

    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4420 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging with accruals on interest bearing loan - Interest calculation: Default Behavior - Charge-back before re-aging - UC3
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INTEREST_RECALC_EMI_360_30_CHARGEBACK_INTEREST_PENALTY_FEE_PRINCIPAL | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
    When Admin sets the business date to "20240201"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.01 EUR transaction amount
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 17.01 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.14           | 32.86         | 1.16     | 0.0  | 0.0       | 34.02 | 0.0   | 0.0        | 0.0  | 34.02       |
      | 3  | 31   | 20240401    |                  | 50.52           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.8            | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.99           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.99         | 0.1      | 0.0  | 0.0       | 17.09 | 0.0   | 0.0        | 0.0  | 17.09       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 116.43        | 2.72     | 0.0  | 0.0       | 119.15 | 17.01 | 0.0        | 0.0  | 102.14      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240131  | Accrual          | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Chargeback       | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 100.0        | false    | false    |
    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate    | numberOfInstallments |
      | 1               | MONTHS        | 20240401| 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 84.53           | 15.47         | 1.74     | 0.0  | 0.0       | 17.21 | 0.0   | 0.0        | 0.0  | 17.21       |
      | 5  | 30   | 20240501      |                  | 67.81           | 16.72         | 0.49     | 0.0  | 0.0       | 17.21 | 0.0   | 0.0        | 0.0  | 17.21       |
      | 6  | 31   | 20240601     |                  | 51.0            | 16.81         | 0.4      | 0.0  | 0.0       | 17.21 | 0.0   | 0.0        | 0.0  | 17.21       |
      | 7  | 30   | 20240701     |                  | 34.09           | 16.91         | 0.3      | 0.0  | 0.0       | 17.21 | 0.0   | 0.0        | 0.0  | 17.21       |
      | 8  | 31   | 20240801   |                  | 17.08           | 17.01         | 0.2      | 0.0  | 0.0       | 17.21 | 0.0   | 0.0        | 0.0  | 17.21       |
      | 9  | 31   | 20240901|                  | 0.0             | 17.08         | 0.1      | 0.0  | 0.0       | 17.18 | 0.0   | 0.0        | 0.0  | 17.18       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 116.43        | 3.81     | 0.0  | 0.0       | 120.24 | 17.01| 0.0        | 0.0  | 103.23      |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Chargeback       | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240315    | Re-age           | 101.42 | 100.0     | 1.42     | 0.0  | 0.0       | 0.0          | false    | false    |

    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240131  | Accrual          | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    | 20240315    | 84.21           | 15.79         | 1.42     | 0.0  | 0.0       | 17.21 | 17.21 | 17.21      | 0.0  | 0.0         |
      | 5  | 30   | 20240501      | 20240315    | 67.0            | 17.21         | 0.0      | 0.0  | 0.0       | 17.21 | 17.21 | 17.21      | 0.0  | 0.0         |
      | 6  | 31   | 20240601     | 20240315    | 49.79           | 17.21         | 0.0      | 0.0  | 0.0       | 17.21 | 17.21 | 17.21      | 0.0  | 0.0         |
      | 7  | 30   | 20240701     | 20240315    | 32.58           | 17.21         | 0.0      | 0.0  | 0.0       | 17.21 | 17.21 | 17.21      | 0.0  | 0.0         |
      | 8  | 31   | 20240801   | 20240315    | 15.37           | 17.21         | 0.0      | 0.0  | 0.0       | 17.21 | 17.21 | 17.21      | 0.0  | 0.0         |
      | 9  | 31   | 20240901| 20240315    | 0.0             | 15.37         | 0.0      | 0.0  | 0.0       | 15.37 | 15.37 | 15.37      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 116.43        | 2.0      | 0.0  | 0.0       | 118.43 | 118.43 | 101.42     | 0.0  | 0.0         |

    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Chargeback       | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240315    | Re-age           | 101.42 | 100.0     | 1.42     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Repayment        | 101.42 | 100.0     | 1.42     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240315    | Accrual          | 0.6    | 0.0       | 0.6      | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C4421 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging with accruals on interest bearing loan - Interest calculation: Default Behavior - N+1 Scenario - UC4
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL  | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.01 EUR transaction amount
    When Admin sets the business date to "20240215"
    When Admin runs inline COB job for Loan
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240715" due date and 10 EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0   | 0.0        | 0.0  | 17.0        |
      | 7  | 14   | 20240715     |                  | 0.0             | 0.0           | 0.0      | 10.0 | 0.0       | 10.0  | 0.0   | 0.0        | 0.0  | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 10.0 | 0.0       | 112.05 | 17.01 | 0.0        | 0.0  | 95.04       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual          | 0.8    | 0.0       | 0.8      | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240401 | 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501      |                  | 56.36           | 13.89         | 0.41     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 6  | 31   | 20240601     |                  | 42.39           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701     |                  | 28.34           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801   |                  | 14.21           | 14.13         | 0.17     | 10.0 | 0.0       | 24.3  | 0.0   | 0.0        | 0.0  | 24.3        |
      | 9  | 31   | 20240901|                  | 0.0             | 14.21         | 0.08     | 0.0  | 0.0       | 14.29 | 0.0   | 0.0        | 0.0  | 14.29       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.8      | 10.0 | 0.0       | 112.8 | 17.01 | 0.0        | 0.0  | 95.79       |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |

    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240214 | Accrual          | 0.8    | 0.0       | 0.8      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Admin sets the business date to "20240401"
    When Admin runs inline COB job for Loan
    When Admin successfully undo Loan re-aging transaction
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 50.53           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.81           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 17.0            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 17.0          | 0.1      | 0.0  | 0.0       | 17.1  | 0.0   | 0.0        | 0.0  | 17.1        |
      | 7  | 14   | 20240715     |                  | 0.0             | 0.0           | 0.0      | 10.0 | 0.0       | 10.0  | 0.0   | 0.0        | 0.0  | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.15     | 10.0 | 0.0       | 112.15 | 17.01 | 0.0        | 0.0  | 95.14       |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | true     | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240315    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Admin sets the business date to "20240402"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 50.53           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.82           | 16.71         | 0.3      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 17.01           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 17.01         | 0.1      | 0.0  | 0.0       | 17.11 | 0.0   | 0.0        | 0.0  | 17.11       |
      | 7  | 14   | 20240715     |                  | 0.0             | 0.0           | 0.0      | 10.0 | 0.0       | 10.0  | 0.0   | 0.0        | 0.0  | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.16     | 10.0 | 0.0       | 112.16 | 17.01 | 0.0        | 0.0  | 95.15       |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20240401    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240401    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240402"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4422 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging with accruals on interest bearing loan - Interest calculation: Default Behavior - with LAST_INSTALLMENT allocation rule and partial repayment - continue with regular payments
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "LAST_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin sets the business date to "20240201"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240201" with 25.0 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.0            | 16.57         | 0.44     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 50.33           | 16.67         | 0.34     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.57           | 16.76         | 0.25     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.71           | 16.86         | 0.15     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.71         | 0.05     | 0.0  | 0.0       | 16.76 | 7.99  | 7.99       | 0.0  | 8.77        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.81     | 0.0  | 0.0       | 101.81 | 25.0 | 7.99       | 0.0  | 76.81       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240131  | Accrual          | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate    | numberOfInstallments |
      | 1               | MONTHS        | 20240401| 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 75.58           | 7.99          | 0.0      | 0.0  | 0.0       | 7.99  | 7.99  | 7.99       | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 63.53           | 12.05         | 0.88     | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 5  | 30   | 20240501      |                  | 50.97           | 12.56         | 0.37     | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 6  | 31   | 20240601     |                  | 38.34           | 12.63         | 0.3      | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 7  | 30   | 20240701     |                  | 25.63           | 12.71         | 0.22     | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 8  | 31   | 20240801   |                  | 12.85           | 12.78         | 0.15     | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 9  | 31   | 20240901|                  | 0.0             | 12.85         | 0.07     | 0.0  | 0.0       | 12.92 | 0.0   | 0.0        | 0.0  | 12.92       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.57     | 0.0  | 0.0       | 102.57 | 25.0 | 7.99       | 0.0  | 77.57       |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.44   | 0.0       | 0.44     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 76.22  | 75.58     | 0.64     | 0.0  | 0.0       | 0.0          | false    | false    |

    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240131  | Accrual          | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
#   Make regular payment on first re-aged installment due date instead of immediate payoff
    When Admin sets the business date to "20240401"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240401" with 12.93 EUR transaction amount
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 75.58           | 7.99          | 0.0      | 0.0  | 0.0       | 7.99  | 7.99  | 7.99       | 0.0  | 0.0         |
      | 4  | 17   | 20240401    | 20240401    | 63.53           | 12.05         | 0.88     | 0.0  | 0.0       | 12.93 | 12.93 | 0.0        | 0.0  | 0.0         |
      | 5  | 30   | 20240501      |                  | 50.97           | 12.56         | 0.37     | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 6  | 31   | 20240601     |                  | 38.34           | 12.63         | 0.3      | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 7  | 30   | 20240701     |                  | 25.63           | 12.71         | 0.22     | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 8  | 31   | 20240801   |                  | 12.85           | 12.78         | 0.15     | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 9  | 31   | 20240901|                  | 0.0             | 12.85         | 0.07     | 0.0  | 0.0       | 12.92 | 0.0   | 0.0        | 0.0  | 12.92       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.57     | 0.0  | 0.0       | 102.57 | 37.93 | 7.99       | 0.0  | 64.64       |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 76.22  | 75.58     | 0.64     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Repayment        | 12.93  | 12.05     | 0.88     | 0.0  | 0.0       | 63.53        | false    | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240315    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |

#   Continue with second regular payment
    When Admin sets the business date to "20240501"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240501" with 12.93 EUR transaction amount
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 75.58           | 7.99          | 0.0      | 0.0  | 0.0       | 7.99  | 7.99  | 7.99       | 0.0  | 0.0         |
      | 4  | 17   | 20240401    | 20240401    | 63.53           | 12.05         | 0.88     | 0.0  | 0.0       | 12.93 | 12.93 | 0.0        | 0.0  | 0.0         |
      | 5  | 30   | 20240501      | 20240501      | 50.97           | 12.56         | 0.37     | 0.0  | 0.0       | 12.93 | 12.93 | 0.0        | 0.0  | 0.0         |
      | 6  | 31   | 20240601     |                  | 38.34           | 12.63         | 0.3      | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 7  | 30   | 20240701     |                  | 25.63           | 12.71         | 0.22     | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 8  | 31   | 20240801   |                  | 12.85           | 12.78         | 0.15     | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 9  | 31   | 20240901|                  | 0.0             | 12.85         | 0.07     | 0.0  | 0.0       | 12.92 | 0.0   | 0.0        | 0.0  | 12.92       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.57     | 0.0  | 0.0       | 102.57 | 50.86 | 7.99       | 0.0  | 51.71       |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 76.22  | 75.58     | 0.64     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Repayment        | 12.93  | 12.05     | 0.88     | 0.0  | 0.0       | 63.53        | false    | false    |
      | 20240401    | Accrual Activity | 0.88   | 0.0       | 0.88     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Repayment        | 12.93  | 12.56     | 0.37     | 0.0  | 0.0       | 50.97        | false    | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240401    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240402    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240403    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240404    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240405    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240406    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240407    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240408    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240409    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240410    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240411    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240412    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240413    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240414    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240415    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240416    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240417    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240418    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240419    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240420    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240421    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240422    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240423    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240424    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240425    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240426    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240427    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240428    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240429    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240430    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

    When Loan Pay-off is made on "20240501"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4423 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging with accruals on interest bearing loan - Interest calculation: Default Behavior - Chargeback after re-aging - UC6
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INTEREST_RECALC_EMI_360_30_CHARGEBACK_INTEREST_PENALTY_FEE_PRINCIPAL | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
    When Admin sets the business date to "20240201"
    When Admin runs inline COB job for Loan
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
      | 20240131  | Accrual          | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate    | numberOfInstallments |
      | 1               | MONTHS        | 20240401| 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501      |                  | 56.36           | 13.89         | 0.41     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 6  | 31   | 20240601     |                  | 42.39           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701     |                  | 28.34           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801   |                  | 14.21           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901|                  | 0.0             | 14.21         | 0.08     | 0.0  | 0.0       | 14.29 | 0.0   | 0.0        | 0.0  | 14.29       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.8      | 0.0  | 0.0       | 102.8 | 17.01 | 0.0        | 0.0  | 85.79       |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |

    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240131  | Accrual          | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240401"
    When Admin runs inline COB job for Loan
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 17.01 EUR transaction amount
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501      |                  | 56.46           | 30.22         | 1.09     | 0.0  | 0.0       | 31.31 | 0.0   | 0.0        | 0.0  | 31.31       |
      | 6  | 31   | 20240601     |                  | 42.49           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701     |                  | 28.44           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801   |                  | 14.31           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901|                  | 0.0             | 14.31         | 0.08     | 0.0  | 0.0       | 14.39 | 0.0   | 0.0        | 0.0  | 14.39       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 116.43        | 3.48     | 0.0  | 0.0       | 119.91 | 17.01 | 0.0        | 0.0  | 102.9       |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Chargeback       | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 100.0        | false    | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240315    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4424 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging with accruals on interest bearing loan - Interest calculation: Default Behavior - DownPayment Scenarios - UC7
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_PYMNT_INTEREST_RECALCULATION_DAILY_EMI_360_30_MULTIDISBURSE_AUTO_DOWNPAYMENT" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_RECALCULATION_DAILY_EMI_360_30_MULTIDISBURSE_AUTO_DOWNPAYMENT | 20240101   | 100            | 7                       | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 |                 | 62.68           | 12.32         | 0.44     | 0.0  | 0.0       | 12.76 | 0.0  | 0.0        | 0.0  | 12.76       |
      | 3  | 29   | 20240301    |                 | 50.29           | 12.39         | 0.37     | 0.0  | 0.0       | 12.76 | 0.0  | 0.0        | 0.0  | 12.76       |
      | 4  | 31   | 20240401    |                 | 37.82           | 12.47         | 0.29     | 0.0  | 0.0       | 12.76 | 0.0  | 0.0        | 0.0  | 12.76       |
      | 5  | 30   | 20240501      |                 | 25.28           | 12.54         | 0.22     | 0.0  | 0.0       | 12.76 | 0.0  | 0.0        | 0.0  | 12.76       |
      | 6  | 31   | 20240601     |                 | 12.67           | 12.61         | 0.15     | 0.0  | 0.0       | 12.76 | 0.0  | 0.0        | 0.0  | 12.76       |
      | 7  | 30   | 20240701     |                 | 0.0             | 12.67         | 0.07     | 0.0  | 0.0       | 12.74 | 0.0  | 0.0        | 0.0  | 12.74       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.54     | 0.0  | 0.0       | 101.54 | 25.0 | 0.0        | 0.0  | 76.54       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Down Payment     | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         | false    | false    |
    When Admin sets the business date to "20240201"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240201" with 12.76 EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101 |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20240101 | 20240101  | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0  | 0.0        | 0.0   | 0.0         |
      | 2  | 31   | 20240201| 20240201 | 62.68           | 12.32         | 0.44     | 0.0  | 0.0       | 12.76 | 12.76 | 0.0        | 0.0   | 0.0         |
      | 3  | 29   | 20240301   |                  | 50.29           | 12.39         | 0.37     | 0.0  | 0.0       | 12.76 | 0.0   | 0.0        | 0.0   | 12.76       |
      | 4  | 31   | 20240401   |                  | 37.82           | 12.47         | 0.29     | 0.0  | 0.0       | 12.76 | 0.0   | 0.0        | 0.0   | 12.76       |
      | 5  | 30   | 20240501     |                  | 25.28           | 12.54         | 0.22     | 0.0  | 0.0       | 12.76 | 0.0   | 0.0        | 0.0   | 12.76       |
      | 6  | 31   | 20240601    |                  | 12.67           | 12.61         | 0.15     | 0.0  | 0.0       | 12.76 | 0.0   | 0.0        | 0.0   | 12.76       |
      | 7  | 30   | 20240701    |                  | 0.0             | 12.67         | 0.07     | 0.0  | 0.0       | 12.74 | 0.0   | 0.0        | 0.0   | 12.74       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 100.0         | 1.54     | 0.0  | 0.0       | 101.54 | 37.76 | 0.0        | 0.0   | 63.78       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Down Payment     | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         | false    | false    |
      | 20240131  | Accrual          | 0.42   | 0.0       | 0.42     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Repayment        | 12.76  | 12.32     | 0.44     | 0.0  | 0.0       | 62.68        | false    | false    |
    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240401 | 6                    |
    Then Loan Repayment schedule has 10 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101   | 20240101  | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201  | 20240201 | 62.68           | 12.32         | 0.44     | 0.0  | 0.0       | 12.76 | 12.76 | 0.0        | 0.0  | 0.0         |
      | 3  | 29   | 20240301     | 20240315    | 62.68           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 14   | 20240315     | 20240315    | 62.68           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 17   | 20240401     |                  | 52.69           | 9.99          | 0.74     | 0.0  | 0.0       | 10.73 | 0.0   | 0.0        | 0.0  | 10.73       |
      | 6  | 30   | 20240501       |                  | 42.27           | 10.42         | 0.31     | 0.0  | 0.0       | 10.73 | 0.0   | 0.0        | 0.0  | 10.73       |
      | 7  | 31   | 20240601      |                  | 31.79           | 10.48         | 0.25     | 0.0  | 0.0       | 10.73 | 0.0   | 0.0        | 0.0  | 10.73       |
      | 8  | 30   | 20240701      |                  | 21.25           | 10.54         | 0.19     | 0.0  | 0.0       | 10.73 | 0.0   | 0.0        | 0.0  | 10.73       |
      | 9  | 31   | 20240801    |                  | 10.64           | 10.61         | 0.12     | 0.0  | 0.0       | 10.73 | 0.0   | 0.0        | 0.0  | 10.73       |
      | 10 | 31   | 20240901 |                  | 0.0             | 10.64         | 0.06     | 0.0  | 0.0       | 10.7  | 0.0   | 0.0        | 0.0  | 10.7        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.11     | 0.0  | 0.0       | 102.11 | 37.76 | 0.0        | 0.0  | 64.35       |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Down Payment     | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         | false    | false    |
      | 20240201 | Repayment        | 12.76  | 12.32     | 0.44     | 0.0  | 0.0       | 62.68        | false    | false    |
      | 20240315    | Re-age           | 63.22  | 62.68     | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240131  | Accrual          | 0.42   | 0.0       | 0.42     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4425 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging with accruals on interest bearing loan - Interest calculation: Default Behavior - reverse-repay, reversal of backdated repayment - UC8.1
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240101   | 100            | 7                       | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201|           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301   |           | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401   |           | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501     |           | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601    |           | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701    |           | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.01 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201| 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301   |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401   |                  | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501     |                  | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601    |                  | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701    |                  | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0   | 0.0        | 0.0  | 17.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 17.01 | 0.0        | 0.0  | 85.04       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 1.27   | 0.0       | 1.27     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240401 | 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501      |                  | 56.36           | 13.89         | 0.41     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 6  | 31   | 20240601     |                  | 42.39           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701     |                  | 28.34           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801   |                  | 14.21           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901|                  | 0.0             | 14.21         | 0.08     | 0.0  | 0.0       | 14.29 | 0.0   | 0.0        | 0.0  | 14.29       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.8      | 0.0  | 0.0       | 102.8 | 17.01 | 0.0        | 0.0  | 85.79       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 1.27   | 0.0       | 1.27     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240401"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240301" with 17.01 EUR transaction amount
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 67.05           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 56.04           | 11.01         | 0.39     | 0.0  | 0.0       | 11.4  | 0.0   | 0.0        | 0.0  | 11.4        |
      | 5  | 30   | 20240501       |                  | 44.97           | 11.07         | 0.33     | 0.0  | 0.0       | 11.4  | 0.0   | 0.0        | 0.0  | 11.4        |
      | 6  | 31   | 20240601      |                  | 33.83           | 11.14         | 0.26     | 0.0  | 0.0       | 11.4  | 0.0   | 0.0        | 0.0  | 11.4        |
      | 7  | 30   | 20240701      |                  | 22.63           | 11.2          | 0.2      | 0.0  | 0.0       | 11.4  | 0.0   | 0.0        | 0.0  | 11.4        |
      | 8  | 31   | 20240801    |                  | 11.36           | 11.27         | 0.13     | 0.0  | 0.0       | 11.4  | 0.0   | 0.0        | 0.0  | 11.4        |
      | 9  | 31   | 20240901 |                  | 0.0             | 11.36         | 0.07     | 0.0  | 0.0       | 11.43 | 0.0   | 0.0        | 0.0  | 11.43       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.45     | 0.0  | 0.0       | 102.45 | 34.02 | 0.0        | 0.0  | 68.43       |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240315    | Re-age           | 67.23  | 67.05     | 0.18     | 0.0  | 0.0       | 0.0          | false    | true     |

    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240314    | Accrual          | 1.27   | 0.0       | 1.27     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Customer undo "2"th transaction made on "20240301"
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501       |                  | 56.36           | 13.89         | 0.41     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 6  | 31   | 20240601      |                  | 42.39           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701      |                  | 28.34           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801    |                  | 14.21           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901 |                  | 0.0             | 14.21         | 0.08     | 0.0  | 0.0       | 14.29 | 0.0   | 0.0        | 0.0  | 14.29       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.8      | 0.0  | 0.0       | 102.8 | 17.01 | 0.0        | 0.0  | 85.79       |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | true     | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | true     |
    Then Loan Transactions tab has no new accrual data

    When Admin sets the business date to "20240402"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | true     | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20240401    | Accrual Activity | 0.98   | 0.0       | 0.98     | 0.0  | 0.0       | 0.0          | false    | false    |

    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240401    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240402"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4426 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging with accruals on interest bearing loan - Interest calculation: Default Behavior - reversal of Re-aging - UC9
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240101   | 100            | 7                       | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201|           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301   |           | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401   |           | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501     |           | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601    |           | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701    |           | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.01 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201| 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301   |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401   |                  | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501     |                  | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601    |                  | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701    |                  | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0   | 0.0        | 0.0  | 17.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 17.01 | 0.0        | 0.0  | 85.04       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240401 | 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501      |                  | 56.36           | 13.89         | 0.41     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 6  | 31   | 20240601     |                  | 42.39           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701     |                  | 28.34           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801   |                  | 14.21           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901|                  | 0.0             | 14.21         | 0.08     | 0.0  | 0.0       | 14.29 | 0.0   | 0.0        | 0.0  | 14.29       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.8      | 0.0  | 0.0       | 102.8 | 17.01 | 0.0        | 0.0  | 85.79       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 1.27   | 0.0       | 1.27     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240401"
    When Admin runs inline COB job for Loan
    When Admin successfully undo Loan re-aging transaction
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201| 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301   |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401   |                  | 50.53           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501     |                  | 33.81           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601    |                  | 17.0            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701    |                  | 0.0             | 17.0          | 0.1      | 0.0  | 0.0       | 17.1  | 0.0   | 0.0        | 0.0  | 17.1        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.15     | 0.0  | 0.0       | 102.15 | 17.01 | 0.0        | 0.0  | 85.14       |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | true     | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240314    | Accrual          | 1.27   | 0.0       | 1.27     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4427 @AdvancedPaymentAllocation
  Scenario: Verify Re-aging reversal with accruals on interest bearing loan - UC5: Interest handling: DEFAULT, re-aging is NOT the latest transaction on loan
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
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
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 17.01 | 0.0        | 0.0  | 85.04       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 50.47           | 16.58         | 0.43     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.75           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.94           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.94         | 0.1      | 0.0  | 0.0       | 17.04 | 0.0   | 0.0        | 0.0  | 17.04       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.09     | 0.0  | 0.0       | 102.09 | 17.01 | 0.0        | 0.0  | 85.08       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 1.27   | 0.0       | 1.27     | 0.0  | 0.0       | 0.0          | false    | false    |

#   --- Re-age transaction ---
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling |
      | 1               | MONTHS        | 20240401 | 6                    | DEFAULT               |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501       |                  | 56.36           | 13.89         | 0.41     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 6  | 31   | 20240601      |                  | 42.39           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701      |                  | 28.34           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801    |                  | 14.21           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901 |                  | 0.0             | 14.21         | 0.08     | 0.0  | 0.0       | 14.29 | 0.0   | 0.0        | 0.0  | 14.29       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.8      | 0.0  | 0.0       | 102.8 | 17.01 | 0.0        | 0.0  | 85.79       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 1.27   | 0.0       | 1.27     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
#    --- Transaction after re-aging ---
    When Admin sets the business date to "20240316"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240316" with 14.3 EUR transaction amount
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     | 20240316    | 70.0            | 13.57         | 0.73     | 0.0  | 0.0       | 14.3  | 14.3  | 14.3       | 0.0  | 0.0         |
      | 5  | 30   | 20240501       |                  | 56.32           | 13.68         | 0.62     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 6  | 31   | 20240601      |                  | 42.35           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701      |                  | 28.3            | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801    |                  | 14.17           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901 |                  | 0.0             | 14.17         | 0.08     | 0.0  | 0.0       | 14.25 | 0.0   | 0.0        | 0.0  | 14.25       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.76     | 0.0  | 0.0       | 102.76 | 31.31 | 14.3       | 0.0  | 71.45       |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Repayment        | 14.3   | 13.57     | 0.73     | 0.0  | 0.0       | 70.0         | false    | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240314    | Accrual          | 1.27   | 0.0       | 1.27     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
#   --- Reversal of re-age transaction ---
    When Admin sets the business date to "20240401"
    When Admin runs inline COB job for Loan
    And Admin successfully undo Loan re-aging transaction
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 14.3  | 0.0        | 14.3 | 2.71        |
      | 3  | 31   | 20240401    |                  | 50.49           | 16.56         | 0.45     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.77           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.96           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.96         | 0.1      | 0.0  | 0.0       | 17.06 | 0.0   | 0.0        | 0.0  | 17.06       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.11     | 0.0  | 0.0       | 102.11 | 31.31 | 0.0        | 14.3 | 70.8        |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20240316    | Repayment        | 14.3   | 13.81     | 0.49     | 0.0  | 0.0       | 69.76        | false    | true     |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240316    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240402"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20240316    | Repayment        | 14.3   | 13.81     | 0.49     | 0.0  | 0.0       | 69.76        | false    | true     |
      | 20240401    | Accrual Activity | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4428 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging with accruals on interest bearing loan - Interest calculation: Default Behavior - backdated re-aging transaction - UC16
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.01 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
    When Admin sets the business date to "20240301"
    And Customer makes "AUTOPAY" repayment on "20240301" with 17.01 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    |                  | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0   | 0.0        | 0.0  | 17.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 34.02 | 0.0        | 0.0  | 68.03       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    |
    When Admin sets the business date to "20240601"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    |                  | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.81           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 17.19           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 17.19         | 0.1      | 0.0  | 0.0       | 17.29 | 0.0   | 0.0        | 0.0  | 17.29       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.34     | 0.0  | 0.0       | 102.34 | 34.02 | 0.0        | 0.0  | 68.32       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Accrual Activity | 0.39   | 0.0       | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Accrual Activity | 0.39   | 0.0       | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240531      | Accrual          | 2.13   | 0.0       | 2.13     | 0.0  | 0.0       | 0.0          | false    | false    |

  # Backdated re-aging - created in June but effective from April 01
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240401 | 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401    | 67.05           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 0    | 20240401    |                  | 56.04           | 11.01         | 0.39     | 0.0  | 0.0       | 11.4  | 0.0   | 0.0        | 0.0  | 11.4        |
      | 5  | 30   | 20240501      |                  | 45.03           | 11.01         | 0.39     | 0.0  | 0.0       | 11.4  | 0.0   | 0.0        | 0.0  | 11.4        |
      | 6  | 31   | 20240601     |                  | 34.02           | 11.01         | 0.39     | 0.0  | 0.0       | 11.4  | 0.0   | 0.0        | 0.0  | 11.4        |
      | 7  | 30   | 20240701     |                  | 22.82           | 11.2          | 0.2      | 0.0  | 0.0       | 11.4  | 0.0   | 0.0        | 0.0  | 11.4        |
      | 8  | 31   | 20240801   |                  | 11.55           | 11.27         | 0.13     | 0.0  | 0.0       | 11.4  | 0.0   | 0.0        | 0.0  | 11.4        |
      | 9  | 31   | 20240901|                  | 0.0             | 11.55         | 0.07     | 0.0  | 0.0       | 11.62 | 0.0   | 0.0        | 0.0  | 11.62       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.64     | 0.0  | 0.0       | 102.64 | 34.02 | 0.0        | 0.0  | 68.62       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240401    | Accrual Activity | 0.39   | 0.0       | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Re-age           | 67.44  | 67.05     | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Accrual Activity | 0.39   | 0.0       | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240531      | Accrual          | 2.13   | 0.0       | 2.13     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Admin sets the business date to "20240602"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Re-age           | 67.44  | 67.05     | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Accrual Activity | 0.39   | 0.0       | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Accrual Activity | 0.39   | 0.0       | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240531      | Accrual          | 2.13   | 0.0       | 2.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240601     | Accrual          | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240601     | Accrual Activity | 0.39   | 0.0       | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240602"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4429 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging trn with 2nd disb and partial chargeback(with custom pmnt alloc) after re-age with accruals - interest bearing multidisb loan with default behaviour - UC1
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSE_CHARGEBACK | 20240101   | 150            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "150" amount and expected disbursement date on "20240101"
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

    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240401 | 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501       |                  | 56.36           | 13.89         | 0.41     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 6  | 31   | 20240601      |                  | 42.39           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701      |                  | 28.34           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801    |                  | 14.21           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901 |                  |  0.0            | 14.21         | 0.08     | 0.0  | 0.0       | 14.29 | 0.0   | 0.0        | 0.0  | 14.29       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.8      | 0.0  | 0.0       | 102.8  | 17.01 | 0.0        | 0.0  | 85.79       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240314    | Accrual          | 1.27   | 0.0       | 1.27     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Admin sets the business date to "20240401"
    When Admin runs inline COB job for Loan
    When Admin successfully disburse the loan on "20240401" with "50" EUR transaction amount
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      |    |      | 20240401     |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 5  | 30   | 20240501       |                  | 96.48           | 23.77         | 0.7      | 0.0  | 0.0       | 24.47 | 0.0   | 0.0        | 0.0  | 24.47       |
      | 6  | 31   | 20240601      |                  | 72.57           | 23.91         | 0.56     | 0.0  | 0.0       | 24.47 | 0.0   | 0.0        | 0.0  | 24.47       |
      | 7  | 30   | 20240701      |                  | 48.52           | 24.05         | 0.42     | 0.0  | 0.0       | 24.47 | 0.0   | 0.0        | 0.0  | 24.47       |
      | 8  | 31   | 20240801    |                  | 24.33           | 24.19         | 0.28     | 0.0  | 0.0       | 24.47 | 0.0   | 0.0        | 0.0  | 24.47       |
      | 9  | 31   | 20240901 |                  |  0.0            | 24.33         | 0.14     | 0.0  | 0.0       | 24.47 | 0.0   | 0.0        | 0.0  | 24.47       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 3.66     | 0.0  | 0.0       | 153.66  | 17.01 | 0.0        | 0.0  | 136.65      |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Disbursement     | 50.0   | 0.0       | 0.0      | 0.0  | 0.0       | 133.57       | false    | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240314    | Accrual          | 1.27   | 0.0       | 1.27     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 17.01 EUR transaction amount
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      |    |      | 20240401     |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 5  | 30   | 20240501       |                  | 96.58           | 40.1          | 1.38     | 0.0  | 0.0       | 41.48 | 0.0   | 0.0        | 0.0  | 41.48       |
      | 6  | 31   | 20240601      |                  | 72.67           | 23.91         | 0.56     | 0.0  | 0.0       | 24.47 | 0.0   | 0.0        | 0.0  | 24.47       |
      | 7  | 30   | 20240701      |                  | 48.62           | 24.05         | 0.42     | 0.0  | 0.0       | 24.47 | 0.0   | 0.0        | 0.0  | 24.47       |
      | 8  | 31   | 20240801    |                  | 24.43           | 24.19         | 0.28     | 0.0  | 0.0       | 24.47 | 0.0   | 0.0        | 0.0  | 24.47       |
      | 9  | 31   | 20240901 |                  |  0.0            | 24.43         | 0.14     | 0.0  | 0.0       | 24.57 | 0.0   | 0.0        | 0.0  | 24.57       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 166.43        | 4.34     | 0.0  | 0.0       | 170.77 | 17.01 | 0.0        | 0.0  | 153.76      |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Disbursement     | 50.0   | 0.0       | 0.0      | 0.0  | 0.0       | 133.57       | false    | false    |
      | 20240401    | Chargeback       | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 150.0        | false    | false    |
   Then Loan Transactions tab has no new accrual data

    When Admin successfully undo last disbursal
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501       |                  | 56.46           | 30.22         | 1.09     | 0.0  | 0.0       | 31.31 | 0.0   | 0.0        | 0.0  | 31.31       |
      | 6  | 31   | 20240601      |                  | 42.49           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701      |                  | 28.44           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801    |                  | 14.31           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901 |                  |  0.0            | 14.31         | 0.08     | 0.0  | 0.0       | 14.39 | 0.0   | 0.0        | 0.0  | 14.39       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 116.43        | 3.48     | 0.0  | 0.0       | 119.91 | 17.01 | 0.0        | 0.0  | 102.9      |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Chargeback       | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 100.0        | false    | false    |
    Then Loan Transactions tab has no new accrual data

    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4430 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging trn with backdated 2nd disb and chargeback after re-age with accruals - interest bearing multidisbursal loan with default behaviour - UC7
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSE_CHARGEBACK | 20240101   | 150            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "150" amount and expected disbursement date on "20240101"
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

    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240401 | 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501       |                  | 56.36           | 13.89         | 0.41     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 6  | 31   | 20240601      |                  | 42.39           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701      |                  | 28.34           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801    |                  | 14.21           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901 |                  |  0.0            | 14.21         | 0.08     | 0.0  | 0.0       | 14.29 | 0.0   | 0.0        | 0.0  | 14.29       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.8     | 0.0  | 0.0       | 102.8  | 17.01 | 0.0        | 0.0  | 85.79      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240314    | Accrual          | 1.27   | 0.0       | 1.27     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Admin sets the business date to "20240401"
    When Admin runs inline COB job for Loan
    When Admin successfully disburse the loan on "20240301" with "50" EUR transaction amount
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      |    |      | 20240301     |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 3  | 14   | 20240315     | 20240315    | 133.57          |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 112.04          | 21.53         | 1.27     | 0.0  | 0.0       | 22.8  | 0.0   | 0.0        | 0.0  | 22.8        |
      | 5  | 30   | 20240501       |                  | 89.89           | 22.15         | 0.65     | 0.0  | 0.0       | 22.8  | 0.0   | 0.0        | 0.0  | 22.8        |
      | 6  | 31   | 20240601      |                  | 67.61           | 22.28         | 0.52     | 0.0  | 0.0       | 22.8  | 0.0   | 0.0        | 0.0  | 22.8        |
      | 7  | 30   | 20240701      |                  | 45.2            | 22.41         | 0.39     | 0.0  | 0.0       | 22.8  | 0.0   | 0.0        | 0.0  | 22.8        |
      | 8  | 31   | 20240801    |                  | 22.66           | 22.54         | 0.26     | 0.0  | 0.0       | 22.8  | 0.0   | 0.0        | 0.0  | 22.8        |
      | 9  | 31   | 20240901 |                  |  0.0            | 22.66         | 0.13     | 0.0  | 0.0       | 22.79 | 0.0   | 0.0        | 0.0  | 22.79       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 3.8      | 0.0  | 0.0       | 153.8  | 17.01 | 0.0        | 0.0  | 136.79      |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Disbursement     | 50.0   | 0.0       | 0.0      | 0.0  | 0.0       | 133.57       | false    | false    |
      | 20240315    | Re-age           | 134.41 | 133.57    | 0.84     | 0.0  | 0.0       | 0.0          | false    | true     |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240314    | Accrual          | 1.27   | 0.0       | 1.27     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 12 EUR transaction amount
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      |    |      | 20240301     |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 3  | 14   | 20240315     | 20240315    | 133.57          |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 112.04          | 21.53         | 1.27     | 0.0  | 0.0       | 22.8  | 0.0   | 0.0        | 0.0  | 22.8        |
      | 5  | 30   | 20240501       |                  | 89.96           | 33.5          | 1.3      | 0.0  | 0.0       | 34.8  | 0.0   | 0.0        | 0.0  | 34.8        |
      | 6  | 31   | 20240601      |                  | 67.68           | 22.28         | 0.52     | 0.0  | 0.0       | 22.8  | 0.0   | 0.0        | 0.0  | 22.8        |
      | 7  | 30   | 20240701      |                  | 45.27           | 22.41         | 0.39     | 0.0  | 0.0       | 22.8  | 0.0   | 0.0        | 0.0  | 22.8        |
      | 8  | 31   | 20240801    |                  | 22.73           | 22.54         | 0.26     | 0.0  | 0.0       | 22.8  | 0.0   | 0.0        | 0.0  | 22.8        |
      | 9  | 31   | 20240901 |                  |  0.0            | 22.73         | 0.13     | 0.0  | 0.0       | 22.86 | 0.0   | 0.0        | 0.0  | 22.86       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 161.42        | 4.45     | 0.0  | 0.0       | 165.87 | 17.01 | 0.0        | 0.0  | 148.86     |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Disbursement     | 50.0   | 0.0       | 0.0      | 0.0  | 0.0       | 133.57       | false    | false    |
      | 20240315    | Re-age           | 134.41 | 133.57    | 0.84     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20240401    | Chargeback       | 12.0   | 11.42     | 0.58     | 0.0  | 0.0       | 144.99       | false    | false    |
    Then Loan Transactions tab has no new accrual data

    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4431 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging trn with backdated CI and CI adj after re-age with accruals - interest bearing multidisb loan default behaviour - UC13
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_RECALC_EMI_360_30_MULTIDISB_APPROVED_OVER_APPLIED_CAPITALIZED_INCOME | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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

    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240401 | 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501      |                  | 56.36           | 13.89         | 0.41     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 6  | 31   | 20240601     |                  | 42.39           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701     |                  | 28.34           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801   |                  | 14.21           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901|                  | 0.0             | 14.21         | 0.08     | 0.0  | 0.0       | 14.29 | 0.0   | 0.0        | 0.0  | 14.29       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.8      | 0.0  | 0.0       | 102.8 | 17.01 | 0.0        | 0.0  | 85.79       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240314    | Accrual          | 1.27   | 0.0       | 1.27     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Admin sets the business date to "20240401"
    When Admin runs inline COB job for Loan
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240301" with "50" EUR transaction amount
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      |    |      | 20240301    |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 3  | 14   | 20240315    | 20240315    | 133.57          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 112.04          | 21.53         | 1.27     | 0.0  | 0.0       | 22.8  | 0.0   | 0.0        | 0.0  | 22.8        |
      | 5  | 30   | 20240501      |                  | 89.89           | 22.15         | 0.65     | 0.0  | 0.0       | 22.8  | 0.0   | 0.0        | 0.0  | 22.8        |
      | 6  | 31   | 20240601     |                  | 67.61           | 22.28         | 0.52     | 0.0  | 0.0       | 22.8  | 0.0   | 0.0        | 0.0  | 22.8        |
      | 7  | 30   | 20240701     |                  | 45.2            | 22.41         | 0.39     | 0.0  | 0.0       | 22.8  | 0.0   | 0.0        | 0.0  | 22.8        |
      | 8  | 31   | 20240801   |                  | 22.66           | 22.54         | 0.26     | 0.0  | 0.0       | 22.8  | 0.0   | 0.0        | 0.0  | 22.8        |
      | 9  | 31   | 20240901|                  | 0.0             | 22.66         | 0.13     | 0.0  | 0.0       | 22.79 | 0.0   | 0.0        | 0.0  | 22.79       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 3.8      | 0.0  | 0.0       | 153.8  | 17.01 | 0.0        | 0.0  | 136.79      |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement       | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment          | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Capitalized Income | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 133.57       | false    | false    |
      | 20240315    | Re-age             | 134.41 | 133.57    | 0.84     | 0.0  | 0.0       | 0.0          | false    | true     |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240314    | Accrual          | 1.27   | 0.0       | 1.27     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |

    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240401" with "20" EUR transaction amount
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      |    |      | 20240301    |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 3  | 14   | 20240315    | 20240315    | 133.57          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 112.04          | 21.53         | 1.27     | 0.0  | 0.0       | 22.8  | 20.0  | 0.0        | 0.0  |  2.8        |
      | 5  | 30   | 20240501      |                  | 89.89           | 22.15         | 0.65     | 0.0  | 0.0       | 22.8  | 0.0   | 0.0        | 0.0  | 22.8        |
      | 6  | 31   | 20240601     |                  | 67.61           | 22.28         | 0.52     | 0.0  | 0.0       | 22.8  | 0.0   | 0.0        | 0.0  | 22.8        |
      | 7  | 30   | 20240701     |                  | 45.2            | 22.41         | 0.39     | 0.0  | 0.0       | 22.8  | 0.0   | 0.0        | 0.0  | 22.8        |
      | 8  | 31   | 20240801   |                  | 22.66           | 22.54         | 0.26     | 0.0  | 0.0       | 22.8  | 0.0   | 0.0        | 0.0  | 22.8        |
      | 9  | 31   | 20240901|                  | 0.0             | 22.66         | 0.13     | 0.0  | 0.0       | 22.79 | 0.0   | 0.0        | 0.0  | 22.79       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 3.8      | 0.0  | 0.0       | 153.8  | 37.01 | 0.0        | 0.0  | 116.79      |
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type              | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                  | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment                     | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Capitalized Income            | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 133.57       | false    | false    |
      | 20240315    | Re-age                        | 134.41 | 133.57    | 0.84     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20240401    | Capitalized Income Adjustment | 20.0   | 20.0      | 0.0      | 0.0  | 0.0       | 113.57       | false    | false    |
    Then Loan Transactions tab has no new accrual data

    When Admin sets the business date to "20240402"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment                       | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 133.57       | false    | false    |
      | 20240315    | Re-age                          | 134.41 | 133.57    | 0.84     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20240401    | Capitalized Income Adjustment   | 20.0   | 20.0      | 0.0      | 0.0  | 0.0       | 113.57       | false    | false    |
      | 20240401    | Capitalized Income Amortization | 8.56   | 0.0       | 8.56     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240401    | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240402"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4432 @AdvancedPaymentAllocation
  Scenario: Verify Re-aging with accruals with interest pause: UC2: Interest handling: DEFAULT, interest pause before re-aging
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
#    --- First installment paid ---
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
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 17.01 | 0.0        | 0.0  | 85.04       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
#    --- Interest pause ---
    When Admin sets the business date to "20240202"
    When Admin runs inline COB job for Loan
    And Create an interest pause period with start date "20240210" and end date "20240310"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 66.69           | 16.88         | 0.13     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 49.96           | 16.73         | 0.28     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.24           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.42           | 16.82         | 0.19     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.42         | 0.1      | 0.0  | 0.0       | 16.52 | 0.0   | 0.0        | 0.0  | 16.52       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.57     | 0.0  | 0.0       | 101.57 | 17.01 | 0.0        | 0.0  | 84.56       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual          | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
#    --- Check before re-age ---
    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 66.69           | 16.88         | 0.13     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 49.97           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.25           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.43           | 16.82         | 0.19     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.43         | 0.1      | 0.0  | 0.0       | 16.53 | 0.0   | 0.0        | 0.0  | 16.53       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.58     | 0.0  | 0.0       | 101.58 | 17.01 | 0.0        | 0.0  | 84.57       |
    And Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240201 | Accrual          | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |

#   --- Re-age transaction ---
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling |
      | 1               | MONTHS        | 20240401 | 6                    | DEFAULT               |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 69.84           | 13.73         | 0.48     | 0.0  | 0.0       | 14.21 | 0.0   | 0.0        | 0.0  | 14.21       |
      | 5  | 30   | 20240501       |                  | 56.04           | 13.8          | 0.41     | 0.0  | 0.0       | 14.21 | 0.0   | 0.0        | 0.0  | 14.21       |
      | 6  | 31   | 20240601      |                  | 42.16           | 13.88         | 0.33     | 0.0  | 0.0       | 14.21 | 0.0   | 0.0        | 0.0  | 14.21       |
      | 7  | 30   | 20240701      |                  | 28.2            | 13.96         | 0.25     | 0.0  | 0.0       | 14.21 | 0.0   | 0.0        | 0.0  | 14.21       |
      | 8  | 31   | 20240801    |                  | 14.15           | 14.05         | 0.16     | 0.0  | 0.0       | 14.21 | 0.0   | 0.0        | 0.0  | 14.21       |
      | 9  | 31   | 20240901 |                  | 0.0             | 14.15         | 0.08     | 0.0  | 0.0       | 14.23 | 0.0   | 0.0        | 0.0  | 14.23       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.29     | 0.0  | 0.0       | 102.29 | 17.01 | 0.0        | 0.0  | 85.28       |
    And Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 83.78  | 83.57     | 0.21     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has no new accrual data

    When Admin sets the business date to "20240316"
    When Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 83.78  | 83.57     | 0.21     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240315    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |

#   --- Close loan ---
    When Loan Pay-off is made on "20240316"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4433 @AdvancedPaymentAllocation
  Scenario: Verify Re-aging with accruals with interest pause: UC3: Interest handling: DEFAULT, interest pause overlapping re-aging
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
#    --- First installment paid ---
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
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 17.01 | 0.0        | 0.0  | 85.04       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
#    --- Interest pause ---
    When Admin sets the business date to "20240202"
    When Admin runs inline COB job for Loan
    And Create an interest pause period with start date "20240210" and end date "20240510"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 66.69           | 16.88         | 0.13     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 49.68           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 32.67           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 15.8            | 16.87         | 0.14     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 15.8          | 0.09     | 0.0  | 0.0       | 15.89 | 0.0   | 0.0        | 0.0  | 15.89       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 0.94     | 0.0  | 0.0       | 100.94 | 17.01 | 0.0        | 0.0  | 83.93       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual          | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
#    --- Check before re-age ---
    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 66.69           | 16.88         | 0.13     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 49.68           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 32.67           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 15.8            | 16.87         | 0.14     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 15.8          | 0.09     | 0.0  | 0.0       | 15.89 | 0.0   | 0.0        | 0.0  | 15.89       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 0.94     | 0.0  | 0.0       | 100.94 | 17.01 | 0.0        | 0.0  | 83.93       |
    And Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240201 | Accrual          | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
#   --- Re-age transaction ---
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling |
      | 1               | MONTHS        | 20240401 | 6                    | DEFAULT               |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 69.5            | 14.07         | 0.13     | 0.0  | 0.0       | 14.2  | 0.0   | 0.0        | 0.0  | 14.2        |
      | 5  | 30   | 20240501       |                  | 55.3            | 14.2          | 0.0      | 0.0  | 0.0       | 14.2  | 0.0   | 0.0        | 0.0  | 14.2        |
      | 6  | 31   | 20240601      |                  | 41.33           | 13.97         | 0.23     | 0.0  | 0.0       | 14.2  | 0.0   | 0.0        | 0.0  | 14.2        |
      | 7  | 30   | 20240701      |                  | 27.37           | 13.96         | 0.24     | 0.0  | 0.0       | 14.2  | 0.0   | 0.0        | 0.0  | 14.2        |
      | 8  | 31   | 20240801    |                  | 13.33           | 14.04         | 0.16     | 0.0  | 0.0       | 14.2  | 0.0   | 0.0        | 0.0  | 14.2        |
      | 9  | 31   | 20240901 |                  | 0.0             | 13.33         | 0.08     | 0.0  | 0.0       | 13.41 | 0.0   | 0.0        | 0.0  | 13.41       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.42     | 0.0  | 0.0       | 101.42 | 17.01 | 0.0        | 0.0  | 84.41       |
    And Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 83.7   | 83.57     | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has no new accrual data

    When Admin sets the business date to "20240316"
    When Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 83.7   | 83.57     | 0.13     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has no new accrual data

#   --- Close loan ---
    When Loan Pay-off is made on "20240316"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4434 @AdvancedPaymentAllocation
  Scenario: Verify Re-aging with accruals with interest pause: UC6: Interest handling: DEFAULT, backdated interest pause created after re-aging, overlapping (start date before re-aging, end date after re-aging)
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
#    --- First installment paid ---
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
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 17.01 | 0.0        | 0.0  | 85.04       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
#    --- Check before re-age ---
    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 50.47           | 16.58         | 0.43     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.75           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.94           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.94         | 0.1      | 0.0  | 0.0       | 17.04 | 0.0   | 0.0        | 0.0  | 17.04       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.09     | 0.0  | 0.0       | 102.09 | 17.01 | 0.0        | 0.0  | 85.08       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 1.27   | 0.0       | 1.27     | 0.0  | 0.0       | 0.0          | false    | false    |
#   --- Re-age transaction ---
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling |
      | 1               | MONTHS        | 20240401 | 6                    | DEFAULT               |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501       |                  | 56.36           | 13.89         | 0.41     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 6  | 31   | 20240601      |                  | 42.39           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701      |                  | 28.34           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801    |                  | 14.21           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901 |                  | 0.0             | 14.21         | 0.08     | 0.0  | 0.0       | 14.29 | 0.0   | 0.0        | 0.0  | 14.29       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.8      | 0.0  | 0.0       | 102.8 | 17.01 | 0.0        | 0.0  | 85.79       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 1.27   | 0.0       | 1.27     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
  #    --- Interest pause ---
    When Admin sets the business date to "20240701"
    When Admin runs inline COB job for Loan
    And Create an interest pause period with start date "20240210" and end date "20240610"
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 69.5            | 14.07         | 0.13     | 0.0  | 0.0       | 14.2  | 0.0   | 0.0        | 0.0  | 14.2        |
      | 5  | 30   | 20240501       |                  | 55.3            | 14.2          | 0.0      | 0.0  | 0.0       | 14.2  | 0.0   | 0.0        | 0.0  | 14.2        |
      | 6  | 31   | 20240601      |                  | 41.1            | 14.2          | 0.0      | 0.0  | 0.0       | 14.2  | 0.0   | 0.0        | 0.0  | 14.2        |
      | 7  | 30   | 20240701      |                  | 27.24           | 13.86         | 0.34     | 0.0  | 0.0       | 14.2  | 0.0   | 0.0        | 0.0  | 14.2        |
      | 8  | 31   | 20240801    |                  | 13.2            | 14.04         | 0.16     | 0.0  | 0.0       | 14.2  | 0.0   | 0.0        | 0.0  | 14.2        |
      | 9  | 31   | 20240901 |                  | 0.0             | 13.2          | 0.08     | 0.0  | 0.0       | 13.28 | 0.0   | 0.0        | 0.0  | 13.28       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.29     | 0.0  | 0.0       | 101.29 | 17.01 | 0.0        | 0.0  | 84.28       |
    And Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 83.7   | 83.57     | 0.13     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20240401    | Accrual Activity | 0.13   | 0.0       | 0.13     | 0.0  | 0.0       | 0.0          | false    | true     |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240314    | Accrual          | 1.27   | 0.0       | 1.27     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240402    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240403    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240404    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240405    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240406    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240407    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240408    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240409    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240410    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240411    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240412    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240413    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240414    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240415    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240416    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240417    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240418    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240419    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240420    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240421    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240422    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240423    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240424    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240425    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240426    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240427    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240428    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240429    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240430    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240502      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240503      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240504      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240505      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240506      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240507      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240508      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240509      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240510      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240511      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240512      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240513      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240514      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240515      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240516      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240517      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240518      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240519      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240520      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240521      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240522      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240523      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240524      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240525      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240526      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240527      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240528      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240529      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240530      | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240531      | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240601     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240602     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240603     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240604     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240605     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240606     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240607     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240608     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240609     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240610     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240611     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240612     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240613     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240614     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240615     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240616     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240617     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240618     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240619     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240620     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240621     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240622     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240623     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240624     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240625     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240626     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240627     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240628     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240629     | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240630     | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
#   --- Close loan ---
    When Loan Pay-off is made on "20240701"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4435 @AdvancedPaymentAllocation
  Scenario: Verify Re-aging with accruals with loan reschedule: UC3: Interest handling: DEFAULT, reschedule - newInterestRate
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
#    --- First installment paid ---
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
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 17.01 | 0.0        | 0.0  | 85.04       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
#    --- Reschedule before re-age ---
    When Admin sets the business date to "20240202"
    When Admin runs inline COB job for Loan
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate  | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240301      | 20240202 |                 |                  |                 |            | 10              |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 66.97           | 16.6          | 0.49     | 0.0  | 0.0       | 17.09 | 0.0   | 0.0        | 0.0  | 17.09       |
      | 3  | 31   | 20240401    |                  | 50.44           | 16.53         | 0.56     | 0.0  | 0.0       | 17.09 | 0.0   | 0.0        | 0.0  | 17.09       |
      | 4  | 30   | 20240501      |                  | 33.77           | 16.67         | 0.42     | 0.0  | 0.0       | 17.09 | 0.0   | 0.0        | 0.0  | 17.09       |
      | 5  | 31   | 20240601     |                  | 16.96           | 16.81         | 0.28     | 0.0  | 0.0       | 17.09 | 0.0   | 0.0        | 0.0  | 17.09       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.96         | 0.14     | 0.0  | 0.0       | 17.1  | 0.0   | 0.0        | 0.0  | 17.1        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.47     | 0.0  | 0.0       | 102.47 | 17.01 | 0.0        | 0.0  | 85.46       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual          | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
#    --- Check before re-age ---
    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 66.97           | 16.6          | 0.49     | 0.0  | 0.0       | 17.09 | 0.0   | 0.0        | 0.0  | 17.09       |
      | 3  | 31   | 20240401    |                  | 50.5            | 16.47         | 0.62     | 0.0  | 0.0       | 17.09 | 0.0   | 0.0        | 0.0  | 17.09       |
      | 4  | 30   | 20240501      |                  | 33.83           | 16.67         | 0.42     | 0.0  | 0.0       | 17.09 | 0.0   | 0.0        | 0.0  | 17.09       |
      | 5  | 31   | 20240601     |                  | 17.02           | 16.81         | 0.28     | 0.0  | 0.0       | 17.09 | 0.0   | 0.0        | 0.0  | 17.09       |
      | 6  | 30   | 20240701     |                  | 0.0             | 17.02         | 0.14     | 0.0  | 0.0       | 17.16 | 0.0   | 0.0        | 0.0  | 17.16       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.53     | 0.0  | 0.0       | 102.53 | 17.01 | 0.0        | 0.0  | 85.52       |
    And Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240201 | Accrual          | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |

#   --- Re-age transaction ---
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling |
      | 1               | MONTHS        | 20240401 | 6                    | DEFAULT               |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 70.33           | 13.24         | 1.18     | 0.0  | 0.0       | 14.42 | 0.0   | 0.0        | 0.0  | 14.42       |
      | 5  | 30   | 20240501       |                  | 56.5            | 13.83         | 0.59     | 0.0  | 0.0       | 14.42 | 0.0   | 0.0        | 0.0  | 14.42       |
      | 6  | 31   | 20240601      |                  | 42.55           | 13.95         | 0.47     | 0.0  | 0.0       | 14.42 | 0.0   | 0.0        | 0.0  | 14.42       |
      | 7  | 30   | 20240701      |                  | 28.48           | 14.07         | 0.35     | 0.0  | 0.0       | 14.42 | 0.0   | 0.0        | 0.0  | 14.42       |
      | 8  | 31   | 20240801    |                  | 14.3            | 14.18         | 0.24     | 0.0  | 0.0       | 14.42 | 0.0   | 0.0        | 0.0  | 14.42       |
      | 9  | 31   | 20240901 |                  | 0.0             | 14.3          | 0.12     | 0.0  | 0.0       | 14.42 | 0.0   | 0.0        | 0.0  | 14.42       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 3.53     | 0.0  | 0.0       | 103.53 | 17.01 | 0.0        | 0.0  | 86.52       |
    And Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.37  | 83.57     | 0.8      | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has no new accrual data
#    --- Reschedule after re-age ---
    When Admin sets the business date to "20240402"
    When Admin runs inline COB job for Loan
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240501        | 20240402   |                 |                  |                 |            | 12              |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 70.33           | 13.24         | 1.18     | 0.0  | 0.0       | 14.42 | 0.0   | 0.0        | 0.0  | 14.42       |
      | 5  | 30   | 20240501       |                  | 56.45           | 13.88         | 0.59     | 0.0  | 0.0       | 14.47 | 0.0   | 0.0        | 0.0  | 14.47       |
      | 6  | 31   | 20240601      |                  | 42.54           | 13.91         | 0.56     | 0.0  | 0.0       | 14.47 | 0.0   | 0.0        | 0.0  | 14.47       |
      | 7  | 30   | 20240701      |                  | 28.5            | 14.04         | 0.43     | 0.0  | 0.0       | 14.47 | 0.0   | 0.0        | 0.0  | 14.47       |
      | 8  | 31   | 20240801    |                  | 14.31           | 14.19         | 0.28     | 0.0  | 0.0       | 14.47 | 0.0   | 0.0        | 0.0  | 14.47       |
      | 9  | 31   | 20240901 |                  | 0.0             | 14.31         | 0.14     | 0.0  | 0.0       | 14.45 | 0.0   | 0.0        | 0.0  | 14.45       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 3.76     | 0.0  | 0.0       | 103.76 | 17.01 | 0.0        | 0.0  | 86.75       |
    And Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.37  | 83.57     | 0.8      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Accrual Activity | 1.18   | 0.0       | 1.18     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has the following new accrual data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240315    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Accrual          | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |

#   --- Close loan ---
  #  When Loan Pay-off is made on "20240402"
    When Loan Pay-off is made on "20240402"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:4436 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging with accruals on interest bearing loan - Interest calculation: Default Behavior - due date and frequency changed from MONTHS to DAYS - Interest Split scenario - UC13.1
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL  | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.01 EUR transaction amount
    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate    | numberOfInstallments |
      | 15              | DAYS          | 20240401| 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 70.36           | 13.21         | 0.98     | 0.0  | 0.0       | 14.19 | 0.0   | 0.0        | 0.0  | 14.19       |
      | 5  | 15   | 20240416    |                  | 56.38           | 13.98         | 0.21     | 0.0  | 0.0       | 14.19 | 0.0   | 0.0        | 0.0  | 14.19       |
      | 6  | 15   | 20240501      |                  | 42.35           | 14.03         | 0.16     | 0.0  | 0.0       | 14.19 | 0.0   | 0.0        | 0.0  | 14.19       |
      | 7  | 15   | 20240516      |                  | 28.28           | 14.07         | 0.12     | 0.0  | 0.0       | 14.19 | 0.0   | 0.0        | 0.0  | 14.19       |
      | 8  | 15   | 20240531      |                  | 14.17           | 14.11         | 0.08     | 0.0  | 0.0       | 14.19 | 0.0   | 0.0        | 0.0  | 14.19       |
      | 9  | 15   | 20240615     |                  | 0.0             | 14.17         | 0.04     | 0.0  | 0.0       | 14.21 | 0.0   | 0.0        | 0.0  | 14.21       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.17     | 0.0  | 0.0       | 102.17 | 17.01 | 0.0        | 0.0  | 85.16       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Accrual          | 1.27   | 0.0       | 1.27     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
