@LoanChargeback
Feature: LoanChargeback - Part3

  @TestRailId:C3448
  Scenario: Two chargeback before the maturity date with interest recalculation ENABLED - Allocation priority: principal, interest, fees - UC4
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                               | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INTEREST_RECALC_EMI_360_30_CHARGEBACK_PRINCIPAL_INTEREST_FEE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.01 EUR transaction amount
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
      | 100           | 2.05     | 0    | 0         | 102.05 | 34.02 | 0          | 0    | 68.03       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
# --- partial chargeback for 1st repayment made on  February, 1st --- #
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 15 EUR transaction amount for Payment nr. 1
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    |                  | 50.52           | 31.53         | 0.48     | 0.0  | 0.0       | 32.01 | 0.0   | 0.0        | 0.0  | 32.01       |
      | 4  | 30   | 20240501      |                  | 33.8            | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.99           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.99         | 0.1      | 0.0  | 0.0       | 17.09 | 0.0   | 0.0        | 0.0  | 17.09       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 115.0         | 2.14     | 0    | 0         | 117.14 | 34.02 | 0          | 0    | 83.12       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240301    | Chargeback       | 15.0   | 15.0      | 0.0      | 0.0  | 0.0       | 82.05        | false    | false    |
# --- full chargeback for 2nd repayment made on  March, 1st --- #
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 17.01 EUR transaction amount for Payment nr. 2
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    |                  | 50.61           | 47.96         | 1.06     | 0.0  | 0.0       | 49.02 | 0.0   | 0.0        | 0.0  | 49.02       |
      | 4  | 30   | 20240501      |                  | 33.9            | 16.71         | 0.3      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 17.09           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 17.09         | 0.1      | 0.0  | 0.0       | 17.19 | 0.0   | 0.0        | 0.0  | 17.19       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 131.52        | 2.73     | 0    | 0         | 134.25 | 34.02 | 0          | 0    | 100.23      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240301    | Chargeback       | 15.0   | 15.0      | 0.0      | 0.0  | 0.0       | 82.05        | false    | false    |
      | 20240301    | Chargeback       | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 98.57        | false    | false    |

  @TestRailId:C3449
  Scenario: Full chargeback before the maturity date on different business date with interest recalculation ENABLED - Allocation priority: interest, fees, principal - UC5
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                               | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INTEREST_RECALC_EMI_360_30_CHARGEBACK_INTEREST_FEE_PRINCIPAL | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.01 EUR transaction amount
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
      | 100           | 2.05     | 0    | 0         | 102.05 | 34.02 | 0          | 0    | 68.03       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
# --- full chargeback for 2nd repayment made on  March, 1st --- #
    When Admin sets the business date to "20240315"
    And Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 17.01 EUR transaction amount for Payment nr. 2
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    |                  | 50.48           | 33.09         | 0.93     | 0.0  | 0.0       | 34.02 | 0.0   | 0.0        | 0.0  | 34.02       |
      | 4  | 30   | 20240501      |                  | 33.76           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.95           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.95         | 0.1      | 0.0  | 0.0       | 17.05 | 0.0   | 0.0        | 0.0  | 17.05       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 116.52        | 2.59     | 0    | 0         | 119.11 | 34.02 | 0          | 0    | 85.09       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240315    | Chargeback       | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 83.57        | false    | false    |

  @TestRailId:C3450
  Scenario: Full chargeback after the maturity date with interest recalculation ENABLED - Allocation priority: interest, fees, principal - UC6
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                               | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INTEREST_RECALC_EMI_360_30_CHARGEBACK_INTEREST_FEE_PRINCIPAL | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.01 EUR transaction amount
    When Admin sets the business date to "20240301"
    And Customer makes "AUTOPAY" repayment on "20240301" with 17.01 EUR transaction amount
    When Admin sets the business date to "20240401"
    And Customer makes "AUTOPAY" repayment on "20240401" with 17.01 EUR transaction amount
    When Admin sets the business date to "20240501"
    And Customer makes "AUTOPAY" repayment on "20240501" with 17.01 EUR transaction amount
    When Admin sets the business date to "20240601"
    And Customer makes "AUTOPAY" repayment on "20240601" with 17.01 EUR transaction amount
    When Admin sets the business date to "20240701"
    And Customer makes "AUTOPAY" repayment on "20240701" with 17 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401    | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240501      | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20240601     | 20240601     | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 6  | 30   | 20240701     | 20240701     | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 17.0  | 0.0        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 100           | 2.05     | 0    | 0         | 102.05 | 102.05 | 0          | 0    | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240401    | Repayment        | 17.01  | 16.62     | 0.39     | 0.0  | 0.0       | 50.43        | false    | false    |
      | 20240501      | Repayment        | 17.01  | 16.72     | 0.29     | 0.0  | 0.0       | 33.71        | false    | false    |
      | 20240601     | Repayment        | 17.01  | 16.81     | 0.2      | 0.0  | 0.0       | 16.9         | false    | false    |
      | 20240701     | Repayment        | 17.0   | 16.9      | 0.1      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240701     | Accrual          | 2.05   | 0.0       | 2.05     | 0.0  | 0.0       | 0.0          | false    | false    |
# --- full chargeback for 5th repayment made on  June, 1st --- #
    When Admin sets the business date to "20240715"
    And Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 17.01 EUR transaction amount for Payment nr. 5
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401    | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240501      | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20240601     | 20240601     | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 6  | 30   | 20240701     | 20240701     | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 17.0  | 0.0        | 0.0  | 0.0         |
      | 7  | 14   | 20240715     |                  | 0.0             | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 116.81        | 2.25     | 0    | 0         | 119.06 | 102.05 | 0          | 0    | 17.01       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240401    | Repayment        | 17.01  | 16.62     | 0.39     | 0.0  | 0.0       | 50.43        | false    | false    |
      | 20240501      | Repayment        | 17.01  | 16.72     | 0.29     | 0.0  | 0.0       | 33.71        | false    | false    |
      | 20240601     | Repayment        | 17.01  | 16.81     | 0.2      | 0.0  | 0.0       | 16.9         | false    | false    |
      | 20240701     | Repayment        | 17.0   | 16.9      | 0.1      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240701     | Accrual          | 2.05   | 0.0       | 2.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240715     | Chargeback       | 17.01  | 16.81     | 0.2      | 0.0  | 0.0       | 16.81        | false    | false    |

  @TestRailId:C3451
  Scenario: Two chargebacks after the maturity date with interest recalculation ENABLED - Allocation priority: interest, fees, principal - UC7
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                               | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INTEREST_RECALC_EMI_360_30_CHARGEBACK_INTEREST_FEE_PRINCIPAL | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.01 EUR transaction amount
    When Admin sets the business date to "20240301"
    And Customer makes "AUTOPAY" repayment on "20240301" with 17.01 EUR transaction amount
    When Admin sets the business date to "20240401"
    And Customer makes "AUTOPAY" repayment on "20240401" with 17.01 EUR transaction amount
    When Admin sets the business date to "20240501"
    And Customer makes "AUTOPAY" repayment on "20240501" with 17.01 EUR transaction amount
    When Admin sets the business date to "20240601"
    And Customer makes "AUTOPAY" repayment on "20240601" with 17.01 EUR transaction amount
    When Admin sets the business date to "20240701"
    And Customer makes "AUTOPAY" repayment on "20240701" with 17 EUR transaction amount
# --- full chargeback for 5th repayment made on  June, 1st --- #
    When Admin sets the business date to "20240715"
    And Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 17.01 EUR transaction amount for Payment nr. 5
# --- full chargeback for 6th repayment made on  July, 1st --- #
    When Admin sets the business date to "20240730"
    And Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 17 EUR transaction amount for Payment nr. 6
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401    | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240501      | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20240601     | 20240601     | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 6  | 30   | 20240701     | 20240701     | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 17.0  | 0.0        | 0.0  | 0.0         |
      | 7  | 29   | 20240730     |                  | 0.0             | 33.71         | 0.3      | 0.0  | 0.0       | 34.01 | 0.0   | 0.0        | 0.0  | 34.01       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 133.71        | 2.35     | 0    | 0         | 136.06 | 102.05 | 0          | 0    | 34.01       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240401    | Repayment        | 17.01  | 16.62     | 0.39     | 0.0  | 0.0       | 50.43        | false    | false    |
      | 20240501      | Repayment        | 17.01  | 16.72     | 0.29     | 0.0  | 0.0       | 33.71        | false    | false    |
      | 20240601     | Repayment        | 17.01  | 16.81     | 0.2      | 0.0  | 0.0       | 16.9         | false    | false    |
      | 20240701     | Repayment        | 17.0   | 16.9      | 0.1      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240701     | Accrual          | 2.05   | 0.0       | 2.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240715     | Chargeback       | 17.01  | 16.81     | 0.2      | 0.0  | 0.0       | 16.81        | false    | false    |
      | 20240730     | Chargeback       | 17.0   | 16.9      | 0.1      | 0.0  | 0.0       | 33.71        | false    | false    |

  @TestRailId:C3452
  Scenario: Chargeback on the last installment due date with interest recalculation ENABLED - Allocation priority: interest, fees, principal - UC8
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INTEREST_RECALC_EMI_360_30_CHARGEBACK_INTEREST_PENALTY_FEE_PRINCIPAL | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.01 EUR transaction amount
    When Admin sets the business date to "20240301"
    And Customer makes "AUTOPAY" repayment on "20240301" with 17.01 EUR transaction amount
    When Admin sets the business date to "20240401"
    And Customer makes "AUTOPAY" repayment on "20240401" with 17.01 EUR transaction amount
    When Admin sets the business date to "20240501"
    And Customer makes "AUTOPAY" repayment on "20240501" with 17.01 EUR transaction amount
    When Admin sets the business date to "20240601"
    And Customer makes "AUTOPAY" repayment on "20240601" with 17.01 EUR transaction amount
    When Admin sets the business date to "20240701"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401    | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240501      | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20240601     | 20240601     | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0   | 0.0        | 0.0  | 17.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 100           | 2.05     | 0    | 0         | 102.05 | 85.05  | 0          | 0    | 17.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240401    | Repayment        | 17.01  | 16.62     | 0.39     | 0.0  | 0.0       | 50.43        | false    | false    |
      | 20240501      | Repayment        | 17.01  | 16.72     | 0.29     | 0.0  | 0.0       | 33.71        | false    | false    |
      | 20240601     | Repayment        | 17.01  | 16.81     | 0.2      | 0.0  | 0.0       | 16.9         | false    | false    |
# --- full chargeback for 5th repayment made on  June, 1st --- #
    And Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 17.01 EUR transaction amount for Payment nr. 5
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401    | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240501      | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20240601     | 20240601     | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 6  | 30   | 20240701     |                  | 0.0             | 33.71         | 0.3      | 0.0  | 0.0       | 34.01 | 0.0   | 0.0        | 0.0  | 34.01       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 116.81        | 2.25     | 0    | 0         | 119.06 | 85.05  | 0          | 0    | 34.01       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240401    | Repayment        | 17.01  | 16.62     | 0.39     | 0.0  | 0.0       | 50.43        | false    | false    |
      | 20240501      | Repayment        | 17.01  | 16.72     | 0.29     | 0.0  | 0.0       | 33.71        | false    | false    |
      | 20240601     | Repayment        | 17.01  | 16.81     | 0.2      | 0.0  | 0.0       | 16.9         | false    | false    |
      | 20240701     | Chargeback       | 17.01  | 16.81     | 0.2      | 0.0  | 0.0       | 33.71        | false    | false    |

  @TestRailId:C3453
  Scenario: Prepay loan after few installments repay and chargeback with interest recalculation ENABLED - Allocation priority: interest, fees, principal - UC9
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                               | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INTEREST_RECALC_EMI_360_30_CHARGEBACK_INTEREST_FEE_PRINCIPAL | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.01 EUR transaction amount
    When Admin sets the business date to "20240301"
    And Customer makes "AUTOPAY" repayment on "20240301" with 17.01 EUR transaction amount
    When Admin sets the business date to "20240401"
    And Customer makes "AUTOPAY" repayment on "20240401" with 17.01 EUR transaction amount
    And Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 17.01 EUR transaction amount for Payment nr. 3
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401    | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 4  | 30   | 20240501      |                  | 33.81           | 33.24         | 0.78     | 0.0  | 0.0       | 34.02 | 0.0   | 0.0        | 0.0  | 34.02       |
      | 5  | 31   | 20240601     |                  | 17.0            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 17.0          | 0.1      | 0.0  | 0.0       | 17.1  | 0.0   | 0.0        | 0.0  | 17.1        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 116.62        | 2.54     | 0    | 0         | 119.16 | 51.03  | 0          | 0    | 68.13       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240401    | Repayment        | 17.01  | 16.62     | 0.39     | 0.0  | 0.0       | 50.43        | false    | false    |
   #   | 20240701     | Accrual          | 2.05   | 0.0       | 2.05     | 0.0  | 0.0       | 0.0          | false    | false    |
      |  20240401   | Chargeback       | 17.01  | 16.62     | 0.39     | 0.0  | 0.0       | 67.05        | false    | false    |
# --- PayOff loan with prepay amount to close a loan --- #
    When Loan Pay-off is made on "20240401"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401    | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240401    | 33.42           | 33.63         | 0.39     | 0.0  | 0.0       | 34.02 | 34.02 | 34.02      | 0.0  | 0.0         |
      | 5  | 31   | 20240601     | 20240401    | 16.41           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
      | 6  | 30   | 20240701     | 20240401    | 0.0             | 16.41         | 0.0      | 0.0  | 0.0       | 16.41 | 16.41 | 16.41      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 116.62        | 1.85     | 0    | 0         | 118.47 | 118.47 | 67.44      | 0    | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240401    | Repayment        | 17.01  | 16.62     | 0.39     | 0.0  | 0.0       | 50.43        | false    | false    |
      | 20240401    | Chargeback       | 17.01  | 16.62     | 0.39     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240401    | Repayment        | 67.44  | 67.05     | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Accrual          | 1.46   | 0.0       | 1.46     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan closedon_date is "20240401"

  @TestRailId:C3454
  Scenario: Full chargeback before the maturity date with run COB and interest recalculation ENABLED - Allocation priority: interest, fees, principal - UC10
    When Admin sets the business date to "20240102"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INTEREST_RECALC_EMI_360_30_CHARGEBACK_INTEREST_PENALTY_FEE_PRINCIPAL | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees  | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0   |           | 0.0     |      |            |      | 0.0         |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0   | 0.0       | 17.01   | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.05           | 16.52         | 0.49     | 0.0   | 0.0       | 17.01   | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.43           | 16.62         | 0.39     | 0.0   | 0.0       | 17.01   | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.71           | 16.72	       | 0.29     | 0.0   | 0.0       | 17.01	| 0.0  | 0.0        | 0.0  | 17.01	     |
      | 5  | 31   | 20240601     |           | 16.9            | 16.81         | 0.2      | 0.0   | 0.0       | 17.01	| 0.0  | 0.0        | 0.0  | 17.01	     |
      | 6  | 30   | 20240701     |           | 0.0             | 16.9          | 0.1      | 0.0   | 0.0       | 17.0 	| 0.0  | 0.0        | 0.0  | 17.0 	     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 100           | 2.05     | 0    | 0         | 102.05  | 0    | 0          | 0    | 102.05      |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.01 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees  | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0   |           | 0.0     | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0   | 0.0       | 17.01   | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.05           | 16.52         | 0.49     | 0.0   | 0.0       | 17.01   | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 50.43           | 16.62         | 0.39     | 0.0   | 0.0       | 17.01   | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.71           | 16.72	      | 0.29     | 0.0   | 0.0       | 17.01   | 0.0   | 0.0        | 0.0  | 17.01	     |
      | 5  | 31   | 20240601     |                  | 16.9            | 16.81         | 0.2      | 0.0   | 0.0       | 17.01   | 0.0   | 0.0        | 0.0  | 17.01	     |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.9          | 0.1      | 0.0   | 0.0       | 17.0    | 0.0   | 0.0        | 0.0  | 17.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 100           | 2.05     | 0    | 0         | 102.05  | 17.01 | 0          | 0    | 85.04     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount  | Principal | Interest | Fees  | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement      | 100.0   | 0.0       | 0.0      | 0.0   | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment         | 17.01   | 16.43     | 0.58     | 0.0   | 0.0       | 83.57        | false    | false    |
# --- full chargeback for the repayment made on February, 1st --- #
    And Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 17.01 EUR transaction amount for Payment nr. 1
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
      | 116.43        | 2.72     | 0    | 0         | 119.15 | 17.01 | 0          | 0    | 102.14      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Chargeback       | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 100.0        | false    | false    |
    When Admin sets the business date to "20240202"
    When Admin runs inline COB job for Loan
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
      | 116.43        | 2.72     | 0    | 0         | 119.15 | 17.01 | 0          | 0    | 102.14      |
    Then Loan Transactions tab has the following data:
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
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Chargeback       | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C4015
  Scenario: Verify early repayment with MIR and chargeback afterwards for 24m progressive loan
    When Admin sets the business date to "20250411"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_ZERO_CHARGE_OFF | 20250411     | 209.72         | 12.25                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 15 EUR transaction amount for MIR nr. 1
    When Admin sets the business date to "20250816"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250411        |                  | 209.72          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20250511          | 20250511      | 201.96          |  7.76         |  2.14    | 0.0  | 0.0       | 9.9   | 9.9   | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250611         | 20250611     | 194.12          |  7.84         |  2.06    | 0.0  | 0.0       | 9.9   | 9.9   | 0.0        | 0.0  | 0.0         |
      | 3  | 30   | 20250711         | 20250711     | 186.2           |  7.92         |  1.98    | 0.0  | 0.0       | 9.9   | 9.9   | 0.0        | 0.0  | 0.0         |
      | 4  | 31   | 20250811       | 20250813   | 178.2           |  8.0          |  1.9     | 0.0  | 0.0       | 9.9   | 9.9   | 0.0        | 9.9  | 0.0         |
      | 5  | 31   | 20250911    |                  | 178.2           |  15.0         |  0.18    | 0.0  | 0.0       | 15.18 | 8.57  | 8.57       | 0.0  | 6.61        |
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
      | 224.72        | 8.26     | 0.0  |  0.0      | 232.98 | 226.37 | 186.77     | 9.9  | 6.61        |
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
      | 20250813   | Merchant Issued Refund | 188.8   | 186.2     | 2.02     | 0.0  | 0.0       | 0.0           | false    | true     |
      | 20250813   | Interest Refund        | 7.87    | 0.0       | 0.0      | 0.0  | 0.0       | 0.0           | false    | true     |
      | 20250815   | Chargeback             | 15.0    | 15.0      | 0.0      | 0.0  | 0.0       | 6.55          | false    | false    |

  @TestRailId:C4677 @AdvancedPaymentAllocation
  Scenario: Verify changedTerms value for LoanDisbursalTransactionBusinessEvent with n+1 trm for interest bearing multidisb loan - backdated 2nd disb with chargeback after maturity date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSE_CHARGEBACK | 20240101   | 150            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "150" amount and expected disbursement date on "20240101"
    When Admin disburses the loan on "20240101" with "100" EUR transaction amount
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
# --- add chargeback after maturity date - n+1 trn -- #
    When Admin sets the business date to "20240801"
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 17.01 EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 50.53           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 34.01           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 17.49           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 17.49         | 0.49     | 0.0  | 0.0       | 17.98 | 0.0   | 0.0        | 0.0  | 17.98       |
      | 7  | 31   | 20240801   |                  | 0.0             | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 116.43        | 3.61     | 0.0  | 0.0       | 120.04 | 17.01 | 0.0        | 0.0  | 103.03      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240801   | Chargeback       | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 100.0        | false    | false    |
# --- add backdated 2nd disbursement --- #
    When Admin disburses the loan on "20240120" with "50" EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240120  |                  |  50.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |                  | 125.22          | 24.78         | 0.7      | 0.0  | 0.0       | 25.48 | 17.01 | 0.0        | 0.0  | 8.47        |
      | 2  | 29   | 20240301    |                  | 100.52          | 24.7          | 0.78     | 0.0  | 0.0       | 25.48 | 0.0   | 0.0        | 0.0  | 25.48       |
      | 3  | 31   | 20240401    |                  | 75.82           | 24.7          | 0.78     | 0.0  | 0.0       | 25.48 | 0.0   | 0.0        | 0.0  | 25.48       |
      | 4  | 30   | 20240501      |                  | 51.12           | 24.7          | 0.78     | 0.0  | 0.0       | 25.48 | 0.0   | 0.0        | 0.0  | 25.48       |
      | 5  | 31   | 20240601     |                  | 26.42           | 24.7          | 0.78     | 0.0  | 0.0       | 25.48 | 0.0   | 0.0        | 0.0  | 25.48       |
      | 6  | 30   | 20240701     |                  | 0.0             | 26.42         | 0.78     | 0.0  | 0.0       | 27.2  | 0.0   | 0.0        | 0.0  | 27.2        |
      | 7  | 31   | 20240801   |                  | 0.0             | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 167.01        | 4.6      | 0.0  | 0.0       | 171.61 | 17.01 | 0.0        | 0.0  | 154.6      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240120  | Disbursement     | 50.0   | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 17.01     | 0.0      | 0.0  | 0.0       | 132.99       | false    | true     |
      | 20240801   | Chargeback       | 17.01  | 17.01     | 0.0      | 0.0  | 0.0       | 150.0        | false    | true     |
    Then LoanDisbursalTransactionBusinessEvent has changedTerms "false"
    When Loan Pay-off is made on "20240801"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

