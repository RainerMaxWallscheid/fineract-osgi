Feature: MerchantIssuedRefund

  @TestRailId:C3731
  Scenario: Merchant Issued Refund reverse replayed with penalty charge and interest recalculation
    When Admin sets the business date to "20250422"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250422     | 187.99         | 11.3                   | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250422" with "187.99" amount and expected disbursement date on "20250422"
    When Admin successfully disburse the loan on "20250422" with "187.99" EUR transaction amount
    When Admin sets the business date to "20250429"
    When Customer makes "REPAYMENT" transaction with "REAL_TIME" payment type on "20250429" with 12 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20250522"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250522" with 63.85 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20250528"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250528" with 187.99 EUR transaction amount and system-generated Idempotency key
    When Customer undo "2"th repayment on "20250528"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20250528" due date and 2.80 EUR transaction amount
    Then Loan status will be "OVERPAID"
    And Loan has 9.2 overpaid amount
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |  Reverted | Replayed |
      | 20250422    | Disbursement           | 187.99 | 0.0       | 0.0      | 0.0  | 0.0       | 187.99       | false     | false    |
      | 20250429    | Repayment              | 12.0   | 11.59     | 0.41     | 0.0  | 0.0       | 176.4        | false     | false    |
      | 20250522      | Repayment              | 63.85  | 62.57     | 1.28     | 0.0  | 0.0       | 113.83       | true      | false    |
      | 20250522      | Accrual Activity       | 1.69   | 0.0       | 1.69     | 0.0  | 0.0       | 0.0          | false     | false    |
      | 20250528      | Accrual                | 1.9    | 0.0       | 1.9      | 0.0  | 0.0       | 0.0          | false     | false    |
      | 20250528      | Interest Refund        | 2.01   | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false     | true     |
      | 20250528      | Accrual                | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false     | false    |
      | 20250528      | Merchant Issued Refund | 187.99 | 176.4     | 1.6      | 0.0  | 2.8       | 0.0          | false     | true     |
      | 20250528      | Accrual Activity       | 3.12   | 0.0       | 0.32     | 0.0  | 2.8       | 0.0          | false     | true     |
      | 20250528      | Accrual                | 2.8    | 0.0       | 0.0      | 0.0  | 2.8       | 0.0          | false     | false    |

  @TestRailId:C3774
  Scenario: Verify that the MIR works correctly when last installment principal got updated to null - 360/30
    When Admin sets the business date to "20241109"
    And Admin creates a client with random data
    And Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_INT_RECALCULATION_ZERO_INT_CHARGE_OFF_INT_RECOGNITION_FROM_DISB_DATE" loan product "MERCHANT_ISSUED_REFUND" transaction type to "LAST_INSTALLMENT" future installment allocation rule
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INT_RECALCULATION_ZERO_INT_CHARGE_OFF_INT_RECOGNITION_FROM_DISB_DATE | 20241109  | 600            | 11.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20241109" with "600" amount and expected disbursement date on "20241109"
    And Admin successfully disburse the loan on "20241109" with "600" EUR transaction amount
    And Admin sets the business date to "20250609"
    And Customer makes "AUTOPAY" repayment on "20250609" with 10 EUR transaction amount
    And Admin sets the business date to "20250610"
    And Admin does charge-off the loan on "20250610"
    And Customer makes "AUTOPAY" repayment on "20250609" with 187.68 EUR transaction amount
    Then Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250610" with 100 EUR transaction amount and system-generated Idempotency key
    And Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_INT_RECALCULATION_ZERO_INT_CHARGE_OFF_INT_RECOGNITION_FROM_DISB_DATE" loan product "MERCHANT_ISSUED_REFUND" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C3775
  Scenario: Verify that the MIR works correctly when last installment principal got updated to null - Actual/Actual
    When Admin sets the business date to "20241109"
    And Admin creates a client with random data
    And Admin set "LP2_ADV_PYMNT_INT_DAILY_EMI_ACTUAL_ACTUAL_INT_REFUND_FULL_ZERO_INT_CHARGE_OFF" loan product "MERCHANT_ISSUED_REFUND" transaction type to "LAST_INSTALLMENT" future installment allocation rule
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INT_DAILY_EMI_ACTUAL_ACTUAL_INT_REFUND_FULL_ZERO_INT_CHARGE_OFF | 20241109  | 600            | 11.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20241109" with "600" amount and expected disbursement date on "20241109"
    And Admin successfully disburse the loan on "20241109" with "600" EUR transaction amount
    And Admin sets the business date to "20250609"
    And Customer makes "AUTOPAY" repayment on "20250609" with 10 EUR transaction amount
    And Admin sets the business date to "20250610"
    And Admin does charge-off the loan on "20250610"
    And Customer makes "AUTOPAY" repayment on "20250609" with 187.68 EUR transaction amount
    Then Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250610" with 100 EUR transaction amount and system-generated Idempotency key
    And Admin set "LP2_ADV_PYMNT_INT_DAILY_EMI_ACTUAL_ACTUAL_INT_REFUND_FULL_ZERO_INT_CHARGE_OFF" loan product "MERCHANT_ISSUED_REFUND" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C3842
  Scenario: Merchant Issued Refund with interestRefundCalculation = false (Interest Refund transaction should NOT be created)
    When Admin sets the business date to "20240701"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240701      | 1000           | 10                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240701" with "1000" amount and expected disbursement date on "20240701"
    And Admin successfully disburse the loan on "20240701" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240701      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240801    |           | 669.43          | 330.57        | 8.33     | 0.0  | 0.0       | 338.9  | 0.0  | 0.0        | 0.0  | 338.9       |
      | 2  | 31   | 20240901 |           | 336.11          | 333.32        | 5.58     | 0.0  | 0.0       | 338.9  | 0.0  | 0.0        | 0.0  | 338.9       |
      | 3  | 30   | 20241001   |           | 0.0             | 336.11        | 2.8      | 0.0  | 0.0       | 338.91 | 0.0  | 0.0        | 0.0  | 338.91      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 16.71    | 0.0  | 0.0       | 1016.71 | 0.0  | 0.0        | 0.0  | 1016.71     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Admin sets the business date to "20240710"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240710" with 338.9 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20240715"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240715" with 50 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation false
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240701      |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20240801    | 20240710 | 663.52          | 336.48        | 2.42     | 0.0  | 0.0       | 338.9  | 338.9 | 338.9      | 0.0  | 0.0         |
      | 2  | 31   | 20240901 |              | 333.42          | 330.1         | 8.8      | 0.0  | 0.0       | 338.9  | 0.0   | 0.0        | 0.0  | 338.9       |
      | 3  | 30   | 20241001   |              | 0.0             | 333.42        | 2.36     | 0.0  | 0.0       | 335.78 | 50.0  | 50.0       | 0.0  | 285.78      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 13.58    | 0.0  | 0.0       | 1013.58 | 388.9  | 388.9      | 0.0  | 624.68      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240710     | Repayment              | 338.9  | 336.48    | 2.42     | 0.0  | 0.0       | 663.52       | false    | false    |
      | 20240715     | Merchant Issued Refund | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 613.52       | false    | false    |

  @TestRailId:C3843
  Scenario: Merchant Issued Refund with interestRefundCalculation = true (Interest Refund transaction SHOULD be created)
    When Admin sets the business date to "20240701"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240701      | 1000           | 10                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240701" with "1000" amount and expected disbursement date on "20240701"
    And Admin successfully disburse the loan on "20240701" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240701      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240801    |           | 669.43          | 330.57        | 8.33     | 0.0  | 0.0       | 338.9  | 0.0  | 0.0        | 0.0  | 338.9       |
      | 2  | 31   | 20240901 |           | 336.11          | 333.32        | 5.58     | 0.0  | 0.0       | 338.9  | 0.0  | 0.0        | 0.0  | 338.9       |
      | 3  | 30   | 20241001   |           | 0.0             | 336.11        | 2.8      | 0.0  | 0.0       | 338.91 | 0.0  | 0.0        | 0.0  | 338.91      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 16.71    | 0.0  | 0.0       | 1016.71 | 0.0  | 0.0        | 0.0  | 1016.71     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Admin sets the business date to "20240710"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240710" with 338.9 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20240715"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240715" with 50 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation true
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240701      |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20240801    | 20240710 | 663.52          | 336.48        | 2.42     | 0.0  | 0.0       | 338.9  | 338.9 | 338.9      | 0.0  | 0.0         |
      | 2  | 31   | 20240901 |              | 333.42          | 330.1         | 8.8      | 0.0  | 0.0       | 338.9  | 0.19  | 0.19       | 0.0  | 338.71      |
      | 3  | 30   | 20241001   |              | 0.0             | 333.42        | 2.36     | 0.0  | 0.0       | 335.78 | 50.0  | 50.0       | 0.0  | 285.78      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 13.58    | 0.0  | 0.0       | 1013.58 | 389.09 | 389.09     | 0.0  | 624.49      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240710     | Repayment              | 338.9  | 336.48    | 2.42     | 0.0  | 0.0       | 663.52       | false    | false    |
      | 20240715     | Merchant Issued Refund | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 613.52       | false    | false    |
      | 20240715     | Interest Refund        | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 613.52       | false    | false    |

  @TestRailId:C3844
  Scenario: Merchant Issued Refund without interestRefundCalculation (should fallback to loan product config)
    When Admin sets the business date to "20240701"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240701      | 1000           | 10                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240701" with "1000" amount and expected disbursement date on "20240701"
    And Admin successfully disburse the loan on "20240701" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240701      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240801    |           | 669.43          | 330.57        | 8.33     | 0.0  | 0.0       | 338.9  | 0.0  | 0.0        | 0.0  | 338.9       |
      | 2  | 31   | 20240901 |           | 336.11          | 333.32        | 5.58     | 0.0  | 0.0       | 338.9  | 0.0  | 0.0        | 0.0  | 338.9       |
      | 3  | 30   | 20241001   |           | 0.0             | 336.11        | 2.8      | 0.0  | 0.0       | 338.91 | 0.0  | 0.0        | 0.0  | 338.91      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 16.71    | 0.0  | 0.0       | 1016.71 | 0.0  | 0.0        | 0.0  | 1016.71     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Admin sets the business date to "20240710"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240710" with 338.9 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20240715"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240715" with 50 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240701      |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20240801    | 20240710 | 663.52          | 336.48        | 2.42     | 0.0  | 0.0       | 338.9  | 338.9 | 338.9      | 0.0  | 0.0         |
      | 2  | 31   | 20240901 |              | 333.42          | 330.1         | 8.8      | 0.0  | 0.0       | 338.9  | 0.19  | 0.19       | 0.0  | 338.71      |
      | 3  | 30   | 20241001   |              | 0.0             | 333.42        | 2.36     | 0.0  | 0.0       | 335.78 | 50.0  | 50.0       | 0.0  | 285.78      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 13.58    | 0.0  | 0.0       | 1013.58 | 389.09 | 389.09     | 0.0  | 624.49      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240710     | Repayment              | 338.9  | 336.48    | 2.42     | 0.0  | 0.0       | 663.52       | false    | false    |
      | 20240715     | Merchant Issued Refund | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 613.52       | false    | false    |
      | 20240715     | Interest Refund        | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 613.52       | false    | false    |

  @TestRailId:C3854
  Scenario: Verify reversal of Merchant Issued Refund when interestRefundCalculation=false (no Interest Refund to reverse)
    When Admin sets the business date to "20240701"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240701      | 1000           | 10                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240701" with "1000" amount and expected disbursement date on "20240701"
    And Admin successfully disburse the loan on "20240701" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240701      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240801    |           | 669.43          | 330.57        | 8.33     | 0.0  | 0.0       | 338.9  | 0.0  | 0.0        | 0.0  | 338.9       |
      | 2  | 31   | 20240901 |           | 336.11          | 333.32        | 5.58     | 0.0  | 0.0       | 338.9  | 0.0  | 0.0        | 0.0  | 338.9       |
      | 3  | 30   | 20241001   |           | 0.0             | 336.11        | 2.8      | 0.0  | 0.0       | 338.91 | 0.0  | 0.0        | 0.0  | 338.91      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 16.71    | 0.0  | 0.0       | 1016.71 | 0.0  | 0.0        | 0.0  | 1016.71     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Admin sets the business date to "20240715"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240715" with 50 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation false
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240701      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240801    |           | 669.2           | 330.8         | 8.1      | 0.0  | 0.0       | 338.9  | 0.0  |  0.0       | 0.0  | 338.9       |
      | 2  | 31   | 20240901 |           | 335.46          | 333.74        | 5.16     | 0.0  | 0.0       | 338.9  | 0.0  | 0.0        | 0.0  | 338.9       |
      | 3  | 30   | 20241001   |           | 0.0             | 335.46        | 2.38     | 0.0  | 0.0       | 337.84 | 50.0 | 50.0       | 0.0  | 287.84      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 15.64    | 0.0  | 0.0       | 1015.64 | 50.0 | 50.0       | 0.0  | 965.64      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240715     | Merchant Issued Refund | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 950.0        | false    | false    |
    When Customer undo "1"th "Merchant Issued Refund" transaction made on "20240715"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240701      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240801    |           | 669.43          | 330.57        | 8.33     | 0.0  | 0.0       | 338.9  | 0.0  | 0.0        | 0.0  | 338.9       |
      | 2  | 31   | 20240901 |           | 336.11          | 333.32        | 5.58     | 0.0  | 0.0       | 338.9  | 0.0  | 0.0        | 0.0  | 338.9       |
      | 3  | 30   | 20241001   |           | 0.0             | 336.11        | 2.8      | 0.0  | 0.0       | 338.91 | 0.0  | 0.0        | 0.0  | 338.91      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 16.71    | 0.0  | 0.0       | 1016.71 | 0.0  | 0.0        | 0.0  | 1016.71     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240715     | Merchant Issued Refund | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 950.0        | true     | false    |

  @TestRailId:C3855
  Scenario: Multiple refunds on same loan with different interestRefundCalculation settings
    When Admin sets the business date to "20240701"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240701      | 1000           | 10                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240701" with "1000" amount and expected disbursement date on "20240701"
    And Admin successfully disburse the loan on "20240701" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240701      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240801    |           | 669.43          | 330.57        | 8.33     | 0.0  | 0.0       | 338.9  | 0.0  | 0.0        | 0.0  | 338.9       |
      | 2  | 31   | 20240901 |           | 336.11          | 333.32        | 5.58     | 0.0  | 0.0       | 338.9  | 0.0  | 0.0        | 0.0  | 338.9       |
      | 3  | 30   | 20241001   |           | 0.0             | 336.11        | 2.8      | 0.0  | 0.0       | 338.91 | 0.0  | 0.0        | 0.0  | 338.91      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 16.71    | 0.0  | 0.0       | 1016.71 | 0.0  | 0.0        | 0.0  | 1016.71     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Admin sets the business date to "20240710"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240710" with 30 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation true
    And Customer makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20240710" with 20 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation false
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240701      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20240801    |           | 669.14          | 330.86        | 8.04     | 0.0  | 0.0       | 338.9  | 20.07 | 20.07      | 0.0  | 318.83      |
      | 2  | 31   | 20240901 |           | 335.57          | 333.57        | 5.33     | 0.0  | 0.0       | 338.9  | 0.0   | 0.0        | 0.0  | 338.9       |
      | 3  | 30   | 20241001   |           | 0.0             | 335.57        | 2.55     | 0.0  | 0.0       | 338.12 | 30.0  | 30.0       | 0.0  | 308.12      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 15.92    | 0.0  | 0.0       | 1015.92 | 50.07 | 50.07      | 0.0  | 965.85      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240710     | Merchant Issued Refund | 30.0   | 30.0      | 0.0      | 0.0  | 0.0       | 970.0        | false    | false    |
      | 20240710     | Interest Refund        | 0.07   | 0.0       | 0.07     | 0.0  | 0.0       | 970.0        | false    | false    |
      | 20240710     | Payout Refund          | 20.0   | 20.0      | 0.0      | 0.0  | 0.0       | 950.0        | false    | false    |

  @TestRailId:C3856
  Scenario: Merchant Issued Refund on fully paid loan with interestRefundCalculation variations
    When Admin sets the business date to "20240701"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240701      | 1000           | 10                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240701" with "1000" amount and expected disbursement date on "20240701"
    And Admin successfully disburse the loan on "20240701" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240701   |           | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240801 |           | 0.0             | 1000.0        | 8.33     | 0.0  | 0.0       | 1008.33 | 0.0  | 0.0        | 0.0  | 1008.33     |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 8.33     | 0.0  | 0.0       | 1008.33 | 0.0  | 0.0        | 0.0  | 1008.33     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Admin sets the business date to "20240801"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240801" with 1008.33 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      |    |      | 20240701   |                | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0     |            |      |             |
      | 1  | 31   | 20240801 | 20240801 | 0.0             | 1000.0        | 8.33     | 0.0  | 0.0       | 1008.33 | 1008.33 | 0.0        | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 1000.0        | 8.33     | 0.0  | 0.0       | 1008.33 | 1008.33 | 0.0        | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement     | 1000.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240801   | Repayment        | 1008.33 | 1000.0    | 8.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240801   | Accrual          | 8.33    | 0.0       | 8.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240801   | Accrual Activity | 8.33    | 0.0       | 8.33     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Loan status will be "CLOSED_OBLIGATIONS_MET"
    When Admin sets the business date to "20240805"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240805" with 10 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation false
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      |    |      | 20240701   |                | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0     |            |      |             |
      | 1  | 31   | 20240801 | 20240801 | 0.0             | 1000.0        | 8.33     | 0.0  | 0.0       | 1008.33 | 1008.33 | 0.0        | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 1000.0        | 8.33     | 0.0  | 0.0       | 1008.33 | 1008.33 | 0.0        | 0.0  | 0.0         |
    #verify that "Interest Refund" transaction is not created
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement           | 1000.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240801   | Repayment              | 1008.33 | 1000.0    | 8.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240801   | Accrual                | 8.33    | 0.0       | 8.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240801   | Accrual Activity       | 8.33    | 0.0       | 8.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240805   | Merchant Issued Refund | 10.0    | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan status will be "OVERPAID"

  @TestRailId:C3873
  Scenario: Manual Interest Refund creation for Merchant Issued Refund with interestRefundCalculation = false
    When Admin sets the business date to "20240701"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240701      | 1000           | 10                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240701" with "1000" amount and expected disbursement date on "20240701"
    And Admin successfully disburse the loan on "20240701" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240701      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240801    |           | 669.43          | 330.57        | 8.33     | 0.0  | 0.0       | 338.9  | 0.0  | 0.0        | 0.0  | 338.9       |
      | 2  | 31   | 20240901 |           | 336.11          | 333.32        | 5.58     | 0.0  | 0.0       | 338.9  | 0.0  | 0.0        | 0.0  | 338.9       |
      | 3  | 30   | 20241001   |           | 0.0             | 336.11        | 2.8      | 0.0  | 0.0       | 338.91 | 0.0  | 0.0        | 0.0  | 338.91      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 16.71    | 0.0  | 0.0       | 1016.71 | 0.0  | 0.0        | 0.0  | 1016.71     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Admin sets the business date to "20240710"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240710" with 338.9 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20240715"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240715" with 50 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation false
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240701      |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20240801    | 20240710 | 663.52          | 336.48        | 2.42     | 0.0  | 0.0       | 338.9  | 338.9 | 338.9      | 0.0  | 0.0         |
      | 2  | 31   | 20240901 |              | 333.42          | 330.1         | 8.8      | 0.0  | 0.0       | 338.9  | 0.0   | 0.0        | 0.0  | 338.9       |
      | 3  | 30   | 20241001   |              | 0.0             | 333.42        | 2.36     | 0.0  | 0.0       | 335.78 | 50.0  | 50.0       | 0.0  | 285.78      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 13.58    | 0.0  | 0.0       | 1013.58 | 388.9  | 388.9      | 0.0  | 624.68      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240710     | Repayment              | 338.9  | 336.48    | 2.42     | 0.0  | 0.0       | 663.52       | false    | false    |
      | 20240715     | Merchant Issued Refund | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 613.52       | false    | false    |
    When Admin manually adds Interest Refund for "MERCHANT_ISSUED_REFUND" transaction made on "20240715" with 0.19 EUR interest refund amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240701      |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20240801    | 20240710 | 663.52          | 336.48        | 2.42     | 0.0  | 0.0       | 338.9  | 338.9 | 338.9      | 0.0  | 0.0         |
      | 2  | 31   | 20240901 |              | 333.42          | 330.1         | 8.8      | 0.0  | 0.0       | 338.9  | 0.19  | 0.19       | 0.0  | 338.71      |
      | 3  | 30   | 20241001   |              | 0.0             | 333.42        | 2.36     | 0.0  | 0.0       | 335.78 | 50.0  | 50.0       | 0.0  | 285.78      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 13.58    | 0.0  | 0.0       | 1013.58 | 389.09 | 389.09     | 0.0  | 624.49      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240710     | Repayment              | 338.9  | 336.48    | 2.42     | 0.0  | 0.0       | 663.52       | false    | false    |
      | 20240715     | Merchant Issued Refund | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 613.52       | false    | false    |
      | 20240715     | Interest Refund        | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 613.52       | false    | false    |
    Then Loan Transactions tab has a "MERCHANT_ISSUED_REFUND" transaction with date "20240715" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 50.0   |
      | LIABILITY | 145023       | Suspense/Clearing account | 50.0  |        |
    Then Loan Transactions tab has a "INTEREST_REFUND" transaction with date "20240715" which has the following Journal entries:
      | Type   | Account code | Account name            | Debit | Credit |
      | ASSET  | 112603       | Interest/Fee Receivable |       | 0.19   |
      | INCOME | 404000       | Interest Income         | 0.19  |        |

  @TestRailId:C3874
  Scenario: Undo Merchant Issued Refund with manual Interest Refund, both transactions are reversed
    When Admin sets the business date to "20240701"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240701      | 1000           | 10                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240701" with "1000" amount and expected disbursement date on "20240701"
    And Admin successfully disburse the loan on "20240701" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240701      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240801    |           | 669.43          | 330.57        | 8.33     | 0.0  | 0.0       | 338.9  | 0.0  | 0.0        | 0.0  | 338.9       |
      | 2  | 31   | 20240901 |           | 336.11          | 333.32        | 5.58     | 0.0  | 0.0       | 338.9  | 0.0  | 0.0        | 0.0  | 338.9       |
      | 3  | 30   | 20241001   |           | 0.0             | 336.11        | 2.8      | 0.0  | 0.0       | 338.91 | 0.0  | 0.0        | 0.0  | 338.91      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 16.71    | 0.0  | 0.0       | 1016.71 | 0.0  | 0.0        | 0.0  | 1016.71     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Admin sets the business date to "20240710"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240710" with 338.9 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20240715"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240715" with 50 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation false
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240701      |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20240801    | 20240710 | 663.52          | 336.48        | 2.42     | 0.0  | 0.0       | 338.9  | 338.9 | 338.9      | 0.0  | 0.0         |
      | 2  | 31   | 20240901 |              | 333.42          | 330.1         | 8.8      | 0.0  | 0.0       | 338.9  | 0.0   | 0.0        | 0.0  | 338.9       |
      | 3  | 30   | 20241001   |              | 0.0             | 333.42        | 2.36     | 0.0  | 0.0       | 335.78 | 50.0  | 50.0       | 0.0  | 285.78      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 13.58    | 0.0  | 0.0       | 1013.58 | 388.9  | 388.9      | 0.0  | 624.68      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240710     | Repayment              | 338.9  | 336.48    | 2.42     | 0.0  | 0.0       | 663.52       | false    | false    |
      | 20240715     | Merchant Issued Refund | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 613.52       | false    | false    |
    When Admin manually adds Interest Refund for "MERCHANT_ISSUED_REFUND" transaction made on "20240715" with 0.19 EUR interest refund amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240701      |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20240801    | 20240710 | 663.52          | 336.48        | 2.42     | 0.0  | 0.0       | 338.9  | 338.9 | 338.9      | 0.0  | 0.0         |
      | 2  | 31   | 20240901 |              | 333.42          | 330.1         | 8.8      | 0.0  | 0.0       | 338.9  | 0.19  | 0.19       | 0.0  | 338.71      |
      | 3  | 30   | 20241001   |              | 0.0             | 333.42        | 2.36     | 0.0  | 0.0       | 335.78 | 50.0  | 50.0       | 0.0  | 285.78      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 13.58    | 0.0  | 0.0       | 1013.58 | 389.09 | 389.09     | 0.0  | 624.49      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240710     | Repayment              | 338.9  | 336.48    | 2.42     | 0.0  | 0.0       | 663.52       | false    | false    |
      | 20240715     | Merchant Issued Refund | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 613.52       | false    | false    |
      | 20240715     | Interest Refund        | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 613.52       | false    | false    |
    Then Loan Transactions tab has a "MERCHANT_ISSUED_REFUND" transaction with date "20240715" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 50.0   |
      | LIABILITY | 145023       | Suspense/Clearing account | 50.0  |        |
    Then Loan Transactions tab has a "INTEREST_REFUND" transaction with date "20240715" which has the following Journal entries:
      | Type   | Account code | Account name            | Debit | Credit |
      | ASSET  | 112603       | Interest/Fee Receivable |       | 0.19   |
      | INCOME | 404000       | Interest Income         | 0.19  |        |
    When Customer undo "1"th transaction made on "20240715"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240701      |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20240801    | 20240710 | 663.52          | 336.48        | 2.42     | 0.0  | 0.0       | 338.9  | 338.9 | 338.9      | 0.0  | 0.0         |
      | 2  | 31   | 20240901 |              | 334.07          | 329.45        | 9.45     | 0.0  | 0.0       | 338.9  | 0.0   | 0.0        | 0.0  | 338.9       |
      | 3  | 30   | 20241001   |              | 0.0             | 334.07        | 2.78     | 0.0  | 0.0       | 336.85 | 0.0   | 0.0        | 0.0  | 336.85      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 14.65    | 0.0  | 0.0       | 1014.65 | 338.9  | 338.9      | 0.0  | 675.75      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240710     | Repayment              | 338.9  | 336.48    | 2.42     | 0.0  | 0.0       | 663.52       | false    | false    |
      | 20240715     | Merchant Issued Refund | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 613.52       | true     | false    |
      | 20240715     | Interest Refund        | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 613.52       | true     | false    |
    Then Loan Transactions tab has a "MERCHANT_ISSUED_REFUND" transaction with date "20240715" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 50.0   |
      | LIABILITY | 145023       | Suspense/Clearing account | 50.0  |        |
      | ASSET     | 112601       | Loans Receivable          | 50.0  |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 50.0   |
    Then Loan Transactions tab has a "INTEREST_REFUND" transaction with date "20240715" which has the following Journal entries:
      | Type   | Account code | Account name            | Debit | Credit |
      | ASSET  | 112603       | Interest/Fee Receivable |       | 0.19   |
      | INCOME | 404000       | Interest Income         | 0.19  |        |
      | ASSET  | 112603       | Interest/Fee Receivable | 0.19  |        |
      | INCOME | 404000       | Interest Income         |       | 0.19   |

  @TestRailId:C3875
  Scenario: Prevent manual Interest Refund creation if interestRefundCalculation = true and Interest Refund already exists
    When Admin sets the business date to "20240701"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240701      | 1000           | 10                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240701" with "1000" amount and expected disbursement date on "20240701"
    And Admin successfully disburse the loan on "20240701" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240701      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240801    |           | 669.43          | 330.57        | 8.33     | 0.0  | 0.0       | 338.9  | 0.0  | 0.0        | 0.0  | 338.9       |
      | 2  | 31   | 20240901 |           | 336.11          | 333.32        | 5.58     | 0.0  | 0.0       | 338.9  | 0.0  | 0.0        | 0.0  | 338.9       |
      | 3  | 30   | 20241001   |           | 0.0             | 336.11        | 2.8      | 0.0  | 0.0       | 338.91 | 0.0  | 0.0        | 0.0  | 338.91      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 16.71    | 0.0  | 0.0       | 1016.71 | 0.0  | 0.0        | 0.0  | 1016.71     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Admin sets the business date to "20240710"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240710" with 338.9 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20240715"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240715" with 50 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation true
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240701      |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20240801    | 20240710 | 663.52          | 336.48        | 2.42     | 0.0  | 0.0       | 338.9  | 338.9 | 338.9      | 0.0  | 0.0         |
      | 2  | 31   | 20240901 |              | 333.42          | 330.1         | 8.8      | 0.0  | 0.0       | 338.9  | 0.19  | 0.19       | 0.0  | 338.71      |
      | 3  | 30   | 20241001   |              | 0.0             | 333.42        | 2.36     | 0.0  | 0.0       | 335.78 | 50.0  | 50.0       | 0.0  | 285.78      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 13.58    | 0.0  | 0.0       | 1013.58 | 389.09 | 389.09     | 0.0  | 624.49      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240701     | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240710     | Repayment              | 338.9  | 336.48    | 2.42     | 0.0  | 0.0       | 663.52       | false    | false    |
      | 20240715     | Merchant Issued Refund | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 613.52       | false    | false    |
      | 20240715     | Interest Refund        | 0.19   | 0.0       | 0.19     | 0.0  | 0.0       | 613.52       | false    | false    |
    When Admin fails to add duplicate Interest Refund for "MERCHANT_ISSUED_REFUND" transaction made on "20240715" with 0.19 EUR interest refund amount

  @TestRailId:C3880
  Scenario: Prevent manual Interest Refund creation with mismatched transaction date for Merchant Issued Refund
    When Admin sets the business date to "20240701"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240701      | 1000           | 10                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240701" with "1000" amount and expected disbursement date on "20240701"
    And Admin successfully disburse the loan on "20240701" with "1000" EUR transaction amount
    When Admin sets the business date to "20240710"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240710" with 338.9 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20240715"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240715" with 50 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation false
    When Admin sets the business date to "20240716"
    #mismatch date for Interest Refund
    When Admin manually adds Interest Refund for "MERCHANT_ISSUED_REFUND" transaction made on invalid date "20240716" with 2.42 EUR interest refund amount


  @TestRailId:C4127
  Scenario: High interest rate in advance paid Repayment + Merchant Issued Refund
    When Admin sets the business date to "20250710"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250710      | 1000           | 24.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250710" with "1000" amount and expected disbursement date on "20250710"
    And Admin successfully disburse the loan on "20250710" with "733.56" EUR transaction amount
    When Admin sets the business date to "20250729"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250729" with 540.0 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250710      |              | 733.56          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20250810    | 20250729 | 703.77          | 29.79         |  9.36    | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 2  | 31   | 20250910 | 20250729 | 664.62          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 3  | 30   | 20251010   | 20250729 | 625.47          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 4  | 31   | 20251110  | 20250729 | 586.32          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 5  | 30   | 20251210  | 20250729 | 547.17          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 6  | 31   | 20260110   | 20250729 | 508.02          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 7  | 31   | 20260210  | 20250729 | 468.87          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 8  | 28   | 20260310     | 20250729 | 429.72          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 9  | 31   | 20260410     | 20250729 | 390.57          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 10 | 30   | 20260510       | 20250729 | 351.42          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 11 | 31   | 20260610      | 20250729 | 312.27          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 12 | 30   | 20260710      | 20250729 | 273.12          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 13 | 31   | 20260810    | 20250729 | 233.97          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 14 | 31   | 20260910 |              | 194.82          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 31.05 | 31.05      | 0.0  |  8.1        |
      | 15 | 30   | 20261010   |              | 194.82          |  0.0          | 39.15    | 0.0  | 0.0       | 39.15  |  0.0  |  0.0       | 0.0  | 39.15       |
      | 16 | 31   | 20261110  |              | 181.27          | 13.55         | 25.6     | 0.0  | 0.0       | 39.15  |  0.0  |  0.0       | 0.0  | 39.15       |
      | 17 | 30   | 20261210  |              | 145.89          | 35.38         |  3.77    | 0.0  | 0.0       | 39.15  |  0.0  |  0.0       | 0.0  | 39.15       |
      | 18 | 31   | 20270110   |              | 109.78          | 36.11         |  3.04    | 0.0  | 0.0       | 39.15  |  0.0  |  0.0       | 0.0  | 39.15       |
      | 19 | 31   | 20270210  |              |  72.92          | 36.86         |  2.29    | 0.0  | 0.0       | 39.15  |  0.0  |  0.0       | 0.0  | 39.15       |
      | 20 | 28   | 20270310     |              |  35.29          | 37.63         |  1.52    | 0.0  | 0.0       | 39.15  |  0.0  |  0.0       | 0.0  | 39.15       |
      | 21 | 31   | 20270410     |              |   0.0           | 35.29         |  0.73    | 0.0  | 0.0       | 36.02  |  0.0  |  0.0       | 0.0  | 36.02       |
      | 22 | 30   | 20270510       | 20250729 |   0.0           |  0.0          |  0.0     | 0.0  | 0.0       |  0.0   |  0.0  |  0.0       | 0.0  |  0.0        |
      | 23 | 31   | 20270610      | 20250729 |   0.0           |  0.0          |  0.0     | 0.0  | 0.0       |  0.0   |  0.0  |  0.0       | 0.0  |  0.0        |
      | 24 | 30   | 20270710      | 20250729 |   0.0           |  0.0          |  0.0     | 0.0  | 0.0       |  0.0   |  0.0  |  0.0       | 0.0  |  0.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 733.56        | 85.46    | 0.0  | 0.0       | 819.02  | 540.0  | 540.0      | 0.0  | 279.02      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250710     | Disbursement           | 733.56 | 0.0       | 0.0      | 0.0  | 0.0       | 733.56       | false    | false    |
      | 20250729     | Repayment              | 540.0  | 530.64    | 9.36     | 0.0  | 0.0       | 202.92       | false    | false    |
    When Admin sets the business date to "20251002"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20251002" with 635.23 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation true
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250710      |                 | 733.56          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20250810    | 20250729    | 703.77          | 29.79         |  9.36    | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 2  | 31   | 20250910 | 20250729    | 664.62          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 3  | 30   | 20251010   | 20250729    | 625.47          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 4  | 31   | 20251110  | 20250729    | 586.32          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 5  | 30   | 20251210  | 20250729    | 547.17          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 6  | 31   | 20260110   | 20250729    | 508.02          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 7  | 31   | 20260210  | 20250729    | 468.87          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 8  | 28   | 20260310     | 20250729    | 429.72          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 9  | 31   | 20260410     | 20250729    | 390.57          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 10 | 30   | 20260510       | 20250729    | 351.42          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 11 | 31   | 20260610      | 20250729    | 312.27          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 12 | 30   | 20260710      | 20250729    | 273.12          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 13 | 31   | 20260810    | 20250729    | 233.97          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 14 | 31   | 20260910 | 20251002 | 202.92          | 31.05         |  0.0     | 0.0  | 0.0       | 31.05  | 31.05 | 31.05      | 0.0  |  0.0        |
      | 15 | 30   | 20261010   | 20251002 | 202.92          |  0.0          |  8.97    | 0.0  | 0.0       |  8.97  |  8.97 |  8.97      | 0.0  |  0.0        |
      | 16 | 31   | 20261110  | 20251002 | 202.92          |  0.0          |  0.0     | 0.0  | 0.0       |  0.0   |  0.0  |  0.0       | 0.0  |  0.0        |
      | 17 | 30   | 20261210  | 20251002 | 202.92          |  0.0          |  0.0     | 0.0  | 0.0       |  0.0   |  0.0  |  0.0       | 0.0  |  0.0        |
      | 18 | 31   | 20270110   | 20251002 | 202.92          |  0.0          |  0.0     | 0.0  | 0.0       |  0.0   |  0.0  |  0.0       | 0.0  |  0.0        |
      | 19 | 31   | 20270210  | 20251002 | 195.75          |  7.17         |  0.0     | 0.0  | 0.0       |  7.17  |  7.17 |  7.17      | 0.0  |  0.0        |
      | 20 | 28   | 20270310     | 20251002 | 156.6           | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 21 | 31   | 20270410     | 20251002 | 117.45          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 22 | 30   | 20270510       | 20251002 |  78.3           | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 23 | 31   | 20270610      | 20251002 |  39.15          | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
      | 24 | 30   | 20270710      | 20251002 |   0.0           | 39.15         |  0.0     | 0.0  | 0.0       | 39.15  | 39.15 | 39.15      | 0.0  |  0.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 733.56        | 18.33    | 0.0  | 0.0       | 751.89  | 751.89 | 751.89     | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250710     | Disbursement           | 733.56 |   0.0     | 0.0      | 0.0  | 0.0       | 733.56       | false    | false    |
      | 20250729     | Repayment              | 540.0  | 530.64    | 9.36     | 0.0  | 0.0       | 202.92       | false    | false    |
      | 20250810   | Accrual Activity       | 9.36   |   0.0     | 9.36     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20251002  | Merchant Issued Refund | 635.23 | 202.92    | 8.97     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20251002  | Interest Refund        | 17.07  |   0.0     | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20251002  | Accrual                | 18.33  |   0.0     | 18.33    | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20251002  | Accrual Activity       |  8.97  |   0.0     | 8.97     | 0.0  | 0.0       |   0.0        | false    | false    |

  @TestRailId:C4355
  Scenario: Verify manual Interest Refund is recalculated during reprocessing even if no prior transaction was reverse-replayed
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PMT_ALLOC_ACTUAL_ACTUAL_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 100            | 26                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "100" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "100" EUR transaction amount
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
    # MIR with interestRefundCalculation=false (no auto Interest Refund)
    When Admin sets the business date to "20250201"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250201" with 66.41 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation false
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement           | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20250201 | Merchant Issued Refund | 66.41  | 64.2      | 2.21     | 0.0  | 0.0       | 35.8         | false    | false    |
    # Manually create Interest Refund with arbitrary amount (0.47 EUR)
    When Admin manually adds Interest Refund for "MERCHANT_ISSUED_REFUND" transaction made on "20250201" with 0.47 EUR interest refund amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement           | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20250201 | Merchant Issued Refund | 66.41  | 64.2      | 2.21     | 0.0  | 0.0       | 35.8         | false    | false    |
      | 20250201 | Interest Refund        | 0.47   | 0.47      | 0.0      | 0.0  | 0.0       | 35.33         | false    | false    |
    # Backdated repayment on 20 January (before MIR) - triggers replay of MIR
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250120" with 17.94 EUR transaction amount and system-generated Idempotency key
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement           | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20250120  | Repayment              | 17.94  | 16.59     | 1.35     | 0.0  | 0.0       | 83.41        | false    | false    |
      | 20250201 | Merchant Issued Refund | 66.41  | 66.41     | 0.0      | 0.0  | 0.0       | 17.0         | false    | true     |
      | 20250201 | Interest Refund        | 1.48   | 1.48      | 0.0      | 0.0  | 0.0       | 15.52        | false    | true     |
#   Step 4: Make another repayment on 25 January (also before MIR)
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250125" with 10.94 EUR transaction amount and system-generated Idempotency key
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement           | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20250120  | Repayment              | 17.94  | 16.59     | 1.35     | 0.0  | 0.0       | 83.41        | false    | false    |
      | 20250125  | Repayment              | 10.94  | 10.94     | 0.0      | 0.0  | 0.0       | 72.47        | false    | false    |
      | 20250201 | Merchant Issued Refund | 66.41  | 66.41     | 0.0      | 0.0  | 0.0       | 6.06         | false    | true     |
      | 20250201 | Interest Refund        | 1.47   | 1.47      | 0.0      | 0.0  | 0.0       | 4.59         | false    | true     |
#   Step 5: Reverse the 1st repayment (20 Jan) - this triggers full transaction reprocessing
#   Key expectation: Interest Refund should be RECALCULATED even though MIR wasn't modified
#   Before fix: Interest Refund kept 1.47 because no txn before it was changed
#   After fix: Interest Refund recalculated to correct value
    When Customer undo "1"th "Repayment" transaction made on "20250120"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement           | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20250120  | Repayment              | 17.94  | 16.59     | 1.35     | 0.0  | 0.0       | 83.41        | true     | false    |
      | 20250125  | Repayment              | 10.94  | 10.94     | 0.0      | 0.0  | 0.0       | 89.06        | false    | false     |
      | 20250201 | Merchant Issued Refund | 66.41  | 64.26     | 2.15     | 0.0  | 0.0       | 24.8         | false    | true     |
      | 20250201 | Interest Refund        | 1.46   | 1.46      | 0.0      | 0.0  | 0.0       | 23.34        | false    | true     |
    #following steps will fail if Interest Refund is not recalculated properly
    Then Loan has 23.97 outstanding amount

  @TestRailId:C4570
  Scenario: Verify MIR and CBR with adjust interest afterwards outcomes with improper allocations on account - UC1
    When Admin sets the business date to "20240924"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240924 | 116.89         | 35.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240924" with "116.89" amount and expected disbursement date on "20240924"
    And Admin successfully disburse the loan on "20240924" with "116.89" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240924 |                 | 116.89          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20241024   |                 | 79.08           | 37.81         |  3.51    | 0.0  | 0.0       | 41.32  | 0.0   | 0.0        | 0.0  | 41.32       |
      | 2  | 31   | 20241124  |                 | 40.13           | 38.95         |  2.37    | 0.0  | 0.0       | 41.32  | 0.0   | 0.0        | 0.0  | 41.32       |
      | 3  | 30   | 20241224  |                 |  0.0            | 40.13         |  1.2     | 0.0  | 0.0       | 41.33  | 0.0   | 0.0        | 0.0  | 41.33       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 116.89        | 7.08     | 0.0  | 0.0       | 123.97  | 0.0    | 0.0        | 0.0  | 123.97      |
    And Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240924 | Disbursement           | 116.89 | 0.0       | 0.0      | 0.0  | 0.0       | 116.89       | false    | false    |
# --- repayment transaction --- #
    When Admin sets the business date to "20240926"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240926" with 117.12 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240924 |                   | 116.89          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20241024   | 20240926 | 75.8            | 41.09         |  0.23    | 0.0  | 0.0       | 41.32  | 41.32 | 41.32      | 0.0  | 0.0         |
      | 2  | 31   | 20241124  | 20240926 | 34.48           | 41.32         |  0.0     | 0.0  | 0.0       | 41.32  | 41.32 | 41.32      | 0.0  | 0.0         |
      | 3  | 30   | 20241224  | 20240926 |  0.0            | 34.48         |  0.0     | 0.0  | 0.0       | 34.48  | 34.48 | 34.48      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 116.89        | 0.23     | 0.0  | 0.0       | 117.12  | 117.12 | 117.12    | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240924 | Disbursement           | 116.89 | 0.0       | 0.0      | 0.0  | 0.0       | 116.89       | false    | false    |
      | 20240926 | Repayment              | 117.12 | 116.89    | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Accrual                | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Accrual Activity       | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
# --- Merchant Issue Refund transaction --- #
    When Admin sets the business date to "20241006"
    Then Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20241006" with 8.13 EUR transaction amount and system-generated Idempotency key
    Then Loan has 0 outstanding amount
    Then Loan status will be "OVERPAID"
    Then Loan has 8.14 overpaid amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240924 |                   | 116.89          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20241024   | 20240926 | 75.8            | 41.09         |  0.23    | 0.0  | 0.0       | 41.32  | 41.32 | 41.32      | 0.0  | 0.0         |
      | 2  | 31   | 20241124  | 20240926 | 34.48           | 41.32         |  0.0     | 0.0  | 0.0       | 41.32  | 41.32 | 41.32      | 0.0  | 0.0         |
      | 3  | 30   | 20241224  | 20240926 |  0.0            | 34.48         |  0.0     | 0.0  | 0.0       | 34.48  | 34.48 | 34.48      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 116.89        | 0.23     | 0.0  | 0.0       | 117.12  | 117.12 | 117.12     | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240924 | Disbursement           | 116.89 | 0.0       | 0.0      | 0.0  | 0.0       | 116.89       | false    | false    |
      | 20240926 | Repayment              | 117.12 | 116.89    | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Accrual                | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Accrual Activity       | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241006   | Merchant Issued Refund | 8.13   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241006   | Interest Refund        | 0.01   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
# --- Credit Balance Refund transaction --- #
    When Admin sets the business date to "20241007"
    And Admin makes Credit Balance Refund transaction on "20241007" with 8.14 EUR transaction amount
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240924 |                   | 116.89          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20241024   | 20240926 | 75.8            | 41.09         |  0.23    | 0.0  | 0.0       | 41.32  | 41.32 | 41.32      | 0.0  | 0.0         |
      | 2  | 31   | 20241124  | 20240926 | 34.48           | 41.32         |  0.0     | 0.0  | 0.0       | 41.32  | 41.32 | 41.32      | 0.0  | 0.0         |
      | 3  | 30   | 20241224  | 20240926 |  0.0            | 34.48         |  0.0     | 0.0  | 0.0       | 34.48  | 34.48 | 34.48      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 116.89        | 0.23     | 0.0  | 0.0       | 117.12  | 117.12 | 117.12     | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240924 | Disbursement           | 116.89 | 0.0       | 0.0      | 0.0  | 0.0       | 116.89       | false    | false    |
      | 20240926 | Accrual                | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Repayment              | 117.12 | 116.89    | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Accrual Activity       | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241006   | Merchant Issued Refund | 8.13   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241006   | Interest Refund        | 0.01   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241007   | Credit Balance Refund  | 8.14   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
# --- loan reschedule with new interest rate --- #
    When Admin sets the business date to "20241030"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240925  | 20241030 |                 |                  |                 |            | 25.99           |
    Then Loan has 0 outstanding amount
    Then Loan status will be "OVERPAID"
    Then Loan has 0.06 overpaid amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240924 |                   | 116.89          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20241024   | 20240926 | 76.4            | 40.49         |  0.17    | 0.0  | 0.0       | 40.66  | 40.66 | 40.66      | 0.0  | 0.0         |
      | 2  | 31   | 20241124  | 20240926 | 35.74           | 40.66         |  0.0     | 0.0  | 0.0       | 40.66  | 40.66 | 40.66      | 0.0  | 0.0         |
      | 3  | 30   | 20241224  | 20240926 |  0.0            | 35.74         |  0.0     | 0.0  | 0.0       | 35.74  | 35.74 | 35.74      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 116.89        | 0.17     | 0.0  | 0.0       | 117.06  | 117.06 | 117.06     | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240924 | Disbursement           | 116.89 | 0.0       | 0.0      | 0.0  | 0.0       | 116.89       | false    | false    |
      | 20240926 | Accrual                | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Repayment              | 117.12 | 116.89    | 0.17     | 0.0  | 0.0       |   0.0        | false    | true     |
      | 20240926 | Accrual Activity       | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       |   0.0        | false    | true     |
      | 20241006   | Merchant Issued Refund | 8.13   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241006   | Interest Refund        | 0.01   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241007   | Credit Balance Refund  | 8.14   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241030   | Accrual Adjustment     | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       |   0.0        | false    | false    |
    And Admin makes Credit Balance Refund transaction on "20241030" with 0.06 EUR transaction amount
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4541
  Scenario: Verify PR and CBR with adjust interest afterwards outcomes with improper allocations on account - UC2
    When Admin sets the business date to "20240924"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240924 | 116.89         | 35.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240924" with "116.89" amount and expected disbursement date on "20240924"
    And Admin successfully disburse the loan on "20240924" with "116.89" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240924 |                 | 116.89          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20241024   |                 | 79.08           | 37.81         |  3.51    | 0.0  | 0.0       | 41.32  | 0.0   | 0.0        | 0.0  | 41.32       |
      | 2  | 31   | 20241124  |                 | 40.13           | 38.95         |  2.37    | 0.0  | 0.0       | 41.32  | 0.0   | 0.0        | 0.0  | 41.32       |
      | 3  | 30   | 20241224  |                 |  0.0            | 40.13         |  1.2     | 0.0  | 0.0       | 41.33  | 0.0   | 0.0        | 0.0  | 41.33       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 116.89        | 7.08     | 0.0  | 0.0       | 123.97  | 0.0    | 0.0        | 0.0  | 123.97      |
    And Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240924 | Disbursement           | 116.89 | 0.0       | 0.0      | 0.0  | 0.0       | 116.89       | false    | false    |
# --- repayment transaction --- #
    When Admin sets the business date to "20240926"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240926" with 117.12 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240924 |                   | 116.89          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20241024   | 20240926 | 75.8            | 41.09         |  0.23    | 0.0  | 0.0       | 41.32  | 41.32 | 41.32      | 0.0  | 0.0         |
      | 2  | 31   | 20241124  | 20240926 | 34.48           | 41.32         |  0.0     | 0.0  | 0.0       | 41.32  | 41.32 | 41.32      | 0.0  | 0.0         |
      | 3  | 30   | 20241224  | 20240926 |  0.0            | 34.48         |  0.0     | 0.0  | 0.0       | 34.48  | 34.48 | 34.48      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 116.89        | 0.23     | 0.0  | 0.0       | 117.12  | 117.12 | 117.12    | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240924 | Disbursement           | 116.89 | 0.0       | 0.0      | 0.0  | 0.0       | 116.89       | false    | false    |
      | 20240926 | Repayment              | 117.12 | 116.89    | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Accrual                | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Accrual Activity       | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
# --- Merchant Issue Refund transaction --- #
    When Admin sets the business date to "20241006"
    When Customer makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20241006" with 8.13 EUR transaction amount and system-generated Idempotency key
    Then Loan has 0 outstanding amount
    Then Loan status will be "OVERPAID"
    Then Loan has 8.14 overpaid amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240924 |                   | 116.89          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20241024   | 20240926 | 75.8            | 41.09         |  0.23    | 0.0  | 0.0       | 41.32  | 41.32 | 41.32      | 0.0  | 0.0         |
      | 2  | 31   | 20241124  | 20240926 | 34.48           | 41.32         |  0.0     | 0.0  | 0.0       | 41.32  | 41.32 | 41.32      | 0.0  | 0.0         |
      | 3  | 30   | 20241224  | 20240926 |  0.0            | 34.48         |  0.0     | 0.0  | 0.0       | 34.48  | 34.48 | 34.48      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 116.89        | 0.23     | 0.0  | 0.0       | 117.12  | 117.12 | 117.12     | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240924 | Disbursement           | 116.89 | 0.0       | 0.0      | 0.0  | 0.0       | 116.89       | false    | false    |
      | 20240926 | Repayment              | 117.12 | 116.89    | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Accrual                | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Accrual Activity       | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241006   | Payout Refund          | 8.13   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241006   | Interest Refund        | 0.01   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
# --- Credit Balance Refund transaction --- #
    When Admin sets the business date to "20241007"
    And Admin makes Credit Balance Refund transaction on "20241007" with 8.14 EUR transaction amount
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240924 |                   | 116.89          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20241024   | 20240926 | 75.8            | 41.09         |  0.23    | 0.0  | 0.0       | 41.32  | 41.32 | 41.32      | 0.0  | 0.0         |
      | 2  | 31   | 20241124  | 20240926 | 34.48           | 41.32         |  0.0     | 0.0  | 0.0       | 41.32  | 41.32 | 41.32      | 0.0  | 0.0         |
      | 3  | 30   | 20241224  | 20240926 |  0.0            | 34.48         |  0.0     | 0.0  | 0.0       | 34.48  | 34.48 | 34.48      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 116.89        | 0.23     | 0.0  | 0.0       | 117.12  | 117.12 | 117.12     | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240924 | Disbursement           | 116.89 | 0.0       | 0.0      | 0.0  | 0.0       | 116.89       | false    | false    |
      | 20240926 | Accrual                | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Repayment              | 117.12 | 116.89    | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Accrual Activity       | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241006   | Payout Refund          | 8.13   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241006   | Interest Refund        | 0.01   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241007   | Credit Balance Refund  | 8.14   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
# --- loan reschedule with new interest rate --- #
    When Admin sets the business date to "20241030"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240925  | 20241030 |                 |                  |                 |            | 25.99           |
    Then Loan has 0 outstanding amount
    Then Loan status will be "OVERPAID"
    Then Loan has 0.06 overpaid amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240924 |                   | 116.89          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20241024   | 20240926 | 76.4            | 40.49         |  0.17    | 0.0  | 0.0       | 40.66  | 40.66 | 40.66      | 0.0  | 0.0         |
      | 2  | 31   | 20241124  | 20240926 | 35.74           | 40.66         |  0.0     | 0.0  | 0.0       | 40.66  | 40.66 | 40.66      | 0.0  | 0.0         |
      | 3  | 30   | 20241224  | 20240926 |  0.0            | 35.74         |  0.0     | 0.0  | 0.0       | 35.74  | 35.74 | 35.74      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 116.89        | 0.17     | 0.0  | 0.0       | 117.06  | 117.06 | 117.06     | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240924 | Disbursement           | 116.89 | 0.0       | 0.0      | 0.0  | 0.0       | 116.89       | false    | false    |
      | 20240926 | Accrual                | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Repayment              | 117.12 | 116.89    | 0.17     | 0.0  | 0.0       |   0.0        | false    | true     |
      | 20240926 | Accrual Activity       | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       |   0.0        | false    | true     |
      | 20241006   | Payout Refund          | 8.13   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241006   | Interest Refund        | 0.01   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241007   | Credit Balance Refund  | 8.14   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241030   | Accrual Adjustment     | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       |   0.0        | false    | false    |
    And Admin makes Credit Balance Refund transaction on "20241030" with 0.06 EUR transaction amount
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4571
  Scenario: Verify Goodwill Credit and CBR with adjust interest afterwards outcomes with improper allocations on account - UC3
    When Admin sets the business date to "20240924"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240924 | 116.89         | 35.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240924" with "116.89" amount and expected disbursement date on "20240924"
    And Admin successfully disburse the loan on "20240924" with "116.89" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240924 |                 | 116.89          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20241024   |                 | 79.08           | 37.81         |  3.51    | 0.0  | 0.0       | 41.32  | 0.0   | 0.0        | 0.0  | 41.32       |
      | 2  | 31   | 20241124  |                 | 40.13           | 38.95         |  2.37    | 0.0  | 0.0       | 41.32  | 0.0   | 0.0        | 0.0  | 41.32       |
      | 3  | 30   | 20241224  |                 |  0.0            | 40.13         |  1.2     | 0.0  | 0.0       | 41.33  | 0.0   | 0.0        | 0.0  | 41.33       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 116.89        | 7.08     | 0.0  | 0.0       | 123.97  | 0.0    | 0.0        | 0.0  | 123.97      |
    And Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240924 | Disbursement           | 116.89 | 0.0       | 0.0      | 0.0  | 0.0       | 116.89       | false    | false    |
# --- repayment transaction --- #
    When Admin sets the business date to "20240926"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240926" with 117.12 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240924 |                   | 116.89          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20241024   | 20240926 | 75.8            | 41.09         |  0.23    | 0.0  | 0.0       | 41.32  | 41.32 | 41.32      | 0.0  | 0.0         |
      | 2  | 31   | 20241124  | 20240926 | 34.48           | 41.32         |  0.0     | 0.0  | 0.0       | 41.32  | 41.32 | 41.32      | 0.0  | 0.0         |
      | 3  | 30   | 20241224  | 20240926 |  0.0            | 34.48         |  0.0     | 0.0  | 0.0       | 34.48  | 34.48 | 34.48      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 116.89        | 0.23     | 0.0  | 0.0       | 117.12  | 117.12 | 117.12    | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240924 | Disbursement           | 116.89 | 0.0       | 0.0      | 0.0  | 0.0       | 116.89       | false    | false    |
      | 20240926 | Repayment              | 117.12 | 116.89    | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Accrual                | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Accrual Activity       | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
# --- Merchant Issue Refund transaction --- #
    When Admin sets the business date to "20241006"
    When Admin makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20241006" with 8.13 EUR transaction amount
    Then Loan has 0 outstanding amount
    Then Loan status will be "OVERPAID"
    Then Loan has 8.13 overpaid amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240924 |                   | 116.89          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20241024   | 20240926 | 75.8            | 41.09         |  0.23    | 0.0  | 0.0       | 41.32  | 41.32 | 41.32      | 0.0  | 0.0         |
      | 2  | 31   | 20241124  | 20240926 | 34.48           | 41.32         |  0.0     | 0.0  | 0.0       | 41.32  | 41.32 | 41.32      | 0.0  | 0.0         |
      | 3  | 30   | 20241224  | 20240926 |  0.0            | 34.48         |  0.0     | 0.0  | 0.0       | 34.48  | 34.48 | 34.48      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 116.89        | 0.23     | 0.0  | 0.0       | 117.12  | 117.12 | 117.12     | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240924 | Disbursement            | 116.89 | 0.0       | 0.0      | 0.0  | 0.0       | 116.89       | false    | false    |
      | 20240926 | Repayment               | 117.12 | 116.89    | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Accrual                 | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Accrual Activity        | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241006   | Goodwill Credit         | 8.13   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
# --- Credit Balance Refund transaction --- #
    When Admin sets the business date to "20241007"
    And Admin makes Credit Balance Refund transaction on "20241007" with 8.13 EUR transaction amount
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240924 |                   | 116.89          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20241024   | 20240926 | 75.8            | 41.09         |  0.23    | 0.0  | 0.0       | 41.32  | 41.32 | 41.32      | 0.0  | 0.0         |
      | 2  | 31   | 20241124  | 20240926 | 34.48           | 41.32         |  0.0     | 0.0  | 0.0       | 41.32  | 41.32 | 41.32      | 0.0  | 0.0         |
      | 3  | 30   | 20241224  | 20240926 |  0.0            | 34.48         |  0.0     | 0.0  | 0.0       | 34.48  | 34.48 | 34.48      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 116.89        | 0.23     | 0.0  | 0.0       | 117.12  | 117.12 | 117.12     | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240924 | Disbursement            | 116.89 | 0.0       | 0.0      | 0.0  | 0.0       | 116.89       | false    | false    |
      | 20240926 | Accrual                 | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Repayment               | 117.12 | 116.89    | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Accrual Activity        | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241006   | Goodwill Credit         | 8.13   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241007   | Credit Balance Refund   | 8.13   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
# --- loan reschedule with new interest rate --- #
    When Admin sets the business date to "20241030"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240925  | 20241030 |                 |                  |                 |            | 25.99           |
    Then Loan has 0 outstanding amount
    Then Loan status will be "OVERPAID"
    Then Loan has 0.06 overpaid amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240924 |                   | 116.89          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20241024   | 20240926 | 76.4            | 40.49         |  0.17    | 0.0  | 0.0       | 40.66  | 40.66 | 40.66      | 0.0  | 0.0         |
      | 2  | 31   | 20241124  | 20240926 | 35.74           | 40.66         |  0.0     | 0.0  | 0.0       | 40.66  | 40.66 | 40.66      | 0.0  | 0.0         |
      | 3  | 30   | 20241224  | 20240926 |  0.0            | 35.74         |  0.0     | 0.0  | 0.0       | 35.74  | 35.74 | 35.74      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 116.89        | 0.17     | 0.0  | 0.0       | 117.06  | 117.06 | 117.06     | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240924 | Disbursement            | 116.89 | 0.0       | 0.0      | 0.0  | 0.0       | 116.89       | false    | false    |
      | 20240926 | Accrual                 | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20240926 | Repayment               | 117.12 | 116.89    | 0.17     | 0.0  | 0.0       |   0.0        | false    | true     |
      | 20240926 | Accrual Activity        | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       |   0.0        | false    | true     |
      | 20241006   | Goodwill Credit         | 8.13   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241007   | Credit Balance Refund   | 8.13   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20241030   | Accrual Adjustment      | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       |   0.0        | false    | false    |
    And Admin makes Credit Balance Refund transaction on "20241030" with 0.06 EUR transaction amount
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4542
  Scenario: Verify adding manual Interest Refund on closed loan with multiple tranches
    When Admin sets the business date to "20250307"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INT_DAILY_EMI_ACTUAL_ACTUAL_INT_REFUND_FULL_ZERO_INT_CHARGE_OFF_ACCRUAL_ACTIVITY | 20250307     | 915.88         | 24.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250307" with "915.88" amount and expected disbursement date on "20250307"
    When Admin sets the business date to "20250311"
    And Admin successfully disburse the loan on "20250311" with "228.97" EUR transaction amount
    And Admin successfully disburse the loan on "20250311" with "228.97" EUR transaction amount
    And Admin successfully disburse the loan on "20250311" with "228.97" EUR transaction amount
    And Admin successfully disburse the loan on "20250311" with "228.97" EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 228.97       | false    | false    |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 457.94       | false    | false    |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 686.91       | false    | false    |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 915.88       | false    | false    |
    Then Loan status will be "ACTIVE"
    # ========== REPAYMENT 1: 20250404 ==========
    When Admin sets the business date to "20250404"
    #And Admin runs inline COB job for Loan
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250404" with 48.91 EUR transaction amount and system-generated Idempotency key
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 228.97       | false    | false    |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 457.94       | false    | false    |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 686.91       | false    | false    |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 915.88       | false    | false    |
      | 20250404    | Repayment        | 48.91  | 33.86     | 15.05    | 0.0  | 0.0       | 882.02       | false    | false    |
    Then Loan status will be "ACTIVE"

    # ========== REPAYMENT 2: 20250502 ==========
    When Admin sets the business date to "20250502"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250502" with 48.91 EUR transaction amount and system-generated Idempotency key
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 228.97       | false    | false    |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 457.94       | false    | false    |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 686.91       | false    | false    |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 915.88       | false    | false    |
      | 20250404    | Repayment        | 48.91  | 33.86     | 15.05    | 0.0  | 0.0       | 882.02       | false    | false    |
      | 20250502      | Repayment        | 48.91  | 32.0      | 16.91    | 0.0  | 0.0       | 850.02       | false    | false    |
    Then Loan status will be "ACTIVE"

    # ========== REPAYMENT 3: 20250530 ==========
    When Admin sets the business date to "20250530"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250530" with 48.91 EUR transaction amount and system-generated Idempotency key
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 228.97       | false    | false    |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 457.94       | false    | false    |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 686.91       | false    | false    |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 915.88       | false    | false    |
      | 20250404    | Repayment        | 48.91  | 33.86     | 15.05    | 0.0  | 0.0       | 882.02       | false    | false    |
      | 20250502      | Repayment        | 48.91  | 32.0      | 16.91    | 0.0  | 0.0       | 850.02       | false    | false    |
      | 20250530      | Repayment        | 48.91  | 32.61     | 16.3     | 0.0  | 0.0       | 817.41       | false    | false    |
    Then Loan status will be "ACTIVE"

    # ========== REPAYMENT 4: 20250627 ==========
    When Admin sets the business date to "20250627"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250627" with 48.91 EUR transaction amount and system-generated Idempotency key
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 228.97       | false    | false    |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 457.94       | false    | false    |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 686.91       | false    | false    |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 915.88       | false    | false    |
      | 20250404    | Repayment        | 48.91  | 33.86     | 15.05    | 0.0  | 0.0       | 882.02       | false    | false    |
      | 20250502      | Repayment        | 48.91  | 32.0      | 16.91    | 0.0  | 0.0       | 850.02       | false    | false    |
      | 20250530      | Repayment        | 48.91  | 32.61     | 16.3     | 0.0  | 0.0       | 817.41       | false    | false    |
      | 20250627     | Repayment        | 48.91  | 33.25     | 15.66    | 0.0  | 0.0       | 784.16       | false    | false    |
    Then Loan status will be "ACTIVE"

    # ========== REPAYMENT 5: 20250808 ==========
    When Admin sets the business date to "20250808"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250808" with 48.91 EUR transaction amount and system-generated Idempotency key
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 228.97       | false    | false    |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 457.94       | false    | false    |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 686.91       | false    | false    |
      | 20250311    | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 915.88       | false    | false    |
      | 20250404    | Repayment        | 48.91  | 33.86     | 15.05    | 0.0  | 0.0       | 882.02       | false    | false    |
      | 20250502      | Repayment        | 48.91  | 32.0      | 16.91    | 0.0  | 0.0       | 850.02       | false    | false    |
      | 20250530      | Repayment        | 48.91  | 32.61     | 16.3     | 0.0  | 0.0       | 817.41       | false    | false    |
      | 20250627     | Repayment        | 48.91  | 33.25     | 15.66    | 0.0  | 0.0       | 784.16       | false    | false    |
      | 20250808   | Repayment        | 48.91  | 26.36     | 22.55    | 0.0  | 0.0       | 757.8        | false    | false    |
    Then Loan status will be "ACTIVE"

    # ========== REPAYMENT 6: 20250905 ==========
    When Admin sets the business date to "20250905"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250905" with 48.91 EUR transaction amount and system-generated Idempotency key
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250311     | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 228.97       | false    | false    |
      | 20250311     | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 457.94       | false    | false    |
      | 20250311     | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 686.91       | false    | false    |
      | 20250311     | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 915.88       | false    | false    |
      | 20250404     | Repayment        | 48.91  | 33.86     | 15.05    | 0.0  | 0.0       | 882.02       | false    | false    |
      | 20250502       | Repayment        | 48.91  | 32.0      | 16.91    | 0.0  | 0.0       | 850.02       | false    | false    |
      | 20250530       | Repayment        | 48.91  | 32.61     | 16.3     | 0.0  | 0.0       | 817.41       | false    | false    |
      | 20250627      | Repayment        | 48.91  | 33.25     | 15.66    | 0.0  | 0.0       | 784.16       | false    | false    |
      | 20250808    | Repayment        | 48.91  | 26.36     | 22.55    | 0.0  | 0.0       | 757.8        | false    | false    |
      | 20250905 | Repayment        | 48.91  | 34.38     | 14.53    | 0.0  | 0.0       | 723.42       | false    | false    |
    Then Loan status will be "ACTIVE"

    # ========== REPAYMENT 7: 20251003 ==========
    When Admin sets the business date to "20251003"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20251003" with 48.91 EUR transaction amount and system-generated Idempotency key
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250311     | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 228.97       | false    | false    |
      | 20250311     | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 457.94       | false    | false    |
      | 20250311     | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 686.91       | false    | false    |
      | 20250311     | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 915.88       | false    | false    |
      | 20250404     | Repayment        | 48.91  | 33.86     | 15.05    | 0.0  | 0.0       | 882.02       | false    | false    |
      | 20250502       | Repayment        | 48.91  | 32.0      | 16.91    | 0.0  | 0.0       | 850.02       | false    | false    |
      | 20250530       | Repayment        | 48.91  | 32.61     | 16.3     | 0.0  | 0.0       | 817.41       | false    | false    |
      | 20250627      | Repayment        | 48.91  | 33.25     | 15.66    | 0.0  | 0.0       | 784.16       | false    | false    |
      | 20250808    | Repayment        | 48.91  | 26.36     | 22.55    | 0.0  | 0.0       | 757.8        | false    | false    |
      | 20250905 | Repayment        | 48.91  | 34.38     | 14.53    | 0.0  | 0.0       | 723.42       | false    | false    |
      | 20251003   | Repayment        | 48.91  | 35.04     | 13.87    | 0.0  | 0.0       | 688.38       | false    | false    |
    Then Loan status will be "ACTIVE"

    # ========== 4 MERCHANT ISSUED REFUNDS: 20251008 ==========
    When Admin sets the business date to "20251008"
    When Admin sets the business date to "20251009"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20251008" with 228.97 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation false
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20251008" with 228.97 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation false
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20251008" with 228.97 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation false
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20251008" with 228.97 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation false
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250311     | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 228.97       | false    | false    |
      | 20250311     | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 457.94       | false    | false    |
      | 20250311     | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 686.91       | false    | false    |
      | 20250311     | Disbursement     | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 915.88       | false    | false    |
      | 20250404     | Repayment        | 48.91  | 33.86     | 15.05    | 0.0  | 0.0       | 882.02       | false    | false    |
      | 20250411     | Accrual Activity | 15.05  | 0.0       | 15.05    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250502       | Repayment        | 48.91  | 32.0      | 16.91    | 0.0  | 0.0       | 850.02       | false    | false    |
      | 20250511       | Accrual Activity | 16.91  | 0.0       | 16.91    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250530       | Repayment        | 48.91  | 32.61     | 16.3     | 0.0  | 0.0       | 817.41       | false    | false    |
      | 20250611      | Accrual Activity | 16.3   | 0.0       | 16.3     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250627      | Repayment        | 48.91  | 33.25     | 15.66    | 0.0  | 0.0       | 784.16       | false    | false    |
      | 20250711      | Accrual Activity | 15.66  | 0.0       | 15.66    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250808    | Repayment        | 48.91  | 26.36     | 22.55    | 0.0  | 0.0       | 757.8        | false    | false    |
      | 20250811    | Accrual Activity | 22.55  | 0.0       | 22.55    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250905 | Repayment        | 48.91  | 34.38     | 14.53    | 0.0  | 0.0       | 723.42       | false    | false    |
      | 20250911 | Accrual Activity | 14.53  | 0.0       | 14.53    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20251003   | Repayment        | 48.91  | 35.04     | 13.87    | 0.0  | 0.0       | 688.38       | false    | false    |
      | 20251008   | Merchant Issued Refund | 228.97 | 226.62    | 2.35     | 0.0  | 0.0       | 461.76       | false    | false    |
      | 20251008   | Merchant Issued Refund | 228.97 | 228.97    | 0.0      | 0.0  | 0.0       | 232.79       | false    | false    |
      | 20251008   | Merchant Issued Refund | 228.97 | 228.97    | 0.0      | 0.0  | 0.0       | 3.82         | false    | false    |
      | 20251008   | Merchant Issued Refund | 228.97 | 3.82      | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20251008   | Accrual Activity       | 16.22  | 0.0       | 16.22    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20251009   | Accrual                | 117.22 | 0.0       | 117.22   | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan status will be "OVERPAID"

    # ========== CREDIT BALANCE REFUND TO CLOSE LOAN: 20251009 ==========
    When Admin sets the business date to "20251009"
    And Admin runs inline COB job for Loan
    And Admin makes Credit Balance Refund transaction on "20251009" with 225.15 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250311     | Disbursement           | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 228.97       | false    | false    |
      | 20250311     | Disbursement           | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 457.94       | false    | false    |
      | 20250311     | Disbursement           | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 686.91       | false    | false    |
      | 20250311     | Disbursement           | 228.97 | 0.0       | 0.0      | 0.0  | 0.0       | 915.88       | false    | false    |
      | 20250404     | Repayment              | 48.91  | 33.86     | 15.05    | 0.0  | 0.0       | 882.02       | false    | false    |
      | 20250411     | Accrual Activity       | 15.05  | 0.0       | 15.05    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250502       | Repayment              | 48.91  | 32.0      | 16.91    | 0.0  | 0.0       | 850.02       | false    | false    |
      | 20250511       | Accrual Activity       | 16.91  | 0.0       | 16.91    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250530       | Repayment              | 48.91  | 32.61     | 16.3     | 0.0  | 0.0       | 817.41       | false    | false    |
      | 20250611      | Accrual Activity       | 16.3   | 0.0       | 16.3     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250627      | Repayment              | 48.91  | 33.25     | 15.66    | 0.0  | 0.0       | 784.16       | false    | false    |
      | 20250711      | Accrual Activity       | 15.66  | 0.0       | 15.66    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250808    | Repayment              | 48.91  | 26.36     | 22.55    | 0.0  | 0.0       | 757.8        | false    | false    |
      | 20250811    | Accrual Activity       | 22.55  | 0.0       | 22.55    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250905 | Repayment              | 48.91  | 34.38     | 14.53    | 0.0  | 0.0       | 723.42       | false    | false    |
      | 20250911 | Accrual Activity       | 14.53  | 0.0       | 14.53    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20251003   | Repayment              | 48.91  | 35.04     | 13.87    | 0.0  | 0.0       | 688.38       | false    | false    |
      | 20251008   | Merchant Issued Refund | 228.97 | 226.62    | 2.35     | 0.0  | 0.0       | 461.76       | false    | false    |
      | 20251008   | Merchant Issued Refund | 228.97 | 228.97    | 0.0      | 0.0  | 0.0       | 232.79       | false    | false    |
      | 20251008   | Merchant Issued Refund | 228.97 | 228.97    | 0.0      | 0.0  | 0.0       | 3.82         | false    | false    |
      | 20251008   | Merchant Issued Refund | 228.97 | 3.82      | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20251008   | Accrual Activity       | 16.22  | 0.0       | 16.22    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20251009   | Accrual                | 117.22 | 0.0       | 117.22   | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20251009   | Credit Balance Refund  | 225.15 | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

    # ========== MANUAL INTEREST REFUNDS ON CLOSED LOAN ==========
    When Admin manually adds Interest Refund for "1"th "MERCHANT_ISSUED_REFUND" transaction made on "20251008" with 0.01 EUR interest refund amount
    When Admin manually adds Interest Refund for "2"th "MERCHANT_ISSUED_REFUND" transaction made on "20251008" with 0.01 EUR interest refund amount
    When Admin manually adds Interest Refund for "3"th "MERCHANT_ISSUED_REFUND" transaction made on "20251008" with 0.01 EUR interest refund amount
    When Admin manually adds Interest Refund for "4"th "MERCHANT_ISSUED_REFUND" transaction made on "20251008" with 0.01 EUR interest refund amount
    Then Loan status will be "OVERPAID"