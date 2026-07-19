@Repayment
Feature: LoanRepayment - Part4

  @TestRailId:C4353
  Scenario: Verify the loan creation with total disbursement amount less then 1 for progressive loan - UC2
    When Admin sets the business date to "20251026"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with loan product`s charges and following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_ZERO_INTEREST_CHARGE_OFF_BEHAVIOUR | 20251026   | 1              | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20251026" with "1" amount and expected disbursement date on "20251026"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |           | 1.0             |               |          | 0.0  |           | 0.0 |      |            |      | 0.0         |
      | 1  | 31   | 20251126 |           | 0.0             | 1.0           | 0.0      | 0.0  | 0.0       | 1.0 | 0.0  | 0.0        | 0.0  | 1.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      | 1.0           | 0.0      | 0.0  | 0.0       | 1.0 | 0.0  | 0.0        | 0.0  | 1.0         |
    When Admin successfully disburse the loan on "20251026" with "0.4" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |           | 0.4             |               |          | 0.0  |           | 0.0 | 0.0  |            |      |             |
      | 1  | 31   | 20251126 |           | 0.0             | 0.4           | 0.0      | 0.0  | 0.0       | 0.4 | 0.0  | 0.0        | 0.0  | 0.4         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      | 0.4           | 0.0      | 0.0  | 0.0       | 0.4 | 0.0  | 0.0        | 0.0  | 0.4         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20251026  | Disbursement     | 0.4    | 0.0       | 0.0      | 0.0  | 0.0       | 0.4          | false    | false    |
    When Admin sets the business date to "20251027"
    When Loan Pay-off is made on "20251027"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |                 | 0.4             |               |          | 0.0  |           | 0.0 | 0.0  |            |      |             |
      | 1  | 31   | 20251126 | 20251027 | 0.0             | 0.4           | 0.0      | 0.0  | 0.0       | 0.4 | 0.4  | 0.4        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      | 0.4           | 0.0      | 0.0  | 0.0       | 0.4 | 0.4  | 0.4        | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20251026  | Disbursement     | 0.4    | 0.0       | 0.0      | 0.0  | 0.0       | 0.4          | false    | false    |
      | 20251027  | Repayment        | 0.4    | 0.4       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4354
  Scenario: Verify the loan creation with total disbursement amount less then 1 for progressive loan - 2 repayments
    When Admin sets the business date to "20251026"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with loan product`s charges and following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_ZERO_INTEREST_CHARGE_OFF_BEHAVIOUR | 20251026   | 1              | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 2                 | MONTHS                | 1              | MONTHS                 | 2                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20251026" with "1" amount and expected disbursement date on "20251026"
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |           | 1.0             |               |          | 0.0  |           | 0.0 |      |            |      | 0.0         |
      | 1  | 31   | 20251126 |           | 0.5             | 0.5           | 0.0      | 0.0  | 0.0       | 0.5 | 0.0  | 0.0        | 0.0  | 0.5         |
      | 2  | 30   | 20251226 |           | 0.0             | 0.5           | 0.0      | 0.0  | 0.0       | 0.5 | 0.0  | 0.0        | 0.0  | 0.5         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      | 1.0           | 0.0      | 0.0  | 0.0       | 1.0 | 0.0  | 0.0        | 0.0  | 1.0         |
    When Admin successfully disburse the loan on "20251026" with "0.4" EUR transaction amount
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |                 | 0.4             |               |          | 0.0  |           | 0.0 | 0.0  |            |      |             |
      | 1  | 31   | 20251126 |                 | 0.2             | 0.2           | 0.0      | 0.0  | 0.0       | 0.2 | 0.0  | 0.0        | 0.0  | 0.2         |
      | 2  | 30   | 20251226 |                 | 0.0             | 0.2           | 0.0      | 0.0  | 0.0       | 0.2 | 0.0  | 0.0        | 0.0  | 0.2         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      | 0.4           | 0.0      | 0.0  | 0.0       | 0.4 | 0.0  | 0.0        | 0.0  | 0.4         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20251026  | Disbursement     | 0.4    | 0.0       | 0.0      | 0.0  | 0.0       | 0.4          | false    | false    |
    When Admin sets the business date to "20251027"
    When Loan Pay-off is made on "20251027"
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |                 | 0.4             |               |          | 0.0  |           | 0.0 | 0.0  |            |      |             |
      | 1  | 31   | 20251126 | 20251027 | 0.2             | 0.2           | 0.0      | 0.0  | 0.0       | 0.2 | 0.2  | 0.2        | 0.0  | 0.0         |
      | 2  | 30   | 20251226 | 20251027 | 0.0             | 0.2           | 0.0      | 0.0  | 0.0       | 0.2 | 0.2  | 0.2        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      | 0.4           | 0.0      | 0.0  | 0.0       | 0.4 | 0.4  | 0.4        | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20251026  | Disbursement     | 0.4    | 0.0       | 0.0      | 0.0  | 0.0       | 0.4          | false    | false    |
      | 20251027  | Repayment        | 0.4    | 0.4       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4648
  Scenario: Verify repayment undo with linked chargeback fails with proper error
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
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 17.01 EUR transaction amount
    Then Customer undo "1"th transaction made on "20240201" results a 403 error and "update not allowed as loan transaction is linked to other transactions" error message
    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4683 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-vertical prepayment with NEXT_INSTALLMENT strategy
    When Admin sets the business date to "20260223"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_VERTICAL_INTEREST_RECALC" loan product "REPAYMENT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_VERTICAL_INTEREST_RECALC | 20260101   | 25000000       | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 12                | MONTHS                | 1              | MONTHS                 | 12                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260101" with "25000000" amount and expected disbursement date on "20260101"
    When Admin successfully disburse the loan on "20260101" with "25000000" EUR transaction amount
    Then Loan Repayment schedule has 12 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest  | Fees | Penalties | Due        | Paid | In advance | Late | Outstanding |
      |    |      | 20260101   |           | 25000000.0      |               |           | 0.0  |           | 0.0        | 0.0  |            |      |             |
      | 1  | 31   | 20260201  |           | 23034153.81     | 1965846.19    | 254794.52 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 2  | 28   | 20260301     |           | 21039772.25     | 1994381.56    | 226259.15 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 3  | 31   | 20260401     |           | 19033564.29     | 2006207.96    | 214432.75 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 4  | 30   | 20260501       |           | 17000651.89     | 2032912.4     | 187728.31 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 5  | 31   | 20260601      |           | 14953278.1      | 2047373.79    | 173266.92 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 6  | 30   | 20260701      |           | 12880121.78     | 2073156.32    | 147484.39 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 7  | 31   | 20260801    |           | 10790752.45     | 2089369.33    | 131271.38 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 8  | 31   | 20260901 |           | 8680088.72      | 2110663.73    | 109976.98 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 9  | 30   | 20261001   |           | 6545059.84      | 2135028.88    | 85611.83  | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 10 | 31   | 20261101  |           | 4391124.95      | 2153934.89    | 66705.82  | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 11 | 30   | 20261201  |           | 2213793.97      | 2177330.98    | 43309.73  | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 12 | 31   | 20270101   |           | 0.0             | 2213793.97    | 22562.5   | 0.0  | 0.0       | 2236356.47 | 0.0  | 0.0        | 0.0  | 2236356.47  |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due         | Paid | In advance | Late | Outstanding |
      | 25000000.0    | 1663404.28 | 0.0  | 0.0       | 26663404.28 | 0.0  | 0.0        | 0.0  | 26663404.28 |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount     | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20260101  | Disbursement     | 25000000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 25000000.0   |
    When Loan Pay-off is made on "20260223"
    Then Loan Repayment schedule has 12 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest  | Fees | Penalties | Due        | Paid       | In advance | Late       | Outstanding |
      |    |      | 20260101   |                  | 25000000.0      |               |           | 0.0  |           | 0.0        | 0.0        |            |            |             |
      | 1  | 31   | 20260201  | 20260223 | 23034153.81     | 1965846.19    | 254794.52 | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 0.0        | 2220640.71 | 0.0         |
      | 2  | 28   | 20260301     | 20260223 | 20813513.1      | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 3  | 31   | 20260401     | 20260223 | 18592872.39     | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 4  | 30   | 20260501       | 20260223 | 16372231.68     | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 5  | 31   | 20260601      | 20260223 | 14151590.97     | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 6  | 30   | 20260701      | 20260223 | 11930950.26     | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 7  | 31   | 20260801    | 20260223 | 9710309.55      | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 8  | 31   | 20260901 | 20260223 | 7489668.84      | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 9  | 30   | 20261001   | 20260223 | 5269028.13      | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 10 | 31   | 20261101  | 20260223 | 3048387.42      | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 11 | 30   | 20261201  | 20260223 | 827746.71       | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 12 | 31   | 20270101   | 20260223 | 0.0             | 827746.71     | 180821.92 | 0.0  | 0.0       | 1008568.63 | 1008568.63 | 1008568.63 | 0.0        | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest  | Fees | Penalties | Due         | Paid        | In advance  | Late       | Outstanding |
      | 25000000.0    | 435616.44 | 0.0  | 0.0       | 25435616.44 | 25435616.44 | 23214975.73 | 2220640.71 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount      | Principal  | Interest  | Fees | Penalties | Loan Balance |
      | 20260101  | Disbursement     | 25000000.0  | 0.0        | 0.0       | 0.0  | 0.0       | 25000000.0   |
      | 20260223 | Repayment        | 25435616.44 | 25000000.0 | 435616.44 | 0.0  | 0.0       | 0.0          |
      | 20260223 | Accrual          | 435616.44   | 0.0        | 435616.44 | 0.0  | 0.0       | 0.0          |
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    When Admin set "LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_VERTICAL_INTEREST_RECALC" loan product "REPAYMENT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C4684 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-vertical prepayment with LAST_INSTALLMENT strategy
    When Admin sets the business date to "20260223"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_VERTICAL_INTEREST_RECALC" loan product "REPAYMENT" transaction type to "LAST_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_VERTICAL_INTEREST_RECALC | 20260101   | 25000000       | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 12                | MONTHS                | 1              | MONTHS                 | 12                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260101" with "25000000" amount and expected disbursement date on "20260101"
    When Admin successfully disburse the loan on "20260101" with "25000000" EUR transaction amount
    Then Loan Repayment schedule has 12 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest  | Fees | Penalties | Due        | Paid | In advance | Late | Outstanding |
      |    |      | 20260101   |           | 25000000.0      |               |           | 0.0  |           | 0.0        | 0.0  |            |      |             |
      | 1  | 31   | 20260201  |           | 23034153.81     | 1965846.19    | 254794.52 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 2  | 28   | 20260301     |           | 21039772.25     | 1994381.56    | 226259.15 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 3  | 31   | 20260401     |           | 19033564.29     | 2006207.96    | 214432.75 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 4  | 30   | 20260501       |           | 17000651.89     | 2032912.4     | 187728.31 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 5  | 31   | 20260601      |           | 14953278.1      | 2047373.79    | 173266.92 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 6  | 30   | 20260701      |           | 12880121.78     | 2073156.32    | 147484.39 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 7  | 31   | 20260801    |           | 10790752.45     | 2089369.33    | 131271.38 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 8  | 31   | 20260901 |           | 8680088.72      | 2110663.73    | 109976.98 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 9  | 30   | 20261001   |           | 6545059.84      | 2135028.88    | 85611.83  | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 10 | 31   | 20261101  |           | 4391124.95      | 2153934.89    | 66705.82  | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 11 | 30   | 20261201  |           | 2213793.97      | 2177330.98    | 43309.73  | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 12 | 31   | 20270101   |           | 0.0             | 2213793.97    | 22562.5   | 0.0  | 0.0       | 2236356.47 | 0.0  | 0.0        | 0.0  | 2236356.47  |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due         | Paid | In advance | Late | Outstanding |
      | 25000000.0    | 1663404.28 | 0.0  | 0.0       | 26663404.28 | 0.0  | 0.0        | 0.0  | 26663404.28 |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount     | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20260101  | Disbursement     | 25000000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 25000000.0   |
    When Loan Pay-off is made on "20260223"
    Then Loan Repayment schedule has 12 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest  | Fees | Penalties | Due        | Paid       | In advance | Late       | Outstanding |
      |    |      | 20260101   |                  | 25000000.0      |               |           | 0.0  |           | 0.0        | 0.0        |            |            |             |
      | 1  | 31   | 20260201  | 20260223 | 23034153.81     | 1965846.19    | 254794.52 | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 0.0        | 2220640.71 | 0.0         |
      | 2  | 28   | 20260301     | 20260223 | 22206407.14     | 827746.67     | 180821.92 | 0.0  | 0.0       | 1008568.59 | 1008568.59 | 1008568.59 | 0.0        | 0.0         |
      | 3  | 31   | 20260401     | 20260223 | 19985766.43     | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 4  | 30   | 20260501       | 20260223 | 17765125.72     | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 5  | 31   | 20260601      | 20260223 | 15544485.01     | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 6  | 30   | 20260701      | 20260223 | 13323844.3      | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 7  | 31   | 20260801    | 20260223 | 11103203.59     | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 8  | 31   | 20260901 | 20260223 | 8882562.88      | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 9  | 30   | 20261001   | 20260223 | 6661922.17      | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 10 | 31   | 20261101  | 20260223 | 4441281.46      | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 11 | 30   | 20261201  | 20260223 | 2220640.75      | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 12 | 31   | 20270101   | 20260223 | 0.0             | 2220640.75    | 0.0       | 0.0  | 0.0       | 2220640.75 | 2220640.75 | 2220640.75 | 0.0        | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest  | Fees | Penalties | Due         | Paid        | In advance  | Late       | Outstanding |
      | 25000000.0    | 435616.44 | 0.0  | 0.0       | 25435616.44 | 25435616.44 | 23214975.73 | 2220640.71 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount      | Principal  | Interest  | Fees | Penalties | Loan Balance |
      | 20260101  | Disbursement     | 25000000.0  | 0.0        | 0.0       | 0.0  | 0.0       | 25000000.0   |
      | 20260223 | Repayment        | 25435616.44 | 25000000.0 | 435616.44 | 0.0  | 0.0       | 0.0          |
      | 20260223 | Accrual          | 435616.44   | 0.0        | 435616.44 | 0.0  | 0.0       | 0.0          |
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    When Admin set "LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_VERTICAL_INTEREST_RECALC" loan product "REPAYMENT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C4685 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-vertical prepayment with NEXT_LAST_INSTALLMENT strategy
    When Admin sets the business date to "20260223"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_VERTICAL_INTEREST_RECALC" loan product "REPAYMENT" transaction type to "NEXT_LAST_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_VERTICAL_INTEREST_RECALC | 20260101   | 25000000       | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 12                | MONTHS                | 1              | MONTHS                 | 12                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260101" with "25000000" amount and expected disbursement date on "20260101"
    When Admin successfully disburse the loan on "20260101" with "25000000" EUR transaction amount
    Then Loan Repayment schedule has 12 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest  | Fees | Penalties | Due        | Paid | In advance | Late | Outstanding |
      |    |      | 20260101   |           | 25000000.0      |               |           | 0.0  |           | 0.0        | 0.0  |            |      |             |
      | 1  | 31   | 20260201  |           | 23034153.81     | 1965846.19    | 254794.52 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 2  | 28   | 20260301     |           | 21039772.25     | 1994381.56    | 226259.15 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 3  | 31   | 20260401     |           | 19033564.29     | 2006207.96    | 214432.75 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 4  | 30   | 20260501       |           | 17000651.89     | 2032912.4     | 187728.31 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 5  | 31   | 20260601      |           | 14953278.1      | 2047373.79    | 173266.92 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 6  | 30   | 20260701      |           | 12880121.78     | 2073156.32    | 147484.39 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 7  | 31   | 20260801    |           | 10790752.45     | 2089369.33    | 131271.38 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 8  | 31   | 20260901 |           | 8680088.72      | 2110663.73    | 109976.98 | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 9  | 30   | 20261001   |           | 6545059.84      | 2135028.88    | 85611.83  | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 10 | 31   | 20261101  |           | 4391124.95      | 2153934.89    | 66705.82  | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 11 | 30   | 20261201  |           | 2213793.97      | 2177330.98    | 43309.73  | 0.0  | 0.0       | 2220640.71 | 0.0  | 0.0        | 0.0  | 2220640.71  |
      | 12 | 31   | 20270101   |           | 0.0             | 2213793.97    | 22562.5   | 0.0  | 0.0       | 2236356.47 | 0.0  | 0.0        | 0.0  | 2236356.47  |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due         | Paid | In advance | Late | Outstanding |
      | 25000000.0    | 1663404.28 | 0.0  | 0.0       | 26663404.28 | 0.0  | 0.0        | 0.0  | 26663404.28 |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount     | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20260101  | Disbursement     | 25000000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 25000000.0   |
    When Loan Pay-off is made on "20260223"
    Then Loan Repayment schedule has 12 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest  | Fees | Penalties | Due        | Paid       | In advance | Late       | Outstanding |
      |    |      | 20260101   |                  | 25000000.0      |               |           | 0.0  |           | 0.0        | 0.0        |            |            |             |
      | 1  | 31   | 20260201  | 20260223 | 23034153.81     | 1965846.19    | 254794.52 | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 0.0        | 2220640.71 | 0.0         |
      | 2  | 28   | 20260301     | 20260223 | 20813513.1      | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 3  | 31   | 20260401     | 20260223 | 19985766.43     | 827746.67     | 180821.92 | 0.0  | 0.0       | 1008568.59 | 1008568.59 | 1008568.59 | 0.0        | 0.0         |
      | 4  | 30   | 20260501       | 20260223 | 17765125.72     | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 5  | 31   | 20260601      | 20260223 | 15544485.01     | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 6  | 30   | 20260701      | 20260223 | 13323844.3      | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 7  | 31   | 20260801    | 20260223 | 11103203.59     | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 8  | 31   | 20260901 | 20260223 | 8882562.88      | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 9  | 30   | 20261001   | 20260223 | 6661922.17      | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 10 | 31   | 20261101  | 20260223 | 4441281.46      | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 11 | 30   | 20261201  | 20260223 | 2220640.75      | 2220640.71    | 0.0       | 0.0  | 0.0       | 2220640.71 | 2220640.71 | 2220640.71 | 0.0        | 0.0         |
      | 12 | 31   | 20270101   | 20260223 | 0.0             | 2220640.75    | 0.0       | 0.0  | 0.0       | 2220640.75 | 2220640.75 | 2220640.75 | 0.0        | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest  | Fees | Penalties | Due         | Paid        | In advance  | Late       | Outstanding |
      | 25000000.0    | 435616.44 | 0.0  | 0.0       | 25435616.44 | 25435616.44 | 23214975.73 | 2220640.71 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount      | Principal  | Interest  | Fees | Penalties | Loan Balance |
      | 20260101  | Disbursement     | 25000000.0  | 0.0        | 0.0       | 0.0  | 0.0       | 25000000.0   |
      | 20260223 | Repayment        | 25435616.44 | 25000000.0 | 435616.44 | 0.0  | 0.0       | 0.0          |
      | 20260223 | Accrual          | 435616.44   | 0.0        | 435616.44 | 0.0  | 0.0       | 0.0          |
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    When Admin set "LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_VERTICAL_INTEREST_RECALC" loan product "REPAYMENT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C78844 @AdvancedPaymentAllocation
  Scenario: Verify installment due date logic for monthly installments - repayment start date type overridden on loan level by submitted on date
    When Admin sets the business date to "20240131"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | expected disbursement date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            | Repayment start date type |
      | LP2_ADV_PYMNT_ZERO_INTEREST_CHARGE_OFF_BEHAVIOUR | 20240131   | 20240210           | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION | SUBMITTED_ON_DATE         |
    Then LoanDetails has repaymentStartDateType field with value: "SUBMITTED_ON_DATE"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240210 |           | 1000.0          |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 29   | 20240229 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20240331    |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 30   | 20240430    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20240531      |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    And Admin successfully approves the loan on "20240131" with "1000" amount and expected disbursement date on "20240211"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240211 |           | 1000.0          |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 29   | 20240229 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20240331    |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 30   | 20240430    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20240531      |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    When Admin sets the business date to "20240212"
    When Admin successfully disburse the loan on "20240212" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240212 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 29   | 20240229 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20240331    |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 30   | 20240430    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20240531      |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |

  @TestRailId:C78845 @AdvancedPaymentAllocation
  Scenario: Verify installment due date logic for monthly installments - repayment start date type overridden on loan level by disbursement date
    When Admin sets the business date to "20240131"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                | submitted on date | expected disbursement date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            | Repayment start date type |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION_REPAYMENT_START_SUBMITTED | 20240131   | 20240210           | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION | DISBURSEMENT_DATE         |
    Then LoanDetails has repaymentStartDateType field with value: "DISBURSEMENT_DATE"
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240210 |           | 1000.0          |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 0    | 20240210 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 29   | 20240310    |           | 562.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 3  | 31   | 20240410    |           | 374.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 4  | 30   | 20240510      |           | 186.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 5  | 31   | 20240610     |           | 0.0             | 186.0         | 0.0      | 0.0  | 0.0       | 186.0 | 0.0  | 0.0        | 0.0  | 186.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    And Admin successfully approves the loan on "20240131" with "1000" amount and expected disbursement date on "20240211"
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240211 |           | 1000.0          |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 0    | 20240211 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 29   | 20240311    |           | 562.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 3  | 31   | 20240411    |           | 374.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 4  | 30   | 20240511      |           | 186.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 5  | 31   | 20240611     |           | 0.0             | 186.0         | 0.0      | 0.0  | 0.0       | 186.0 | 0.0  | 0.0        | 0.0  | 186.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    When Admin sets the business date to "20240212"
    When Admin successfully disburse the loan on "20240212" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240212 |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240212 | 20240212 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240312    |                  | 562.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 3  | 31   | 20240412    |                  | 374.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 4  | 30   | 20240512      |                  | 186.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 5  | 31   | 20240612     |                  | 0.0             | 186.0         | 0.0      | 0.0  | 0.0       | 186.0 | 0.0   | 0.0        | 0.0  | 186.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |

  @TestRailId:CXXXX @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-vertical two repayment and prepayment with NEXT_INSTALLMENT strategy
    When Admin sets the business date to "20260223"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_VERTICAL_INTEREST_RECALC" loan product "REPAYMENT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_VERTICAL_INTEREST_RECALC | 20241231  | 424036.08      | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 36                | MONTHS                | 1              | MONTHS                 | 36                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20241231" with "424036.08" amount and expected disbursement date on "20241231"
    When Admin successfully disburse the loan on "20241231" with "424036.08" EUR transaction amount
    Then Loan Repayment schedule has 36 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due      | Paid | In advance | Late | Outstanding |
      |    |      | 20241231  |           | 424036.08       |               |          | 0.0  |           | 0.0      | 0.0  |            |      |             |
      | 1  | 31   | 20250131   |           | 414277.37       | 9758.71       | 4321.68  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 2  | 28   | 20250228  |           | 404100.44       | 10176.93      | 3903.46  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 3  | 31   | 20250331     |           | 394341.73       | 9758.71       | 4321.68  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 4  | 30   | 20250430     |           | 384443.61       | 9898.12       | 4182.27  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 5  | 31   | 20250531       |           | 374684.9        | 9758.71       | 4321.68  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 6  | 30   | 20250630      |           | 364786.78       | 9898.12       | 4182.27  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 7  | 31   | 20250731      |           | 355028.07       | 9758.71       | 4321.68  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 8  | 31   | 20250831    |           | 345269.36       | 9758.71       | 4321.68  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 9  | 30   | 20250930 |           | 335371.24       | 9898.12       | 4182.27  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 10 | 31   | 20251031   |           | 325612.53       | 9758.71       | 4321.68  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 11 | 30   | 20251130  |           | 315714.41       | 9898.12       | 4182.27  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 12 | 31   | 20251231  |           | 305955.7        | 9758.71       | 4321.68  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 13 | 31   | 20260131   |           | 296196.99       | 9758.71       | 4321.68  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 14 | 28   | 20260228  |           | 285809.91       | 10387.08      | 3693.31  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 15 | 31   | 20260331     |           | 274642.43       | 11167.48      | 2912.91  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 16 | 30   | 20260430     |           | 263270.84       | 11371.59      | 2708.8   | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 17 | 31   | 20260531       |           | 251873.65       | 11397.19      | 2683.2   | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 18 | 30   | 20260630      |           | 240277.49       | 11596.16      | 2484.23  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 19 | 31   | 20260731      |           | 228645.96       | 11631.53      | 2448.86  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 20 | 31   | 20260831    |           | 216895.88       | 11750.08      | 2330.31  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 21 | 30   | 20260930 |           | 204954.74       | 11941.14      | 2139.25  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 22 | 31   | 20261031   |           | 192963.2        | 11991.54      | 2088.85  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 23 | 30   | 20261130  |           | 180786.01       | 12177.19      | 1903.2   | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 24 | 31   | 20261231  |           | 168548.15       | 12237.86      | 1842.53  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 25 | 31   | 20270131   |           | 156185.57       | 12362.58      | 1717.81  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 26 | 28   | 20270228  |           | 143542.94       | 12642.63      | 1437.76  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 27 | 31   | 20270331     |           | 130925.51       | 12617.43      | 1462.96  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 28 | 30   | 20270430     |           | 118136.44       | 12789.07      | 1291.32  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 29 | 31   | 20270531       |           | 105260.07       | 12876.37      | 1204.02  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 30 | 30   | 20270630      |           | 92217.86        | 13042.21      | 1038.18  | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 31 | 31   | 20270731      |           | 79077.33        | 13140.53      | 939.86   | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 32 | 31   | 20270831    |           | 65802.88        | 13274.45      | 805.94   | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 33 | 30   | 20270930 |           | 52371.5         | 13431.38      | 649.01   | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 34 | 31   | 20271031   |           | 38824.87        | 13546.63      | 533.76   | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 35 | 30   | 20271130  |           | 25127.41        | 13697.46      | 382.93   | 0.0  | 0.0       | 14080.39 | 0.0  | 0.0        | 0.0  | 14080.39    |
      | 36 | 31   | 20271231  |           | 0.0             | 25127.41      | 256.09   | 0.0  | 0.0       | 25383.5  | 0.0  | 0.0        | 0.0  | 25383.5     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due       | Paid | In advance | Late | Outstanding |
      | 424036.08     | 94161.07 | 0.0  | 0.0       | 518197.15 | 0.0  | 0.0        | 0.0  | 518197.15   |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount    | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20241231 | Disbursement     | 424036.08 | 0.0       | 0.0      | 0.0  | 0.0       | 424036.08    |
    And Customer makes "AUTOPAY" repayment on "20250212" with 55284.0 EUR transaction amount
    Then Loan Repayment schedule has 36 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due      | Paid     | In advance | Late     | Outstanding |
      |    |      | 20241231  |                  | 424036.08       |               |          | 0.0  |           | 0.0      | 0.0      |            |          |             |
      | 1  | 31   | 20250131   | 20250212 | 414277.37       | 9758.71       | 4321.68  | 0.0  | 0.0       | 14080.39 | 14080.39 | 0.0        | 14080.39 | 0.0         |
      | 2  | 28   | 20250228  | 20250212 | 400196.98       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 3  | 31   | 20250331     | 20250212 | 386116.59       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 4  | 30   | 20250430     |                  | 372036.2        | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 13042.83 | 13042.83   | 0.0      | 1037.56     |
      | 5  | 31   | 20250531       |                  | 372036.2        | 0.0           | 14080.39 | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 6  | 30   | 20250630      |                  | 362474.64       | 9561.56       | 4518.83  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 7  | 31   | 20250731      |                  | 352196.54       | 10278.1       | 3802.29  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 8  | 31   | 20250831    |                  | 341918.44       | 10278.1       | 3802.29  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 9  | 30   | 20250930 |                  | 331517.68       | 10400.76      | 3679.63  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 10 | 31   | 20251031   |                  | 321239.58       | 10278.1       | 3802.29  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 11 | 30   | 20251130  |                  | 310838.82       | 10400.76      | 3679.63  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 12 | 31   | 20251231  |                  | 300560.72       | 10278.1       | 3802.29  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 13 | 31   | 20260131   |                  | 290282.62       | 10278.1       | 3802.29  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 14 | 28   | 20260228  |                  | 279500.46       | 10782.16      | 3298.23  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 15 | 31   | 20260331     |                  | 268268.68       | 11231.78      | 2848.61  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 16 | 30   | 20260430     |                  | 256834.23       | 11434.45      | 2645.94  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 17 | 31   | 20260531       |                  | 245371.44       | 11462.79      | 2617.6   | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 18 | 30   | 20260630      |                  | 233711.15       | 11660.29      | 2420.1   | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 19 | 31   | 20260731      |                  | 222012.69       | 11698.46      | 2381.93  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 20 | 31   | 20260831    |                  | 210195.0        | 11817.69      | 2262.7   | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 21 | 30   | 20260930 |                  | 198187.77       | 12007.23      | 2073.16  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 22 | 31   | 20261031   |                  | 186127.27       | 12060.5       | 2019.89  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 23 | 30   | 20261130  |                  | 173882.66       | 12244.61      | 1835.78  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 24 | 31   | 20261231  |                  | 161574.44       | 12308.22      | 1772.17  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 25 | 31   | 20270131   |                  | 149140.78       | 12433.66      | 1646.73  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 26 | 28   | 20270228  |                  | 136433.3        | 12707.48      | 1372.91  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 27 | 31   | 20270331     |                  | 123743.41       | 12689.89      | 1390.5   | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 28 | 30   | 20270430     |                  | 110883.5        | 12859.91      | 1220.48  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 29 | 31   | 20270531       |                  | 97933.21        | 12950.29      | 1130.1   | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 30 | 30   | 20270630      |                  | 84818.74        | 13114.47      | 965.92   | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 31 | 31   | 20270731      |                  | 71602.8         | 13215.94      | 864.45   | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 32 | 31   | 20270831    |                  | 58252.17        | 13350.63      | 729.76   | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 33 | 30   | 20270930 |                  | 44746.32        | 13505.85      | 574.54   | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 34 | 31   | 20271031   |                  | 31121.97        | 13624.35      | 456.04   | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 35 | 30   | 20271130  |                  | 17348.54        | 13773.43      | 306.96   | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 36 | 31   | 20271231  |                  | 0.0             | 17348.54      | 176.81   | 0.0  | 0.0       | 17525.35 | 0.0      | 0.0        | 0.0      | 17525.35    |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due      | Paid    | In advance | Late     | Outstanding |
      | 424036.08     | 86302.92 | 0.0  | 0.0       | 510339.0 | 55284.0 | 41203.61   | 14080.39 | 455055.0    |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount    | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20241231 | Disbursement     | 424036.08 | 0.0       | 0.0      | 0.0  | 0.0       | 424036.08    |
      | 20250212 | Repayment        | 55284.0   | 50962.32  | 4321.68  | 0.0  | 0.0       | 373073.76    |
    And Customer makes "AUTOPAY" repayment on "20250627" with 66605.0 EUR transaction amount
    Then Loan Repayment schedule has 36 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due      | Paid     | In advance | Late     | Outstanding |
      |    |      | 20241231  |                  | 424036.08       |               |          | 0.0  |           | 0.0      | 0.0      |            |          |             |
      | 1  | 31   | 20250131   | 20250212 | 414277.37       | 9758.71       | 4321.68  | 0.0  | 0.0       | 14080.39 | 14080.39 | 0.0        | 14080.39 | 0.0         |
      | 2  | 28   | 20250228  | 20250212 | 400196.98       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 3  | 31   | 20250331     | 20250212 | 386116.59       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 4  | 30   | 20250430     | 20250627     | 372036.2        | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 13042.83   | 1037.56  | 0.0         |
      | 5  | 31   | 20250531       | 20250627     | 372036.2        | 0.0           | 14080.39 | 0.0  | 0.0       | 14080.39 | 14080.39 | 0.0        | 14080.39 | 0.0         |
      | 6  | 30   | 20250630      | 20250627     | 357955.81       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 7  | 31   | 20250731      | 20250627     | 343875.42       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 8  | 31   | 20250831    | 20250627     | 329795.03       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 9  | 30   | 20250930 |                  | 329795.03       | 0.0           | 14080.39 | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 10 | 31   | 20251031   |                  | 319063.77       | 10731.26      | 3349.13  | 0.0  | 0.0       | 14080.39 | 9245.88  | 9245.88    | 0.0      | 4834.51     |
      | 11 | 30   | 20251130  |                  | 308144.96       | 10918.81      | 3161.58  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 12 | 31   | 20251231  |                  | 297331.54       | 10813.42      | 3266.97  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 13 | 31   | 20260131   |                  | 286518.12       | 10813.42      | 3266.97  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 14 | 28   | 20260228  |                  | 275332.6        | 11185.52      | 2894.87  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 15 | 31   | 20260331     |                  | 264058.34       | 11274.26      | 2806.13  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 16 | 30   | 20260430     |                  | 252582.36       | 11475.98      | 2604.41  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 17 | 31   | 20260531       |                  | 241076.23       | 11506.13      | 2574.26  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 18 | 30   | 20260630      |                  | 229373.58       | 11702.65      | 2377.74  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 19 | 31   | 20260731      |                  | 217630.92       | 11742.66      | 2337.73  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 20 | 31   | 20260831    |                  | 205768.58       | 11862.34      | 2218.05  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 21 | 30   | 20260930 |                  | 193717.69       | 12050.89      | 2029.5   | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 22 | 31   | 20261031   |                  | 181611.63       | 12106.06      | 1974.33  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 23 | 30   | 20261130  |                  | 169322.48       | 12289.15      | 1791.24  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 24 | 31   | 20261231  |                  | 156967.79       | 12354.69      | 1725.7   | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 25 | 31   | 20270131   |                  | 144487.18       | 12480.61      | 1599.78  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 26 | 28   | 20270228  |                  | 131736.86       | 12750.32      | 1330.07  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 27 | 31   | 20270331     |                  | 118999.1        | 12737.76      | 1342.63  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 28 | 30   | 20270430     |                  | 106092.4        | 12906.7       | 1173.69  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 29 | 31   | 20270531       |                  | 93093.28        | 12999.12      | 1081.27  | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 30 | 30   | 20270630      |                  | 79931.07        | 13162.21      | 918.18   | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 31 | 31   | 20270731      |                  | 66665.32        | 13265.75      | 814.64   | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 32 | 31   | 20270831    |                  | 53264.37        | 13400.95      | 679.44   | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 33 | 30   | 20270930 |                  | 39709.33        | 13555.04      | 525.35   | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 34 | 31   | 20271031   |                  | 26033.65        | 13675.68      | 404.71   | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 35 | 30   | 20271130  |                  | 12210.03        | 13823.62      | 256.77   | 0.0  | 0.0       | 14080.39 | 0.0      | 0.0        | 0.0      | 14080.39    |
      | 36 | 31   | 20271231  |                  | 0.0             | 12210.03      | 124.44   | 0.0  | 0.0       | 12334.47 | 0.0      | 0.0        | 0.0      | 12334.47    |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due       | Paid     | In advance | Late     | Outstanding |
      | 424036.08     | 81112.04 | 0.0  | 0.0       | 505148.12 | 121889.0 | 92690.66   | 29198.34 | 383259.12   |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount    | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20241231 | Disbursement     | 424036.08 | 0.0       | 0.0      | 0.0  | 0.0       | 424036.08    |
      | 20250212 | Repayment        | 55284.0   | 50962.32  | 4321.68  | 0.0  | 0.0       | 373073.76    |
      | 20250627     | Repayment        | 66605.0   | 52524.61  | 14080.39 | 0.0  | 0.0       | 320549.15    |
    When Loan Pay-off is made on "20250820"
    Then Loan Repayment schedule has 36 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due      | Paid     | In advance | Late     | Outstanding |
      |    |      | 20241231  |                  | 424036.08       |               |          | 0.0  |           | 0.0      | 0.0      |            |          |             |
      | 1  | 31   | 20250131   | 20250212 | 414277.37       | 9758.71       | 4321.68  | 0.0  | 0.0       | 14080.39 | 14080.39 | 0.0        | 14080.39 | 0.0         |
      | 2  | 28   | 20250228  | 20250212 | 400196.98       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 3  | 31   | 20250331     | 20250212 | 386116.59       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 4  | 30   | 20250430     | 20250627     | 372036.2        | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 13042.83   | 1037.56  | 0.0         |
      | 5  | 31   | 20250531       | 20250627     | 372036.2        | 0.0           | 14080.39 | 0.0  | 0.0       | 14080.39 | 14080.39 | 0.0        | 14080.39 | 0.0         |
      | 6  | 30   | 20250630      | 20250627     | 357955.81       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 7  | 31   | 20250731      | 20250627     | 343875.42       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 8  | 31   | 20250831    | 20250627     | 329795.03       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 9  | 30   | 20250930 | 20250820   | 315714.64       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 10 | 31   | 20251031   | 20250820   | 301634.25       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 11 | 30   | 20251130  | 20250820   | 287553.86       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 12 | 31   | 20251231  | 20250820   | 273473.47       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 13 | 31   | 20260131   | 20250820   | 259393.08       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 14 | 28   | 20260228  | 20250820   | 245312.69       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 15 | 31   | 20260331     | 20250820   | 231232.3        | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 16 | 30   | 20260430     | 20250820   | 217151.91       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 17 | 31   | 20260531       | 20250820   | 203071.52       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 18 | 30   | 20260630      | 20250820   | 188991.13       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 19 | 31   | 20260731      | 20250820   | 174910.74       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 20 | 31   | 20260831    | 20250820   | 160830.35       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 21 | 30   | 20260930 | 20250820   | 146749.96       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 22 | 31   | 20261031   | 20250820   | 132669.57       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 23 | 30   | 20261130  | 20250820   | 118589.18       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 24 | 31   | 20261231  | 20250820   | 104508.79       | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 25 | 31   | 20270131   | 20250820   | 90428.4         | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 26 | 28   | 20270228  | 20250820   | 76348.01        | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 27 | 31   | 20270331     | 20250820   | 62267.62        | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 28 | 30   | 20270430     | 20250820   | 48187.23        | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 29 | 31   | 20270531       | 20250820   | 34106.84        | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 30 | 30   | 20270630      | 20250820   | 20026.45        | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 31 | 31   | 20270731      | 20250820   | 5946.06         | 14080.39      | 0.0      | 0.0  | 0.0       | 14080.39 | 14080.39 | 14080.39   | 0.0      | 0.0         |
      | 32 | 31   | 20270831    | 20250820   | 0.0             | 5946.06       | 0.0      | 0.0  | 0.0       | 5946.06  | 5946.06  | 5946.06    | 0.0      | 0.0         |
      | 33 | 30   | 20270930 | 20250820   | 0.0             | 0.0           | 9841.72  | 0.0  | 0.0       | 9841.72  | 9841.72  | 9841.72    | 0.0      | 0.0         |
      | 34 | 31   | 20271031   | 20250820   | 0.0             | 0.0           | 0.0      | 0.0  | 0.0       | 0.0      | 0.0      | 0.0        | 0.0      | 0.0         |
      | 35 | 30   | 20271130  | 20250820   | 0.0             | 0.0           | 0.0      | 0.0  | 0.0       | 0.0      | 0.0      | 0.0        | 0.0      | 0.0         |
      | 36 | 31   | 20271231  | 20250820   | 0.0             | 0.0           | 0.0      | 0.0  | 0.0       | 0.0      | 0.0      | 0.0        | 0.0      | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due       | Paid      | In advance | Late     | Outstanding |
      | 424036.08     | 28243.79 | 0.0  | 0.0       | 452279.87 | 452279.87 | 423081.53  | 29198.34 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount    | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20241231 | Disbursement     | 424036.08 | 0.0       | 0.0      | 0.0  | 0.0       | 424036.08    |
      | 20250212 | Repayment        | 55284.0   | 50962.32  | 4321.68  | 0.0  | 0.0       | 373073.76    |
      | 20250627     | Repayment        | 66605.0   | 52524.61  | 14080.39 | 0.0  | 0.0       | 320549.15    |
      | 20250820   | Repayment        | 330390.87 | 320549.15 | 9841.72  | 0.0  | 0.0       | 0.0          |
      | 20260223 | Accrual          | 28243.79  | 0.0       | 28243.79 | 0.0  | 0.0       | 0.0          |
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    When Admin set "LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_VERTICAL_INTEREST_RECALC" loan product "REPAYMENT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C80938
  Scenario: Disbursement with EMI smaller than installmentAmountInMultiplesOf=10 distributes residual across installments instead of collapsing onto one
    When Admin sets the business date to "20251026"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with loan product`s charges and following data:
      | LoanProduct                            | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_ZERO_INTEREST_MULT_OF_10 | 20251026   | 30             | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20251026" with "30" amount and expected disbursement date on "20251026"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |           | 30.0            |               |          | 0.0  |           | 0.0  |      |            |      | 0.0         |
      | 1  | 31   | 20251126 |           | 20.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 2  | 30   | 20251226 |           | 10.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 3  | 31   | 20260126  |           | 0.0             | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 30.0          | 0.0      | 0.0  | 0.0       | 30.0 | 0.0  | 0.0        | 0.0  | 30.0        |
    When Admin successfully disburse the loan on "20251026" with "4" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |           | 4.0             |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 31   | 20251126 |           | 2.67            | 1.33          | 0.0      | 0.0  | 0.0       | 1.33 | 0.0  | 0.0        | 0.0  | 1.33        |
      | 2  | 30   | 20251226 |           | 1.34            | 1.33          | 0.0      | 0.0  | 0.0       | 1.33 | 0.0  | 0.0        | 0.0  | 1.33        |
      | 3  | 31   | 20260126  |           | 0.0             | 1.34          | 0.0      | 0.0  | 0.0       | 1.34 | 0.0  | 0.0        | 0.0  | 1.34        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      | 4.0           | 0.0      | 0.0  | 0.0       | 4.0 | 0.0  | 0.0        | 0.0  | 4.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20251026  | Disbursement     | 4.0    | 0.0       | 0.0      | 0.0  | 0.0       | 4.0          | false    | false    |
    When Admin sets the business date to "20251027"
    When Loan Pay-off is made on "20251027"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |                 | 4.0             |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 31   | 20251126 | 20251027 | 2.67            | 1.33          | 0.0      | 0.0  | 0.0       | 1.33 | 1.33 | 1.33       | 0.0  | 0.0         |
      | 2  | 30   | 20251226 | 20251027 | 1.34            | 1.33          | 0.0      | 0.0  | 0.0       | 1.33 | 1.33 | 1.33       | 0.0  | 0.0         |
      | 3  | 31   | 20260126  | 20251027 | 0.0             | 1.34          | 0.0      | 0.0  | 0.0       | 1.34 | 1.34 | 1.34       | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      | 4.0           | 0.0      | 0.0  | 0.0       | 4.0 | 4.0  | 4.0        | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20251026  | Disbursement     | 4.0    | 0.0       | 0.0      | 0.0  | 0.0       | 4.0          | false    | false    |
      | 20251027  | Repayment        | 4.0    | 4.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C80939
  Scenario: Multi-tranche progressive disbursement with both sub-multiplesOf tranches distributes residual across all installments
    When Admin sets the business date to "20251026"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with loan product`s charges and following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_ZERO_INTEREST_CHARGE_OFF_BEHAVIOUR | 20251026   | 3              | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20251026" with "3" amount and expected disbursement date on "20251026"
    # First tranche - 0.5 EUR triggers sub-multiplesOf EMI branch
    When Admin successfully disburse the loan on "20251026" with "0.5" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |           | 0.5             |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 31   | 20251126 |           | 0.33            | 0.17          | 0.0      | 0.0  | 0.0       | 0.17 | 0.0  | 0.0        | 0.0  | 0.17        |
      | 2  | 30   | 20251226 |           | 0.16            | 0.17          | 0.0      | 0.0  | 0.0       | 0.17 | 0.0  | 0.0        | 0.0  | 0.17        |
      | 3  | 31   | 20260126  |           | 0.0             | 0.16          | 0.0      | 0.0  | 0.0       | 0.16 | 0.0  | 0.0        | 0.0  | 0.16        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      | 0.5           | 0.0      | 0.0  | 0.0       | 0.5 | 0.0  | 0.0        | 0.0  | 0.5         |
    # Second tranche on the same day - additional 0.4 EUR, cumulative outstanding 0.9 EUR. New EMI = 0.30 across all installments.
    When Admin successfully disburse the loan on "20251026" with "0.4" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |           | 0.5             |               |          | 0.0  |           | 0.0 | 0.0  |            |      |             |
      |    |      | 20251026  |           | 0.4             |               |          | 0.0  |           | 0.0 | 0.0  |            |      |             |
      | 1  | 31   | 20251126 |           | 0.6             | 0.3           | 0.0      | 0.0  | 0.0       | 0.3 | 0.0  | 0.0        | 0.0  | 0.3         |
      | 2  | 30   | 20251226 |           | 0.3             | 0.3           | 0.0      | 0.0  | 0.0       | 0.3 | 0.0  | 0.0        | 0.0  | 0.3         |
      | 3  | 31   | 20260126  |           | 0.0             | 0.3           | 0.0      | 0.0  | 0.0       | 0.3 | 0.0  | 0.0        | 0.0  | 0.3         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      | 0.9           | 0.0      | 0.0  | 0.0       | 0.9 | 0.0  | 0.0        | 0.0  | 0.9         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20251026  | Disbursement     | 0.5    | 0.0       | 0.0      | 0.0  | 0.0       | 0.5          | false    | false    |
      | 20251026  | Disbursement     | 0.4    | 0.0       | 0.0      | 0.0  | 0.0       | 0.9          | false    | false    |
    When Admin sets the business date to "20251027"
    When Loan Pay-off is made on "20251027"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |                 | 0.5             |               |          | 0.0  |           | 0.0 | 0.0  |            |      |             |
      |    |      | 20251026  |                 | 0.4             |               |          | 0.0  |           | 0.0 | 0.0  |            |      |             |
      | 1  | 31   | 20251126 | 20251027 | 0.6             | 0.3           | 0.0      | 0.0  | 0.0       | 0.3 | 0.3  | 0.3        | 0.0  | 0.0         |
      | 2  | 30   | 20251226 | 20251027 | 0.3             | 0.3           | 0.0      | 0.0  | 0.0       | 0.3 | 0.3  | 0.3        | 0.0  | 0.0         |
      | 3  | 31   | 20260126  | 20251027 | 0.0             | 0.3           | 0.0      | 0.0  | 0.0       | 0.3 | 0.3  | 0.3        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      | 0.9           | 0.0      | 0.0  | 0.0       | 0.9 | 0.9  | 0.9        | 0.0  | 0.0         |
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
